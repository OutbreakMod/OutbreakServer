/*
	Save vehicle and inventory data
	@author: TheAmazingAussie
*/

private ["_vehicle", "_objectID", "_type", "_hitPoints", "_savedHitPoints"];

_vehicle = _this select 0;

_itemInventory = [
	getWeaponCargo _vehicle,
	getMagazineCargo _vehicle,
	getBackpackCargo _vehicle,
	getItemCargo _vehicle
];

_objectID = _vehicle getVariable ["ObjectID", "0"];

if (isNil {_vehicle getVariable "ObjectID"}) then {
	[_vehicle] call hive_new_vehicle;
	_objectID = _vehicle getVariable ["ObjectID", "0"];
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
_dir = getDir _vehicle;
_worldSpace = [_pos, (round direction _vehicle), vectorDir _vehicle, vectorUp _vehicle];
_fuel = fuel _vehicle;
_damage = getDammage _vehicle;

_lifetime = _vehicle getVariable ["ObjectLifetime", -1];

_update = format["UpdateObject, '%1','%2','%3','%4','%5','%6','%7'", _objectID, _itemInventory, _savedHitPoints, _worldSpace, _fuel, _damage, _lifetime];
[_update] call hive_static;