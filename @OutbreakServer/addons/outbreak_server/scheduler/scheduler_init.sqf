/*	
	Scheduler system for main server
	@author: TheAmazingAussie
*/

_scheduleArray = _this select 0;

diag_log format["Schedule array: %1", _scheduleArray];

//////////////////////////
// LOG ADDED SCHEDULED TASKS
//////////////////////////
_counter = 0;

{

	_once = (_x select 0);  // convert to seconds
	_interval = (_x select 1) * 60;  // convert to seconds
	_execute = (_x select 2);
			
	_counter = _counter + 1;
	diag_log format["Found schedule (%1) with minutes interval (%2): %3", _counter, _interval, _execute];
	
	if (_once) then {
		[] execVM format["addons\outbreak_server\scheduler\%1.sqf", _execute];
	};
	
} foreach _scheduleArray;

//////////////////////////
// START SCHEDULE THREAD
//////////////////////////
_scheduleArray spawn {

	_tick = 0;
	_cleanUp = [];

	while {true} do {
	
		{
		
			_once = (_x select 0);
			_interval = (_x select 1) * 60;  // convert to seconds
			_execute = (_x select 2);

			if (!_once) then {
				if ((_tick % _interval) == 0) then {
					
					dynamic_event = compile preProcessFileLineNumbers format["addons\outbreak_server\scheduler\%1.sqf", _execute];
					_object = [_execute] call dynamic_event;
					
					// if cleanup has objects, clean them up
					if (count _cleanUp > 0) then {
					
						for "_i" from 0 to (count _cleanUp) - 1 do { 
							
							_itemDespawn = _cleanUp select _i;	
							
							if (!isNil "_itemDespawn") then {
							
								_itemType = _itemDespawn getVariable ["spawnType", ""];
								
								if (_execute == _itemType) then {
									_itemDespawn call scheduler_despawn;
									_cleanUp = _cleanUp - [_itemDespawn];
								};
							};
						};
					};
					
					// add object to be cleaned up
					_cleanUp = _cleanUp + [_object];
				};
			};
			
		} foreach _this;
		
		sleep 1;
		_tick = _tick + 1;
	};
};

scheduler_despawn = {

	private ["_despawn", "_markerID"];

	_despawn = _this;
	_lootArray = _despawn getVariable ["lootarray", []];
	_markerID = _despawn getVariable ["markerID", ""];

	{
		_type = typeOf _x;
		
		if (_type == "test_EmptyObjectForSmoke") then {
			_x call fnc_deleteVehicle;
		} else {
			deleteVehicle(_x);
		};
		
	} foreach _lootArray;
	
	deleteVehicle (_despawn);	
	deleteMarker _markerID;
	
};

// ---
// https://community.bistudio.com/wiki/deleteVehicle
// ---
fnc_deleteVehicle = {
	_this addMPEventHandler ["MPKilled", {
		_this = _this select 0;
		{
			deleteVehicle _x;
		} forEach (_this getVariable ["effects", []]);
		if (isServer) then {
			deleteVehicle _this;
		};
	}];
	_this setDamage 1; 
};