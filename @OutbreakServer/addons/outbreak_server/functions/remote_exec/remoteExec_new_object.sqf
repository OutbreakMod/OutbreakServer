/*
	Create a new object vehicle in the database
	@author: TheAmazingAussie
*/

_player = _this select 0;
_vehicle = _this select 1;
_class = _this select 2;
_worldspace = _this select 3;
_dir = _this select 4;
_hitPoints = _this select 5;

_fuel = fuel _vehicle;
_damage = damage _vehicle;
_inventory = [];
	
_update = format["NewObject, '%1','%2','%3','%4','%5','%6','%7','%8','%9'", MOD_HIVE, _vehicle getVariable ["ObjectID", 0], _class, _worldspace, _dir, _inventory, _hitPoints, _fuel, _damage];
	
[_update] call hive_static;