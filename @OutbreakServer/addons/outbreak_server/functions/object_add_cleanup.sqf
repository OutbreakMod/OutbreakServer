/*
	Add item to cleanup array
	@author: TheAmazingAussie
*/

_object = _this select 0;

if (!(_object in STORAGE_ARRAY)) then {
	diag_log format["Added object (%1) to storage array", typeOf _object];
	STORAGE_ARRAY = STORAGE_ARRAY + [_object];
};