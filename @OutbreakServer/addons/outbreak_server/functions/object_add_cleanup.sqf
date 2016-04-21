/*
	Add item to cleanup array
	@author: TheAmazingAussie
*/

_object = _this select 0;

if (!(_object in STORAGE_ARRAY)) then {
	STORAGE_ARRAY = STORAGE_ARRAY + [_object];
};