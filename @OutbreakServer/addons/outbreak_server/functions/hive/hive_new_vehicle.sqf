/*
	Create new vehicle in hive
	@author: TheAmazingAussie
*/

private ["_veh", "_location", "_class", "_position", "_type", "_hitPoints", "_sections", "_savedHitPoints", "_worldspace", "_fuel", "_damage", "_objectID"];

_class = "";
_position = [];
_dir = 0;
_veh = objNull;

if (count _this > 2) then {
	_class = _this select 0;
	_position = _this select 1;
	_dir = _this select 2;
	
	_veh = createVehicle [_class, _position, [], 0, "CAN_COLLIDE"];
	_veh setDir _dir;

} else {
	_veh = _this select 0;
	_position = getPosATL _veh;
	_dir = getDir _veh;
	_class = typeOf _veh;
	
};

[_veh] call vehicle_damage;
_location = _veh modelToWorld [0,0,0];

_type = typeOf _veh;
_hitPoints = (count (configFile >> "CfgVehicles" >> _type >> "HitPoints")) - 1;
_sections = [];

for "_i" from 0 to _hitPoints do {

	_selected = (configFile >> "CfgVehicles" >> _type >> "HitPoints") select _i;
	_selectedName = getText(_selected >> "name");
	_sections = _sections + [_selectedName];
};

_savedHitPoints = [];

for "_i" from 0 to (count _sections) - 1 do { 

	_hitDamage = _veh getHit (_sections select _i);
	_savedHitPoints = _savedHitPoints + [[(_sections select _i), _hitDamage]];	
};

// create worldspace
_worldspace = [_location, vectorDir _veh, vectorUp _veh];

_fuel = fuel _veh;
_damage = damage _veh;

_veh setPos (_worldspace select 0);
_veh setDir _dir;
_veh setVectorDir (_worldspace select 1);
_veh setVectorUp (_worldspace select 2);

_objectID = [_worldspace] call create_uid;
_veh setVariable ["ObjectID", _objectID, true];

// insert into db
_update = format["NewObject, 'DEV001','%1','%2','%3','%4','%5','%6','%7','%8'", _objectID, _class, _worldspace, _dir, "", _savedHitPoints, _fuel, _damage];
_response = [_update] call hive_static;

_veh