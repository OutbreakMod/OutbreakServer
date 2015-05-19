/*
	Adds objects from the database into a vehicle
	@author: TheAmazingAussie
*/

private ["_veh", "_itemInventory", "_weaponCargo", "_weaponCargoCount", "_weaponCargoItems", "_magazineCargo", "_magazineCargoCount", "_magazineCargoItems", "_backpackCargo", "_backpackCargoCount", "_backpackCargoItems", "_itemCargo", "_itemCargoCount", "_itemCargoItems"];

_veh = _this select 0;
_itemInventory = _this select 1;

_weaponCargo = _itemInventory select 0;
_weaponCargoItems = _weaponCargo select 0;
_weaponCargoCount = _weaponCargo select 1;

for "_wc" from 0 to (count _weaponCargoItems) - 1 do { 
	
	_className = _weaponCargoItems select _wc;
	_amount = _weaponCargoCount select _wc;
	_veh addWeaponCargoGlobal [_className, _amount];
};

_magazineCargo = _itemInventory select 1;
_magazineCargoItems = _magazineCargo select 0;
_magazineCargoCount = _magazineCargo select 1;

for "_wc" from 0 to (count _magazineCargoItems) - 1 do { 
	
	_className = _magazineCargoItems select _wc;
	_amount = _magazineCargoCount select _wc;
	_veh addMagazineCargoGlobal [_className, _amount];
};


_backpackCargo = _itemInventory select 2;
_backpackCargoItems = _backpackCargo select 0;
_backpackCargoCount = _backpackCargo select 1;

for "_wc" from 0 to (count _backpackCargoItems) - 1 do { 
	
	_className = _backpackCargoItems select _wc;
	_amount = _backpackCargoCount select _wc;
	_veh addBackpackCargoGlobal [_className, _amount];
};


_itemCargo = _itemInventory select 3;
_itemCargoItems = _itemCargo select 0;
_itemCargoCount = _itemCargo select 1;

for "_wc" from 0 to (count _itemCargoItems) - 1 do { 
	
	_className = _itemCargoItems select _wc;
	_amount = _itemCargoCount select _wc;
	_veh addItemCargoGlobal [_className, _amount];
};