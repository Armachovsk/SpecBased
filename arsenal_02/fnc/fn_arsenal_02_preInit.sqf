if (isServer) then {
    ["SPEC_arsenal_02_compile", {
        _this call SPEC_fnc_arsenal_02_onCompile;
    }] call CBA_fnc_addEventHandler;
};

["SPEC_arsenal_02_presetsCompiled", {
    [player, _this] call SPEC_fnc_arsenal_02_onPresetsCompiled;
}] call CBA_fnc_addEventHandler;
