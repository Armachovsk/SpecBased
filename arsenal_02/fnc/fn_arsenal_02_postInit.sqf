[{!isNil "KPLIB_presetArsenal" && {KPLIB_param_useArsenalPreset == 2}}, {
    ["SPEC_arsenal_02_compile", [KPLIB_presetArsenal, false]] call CBA_fnc_serverEvent;
}] call CBA_fnc_waitUntilAndExecute;
