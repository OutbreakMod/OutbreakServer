/*
	Register server-side variables
	@author: TheAmazingAussie
*/

// All objects that need cleaning up are stored here	
CLEANUP_ARRAY = [];

// Clean up thread
CLEANUP_HANDLER = [] spawn {
	
	// Start thread once server has finished loading information
	waitUntil { init_done };
	
	while {true} do {
		
		sleep 1;
		
		{
			_object = _x;
			_cleanUp = _object getVariable ["cleanupTime", 0];
			
			if (_cleanUp > 0) then {
				_object setVariable ["cleanupTime", (_cleanUp - 1)]
			} else {
				deleteVehicle (_object);
				CLEANUP_ARRAY = CLEANUP_ARRAY - [_object];
			};
			
		} foreach CLEANUP_ARRAY;
	};
};