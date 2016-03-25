/*
	Server start/initialization
	@author: TheAmazingAussie
*/

// wait for functions
waitUntil{!isNil "BIS_fnc_findSafePos"};
waitUntil{!isNil "BIS_fnc_selectRandom"};

if (!isNil "init_done") exitWith {}; // prevent server_monitor be called twice (bug during login of the first player)
if (init_done) exitWith {};

init_done = false;

diag_log "SERVER INIT: Outbreak Mod";

// run variables
[] execVM "addons\outbreak_server\variables.sqf";

call compile preprocessFileLineNumbers "addons\outbreak_server\compiles.sqf";

// run server
[] execVM "addons\outbreak_server\init\server_init.sqf";

// disconnect handler
onPlayerDisconnected {[_uid,_name] spawn server_playerDisconnect;};