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
	
	_player addPrimaryWeaponItem "acc_flashlight";
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
	
	_update = format["NewObject, '%1','%2','%3','%4','%5','%6','%7'", _class, _worldspace, _dir, _inventory, _hitPoints, _fuel, _damage];
	_response = [_update] call hive_static;
	
	diag_log format ["hive_newObject response: %1", _response];
	
	_vehicle setVariable ["ObjectID", parseNumber(_response), true]
};
