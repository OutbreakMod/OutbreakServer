/*
	Create crash sites
	@author: TheAmazingAussie
*/

private ["_item", "_buildingLoot", "_clutter", "_clutterPos", "_crash", "_crashModels", "_fire", "_fireEffect", "_guaranteedLoot", "_heightAdjustment", "_i", "_istoomany", "_item", "_itemPos", "_loot", "_lootArray", "_lootPos"];

_lootArray = [];
_spawnType = _this select 0;

_randomLootNum = 3;
_guaranteedLoot  = 4;

_maxLootRadius = 5;
_minLootRadius = 3;

_fire = true;

_crashModels = ["Mi8Wreck"];
_model = _crashModels call BIS_fnc_selectRandom;

_lootTable = configFile >> "CfgBuildingType" >> _model;
_heightAdjustment = 0;

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
_newPos set [2, _heightAdjustment];
_crash setPos _newPos;

_fireEffect = objNull;

if (_model != "Mi8Wreck") then {
	_fireEffect = createVehicle ["test_EmptyObjectForSmoke", _newPos, [], 0, "CAN_COLLIDE"];
	_fireEffect setDir (random 360);
};

_num = round(random _randomLootNum) + _guaranteedLoot;
_buildingLoot = _model call building_items;

if (count (_buildingLoot) > 0) then {
	while {count(_lootArray) < _num} do {
		for "_i" from 0 to count (_buildingLoot) - 1 do {				
			_loot = _buildingLoot select _i;

			if ((random 1) < (_loot select 2)) then {
				
				_maxLootRadius = (random _maxLootRadius) + _minLootRadius;
				_lootPos = [_position, _maxLootRadius, random 360] call BIS_fnc_relPos;
				
				_clutter = createVehicle ["ClutterCutter_small_2_EP1", _lootPos, [], 0, "CAN_COLLIDE"];
				_clutterPos = getPosATL _clutter;
				_clutterPos set [2, 0];
				_clutter setPosATL _clutterPos;
				
				_item = [_lootPos, _loot select 0, _loot select 1, _model] call loot_holder;
				_itemPos = getPosATL _item;
				_itemPos set [2, 0];
				_item setPosATL _itemPos;

				_lootArray = _lootArray + [_item];
			};
		};
	};
};

if (_fireEffect != objNull) then {
	_lootArray = _lootArray + [_fireEffect];
};

_crash setVariable ["lootarray", _lootArray, true];
_crash setVariable ["loottimer", 0, true];
_crash setVariable ["lootRespawn", false, true];
_crash setVariable ["spawnType", _spawnType, true];
_crash setVariable ["markerID", str(_position), true];

_markerstr = createMarker [str(_position), _position];
_markerstr setMarkerShape "ICON";
_markerstr setMarkerType "mil_dot";
_markerstr setMarkerText _model;

_crash;