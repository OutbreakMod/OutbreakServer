/*
	Write to hive
	@author: TheAmazingAussie
*/

private ["_method", "_data"];

_method = _this select 0;

// read config
_data = format["%1", call compile ("Arma2Net.Unmanaged" callExtension format["ArmaHive [%1]", _method])];

// compile code
_data