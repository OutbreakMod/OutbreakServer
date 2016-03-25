/*
	Write to hive
	@author: TheAmazingAussie
*/

_player = _this;
_uuid = format["%1", getPlayerUID _player];
_name = format["%1", name _player];
_position = format["%1", getPos _player];

_inventory = toArray(format["%1", _player call player_serializeInventory]);
_inventory = format["%1", _inventory];

// log request
//diag_log format["ArmaHive: Request for new user: (%1, %2, %3, %4)", _uuid, _name, _position, _inventory];

// send request to ArmaHive through Arma2Net
_data = call compile ("Arma2Net.Unmanaged" callExtension format["ArmaHive [NewUser, '%1', '%2', '%3', '%4']", _uuid, _name, _position, _inventory]);

// log response
//diag_log format["ArmaHive: Response for new user: %1", _data];

// compile code
_data