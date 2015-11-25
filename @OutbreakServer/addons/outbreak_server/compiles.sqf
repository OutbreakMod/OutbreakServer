// hive
hive_read = compile preProcessFileLineNumbers "addons\outbreak_server\functions\hive\hive_read.sqf";
hive_write = compile preProcessFileLineNumbers "addons\outbreak_server\functions\hive\hive_write.sqf";
hive_exists = compile preProcessFileLineNumbers "addons\outbreak_server\functions\hive\hive_exists.sqf";
hive_delete = compile preProcessFileLineNumbers "addons\outbreak_server\functions\hive\hive_delete.sqf";
hive_config = compile preProcessFileLineNumbers "addons\outbreak_server\functions\hive\hive_config.sqf";
hive_static = compile preProcessFileLineNumbers "addons\outbreak_server\functions\hive\hive_static.sqf";

//server
server_spawnCityWrecks = compile preProcessFileLineNumbers "addons\outbreak_server\functions\server_spawnCityWrecks.sqf";
server_objectAddInventory = compile preProcessFileLineNumbers "addons\outbreak_server\functions\server_objectAddInventory.sqf";
server_findSpawn = compile preProcessFileLineNumbers "addons\outbreak_server\functions\server_findSpawn.sqf";
server_clientSave = compile preProcessFileLineNumbers "addons\outbreak_server\functions\server_clientSave.sqf";
server_playerDisconnect = compile preProcessFileLineNumbers "addons\outbreak_server\functions\server_playerDisconnect.sqf";
server_clientCommand = compile preProcessFileLineNumbers "addons\outbreak_server\functions\server_clientCommand.sqf";

// inserts
hive_newUser = compile preProcessFileLineNumbers "addons\outbreak_server\functions\hive\hive_newUser.sqf";

// player
player_clearInventory = compile preProcessFileLineNumbers "addons\outbreak_code\functions\player_clearInventory.sqf";
player_loadInventory = compile preProcessFileLineNumbers "addons\outbreak_code\functions\player_loadInventory.sqf";
player_serializeInventory = compile preProcessFileLineNumbers "addons\outbreak_code\functions\player_serializeInventory.sqf";
player_hiveSync = compile preProcessFileLineNumbers "addons\outbreak_code\functions\player_hiveSync.sqf";

// building
building_items = compile preProcessFileLineNumbers "addons\outbreak_server\functions\building_items.sqf";
building_spawnLoot = compile preProcessFileLineNumbers "addons\outbreak_server\functions\building_spawnLoot.sqf";
loot_holder = compile preProcessFileLineNumbers "addons\outbreak_server\functions\loot_holder.sqf";


// vehicles
vehicle_damage = compile preProcessFileLineNumbers "addons\outbreak_server\functions\vehicle_damage.sqf";