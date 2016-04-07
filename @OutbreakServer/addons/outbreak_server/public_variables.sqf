"hive_playerLogin" addPublicVariableEventHandler {

	_packet = _this select 1;
	_player = _packet select 0;
	
	_uuid = format["%1", getPlayerUID _player];
	_exists = ["users", "uuid", _uuid] call hive_exists;
	
	if (_exists) then {
	
		_userData = _player call hive_get_user;
		
		waitUntil {!isNil "_userData"};
	
		_inventory = _userData select 2;
		_inventory = call compile(toString _inventory);		
	
		[_player, ["gear", _inventory]] call server_clientCommand;
		[_player, ["tp", _userData select 3]] call server_clientCommand;
		[_player, ["medical", _userData select 4]] call server_clientCommand;
		[_player, ["login"]] call server_clientCommand;
		
		// Update name
		if (_name != "Error: No unit") then {
			["users", "name", _name, "uuid", _uuid] call hive_write;
		};

	} else {
		
		_player call hive_new_user;
		
		[_player, ["findspawn"]] call server_clientCommand;
		[_player, ["login"]] call server_clientCommand;		
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
	_update = format["NewObject, '%1','%2','%3','%4','%5','%6','%7','%8','%9'", MOD_HIVE, _vehicle getVariable ["ObjectID", 0], _class, _worldspace, _dir, _inventory, _hitPoints, _fuel, _damage];
	[_update] call hive_static;
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
					[[_zombiePosition, _building], false] call zombie_initialize;
				};
				
				_building setVariable ["helicrashSpawnZeds", false, true];
			};
		} else {
			
			if (_building getVariable ["lootRespawn", true]) then {
				for "_i" from 0 to count (_lootArray) - 1 do {
					deleteVehicle (_lootArray select _i);
				};
			};
			
			_building setVariable ["lootarray", []];
			_building call building_spawnLoot;
		};
	};
};

"server_spawnZombie" addPublicVariableEventHandler {
	
	_packet = _this select 1;
	_position = _packet select 0;
	
	_agent = createAgent ["Zombie", _position, [], 0, "NONE"];
	[_agent] call fnc_zombie;
};

"server_cleanup" addPublicVariableEventHandler {
	
	_packet = _this select 1;
	
	_vehicle = _packet select 0;
	_timeToDespawn = _packet select 1;
	
	_vehicle setVariable ["cleanupTime", _timeToDespawn];
	CLEANUP_ARRAY = CLEANUP_ARRAY + [_vehicle];
};