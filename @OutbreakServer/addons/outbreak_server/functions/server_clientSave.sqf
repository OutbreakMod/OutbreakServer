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

	_itemInventory = [
		getWeaponCargo _vehicle,
		getMagazineCargo _vehicle,
		getBackpackCargo _vehicle,
		getItemCargo _vehicle
	];
	
	_id = _vehicle getVariable ["ObjectID", 0];
	
	if (_id == 0) then {
		[_vehicle] call hive_new_vehicle;
		_id = _vehicle getVariable ["ObjectID", 0];
	};
	
	_type = typeOf _vehicle;
	_hitPoints = (count (configFile >> "CfgVehicles" >> _type >> "HitPoints")) - 1;
	_sections = [];

	for "_i" from 0 to _hitPoints do {

		_selected = (configFile >> "CfgVehicles" >> _type >> "HitPoints") select _i;
		_selectedName = getText(_selected >> "name");
		_sections = _sections + [_selectedName];
	};
	
	_savedHitPoints = [];
	{
		_hitDamage = _vehicle getHit _x;
		_savedHitPoints = _savedHitPoints + [[_x, _hitDamage]];	
	} forEach _sections;
	
	_pos = getPos _vehicle;
	_worldSpace = [_pos, vectorDir _vehicle, vectorUp _vehicle, (round direction _vehicle)];
	_fuel = fuel _vehicle;
	_damage = getDammage _vehicle;

	_update = format["UpdateObject, '%1','%2','%3','%4','%5','%6'", _id, _itemInventory, _savedHitPoints, _worldSpace, _dir,_fuel,_damage];
	[_update] call hive_static;
	
};
		