params [
    ["_actions", [], [[]]],
    ["_condition", { !([_this # 0, "transport"] call SSS_interaction_fnc_availableEntities isEqualTo []) }, [{}]]
];

private _compiled = _actions apply { [_x # 0, _x # 1, _x # 2, _x # 3, _condition] call ace_interact_menu_fnc_createAction };
{ [typeOf player, 1, ["ACE_SelfActions","SSS_main"], _x] call ace_interact_menu_fnc_addActionToClass } forEach _compiled;

true
