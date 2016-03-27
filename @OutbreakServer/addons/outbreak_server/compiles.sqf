// hive
hive_read = compile preProcessFileLineNumbers "addons\outbreak_server\functions\hive\hive_read.sqf";
hive_write = compile preProcessFileLineNumbers "addons\outbreak_server\functions\hive\hive_write.sqf";
hive_exists = compile preProcessFileLineNumbers "addons\outbreak_server\functions\hive\hive_exists.sqf";
hive_delete = compile preProcessFileLineNumbers "addons\outbreak_server\functions\hive\hive_delete.sqf";
hive_config = compile preProcessFileLineNumbers "addons\outbreak_server\functions\hive\hive_config.sqf";
hive_static = compile preProcessFileLineNumbers "addons\outbreak_server\functions\hive\hive_static.sqf";
hive_new_vehicle = compile preProcessFileLineNumbers "addons\outbreak_server\functions\hive\hive_new_vehicle.sqf";
create_uid = compile preProcessFileLineNumbers "addons\outbreak_server\functions\create_uid.sqf";

//server
server_spawnCityWrecks = compile preProcessFileLineNumbers "addons\outbreak_server\functions\server_spawnCityWrecks.sqf";
server_objectAddInventory = compile preProcessFileLineNumbers "addons\outbreak_server\functions\server_objectAddInventory.sqf";
server_findSpawn = compile preProcessFileLineNumbers "addons\outbreak_server\functions\server_findSpawn.sqf";
server_clientSave = compile preProcessFileLineNumbers "addons\outbreak_server\functions\server_clientSave.sqf";
server_playerDisconnect = compile preProcessFileLineNumbers "addons\outbreak_server\functions\server_playerDisconnect.sqf";
server_clientCommand = compile preProcessFileLineNumbers "addons\outbreak_server\functions\server_clientCommand.sqf";

// inserts
hive_newUser = compile preProcessFileLineNumbers "addons\outbreak_server\functions\hive\hive_newUser.sqf";

// building
building_items = compile preProcessFileLineNumbers "addons\outbreak_server\functions\building_items.sqf";
building_spawnLoot = compile preProcessFileLineNumbers "addons\outbreak_server\functions\building_spawnLoot.sqf";
loot_holder = compile preProcessFileLineNumbers "addons\outbreak_server\functions\loot_holder.sqf";

// vehicles
vehicle_damage = compile preProcessFileLineNumbers "addons\outbreak_server\functions\vehicle_damage.sqf";

// general player functions
player_respawn = compile preProcessFileLineNumbers "addons\outbreak_code\functions\player_respawn.sqf";
player_killed = compile preProcessFileLineNumbers "addons\outbreak_code\functions\player_killed.sqf";
player_findSpawn = compile preProcessFileLineNumbers "addons\outbreak_code\functions\player_findSpawn.sqf";
player_scheduler_actions = compile preProcessFileLineNumbers "addons\outbreak_code\functions\player_scheduler_actions.sqf";
player_hiveSync = compile preProcessFileLineNumbers "addons\outbreak_code\functions\player_hiveSync.sqf";
player_pressKey = compile preProcessFileLineNumbers "addons\outbreak_code\functions\player_pressKey.sqf";
player_handleDamage = compile preProcessFileLineNumbers "addons\outbreak_code\functions\player_handleDamage.sqf";
zombie_handleDamage = compile preProcessFileLineNumbers "addons\outbreak_code\functions\zombie_handleDamage.sqf";
player_command = compile preProcessFileLineNumbers "addons\outbreak_code\functions\player_command.sqf";
player_findNearby = compile preProcessFileLineNumbers "addons\outbreak_code\functions\player_findNearby.sqf";

// inventory
player_clearInventory = compile preProcessFileLineNumbers "addons\outbreak_code\functions\player_clearInventory.sqf";
player_loadInventory = compile preProcessFileLineNumbers "addons\outbreak_code\functions\player_loadInventory.sqf";
player_serializeInventory = compile preProcessFileLineNumbers "addons\outbreak_code\functions\player_serializeInventory.sqf";
player_selectItem = compile preProcessFileLineNumbers "addons\outbreak_code\functions\player_selectItem.sqf";

// fnc functions
fnc_inString = compile preProcessFileLineNumbers "addons\outbreak_code\functions\fnc\fnc_inString.sqf";
fnc_getServerVehicle = compile preProcessFileLineNumbers "addons\outbreak_code\functions\fnc\fnc_getServerVehicle.sqf";
fnc_hasItem = compile preProcessFileLineNumbers "addons\outbreak_code\functions\fnc\fnc_hasItem.sqf";
fnc_countItems = compile preProcessFileLineNumbers "addons\outbreak_code\functions\fnc\fnc_countItems.sqf";
object_speak = compile preProcessFileLineNumbers "addons\outbreak_code\functions\object_speak.sqf";
fnc_damageType = compile preProcessFileLineNumbers "addons\outbreak_code\functions\fnc\fnc_damageType.sqf";
fnc_damageEffect = compile preProcessFileLineNumbers "addons\outbreak_code\functions\fnc\fnc_damageEffect.sqf";
fnc_simulateHealthEffect = compile preProcessFileLineNumbers "addons\outbreak_code\functions\fnc\fnc_simulateHealthEffect.sqf";
fnc_selectRandomLocation = compile preProcessFileLineNumbers "addons\outbreak_code\functions\fnc\fnc_selectRandomLocation.sqf";
fnc_selectRandom = compile preProcessFileLineNumbers "addons\outbreak_code\functions\fnc\fnc_selectRandom.sqf";

// actions
player_build = compile preProcessFileLineNumbers "addons\outbreak_code\actions\player_build.sqf";
player_apply_morphine = compile preProcessFileLineNumbers "addons\outbreak_code\actions\apply_morphine.sqf";

// infected
player_spawnZombies = compile preProcessFileLineNumbers "addons\outbreak_code\functions\player_spawnZombies.sqf";
fnc_startZombie = compile preProcessFileLineNumbers "addons\outbreak_code\functions\ai\fnc_startZombie.sqf";
fnc_findTarget = compile preProcessFileLineNumbers "addons\outbreak_code\functions\ai\fnc_findTarget.sqf";
fnc_hasTarget = compile preProcessFileLineNumbers "addons\outbreak_code\functions\ai\fnc_hasTarget.sqf";