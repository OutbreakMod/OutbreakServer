/*
	Dynamic wrecks around cities
	@author: TheAmazingAussie
*/

private ["_nearestLoc", "_wrecks", "_townPos", "_roads", "_nearOtherWrecks", "_wreck", "_veh"];

_nearestLoc = nearestLocations [getMarkerPos "center", ["NameCityCapital","NameCity","NameVillage"], 10000];

_wrecks = [
	"SKODAWreck",
	"HMMWVWreck",
	"UralWreck",
	"datsun01Wreck",
	"hiluxWreck",
	"datsun02Wreck",
	"UAZWreck"
];

{
	_townPos = locationPosition _x;
	_roads = _townPos nearRoads 200;
	
	for "_i" from 1 to count (_roads) do {
		
		// 80% chance
		if ((random 1) < 0.8) then {
			
			_nearOtherWrecks = true;
			_roadPos = objNull;
			
			while {_nearOtherWrecks} do {
				_roadPos = (_roads call BIS_fnc_selectRandom) modelToWorld [0,0,0];
				_nearOtherWrecks = count (_roadPos nearObjects ["All", 6]) > 0;
			};
			
			if (!isNil '_roadPos') then {
				_wreck = (_wrecks call BIS_fnc_selectRandom);
				_veh = createVehicle [_wreck, _roadPos, [], 0, "CAN_COLLIDE"];
				_veh enableSimulation false;
				_veh setDir round(random 360);
			};
		};
	};
	
} foreach _nearestLoc;