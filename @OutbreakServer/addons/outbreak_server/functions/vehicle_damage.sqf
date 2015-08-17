/*
	Randomise vehicle damage
	@author: TheAmazingAussie
*/

private ["_vehicle", "_type", "_hitPoints", "_sections", "_hitPoints", "_selected", "_selectedName", "_sections", "_vehicle", "_savedHitPoints", "_savedHitPoints"];

_vehicle = _this select 0;

_type = typeOf _vehicle;
_hitPoints = (count (configFile >> "CfgVehicles" >> _type >> "HitPoints")) - 1;
_sections = [];

for "_i" from 0 to _hitPoints do {

	_selected = (configFile >> "CfgVehicles" >> _type >> "HitPoints") select _i;
	_selectedName = getText(_selected >> "name");
	_sections = _sections + [_selectedName];
};

_vehicle setDamage (random 0.2) + (random 0.7);
_vehicle setFuel (random 0.2) + (random 0.7);

_savedHitPoints = [];

{
	_hitDamage = (random 0.2) + (random 0.7);
	_vehicle setHit [_x, _hitDamage];
	_savedHitPoints = _savedHitPoints + [[_x, _hitDamage]];	
} forEach _sections;

_vehicle setVariable ["hitpoints", _savedHitPoints];