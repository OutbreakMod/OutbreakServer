/*
	Handles spawning of items
	@author: TheAmazingAussie
*/

private ["_lootPos", "_itemClass", "_itemType", "_buildingClass", "_magazine"];

_lootPos = _this select 0;
_itemClass = _this select 1;
_itemType = _this select 2;
_buildingClass = _this select 3;

_nearByPile = nearestObjects [_lootPos, ["WeaponHolderSimulated", "GroundWeaponHolder"], 1];
_weaponHolder = objNull;

 if (count _nearByPile == 0) then {
	_weaponHolder = createVehicle ["GroundWeaponHolder", _lootPos, [], 1, "CAN_COLLIDE"];
} else {
	_weaponHolder = _nearByPile select 0;
};

if (_itemType == "gun") then {

	_weaponHolder setVariable ["isLoot", true];
	_weaponHolder addWeaponCargoGlobal [_itemClass, 1];
	
	_amount = 0;
	
	if ((random 1) < 0.50) then {
		_amount = _amount + 1;
	};
    
	if ((random 1) < 0.25) then {
		_amount = _amount + 1;
	};
    
	if ((random 1) < 0.25) then {
		_amount = _amount + 1;
	};
	
	
	for "_i" from 1 to _amount do {
		_magazine = getArray (configFile >> "CfgWeapons" >> _itemClass >> "magazines") select 0;
		_weaponHolder addMagazineCargoGlobal [_magazine, 1];
	};
	
	_item = _weaponHolder;
};

if (_itemType == "supplybox") then {
	_weaponHolder = createVehicle [_itemClass, _lootPos, [], 0, "CAN_COLLIDE"];
	_weaponHolder setVariable ["isLoot", true];
};

if (_itemType == "backpack") then {
	_weaponHolder setVariable ["isLoot", true];
	_weaponHolder addBackpackCargoGlobal [_itemClass, 1];
};

if (_itemType == "single") then {
	_weaponHolder setVariable ["isLoot", true];
	_weaponHolder addItemCargoGlobal [_itemClass, 1];
};

if (_itemType == "magazine") then {

	_weaponHolder setVariable ["isLoot", true];

	_amount = 0;
	
	if (_itemClass == "MOD_30Rnd_545x39") then {
		_itemClass = selectRandom ["MOD_30Rnd_545x39_M", "MOD_30Rnd_545x39"];
	};
	
	if ((random 1) < 0.50) then {
		_amount = _amount + 1;
	};
    
	if ((random 1) < 0.25) then {
		_amount = _amount + 1;
	};
    
	if ((random 1) < 0.25) then {
		_amount = _amount + 1;
	};
	
	_weaponHolder addMagazineCargoGlobal [_itemClass, _amount];
};

if (_itemType == "item") then {
	_weaponHolder setVariable ["isLoot", true];
	_weaponHolder addItemCargoGlobal [_itemClass, 1];
	
	/*_current = 1;
	
	_maxItems = _current + floor (random 2); // number giving possibily of more items into this holder. max = three, min = 1
	_objItems = _buildingClass call building_items;
	
	for "_j" from 0 to count (_objItems) - 1 do { 
		if (_current <= _maxItems) then {
			_item = _objItems select _i;
			
			//if ((random 1) < (_item select 2) && ((_item select 1) == _itemType)) then { 
				//_weaponHolder addItemCargoGlobal [(_item select 0), 1];
				//diag_log format ["Spawned item: %1 at building: %2", (_item select 0), _buildingClass];
				//_current = _current + 1;
			//};
			
			_extraItemClass = _item select 0;
			_extraItemType = _item select 1;
			_extraChance = _item select 2;
			
			if (random 1 < _extraChance) then { 
			
				if (_extraItemType == "magazine") then {
					_weaponHolder addMagazineCargoGlobal [_extraItemClass, 1];
				} else {
					_weaponHolder addItemCargoGlobal [_extraItemClass, 1];
				};
				
				//diag_log format ["Spawned item: %1 at building: %2", (_item select 0), _buildingClass];
				_current = _current + 1;
			};
		};
	};*/
};

// random rotation
_weaponHolder setDir (random 360);

// stop floating objs
_weaponHolder setPos _lootPos;

// return
_weaponHolder