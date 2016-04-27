[] spawn {
	
	_i = 0;
	
	while {true} do {
		
		for "_i" from 0 to (count STORAGE_ARRAY) - 1 do {
	
			_vehicle = STORAGE_ARRAY select _i;
			_lifetime = _vehicle getVariable ["ObjectLifetime", -1];
			
			if (_lifetime > 0) then {
				
				_lifetime = _lifetime - 1;
				_vehicle setVariable ["ObjectLifetime", _lifetime]
				
			} else {
				
				if (_lifetime == 0) then {
					STORAGE_ARRAY = STORAGE_ARRAY - [_vehicle];
					deleteVehicle _vehicle;
				};
			};
		};
		
		if (_i > 0) then {
			if ((_i % 300) == 0) then {
		
				for "_i" from 0 to (count STORAGE_ARRAY) - 1 do {
		
					diag_log format ["Running save scheduler: %1", _vehicle];
					[_vehicle] call hive_save_vehicle;
				};
			};
			
		};
		
		_i = _i + 1;
		
		sleep 1;
	};
};