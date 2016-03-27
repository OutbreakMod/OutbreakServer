/*
	Create unique object ID
	@author: TheAmazingAussie
*/

_worldSpace = _this select 0;
_firstData = _worldSpace select 0;

_x = _firstData select 0;
_y = _firstData select 1;
_z = _firstData select 2;

if (_x < 1) then {
	_x = _x * -10;
};

if (_y < 1) then {
	_y = _y * -10;
};

if (_z < 1) then {
	_z = _z * -10;
};

_objectID = (_x * 10) + (_y * 10) + (_firstData select 2);
_objectID;