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

_crashModels = ["Land_Wreck_Van_F"];
_model = _crashModels call BIS_fnc_selectRandom;

// find heli crash site model
_lootTable = configFile >> "CfgBuildingType" >> "MOD_UH1YWreck";


_needsrelocated = true;
_position = [];

while {_needsrelocated} do {
	
	_position = RoadList call BIS_fnc_selectRandom;
	_position = _position modelToWorld [0,0,0];
	_position = [_position,5,20,5,0,2000,0] call BIS_fnc_findSafePos;
	
	_istoomany = _position nearObjects ["All", 5];
	
	if (count _istoomany == 0) then { 
		_needsrelocated = false; 
	};
};

_crash = createVehicle [_model, _position, [], 0, "CAN_COLLIDE"];
_crash setDir (random 360);
_crash enableSimulation false;

_newPos = _crash modelToWorld [0,0,0];
_crash setPos _newPos;

if (_model != "Mi8Wreck") then {
	_fireEffect = createVehicle ["test_EmptyObjectForSmoke", _newPos, [], 0, "CAN_COLLIDE"];
	_fireEffect setDir (random 360);
};

// spawn loot
_num = round(random _randomLootNum) + _guaranteedLoot;

// combine all loot into one array
_buildingLoot = _model call building_items;

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
				_crash setVariable ["lootarray", _lootArray];
				_crash setVariable ["loottimer", 0, true];
				_crash getVariable ["lootRespawn", false];
			};
		};
	};
};

_markerstr = createMarker [str(_position), _position];
_markerstr setMarkerShape "ICON";
_markerstr setMarkerType "mil_dot";
_markerstr setMarkerText _model;