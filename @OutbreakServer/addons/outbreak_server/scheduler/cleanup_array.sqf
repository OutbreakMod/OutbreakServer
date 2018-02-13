[] spawn {
	
	_tick = 0;
	
	while {true} do {
		if ((count STORAGE_ARRAY) > 0) then {
			for "_i" from 0 to (count STORAGE_ARRAY) - 1 do {
		
				_vehicle = STORAGE_ARRAY select _i;
				
				if (!isNil "_vehicle") then {
					if (!isNil {_vehicle getVariable "ObjectLifetime"}) then {
					
						_lifetime = _vehicle getVariable ["ObjectLifetime", -1];
						
						if (_tick > 0) then {
							if ((_tick % 30) == 0) then {
								if ((_vehicle getVariable ["ObjectDatabase", 0]) == 1) then { 
									diag_log format ["Running save scheduler: %1", _vehicle];
									[_vehicle] call hive_save_vehicle;
								}
							};
						};
						
						if (_lifetime > 0) then {
							_lifetime = _lifetime - 1;
							_vehicle setVariable ["ObjectLifetime", _lifetime];
						};
							
						if (_lifetime == 0) then {
							STORAGE_ARRAY = STORAGE_ARRAY - [_vehicle];
							diag_log format ["Deleting vehicle: %1", typeOf _vehicle];
							
							if ((_vehicle getVariable ["ObjectDatabase", 0]) == 1) then { 
								_id = _vehicle getVariable ["ObjectID", 0];
								["object_data", "id", _id] call hive_delete;
							
							};
							
							deleteVehicle _vehicle;
							
						};
					};
				};
			};
		};
		
		_tick = _tick + 1;
		
		sleep 1;
	};
};