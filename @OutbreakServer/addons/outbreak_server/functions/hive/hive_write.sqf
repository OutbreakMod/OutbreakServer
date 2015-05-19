/*
	Write to hive
	@author: TheAmazingAussie
*/

_table = _this select 0;
_field = _this select 1;
_fieldSet = _this select 2;
_where = _this select 3;
_equals = _this select 4;

if (_field == "inventory") then {
	_fieldSet = toArray(_fieldSet);
};

// log request
//diag_log format["ArmaHive: Request for update at table %1, field %2, fieldSet %3, where %4, equals %5", _table, _field, _fieldSet, _where, _equals];

// send request to ArmaHive through Arma2Net
_data = call compile ("Arma2Net.Unmanaged" callExtension format["ArmaHive [Update, '%1', '%2', '%3', '%4', '%5']", _table, _field, _fieldSet, _where, _equals]);

// log response
//diag_log format["ArmaHive: Response for update: %1", _data];

// compile code
_data