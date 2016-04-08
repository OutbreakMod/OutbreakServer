/*
	Server start/initialization
	@author: TheAmazingAussie
*/

private ["_clientID", "_arguments", "_player"];

_player = _this select 0;
_arguments = _this select 1;
_clientID = (owner _player);

_arguments remoteExecCall ["player_command", _clientID];