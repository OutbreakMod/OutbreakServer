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

	while {true} do {
	
		{
		
			_once = (_x select 0);
			_interval = (_x select 1) * 60;  // convert to seconds
			_execute = (_x select 2);

			if (!_once) then {
				if ((_tick % _interval) == 0) then {
					[] execVM format["addons\outbreak_server\scheduler\%1.sqf", _execute];
				};
			};
			
		} foreach _this;
		
		sleep 1;
		_tick = _tick + 1;
	};
};