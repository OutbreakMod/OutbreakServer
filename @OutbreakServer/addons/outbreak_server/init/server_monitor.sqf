/*
	Server monitor for time syncing, etc
	@author: TheAmazingAussie
*/

private ["_dynamicEvents", "_timeSettings", "_objects", "_setting", "_position", "_dir", "_veh", "_i"];

/////////////////////////////////
///  Dynamic events functions ///
/////////////////////////////////

// crash site configuration - per server restart
_dynamicEvents = [
	["helicopter_crash_site", 3]
];

// spawn dynamic events
{
	_event = _x select 0;
	_count = _x select 1;
	
	for "_i" from 0 to (_count) - 1 do { 
		[_event] call server_spawnDynamicEvent;
	};
	
} foreach _dynamicEvents;

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
	
	_itemInventory = _obj select 4;
	
};