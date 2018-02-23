/*
	Server start/initialization
	@author: TheAmazingAussie
*/

// wait for functions
waitUntil{!isNil "BIS_fnc_findSafePos"};
waitUntil{!isNil "BIS_fnc_selectRandom"};

if (!isNil "init_done") exitWith {}; // prevent server_monitor be called twice (bug during login of the first player)
    
init_done = false;
if (init_done) exitWith {};

diag_log "SERVER INIT: Outbreak Mod";

call compile preprocessFileLineNumbers "addons\outbreak_server\compiles.sqf";
_isConnected = (["TestConnection"] call hive_static) == "true";

if (_isConnected) then {
	diag_log format["HIVE: Connecting to MySQL was successful"];

	[] execVM "addons\outbreak_server\variables.sqf";
	[] execVM "addons\outbreak_server\init\server_init.sqf";
    [] execVM "addons\outbreak_code\weather\real_weather.sqf";
	
	addMissionEventHandler ["HandleDisconnect", { 
		[_this select 0] spawn server_playerDisconnect; 
		false; 
	}];
	
} else {
	diag_log format["HIVE: Failed to connect to MySQL"];
};

init_done = true;