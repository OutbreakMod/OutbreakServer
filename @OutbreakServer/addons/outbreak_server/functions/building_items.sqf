/*
	Compiles all items for a building into one array
	@author: TheAmazingAussie
*/

private ["_class", "_lootCategories", "_lootItems", "_cfgLootCategories"];

_class = _this;
_lootCategories = [];
_lootItems = [];
_cfgLootCategories = "";

if (isClass(configFile >> "CfgBuildingType" >> _class)) then {
	_lootCategories = [] + getArray(configFile >> "CfgBuildingType" >> _class >> "lootCategories");
} else {
	_lootCategories = ["GeneralTools", "CivillianPistols", "CivillianBackpacks", "CookingUtilities", "CivillianFoodStorage", "MiscMedical", "CivillianMagazines"];

};

{ _lootItems = _lootItems + getArray(configFile >> "CfgLootCategories" >> _x >> "loot"); } count _lootCategories;
_lootItems = (_lootItems call KK_fnc_arrayShuffle);
_lootItems