/*
	Create crash sites
	@author: TheAmazingAussie
*/

//private ["_crashSiteType", "_maxLootRadius", "_minLootRadius", "_needsrelocated", "_model", "_marker", "_istoomany", "_crash"];

_lootArray = [];
_randomLootNum = 3;
_guaranteedLoot  = 4;

_maxLootRadius = 5;
_minLootRadius = 3;

_fire = true;

_crashModels = ["MOD_Mi8Wreck", "Mi8Wreck", "MOD_UH1YWreck", "Land_Wreck_Heli_Attack_02_F"];
_model = _crashModels call BIS_fnc_selectRandom;

// find heli crash site model
_lootTable = configFile >> "CfgBuildingType" >> _model;
_heightAdjustment = 0;

if (_model == "MOD_Mi8Wreck") then {
	_heightAdjustment = 2;
};

_needsrelocated = true;
_position = [];

while {_needsrelocated} do {
	_position = [getMarkerPos "center", 0, 7000, 10, 0, 2000,0] call BIS_fnc_findSafePos;
	_istoomany = _position nearObjects ["AllVehicles", 5];
	if (count _istoomany == 0) then { 
		_needsrelocated = false; 
	};
};

_crash = createVehicle [_model, _position, [], 0, "CAN_COLLIDE"];
_crash setDir (random 360);

_newPos = _crash modelToWorld [0,0,0];
_newPos set [2, _heightAdjustment]; // height adjustment
_crash setPos _newPos;

if (_model != "Mi8Wreck") then {
	_fireEffect = createVehicle ["test_EmptyObjectForSmoke", _newPos, [], 0, "CAN_COLLIDE"];
	_fireEffect setDir (random 360);
};

// spawn loot
_num = round(random _randomLootNum) + _guaranteedLoot;

// combine all loot into one array
_buildingLoot = _model call building_items;

if (count (_buildingLoot) > 0) then {
	while {count(_crash getVariable ["lootarray", []]) < _num} do {
		for "_i" from 0 to count (_buildingLoot) - 1 do {				
			_loot = _buildingLoot select _i;

			if ((random 1) < (_loot select 2)) then {
				
				_maxLootRadius = (random _maxLootRadius) + _minLootRadius;
				_lootPos = [_position, _maxLootRadius, random 360] call BIS_fnc_relPos;
				
				_item = [_lootPos, _loot select 0, _loot select 1, _model] call loot_holder;
				
				_lootArray = _lootArray + [_item];
				_crash setVariable ["lootarray", _lootArray, true];
				_crash setVariable ["loottimer", 0, true, true];
				_crash getVariable ["lootRespawn", false, true];
			};
		};
	};
};

_markerstr = createMarker [str(_position), _position];
_markerstr setMarkerShape "ICON";
_markerstr setMarkerType "mil_dot";
_markerstr setMarkerText _model;