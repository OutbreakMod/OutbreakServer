_building = nearestObject [player, "Building"];
_relPos = _building worldToModel (getPosATL player);
_getBuildingName = typeOf nearestBuilding position player;

_timeFactor = time;
player sideChat format ["Copied to clipboard! :: %1", _timeFactor];
x = _relPos select 0;
y = _relPos select 1;
z = _relPos select 2;

hint format ["%4 :: {%1,%2,%3};", x, y, z, _getBuildingName];
diag_log text format ["[DEVTOOL] Copied BldgPos to RPT %4 :: {%1,%2,%3};",x, y, z, _getBuildingName];

copyToClipboard format ["%4 :: {%1,%2,%3};", x, y, z, _getBuildingName];