OUTBREAK_MAP = "Chernarus";
OUTBREAK_SPAWN_SHORE_MODE = 1;
OUTBREAK_SPAWN_AREA = 1500;
OUTBREAK_EXTRA_BUILDINGS = true;

if (isServer) then {
	
	// init server
	call compile preprocessFileLineNumbers "addons\outbreak_server\init.sqf";
	
	// add extra buildings, comment next line to disable
	if (OUTBREAK_EXTRA_BUILDINGS) then {
		[] execVM format["addons\outbreak_code\extra_buildings\%1\init.sqf", toLower(OUTBREAK_MAP)];
	};
	
	// dynamic weather
	[] execVM "real_weather.sqf";
};

if (isDedicated) exitWith {}; // CLIENT ONLY BELOW THIS LINE
waitUntil {!isNull player};

// init variables and functions for player connected
call compile preprocessFileLineNumbers "addons\outbreak_code\init.sqf";

// called when a fresh player has spawned, for starting gear
player_missionSpawn = {
	player addWeapon "ItemMap";
	
	_clothes = getArray (configFile >> "CfgZombies" >> "CfgClothes" >> "civilian");
	player addUniform (_clothes call BIS_fnc_selectRandom);	
};

// called when a player logs in (called after missionSpawn if new character)
player_missionLogin = {
	execVM "fusionsmenu\admin\activate.sqf";
};
