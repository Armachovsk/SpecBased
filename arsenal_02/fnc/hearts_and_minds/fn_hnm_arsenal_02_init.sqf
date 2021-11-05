[
    {
        !isNil "btc_version" &&
        {btc_version isEqualTo [1, 20, 9]} &&
        {btc_p_arsenal_Type isEqualTo 5 && btc_p_arsenal_Restrict isEqualTo 4}
    },
    {
        ["SPEC_arsenal_02_presetsCompiled", {

            [btc_gear_object, _this] call SPEC_fnc_arsenal_02_onPresetsCompiled;

            [[btc_gear_object, !(btc_p_arsenal_Restrict isEqualTo 1 || btc_p_arsenal_Restrict isEqualTo 4)], {
                params ["_object", "_condition"];
                removeAllActions _object;
                _object addAction [
                    localize "STR_BTC_HAM_ACTION_ARSENAL_OPEN_BIS",
                    {['Open', [_this # 3 # 0, _this # 0]] call bis_fnc_arsenal;},
                    [_condition]
                ];
                _object addAction [
                    localize "STR_BTC_HAM_ACTION_ARSENAL_OPEN_ACE",
                    {[_this # 3 # 0, player] call ace_arsenal_fnc_openBox;},
                    [_object]
                ];
            }] remoteExec ["call", [0, -2] select isDedicated, isDedicated];

        }] call CBA_fnc_addEventHandler;
    }
] call CBA_fnc_waitUntilAndExecute;
