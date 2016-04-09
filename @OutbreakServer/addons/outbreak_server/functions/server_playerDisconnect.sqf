/*
	Handle player disconnection
	@author: TheAmazingAussie
*/

private ["_name","_uid","_clientId","_unit", "_position", "_inventory"];
 
_uid = _this select 0;
_name = _this select 1;  
_unit = nil;

{

	if (player getVariable["playeruuid", _uid] == _uid) then {
		_unit = _x;
	};
	
} foreach playableUnits;

if (!isNil '_unit') then {

	_array = (_unit getVariable ["playerSaveData", []]);
	_array set [1, _uid];
	_array call server_clientSave;
	
	_pos = getPosATL _unit;
	
	_attackingZombies = _unit getVariable ["attackingZombies", []];
	{ 
		_x setVariable ["zombieTarget", _x, true];
		_x setVariable ["zombieSpawned", _pos, true];
		_x setVariable ["zombieTimerGunshot", 0, true]; // Trigger gunshot reset
	} foreach _attackingZombies;
	
	_unit setVariable ["attackingZombies", [], true];
	
	_spawnedZombies = _unit getVariable ["spawnedZombies", []];
	{ deleteVehicle _x; } foreach _spawnedZombies;
	
	deleteVehicle (_unit);
};