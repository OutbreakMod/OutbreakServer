/*
	Select from hive
	@author: TheAmazingAussie
*/

_table = _this select 0;
_field = _this select 1;
_where = _this select 2;
_equals = _this select 3;

// log request
//diag_log format["ArmaHive: Request for select at table %1, field %2, where %3, equals %4", _table, _field, _where, _equals];

// send request to ArmaHive through Arma2Net
_data = call compile ("Arma2Net.Unmanaged" callExtension format["ArmaHive [Select, '%1', '%2', '%3', '%4']", _table, _field, _where, _equals]);

//ArmaHive [Select, 'users', 'inventory', 'uuid', '76561198127078878']

//diag_log format["ArmaHive: Response for read: %1", _data];

_data