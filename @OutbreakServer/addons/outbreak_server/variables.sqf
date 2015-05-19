/*
	Register server-side variables
	@author: TheAmazingAussie
*/

// Sets civilians hostile towards blufor

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

"player_agentsSpawnCheck" addPublicVariableEventHandler {

	_packet = _this select 1;
	_pos = _packet select 0;

	_animalRadius = 5;
	_minimumSpawnRadius = 20;
	_maximumSpawnRadius = 30;
	
	_animalAgents = ["Sheep_random_F"];
	
//	_nearAnimals = _pos nearEntities [_animalAgents, _maximumSpawnRadius];
//
//	if ((count _nearAnimals) < _animalRadius) then {
//		
//		_animalsToSpawn = _animalRadius - (count _nearAnimals);	
//		
//		for "_i" from 1 to (_animalsToSpawn) do { 
//			_animalType = _animalAgents call BIS_fnc_selectRandom;
//			diag_log format["Animal spawn request %1 -- %2 -- %3", _maximumSpawnRadius, _maximumSpawnRadius, _animalType];
//			[_maximumSpawnRadius, _minimumSpawnRadius, _animalType, _pos] spawn player_spawnAnimal;
//		};
//	};
};


//[91,34,34,44,34,34,44,34,34,44,60,110,117,108,108,62,44,34,34,44,60,110,117,108,108,62,44,34,34,44,60,110,117,108,108,62,44,34,34,44,60,110,117,108,108,62,44,91,93,44,34,34,44,60,110,117,108,108,62,44,91,93,44,34,34,44,60,110,117,108,108,62,44,91,93,44,60,110,117,108,108,62,93]

"hive_playerSave" addPublicVariableEventHandler {

	_packet = _this select 1;
	_packet spawn server_clientSave;
	
	//diag_log format["Process save for: %1 - %2", getPlayerUID _player, name _player];
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
	_class = _packet select 1;
	
	_worldspace = _packet select 2;
	_dir = _packet select 3;
	
	_inventory = [];
	
	_update = format["NewObject, '%1','%2','%3','%4'", _class, _worldspace, _dir, _inventory];
	diag_log _update;
	
	_response = [_update] call hive_static;
	diag_log format ["response: %1", _response];
	
	_vehicle setVariable ["ObjectID", parseNumber(_response), true]
};

"hive_updateObject" addPublicVariableEventHandler {

	_packet = _this select 1;
	
	_player = _packet select 0;
	_vehicle = _packet select 1;
	_id = _vehicle getVariable ["ObjectID", 0];
	_inventory = [];
	
	// public string NewObject(String clazz, String position, String dir, String inventory)
	
	if (_id == 0) exitWith { diag_log format["Saving object failed, no object ID"]; };
	
	_update = format["UpdateObject, '%1','%2'", _id, _inventory];
	[_update] call hive_static;
};
