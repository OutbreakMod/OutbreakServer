/*
	Server start/initialization
	@author: TheAmazingAussie
*/

// wait for functions
waitUntil{!isNil "BIS_fnc_findSafePos"};
waitUntil{!isNil "BIS_fnc_selectRandom"};

diag_log "SERVER INIT: Outbreak Mod";

// run variables
[] execVM "addons\outbreak_server\variables.sqf";

call compile preprocessFileLineNumbers "addons\outbreak_server\compiles.sqf";

// run server
[] execVM "addons\outbreak_server\init\server_init.sqf";

// disconnect handler
onPlayerDisconnected {[_uid,_name] spawn server_playerDisconnect;};