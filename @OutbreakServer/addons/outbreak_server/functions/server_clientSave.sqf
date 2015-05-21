/*
	Save player to database
	@author: TheAmazingAussie
*/

//private ["_unit", "_inventory", "_uuid", "_position", "_itemInventory", "_legFracture"];

_unit = _this select 0;
_uuid = format["%1", getPlayerUID _unit];

_exists = ["users", "uuid", _uuid] call hive_exists;

if (!_exists) then {
	_unit call hive_newUser;
};

_name = _this select 1;
_position = _this select 2;
_inventory = _this select 3;
_legFracture = _this select 4;
_health = _this select 5;
_blood = _this select 6;

// run queries

if (_name != "Error: No unit") then {
	["users", "name", _name, "uuid", _uuid] call hive_write;
};

["users", "inventory", format["%1", _inventory], "uuid", _uuid] call hive_write;
["users", "position", format["%1", _position], "uuid", _uuid] call hive_write;
["users", "medical", format["%1", [_legFracture, _health, _blood]], "uuid", _uuid] call hive_write;

{
	_itemInventory = [
		getWeaponCargo _x,
		getMagazineCargo _x,
		getBackpackCargo _x,
		getItemCargo _x
	];
	
	_id = _x getVariable ["ObjectID", 0];
	_update = format["UpdateObject, '%1','%2'", _id, _itemInventory];
	[_update] call hive_static;
	
} forEach nearestObjects [_position, ["Car", "Helicopter", "Motorcycle", "Ship", "OutbreakShackV1", "OutbreakShackV2", "OutbreakShackV3", "OutbreakShackV4", "OutbreakTent"], 100];
		