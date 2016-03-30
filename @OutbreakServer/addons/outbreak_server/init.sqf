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
_connected = ["MySQL", "SQL_RAW_V2", "ADD_QUOTES"] call DB_fnc_init;

if (_connected) then {
	
	[] execVM "addons\outbreak_server\variables.sqf";
	[] execVM "addons\outbreak_server\init\server_init.sqf";
	onPlayerDisconnected {[_uid,_name] spawn server_playerDisconnect;};
	init_done = true;
};