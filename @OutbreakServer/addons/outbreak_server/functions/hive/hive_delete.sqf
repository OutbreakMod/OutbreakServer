/*
	Write to hive
	@author: TheAmazingAussie
*/

_table = _this select 0;
_where = _this select 1;
_equals = _this select 2;

// log request
//diag_log format["ArmaHive: Request for delete at table %1, where %2, equals %3", _table, _where, _equals];

// send request to ArmaHive through Arma2Net
_data = call compile ("Arma2Net.Unmanaged" callExtension format["ArmaHive [Delete, '%1', '%2', '%3']", _table, _where, _equals]);

// log response
//diag_log format["ArmaHive: Response for delete: %1", _data];

// compile code
_data