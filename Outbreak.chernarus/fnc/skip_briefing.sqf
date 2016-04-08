/*
	Removes the briefing (map display) when joining Outbreak Mod servers
	@author: killzonekid
	@source: http://killzonekid.com/arma-scripting-tutorials-how-to-skip-briefing-screen-in-mp/
*/


if (hasInterface) then {
    if (!isNumber (missionConfigFile >> "briefing")) exitWith {};
    if (getNumber (missionConfigFile >> "briefing") == 1) exitWith {};
    0 = [] spawn {
        waitUntil {
            if (getClientState == "BRIEFING READ") exitWith {true};
            if (!isNull findDisplay 53) exitWith {
                ctrlActivate (findDisplay 53 displayCtrl 1);
                findDisplay 53 closeDisplay 1;
                true
            };
            false
        };
    };
};