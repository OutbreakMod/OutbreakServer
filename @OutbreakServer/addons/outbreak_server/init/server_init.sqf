/*
	Server monitor for time syncing, etc
	@author: TheAmazingAussie
*/

private ["_dynamicEvents", "_timeSettings", "_objects", "_setting", "_position", "_dir", "_veh", "_i"];

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
///   World Storage Objs ///
////////////////////////////

diag_log "SERVER: Running world storage objects";

_objects = ["GetUserStorage"] call hive_static;
_objects = call compile(format["%1", _objects]);

for "_i" from 0 to (count _objects) - 1 do { 

	_obj = _objects select _i;
	
	_class = _obj select 1;
	_worldspace = _obj select 2;
	_dir = _obj select 3;
	
	_veh = createVehicle [_class, (_worldspace select 0), [], 0, "CAN_COLLIDE"];
	_veh setPos (_worldspace select 0);
	_veh setDir _dir;
	_veh setVectorDir (_worldspace select 1);
	_veh setVectorUp (_worldspace select 2);
	_veh setVariable ["ObjectID", _obj select 0, true];

	// add items from db into object
	[_veh, (_obj select 4)] call server_objectAddInventory;
	
};

////////////////////
///   Scheduler  ///
////////////////////

diag_log "SERVER: Running scheduler";

_scheduler = [
	[false, 80, "spawn_crashsite"]
];

[_scheduler] execVM "addons\outbreak_server\scheduler\scheduler_init.sqf";