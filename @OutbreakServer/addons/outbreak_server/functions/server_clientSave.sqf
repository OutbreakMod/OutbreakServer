/*
	Save player to database
	@author: TheAmazingAussie
*/

//private ["_unit", "_inventory", "_uuid", "_position", "_itemInventory", "_legFracture"];

_unit = _this select 0;
_name = _this select 1;
_uuid = _this select 2;
_position = _this select 3;
_inventory = _this select 4;
_legDamage = _this select 5;
_health = _this select 6;
_stomach = _this select 7;

["users", "inventory", format["%1", _inventory], "uuid", _uuid] call hive_write;
["users", "position", format["%1", _position], "uuid", _uuid] call hive_write;
["users", "medical", format["%1", [_legDamage, _health, _stomach]], "uuid", _uuid] call hive_write;

_storageObjects = nearestObjects [_position, STORAGE_UNITS, 20];

for "_i" from 0 to (count _storageObjects) - 1 do {
	
	_vehicle = _storageObjects select _i;
	_vehicle setVariable ["ObjectLifetime", ([typeOf _vehicle] call object_lifetime)];
	
	//[_vehicle] call hive_save_vehicle;
	
};
		