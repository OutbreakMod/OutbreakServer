/*
	Adds a vehicle object (and time in seconds given) to despawn, useless for body clean up
	@author: TheAmazingAussie
*/

_vehicle = _this select 0;
_timeToDespawn = _this select 1;

_vehicle setVariable ["cleanupTime", _timeToDespawn];

if (!(_vehicle in CLEANUP_ARRAY)) then {
	CLEANUP_ARRAY = CLEANUP_ARRAY + [_vehicle];
};