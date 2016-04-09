/*
	Deletes player from hive, if the player is deleted while they're still connected, it will reinsert their data into the database
	@author: TheAmazingAussie
*/

_player = _this select 0;
["users", "uuid", getPlayerUID _player] call hive_delete;