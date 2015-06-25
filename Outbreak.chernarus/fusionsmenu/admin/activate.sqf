waituntil {!alive player ; !isnull (finddisplay 46)};
if ((getPlayerUID player) in ["76561198127078878"]) then {
;
act = player addaction [("<t color=""#0074E8"">" + ("Tools Menu") +"</t>"),"fusionsmenu\admin\tools.sqf","",5,false,true,"",""];

};
