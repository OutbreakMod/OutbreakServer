[] spawn {
	
	_tick = 0;
	
	while {true} do {
		
		if ((count STORAGE_ARRAY) > 0) then {
		
			for "_i" from 0 to (count STORAGE_ARRAY) - 1 do {
		
				_vehicle = STORAGE_ARRAY select _i;
				
				if (!isNil "_vehicle") then {
					if (!isNil {_vehicle getVariable "ObjectLifetime"}) then {
					
						_lifetime = _vehicle getVariable ["ObjectLifetime", -1];
						
						if (_lifetime > 0) then {
							
							_lifetime = _lifetime - 1;
							_vehicle setVariable ["ObjectLifetime", _lifetime];
						} else {
							
							if (_lifetime == 0) then {
								STORAGE_ARRAY = STORAGE_ARRAY - [_vehicle];
								diag_log format ["Deleting vehicle: %1", typeOf _vehicle];
								deleteVehicle _vehicle;
								
							} else {
							
								if (_tick > 0) then {
									if ((_tick % 120) == 0) then {
										if ((_vehicle getVariable ["ObjectDatabase", 0]) == 1) then { 
											diag_log format ["Running save scheduler: %1", _vehicle];
											[_vehicle] call hive_save_vehicle;
										}
									};
								};
							};
						};
					};
				};
			};
		};
		
		_tick = _tick + 1;
		
		sleep 1;
	};
};