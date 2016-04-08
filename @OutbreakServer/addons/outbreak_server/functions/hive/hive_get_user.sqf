/*
	Write to hive
	@author: TheAmazingAussie
*/

_player = _this;
_data = [format["GetUser, '%1'", getPlayerUID _player]] call hive_static;
_data = call compile(format["%1", _data]);
_data;