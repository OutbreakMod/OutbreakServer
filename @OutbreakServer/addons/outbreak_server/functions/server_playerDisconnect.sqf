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

	// new position
	_position = (getPosATL _unit);
	_inventory = (_unit call player_serializeInventory);
	
	// save to hive
	[_unit] call player_hiveSync;

	// remove other unit
	deleteVehicle (_unit);
	
	/////
	// ANTI-LOGGER NPC
	/////
	_combatNPC = (createGroup west) createUnit ["b_survivor_F", _position, [], 0, "CAN_COLLIDE"];
	_combatNPC setVariable ["playeruuid", _uid];
	_combatNPC call player_clearInventory;
	
	// load npc inventory
	[_combatNPC, _inventory] call player_loadInventory;

	sleep 30;

	// only delete NPC if they were alive
	if (alive _combatNPC) then {
		deleteVehicle (_combatNPC);
	} else {
		
	};
};