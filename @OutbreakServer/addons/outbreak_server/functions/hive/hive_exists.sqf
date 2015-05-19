/*
	Select if a row exists from hive
	@author: TheAmazingAussie
*/

//ArmaHive ['exists', 'users', 'name', 'Donut']

_table = _this select 0;
_where = _this select 1;
_equals = _this select 2;

// log request
//diag_log format["ArmaHive: Request for exists at table %1, where %2, equals %3", _table, _where, _equals];

// send request to ArmaHive through Arma2Net
_data = call compile("Arma2Net.Unmanaged" callExtension format["ArmaHive [Exists, '%1', '%2', '%3']", _table, _where, _equals]);

//diag_log format["ArmaHive: Response for exists: %1", _data];

// compile code
_response = (_data == "true");
_response