/*
	Write to hive
	@author: TheAmazingAussie
*/

_player = _this;
_uuid = format["%1", getPlayerUID _player];

_data = [format["GetUser, '%1'", _uuid]] call hive_static;
_data = call compile(format["%1", _userData]);
_data;