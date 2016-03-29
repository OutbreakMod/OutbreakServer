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

// database connection
_connected = ["MySQL", "SQL_RAW_V2", "ADD_QUOTES"] execVM "addons\outbreak_server\extdb2\init.sqf";

if (_connected) then {
	
	SQL_ID = uiNamespace getVariable ["extDB_SQL_CUSTOM_ID", ""];

	// run variables
	[] execVM "addons\outbreak_server\variables.sqf";

	// compile functions
	call compile preprocessFileLineNumbers "addons\outbreak_server\compiles.sqf";

	// run server
	[] execVM "addons\outbreak_server\init\server_init.sqf";

	// disconnect handler
	onPlayerDisconnected {[_uid,_name] spawn server_playerDisconnect;};
	init_done = true;
};