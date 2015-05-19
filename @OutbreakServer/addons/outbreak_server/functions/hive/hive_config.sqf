/*
	Write to hive
	@author: TheAmazingAussie
*/

private ["_key", "_value", "_data"];

_key = _this select 0;

// read config
_data = format["%1", call compile ("Arma2Net.Unmanaged" callExtension format["ArmaHive [GetConfig, '%1']", _key])];

// compile code
_data