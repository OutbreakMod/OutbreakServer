/*
	Register server-side variables
	@author: TheAmazingAussie
*/

// Make AI Hostile to Survivors
WEST setFriend [EAST,0];
EAST setFriend [WEST,0];

// Make AI Hostile to Zeds
EAST setFriend [CIVILIAN,0];
CIVILIAN setFriend [EAST,0];

// variables
LOOT_TABLES = [];
	
"hive_playerLogin" addPublicVariableEventHandler {

	_packet = _this select 1;
	_player = _packet select 0;
	_clientID = (owner _player);
	_uuid = format["%1", getPlayerUID _player];
	
	_exists = ["users", "uuid", _uuid] call hive_exists;
	
	if (_exists) then {
	
		// player position
		_position = ["users", "position", "uuid", _uuid] call hive_read;
		[_player, ["tp", call compile(format["%1", _position])]] call server_clientCommand;
		
		// inventory
		_inventory = toString (call compile(["users", "inventory", "uuid", _uuid] call hive_read));
		[_player, ["gear", call compile(_inventory)]] call server_clientCommand;
		
		// medical
		_medical = ["users", "medical", "uuid", _uuid] call hive_read;
		[_player, ["medical", call compile(format["%1", _medical])]] call server_clientCommand;
		
		// login finished
		[_player, ["login"]] call server_clientCommand;

	} else {
	
		// find new spawn
		[_player, ["findspawn"]] call server_clientCommand;
		
		// create new row
		_player call hive_newUser;
	
	};
};

"hive_playerSave" addPublicVariableEventHandler {

	_packet = _this select 1;
	_packet spawn server_clientSave;
};

"hive_playerDelete" addPublicVariableEventHandler {

	_packet = _this select 1;
	_player = _packet select 0;
	
	["users", "uuid", getPlayerUID _player] call hive_delete;
};

"player_createVehicle" addPublicVariableEventHandler {
	
	_packet = _this select 1;
	_class = _packet select 0;
	_position = _packet select 1;
	_unqiueID = _packet select 3;
	_player = _packet select 3;
	
	_vehicle = createVehicle [_class, _position, [], 0, "CAN_COLLIDE"];
	_player setVariable [_uniqueID, _vehicle, true];
};

"hive_newObject" addPublicVariableEventHandler {

	_packet = _this select 1;
	
	_player = _packet select 0;
	_vehicle = _packet select 1;
	_class = _packet select 2;
	_worldspace = _packet select 3;
	_dir = _packet select 4;
	_hitPoints = _packet select 5;
	_fuel = fuel _vehicle;
	_damage = damage _vehicle;
	
	_inventory = [];
	
	_update = format["NewObject, '%1','%2','%3','%4','%5','%6','%7','%8'", MOD_HIVE, _class, _worldspace, _dir, _inventory, _hitPoints, _fuel, _damage];
	_response = [_update] call hive_static;
	
	diag_log format ["hive_newObject response: %1", _response];
	
	_vehicle setVariable ["ObjectID", parseNumber(_response), true]
};

"server_spawnLoot" addPublicVariableEventHandler {

	_packet = _this select 1;
	_building = _packet select 0;
	
	if (serverTime > _building getVariable ["loottimer", 0]) then {
		_lootArray = _building getVariable ["lootarray", []];
		
		if ((typeOf _building) in ["MOD_Mi8Wreck", "Mi8Wreck", "MOD_UH1YWreck", "Land_Wreck_Heli_Attack_02_F"]) then {
			if ((_building getVariable ["helicrashSpawnZeds", true])) then {
			
				_maxZeds = floor (random 6) + 2;
				
				for "_i" from 0 to _maxZeds - 1 do {

					_spawnMinRadius = 5;
					_spawnMaxRadius = 8;
					
					_zombiePosition = [(position _building), (random _spawnMaxRadius) + _spawnMinRadius, random 360] call BIS_fnc_relPos;
					_agent = createAgent ["Zombie", _zombiePosition, [], 0, "NONE"];
					[_agent] call fnc_startZombie;
				};
				
				_building setVariable ["helicrashSpawnZeds", false, true];
			};
		} else {
			
			for "_i" from 0 to count (_lootArray) - 1 do {
				deleteVehicle (_lootArray select _i);
			};


			_building setVariable ["lootarray", []];
			_building call building_spawnLoot;
		};
	};
};

