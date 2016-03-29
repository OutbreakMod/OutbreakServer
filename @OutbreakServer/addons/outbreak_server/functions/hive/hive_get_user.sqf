/*
	Write to hive
	@author: TheAmazingAussie
*/

_uuid = format["%1", _this];
_data = [];
_data = call compile ("extDB2" callExtension format["0:%1:SELECT * FROM users WHERE uuid = '%1'" , SQL_ID, _uuid]);
_data;