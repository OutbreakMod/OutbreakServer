/*
	Function for player sending request to server to log themselves into the server
	@author: TheAmazingAussie
*/

_player = _this select 0;
_uuid = getPlayerUID _player;

_exists = ["users", "uuid", _uuid] call hive_exists;

if (_exists) then {

	_userData = _player call hive_get_user;
	
	waitUntil {!isNil "_userData"};

	_inventory = _userData select 2;
	_inventory = call compile(toString _inventory);		

	[_player, ["gear", _inventory]] call server_clientCommand;
	[_player, ["tp", _userData select 3]] call server_clientCommand;
	[_player, ["medical", _userData select 4]] call server_clientCommand;
	[_player, ["login"]] call server_clientCommand;
	
	if (_name != "Error: No unit") then {
		["users", "name", _name, "uuid", _uuid] call hive_write;
	};

} else {
	
	_player call hive_new_user;
	
	[_player, ["findspawn"]] call server_clientCommand;
	[_player, ["login"]] call server_clientCommand;
};