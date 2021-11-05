if (isNil "SPEC_arsenal_02_disableStandardInit") then {
    SPEC_arsenal_02_disableStandardInit = false;
};

[
    {!SPEC_arsenal_02_disableStandardInit},
    {
        ["SPEC_arsenal_02_presetsCompiled", {
            [player, _this] call SPEC_fnc_arsenal_02_onPresetsCompiled;
        }] call CBA_fnc_addEventHandler;
    }
] call CBA_fnc_waitUntilAndExecute;

[{!isNil "KPLIB_presetArsenal" && {KPLIB_param_useArsenalPreset == 2}}, {
    ["SPEC_arsenal_02_compile", [KPLIB_presetArsenal, false]] call CBA_fnc_serverEvent;
}] call CBA_fnc_waitUntilAndExecute;
