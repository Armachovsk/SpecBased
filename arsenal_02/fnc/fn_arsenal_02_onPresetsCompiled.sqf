params ["_object", "_store"];

private _virtualItems = _store get "_virtualItems";
[missionNamespace, (_virtualItems get "weapons"), true] call BIS_fnc_addVirtualWeaponCargo;
[missionNamespace, (_virtualItems get "magazines"), true] call BIS_fnc_addVirtualMagazineCargo;
[missionNamespace, (_virtualItems get "items"), true] call BIS_fnc_addVirtualItemCargo;
[missionNamespace, (_virtualItems get "backpacks"), true] call BIS_fnc_addVirtualBackpackCargo;

private _cargo = _store get "_cargo";
_object setVariable ["ace_arsenal_virtualItems", _cargo, true];

true
