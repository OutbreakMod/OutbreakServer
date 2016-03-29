/*
	Select if a row exists from hive
	@author: TheAmazingAussie
*/

//ArmaHive ['exists', 'users', 'name', 'Donut']

_table = _this select 0;
_where = _this select 1;
_equals = _this select 2;

_data = [];
_data = call compile ("extDB2" callExtension format["0:%1:SELECT * FROM %2 WHERE %3 = '%4'" , SQL_ID, _table, _where, _equals]);

_exists = (count _data) > 0;
_exists;