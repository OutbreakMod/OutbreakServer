/*
	Server monitor for time syncing, etc
	@author: TheAmazingAussie
*/

private ["_dynamicEvents", "_timeSettings", "_objects", "_setting", "_position", "_dir", "_veh", "_i", "_spawns", "_class", "_position", "_objectSpawns"];

if (OUTBREAK_EXTRA_BUILDINGS) then {
	diag_log format ["Adding extra buildings for: %1", toLower(OUTBREAK_MAP)];
	[] execVM format["addons\outbreak_code\extra_buildings\%1\init.sqf", toLower(OUTBREAK_MAP)];
};

diag_log format ["Running server with hive: %1", MOD_HIVE];

////////////////////////////
///  Time sync functions ///
////////////////////////////

diag_log format["TIME SYNC: Loading time sync settings.."];

_timeSetting = ["TIME_SETTING"] call hive_config;
_value = ["TIME_VALUE"] call hive_config;

if (_timeSetting == "Custom") then {
	setDate [date select 0, date select 1, date select 2, parseNumber (_value), date select 4];
};

if (_timeSetting == "Local") then {
	_newDate = ["GetDateNow"] call hive_static;
	_newDate = call compile(format["%1", _newDate]);
	setDate _newDate;
};

if (_timeSetting == "Static") then {
	_newDate = ["GetDateTimezone"] call hive_static;
	_newDate = call compile(format["%1", _newDate]);
	setDate _newDate;
};

//[[[],[]],[[],[]],[[],[]],[[],[]]]

diag_log format["TIME SYNC: Time type: %1 with setting: %2", _timeSetting, _value];

////////////////////////////
///   Vehicle Spawn Objs ///
////////////////////////////

_objects = [format["GetObjectStorage, '%1'", MOD_HIVE]] call hive_static;
_objects = call compile(format["%1", _objects]);

_objectSpawns = ["GetObjectSpawns"] call hive_static;
_objectSpawns = call compile(format["%1", _objectSpawns]);

waitUntil {!isNil "_objects"};
waitUntil {!isNil "_objectSpawns"};

sleep 0.5;

if (count _objects < 1) then {

	{
		_class = _x select 1;
		_position = _x select 2;
		_dir = _x select 3;
		
		_veh = [_class, _position, _dir] call hive_new_vehicle;
		deleteVehicle (_veh); // delete the vehicle because the next function will load it
		
	} forEach _objectSpawns;

};

////////////////////////////
///   World Storage Objs ///
////////////////////////////

diag_log "SERVER: Running world storage objects";

_objects = [format["GetObjectStorage, '%1'", MOD_HIVE]] call hive_static;
_objects = call compile(format["%1", _objects]);

diag_log format ["SERVER HIVE OBJECTS: %1", _objects];

waitUntil {!isNil "_objects"};
sleep 0.5;

for "_i" from 0 to (count _objects) - 1 do { 

	_obj = _objects select _i;
	
	_id = _obj select 0;
	_class = _obj select 1;
	_worldspace = _obj select 2;
	_inventory = _obj select 3;
	_hitpoints = _obj select 4;
	_fuel = _obj select 5;
	_damage = _obj select 6;
	_lifetime = _obj select 7;
	
	_veh = createVehicle [_class, (_worldspace select 0), [], 0, "CAN_COLLIDE"];
	_veh setPos (_worldspace select 0);
	_veh setVectorDir (_worldspace select 1);
	_veh setVectorUp (_worldspace select 2);
	_veh setDir (_worldspace select 3);
	_veh setVariable ["ObjectID", _id, true];
	_veh setVariable ["ObjectLifetime", _lifetime];

	[_veh, _inventory] call server_objectAddInventory;
	
	_veh setDamage _damage;
	_veh setFuel _fuel;
	
	{
		_hit = _x select 0;
		_dmg = _x select 1;
		
		_veh setHit [_hit, _dmg];
		
	} foreach _hitpoints;
	
	[_veh] call object_add_cleanup;
	
};

////////////////////
///   Scheduler  ///
////////////////////

diag_log "SERVER: Running scheduler";

_scheduler = [
	[false, 5, "spawn_us_crashsite"],
	[false, 5, "spawn_ru_crashsite"]
];

[_scheduler] execVM "addons\outbreak_server\scheduler\scheduler_init.sqf";

diag_log "Running cleanup thread";
[] execVM "addons\outbreak_server\scheduler\cleanup_array.sqf";

//diag_log "SERVER: Running clean up thread";
//[] execVM "addons\outbreak_server\scheduler\cleanup.sqf";

diag_log "Server successfully started!";