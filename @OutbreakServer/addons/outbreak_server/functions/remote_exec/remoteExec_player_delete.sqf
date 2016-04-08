/*
	Function for player sending request to server to log themselves into the server
	@author: TheAmazingAussie
*/

_player = _this select 0;
["users", "uuid", getPlayerUID _player] call hive_delete;