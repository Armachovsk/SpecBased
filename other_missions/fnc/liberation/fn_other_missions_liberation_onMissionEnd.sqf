params ["_missionName", "_state", "_rewardsOrPenaltyHashOrErr"];

if (!isServer) exitWith {false};

if (_state isEqualTo "SUCCEEDED") then {
    private _intel = _rewardsOrPenaltyHashOrErr getOrDefault ["intel", 0];
    resources_intel = resources_intel + _intel;
};
if (_state isEqualTo "FAILED") then {
    private _intel = _rewardsOrPenaltyHashOrErr getOrDefault ["intel", 0];
    private _minus = resources_intel - _intel;
    if (_minus <= 0) then {
        resources_intel = 0;
    };
    resources_intel = _minus;
};
if (_state isEqualTo "ERROR" && {_rewardsOrPenaltyHashOrErr isEqualType ""}) then {
    private _errMsg = _rewardsOrPenaltyHashOrErr;
    [_errMsg, { [_this] call BIS_fnc_error; }] remoteExec ["call"];
};

KPLIB_secondary_in_progress = -1;
publicVariable "KPLIB_secondary_in_progress";

[{ [] spawn KPLIB_fnc_doSave; }, [], 1] call CBA_fnc_waitAndExecute;

true
