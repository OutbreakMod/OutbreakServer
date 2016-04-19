/*
	Handle player disconnection
	@author: TheAmazingAussie
*/

private ["_name","_uid","_clientId","_unit", "_position", "_inventory"];
 
_unit = _this select 0;

_array = (_unit getVariable ["playerSaveData", []]);

if (count _array > 0) then {
	_array call server_clientSave;
};
	
_attackingZombies = _unit getVariable ["attackingZombies", []];
{ 
	_x setVariable ["zombieTarget", _x, true];
	_x setVariable ["zombieSpawned", getPosATL _unit , true];
	_x setVariable ["zombieTimerGunshot", 0, true]; // Trigger gunshot reset
} foreach _attackingZombies;

_unit setVariable ["attackingZombies", [], true];

_spawnedZombies = _unit getVariable ["spawnedZombies", []];
{ if (alive _x) then { deleteVehicle _x; }; } foreach _spawnedZombies;

deleteVehicle (_unit);