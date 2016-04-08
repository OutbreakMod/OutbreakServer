/*
	Function for player sending request to server to log themselves into the server
	@author: TheAmazingAussie
*/

_player = _this select 0;
_playerID = owner _player;

_uuid = getPlayerUID _player;

_exists = ["users", "uuid", _uuid] call hive_exists;

if (_exists) then {

	_data = _player call hive_get_user;
	
	waitUntil {!isNil "_data"};

	_inventory = (_data select 2);
	_inventory = call compile(toString _inventory);		
	
	_position = _data select 3;
	_medical = _data select 4;
	
	[_inventory] remoteExecCall ["remoteExec_gear", _playerID];
	[_medical] remoteExecCall ["remoteExec_medical", _playerID];
	[_position] remoteExecCall ["remoteExec_teleport", _playerID];
	[_player] remoteExecCall ["remoteExec_login", _playerID];
	
	if (_name != "Error: No unit") then {
		["users", "name", _name, "uuid", _uuid] call hive_write;
	};

} else {
	
	_player call hive_new_user;
	
	[_player] remoteExecCall ["remoteExec_find_spawn", _playerID];
	[_player] remoteExecCall ["remoteExec_login", _playerID];
};