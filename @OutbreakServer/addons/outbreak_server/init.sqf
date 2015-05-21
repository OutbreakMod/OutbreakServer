/*
	Server start/initialization
	@author: TheAmazingAussie
*/

// wait for functions
waitUntil{!isNil "BIS_fnc_findSafePos"};
waitUntil{!isNil "BIS_fnc_selectRandom"};

diag_log "SERVER INIT: Outbreak Mod";

//setWind [10, 10, true];

// variables
[] execVM "addons\outbreak_server\variables.sqf";

// hive
hive_read = compile preProcessFileLineNumbers "addons\outbreak_server\functions\hive\hive_read.sqf";
hive_write = compile preProcessFileLineNumbers "addons\outbreak_server\functions\hive\hive_write.sqf";
hive_exists = compile preProcessFileLineNumbers "addons\outbreak_server\functions\hive\hive_exists.sqf";
hive_delete = compile preProcessFileLineNumbers "addons\outbreak_server\functions\hive\hive_delete.sqf";
hive_config = compile preProcessFileLineNumbers "addons\outbreak_server\functions\hive\hive_config.sqf";
hive_static = compile preProcessFileLineNumbers "addons\outbreak_server\functions\hive\hive_static.sqf";

//server
server_spawnDynamicEvent = compile preProcessFileLineNumbers "addons\outbreak_server\functions\server_spawnDynamicEvent.sqf";
server_spawnCityWrecks = compile preProcessFileLineNumbers "addons\outbreak_server\functions\server_spawnCityWrecks.sqf";
server_objectAddInventory = compile preProcessFileLineNumbers "addons\outbreak_server\functions\server_objectAddInventory.sqf";
server_findSpawn = compile preProcessFileLineNumbers "addons\outbreak_server\functions\server_findSpawn.sqf";
server_clientCommand = compile preProcessFileLineNumbers "addons\outbreak_server\functions\server_clientCommand.sqf";
server_clientSave = compile preProcessFileLineNumbers "addons\outbreak_server\functions\server_clientSave.sqf";
server_playerDisconnect = compile preProcessFileLineNumbers "addons\outbreak_server\functions\server_playerDisconnect.sqf";

// inserts
hive_newUser = compile preProcessFileLineNumbers "addons\outbreak_server\functions\hive\hive_newUser.sqf";

// ai
zombie_ai = compile preProcessFileLineNumbers "addons\outbreak_server\functions\zombie_ai.sqf";
fnc_infectedContact = compile preProcessFileLineNumbers "addons\outbreak_server\functions\fnc\fnc_infectedContact.sqf";
fnc_infectedNextSound = compile preProcessFileLineNumbers "addons\outbreak_server\functions\fnc\fnc_infectedNextSound.sqf";

// player
player_clearInventory = compile preProcessFileLineNumbers "addons\outbreak_code\functions\player_clearInventory.sqf";
player_loadInventory = compile preProcessFileLineNumbers "addons\outbreak_code\functions\player_loadInventory.sqf";
player_serializeInventory = compile preProcessFileLineNumbers "addons\outbreak_code\functions\player_serializeInventory.sqf";
player_spawnAnimal = compile preProcessFileLineNumbers "addons\outbreak_code\functions\player_spawnAnimal.sqf";
player_hiveSync = compile preProcessFileLineNumbers "addons\outbreak_code\functions\player_hiveSync.sqf";

// loot stuff
building_items = compile preProcessFileLineNumbers "addons\outbreak_code\functions\building_items.sqf";
loot_holder = compile preProcessFileLineNumbers "addons\outbreak_code\functions\loot_holder.sqf";

// ai
zombie_ai = compile preProcessFileLineNumbers "addons\outbreak_code\functions\zombie_ai.sqf";
fnc_infectedContact = compile preProcessFileLineNumbers "addons\outbreak_code\functions\fnc\fnc_infectedContact.sqf";
fnc_infectedNextSound = compile preProcessFileLineNumbers "addons\outbreak_code\functions\fnc\fnc_infectedNextSound.sqf";

// disconnect handler
onPlayerDisconnected {[_uid,_name] spawn server_playerDisconnect;};

// run server
[] execVM "addons\outbreak_server\init\server_monitor.sqf";

