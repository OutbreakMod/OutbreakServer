/*
	Spawn loot inside buildings based on a timer and spawn zombies around helicopter crash sites
	@author: TheAmazingAussie
*/

_building = _this select 0;

if (serverTime > _building getVariable ["loottimer", 0]) then {
	_lootArray = _building getVariable ["lootarray", []];
	
	if ((typeOf _building) in ["MOD_Mi8Wreck", "Mi8Wreck", "MOD_UH1YWreck", "Land_Wreck_Heli_Attack_02_F"]) then {
		if ((_building getVariable ["helicrashSpawnZeds", true])) then {
		
			_maxZeds = floor (random 6) + 2;
			
			for "_i" from 0 to _maxZeds - 1 do {

				_spawnMinRadius = 5;
				_spawnMaxRadius = 8;
				
				_zombiePosition = [(position _building), (random _spawnMaxRadius) + _spawnMinRadius, random 360] call BIS_fnc_relPos;
				[[_zombiePosition, _building], false] spawn zombie_create;
			};
			
			_building setVariable ["helicrashSpawnZeds", false, true];
		};
	} else {
		
		if (_building getVariable ["lootRespawn", true]) then {
			for "_i" from 0 to count (_lootArray) - 1 do {
				deleteVehicle (_lootArray select _i);
			};
		};
		
		_building setVariable ["lootarray", []];
		_building spawn building_spawnLoot;
	};
};