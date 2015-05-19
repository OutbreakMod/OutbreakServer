/*
	Server start/initialization
	@author: TheAmazingAussie
*/

private ["_clientID", "_arguments", "_player"];

_player = _this select 0;
_arguments = _this select 1;
_clientID = (owner _player);

player_sendCommand = _arguments;
_clientID publicVariableClient "player_sendCommand";