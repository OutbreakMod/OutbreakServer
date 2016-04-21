// hive
hive_read = compile preProcessFileLineNumbers "addons\outbreak_server\functions\hive\hive_read.sqf";
hive_write = compile preProcessFileLineNumbers "addons\outbreak_server\functions\hive\hive_write.sqf";
hive_exists = compile preProcessFileLineNumbers "addons\outbreak_server\functions\hive\hive_exists.sqf";
hive_delete = compile preProcessFileLineNumbers "addons\outbreak_server\functions\hive\hive_delete.sqf";
hive_config = compile preProcessFileLineNumbers "addons\outbreak_server\functions\hive\hive_config.sqf";
hive_static = compile preProcessFileLineNumbers "addons\outbreak_server\functions\hive\hive_static.sqf";
hive_new_vehicle = compile preProcessFileLineNumbers "addons\outbreak_server\functions\hive\hive_new_vehicle.sqf";
hive_new_user = compile preProcessFileLineNumbers "addons\outbreak_server\functions\hive\hive_new_user.sqf";
hive_get_user = compile preProcessFileLineNumbers "addons\outbreak_server\functions\hive\hive_get_user.sqf";

//server
server_spawnCityWrecks = compile preProcessFileLineNumbers "addons\outbreak_server\functions\server_spawnCityWrecks.sqf";
server_objectAddInventory = compile preProcessFileLineNumbers "addons\outbreak_server\functions\server_objectAddInventory.sqf";
server_findSpawn = compile preProcessFileLineNumbers "addons\outbreak_server\functions\server_findSpawn.sqf";
server_clientSave = compile preProcessFileLineNumbers "addons\outbreak_server\functions\server_clientSave.sqf";
server_playerDisconnect = compile preProcessFileLineNumbers "addons\outbreak_server\functions\server_playerDisconnect.sqf";
object_lifetime = compile preProcessFileLineNumbers "addons\outbreak_server\functions\object_lifetime.sqf";

// building
building_items = compile preProcessFileLineNumbers "addons\outbreak_server\functions\building_items.sqf";
building_spawnLoot = compile preProcessFileLineNumbers "addons\outbreak_server\functions\building_spawnLoot.sqf";
loot_holder = compile preProcessFileLineNumbers "addons\outbreak_server\functions\loot_holder.sqf";

// vehicles
vehicle_damage = compile preProcessFileLineNumbers "addons\outbreak_server\functions\vehicle_damage.sqf";

// remote exc functions
remoteExec_add_cleanup = compile preProcessFileLineNumbers "addons\outbreak_server\functions\remote_exec\remoteExec_add_cleanup.sqf";
remoteExec_new_object = compile preProcessFileLineNumbers "addons\outbreak_server\functions\remote_exec\remoteExec_new_object.sqf";
remoteExec_player_delete = compile preProcessFileLineNumbers "addons\outbreak_server\functions\remote_exec\remoteExec_player_delete.sqf";
remoteExec_player_login = compile preProcessFileLineNumbers "addons\outbreak_server\functions\remote_exec\remoteExec_player_login.sqf";
remoteExec_player_save = compile preProcessFileLineNumbers "addons\outbreak_server\functions\remote_exec\remoteExec_player_save.sqf";
remoteExec_spawn_loot = compile preProcessFileLineNumbers "addons\outbreak_server\functions\remote_exec\remoteExec_spawn_loot.sqf";