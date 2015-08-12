private ["_zombie", "_grp", "_sleepTime", "_lockedTarget", "_playersInRange", "_closeHumans", "_hasContact"];

_zombie = _this select 0;
_player = _this select 1;
_group = _this select 2;

[_zombie] joinSilent _group;

_zombie disableAI "FSM";
_zombie disableAI "AUTOTARGET";
_zombie disableAI "TARGET";
_zombie setBehaviour "CARELESS";
_zombie enableFatigue true;
_zombie setVariable ["BIS_noCoreConversations", true];

_grp = group _zombie;
_grp setCombatMode "CARELESS";
_grp setSpeedMode "FULL";

//_zombie addEventHandler ["hit",{[_this select 0, "hurt"] call fnc_infectedNextSound;}];

_sleepTime = 7;
//When the target is the zombie itself, it is idle
_lockedTarget = _zombie;

_zombie forceSpeed 2;
_zombie doMove (getPosASL _player)

while {alive _zombie} do {

	if (_lockedTarget == _zombie) then {
		
		//Idle mode
		
		_playersInRange = false;
		_closeHumans = _zombie nearEntities [["man"], 20];
		{
			if ((side _zombie) getFriend (side _x) < 0.5) then {
			
				_zombie forceSpeed 8;
			
				_playersInRange = true;
				_hasContact = [_zombie, _x] call fnc_infectedContact;
				if (_hasContact) then {
					_lockedTarget = _x;
				};
			};
			
		} foreach _closeHumans;

		//_sleepTime will be overwritten later again in case player was spotted
		//Lower sleep time if a player is within 200m, longer sleep time if not to save processing power
		//A player will take longer than 15 seconds to travel 100m on foot, and zombies see players from 100m max.
		//Values can be adjusted accordingly to improve performance.
		if (_playersInRange) then {_sleepTime = 2} else {_sleepTime = 15};
	};

	if (_lockedTarget != _zombie) then {
		_zombie doMove getPosASL _lockedTarget;
		
		if (_zombie distance _lockedTarget < 2 && alive _lockedTarget) then {
			_zombie switchMove "AwopPercMstpSgthWnonDnon_end";
			
			//_lockedTarget setDamage (damage _lockedTarget + 0.34);
			//[_zombie, "punch"] call fnc_infectedNextSound;
		};
		
		if (!alive _lockedTarget) then {
				_lockedTarget = _zombie;
				_zombie forceSpeed 2;
		};
		
		_sleepTime = 1;
	};

	sleep _sleepTime;
};