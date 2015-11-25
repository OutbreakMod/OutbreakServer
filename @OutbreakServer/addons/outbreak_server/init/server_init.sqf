/*
	Server monitor for time syncing, etc
	@author: TheAmazingAussie
*/

private ["_dynamicEvents", "_timeSettings", "_objects", "_setting", "_position", "_dir", "_veh", "_i", "_spawns", "_class", "_position", "_objectSpawns"];

if (OUTBREAK_EXTRA_BUILDINGS) then {
	diag_log format ["Adding extra buildings for: %1", toLower(OUTBREAK_MAP)];
	[] execVM format["addons\outbreak_code\extra_buildings\%1\init.sqf", toLower(OUTBREAK_MAP)];
};

_chance = 0.6;

86400 setOvercast _chance;
skipTime 24;
skipTime -24;
86400 setOvercast _chance;
skipTime 24;

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

_objects = ["GetObjectStorage, 'DEV001'"] call hive_static;
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
		
		_veh = createVehicle [_class, _position, [], 0, "CAN_COLLIDE"];
		_location = _veh modelToWorld [0,0,0];
		[_veh] call vehicle_damage;
		
		_type = typeOf _veh;
		_hitPoints = (count (configFile >> "CfgVehicles" >> _type >> "HitPoints")) - 1;
		_sections = [];

		for "_i" from 0 to _hitPoints do {

			_selected = (configFile >> "CfgVehicles" >> _type >> "HitPoints") select _i;
			_selectedName = getText(_selected >> "name");
			_sections = _sections + [_selectedName];
		};
		
		_savedHitPoints = [];
		
		for "_i" from 0 to (count _sections) - 1 do { 
		
			_hitDamage = _veh getHit (_sections select _i);
			_savedHitPoints = _savedHitPoints + [[(_sections select _i), _hitDamage]];	
		};
		
		// create worldspace
		_worldspace = [_location, vectorDir _veh, vectorUp _veh];
		
		_fuel = fuel _veh;
		_damage = damage _veh;
		
		// insert into db
		_update = format["NewObject, 'DEV001','%1','%2','%3','%4','%5','%6','%7'", _class, _worldspace, _dir, "", _savedHitPoints, _fuel, _damage];
		_response = [_update] call hive_static;
		
		diag_log format ["hive_newObject response: %1", _response];

		deleteVehicle (_veh);
		
	} forEach _objectSpawns;

};

////////////////////////////
///   World Storage Objs ///
////////////////////////////

diag_log "SERVER: Running world storage objects";

_objects = ["GetObjectStorage, 'DEV001'"] call hive_static;
_objects = call compile(format["%1", _objects]);

waitUntil {!isNil "_objects"};
sleep 0.5;

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
	
	_damage = _obj select 7;
	_veh setDamage _damage;
	
	_fuel = _obj select 6;
	_veh setFuel _fuel;
	
	_hitpoints = _obj select 5;
	
	{
		_hit = _x select 0;
		_dmg = _x select 1;
		
		_veh setHit [_hit, _dmg];
		
	} foreach _hitpoints;
	
};

////////////////////
///   Scheduler  ///
////////////////////

diag_log "SERVER: Running scheduler";

_scheduler = [
	[false, 80, "spawn_crashsite"]
];

[_scheduler] execVM "addons\outbreak_server\scheduler\scheduler_init.sqf";