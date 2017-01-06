/*
	Adds a vehicle object (and time in seconds given) to despawn, useful for body clean up
	@author: TheAmazingAussie
*/

_vehicle = _this select 0;
_timeToDespawn = _this select 1;

_vehicle setVariable ["ObjectLifetime", _timeToDespawn];

if (!(_vehicle in STORAGE_ARRAY)) then {
	STORAGE_ARRAY = STORAGE_ARRAY + [_vehicle];
};