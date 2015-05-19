/*
	Find safe spawn for player
	@author: TheAmazingAussie
*/

private ["_position", "_spawnMarkers", "_mkr"];

_position = [0,0,0];
_spawnMarkers = 6;
_mkr = "spawn" + str(floor(random _spawnMarkers));

_position = ([(getMarkerPos _mkr), 0, OUTBREAK_SPAWN_AREA, 10, 0, 400, OUTBREAK_SPAWN_SHORE_MODE] call BIS_fnc_findSafePos);
//_position = [4672.9883, 2599.251, 0];
_position