/*
	Gets the lifetime for the class name, 2 weeks default
	@author: TheAmazingAussie
*/

_class = _this select 0;
_lifetime = 1209600;

if (["object_lifetimes", "class", _class] call hive_exists) then {
	_lifetime = parseNumber (["object_lifetimes", "lifetime", "class", _class] call hive_read);
};

_lifetime;