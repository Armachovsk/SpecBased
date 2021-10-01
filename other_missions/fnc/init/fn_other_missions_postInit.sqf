// /*
//     KPLIB_fnc_missions_postInit

//     File: fn_missions_postInit.sqf
//     Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
//     Date: 2019-06-22
//     Last Update: 2019-06-22
//     License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
//     Public: No

//     Description:
//         The postInit function of a module takes care of starting/executing the modules functions or scripts.
//         Basically it starts/initializes the module functionality to make all provided features usable.

//     Parameter(s):
//         NONE

//     Returns:
//         Module postInit finished [BOOL]
// */

// if (isServer) then {

//     ["Module initializing...", "POST] [MISSIONS", true] call KPLIB_fnc_common_log;

//         [
//         "Destroy_Tank",
//         {true},
//         false,
//         [0, 0, 0, 0],
//         10,
//         10,
//         "SPEC\other_missions\mission_1\start.sqf",
//         "modules\90_missions\example\abort.sqf"
//     ] call KPLIB_fnc_mission_registerMission;

//         [
//         "Destroy_Heli",
//         {true},
//         false,
//         [0, 0, 0, 0],
//         10,
//         10,
//         "SPEC\other_missions\mission_2\start.sqf",
//         "modules\90_missions\example\abort.sqf"
//     ] call KPLIB_fnc_mission_registerMission;

//         [
//         "Recvest_pilots",
//         {true},
//         false,
//         [0, 0, 0, 0],
//         10,
//         10,
//         "SPEC\other_missions\mission_3\start.sqf",
//         "modules\90_missions\example\abort.sqf"
//     ] call KPLIB_fnc_mission_registerMission;

//     [
//         "Recvest_intel_from_UAV",
//         {true},
//         false,
//         [0, 0, 0, 0],
//         10,
//         10,
//         "SPEC\other_missions\mission_4\start.sqf",
//         "modules\90_missions\example\abort.sqf"
//     ] call KPLIB_fnc_mission_registerMission;

//     [
//         "Recwest_MHQ",
//         {true},
//         false,
//         [0, 0, 0, 0],
//         10,
//         10,
//         "SPEC\other_missions\mission_5\start.sqf",
//         "modules\90_missions\example\abort.sqf"
//     ] call KPLIB_fnc_mission_registerMission;

//     [
//         "Damage_transport",
//         {true},
//         false,
//         [0, 0, 0, 0],
//         10,
//         10,
//         "SPEC\other_missions\mission_6\start.sqf",
//         "modules\90_missions\example\abort.sqf"
//     ] call KPLIB_fnc_mission_registerMission;

//     [
//         "Destroy_arty",
//         {true},
//         false,
//         [0, 0, 0, 0],
//         10,
//         10,
//         "SPEC\other_missions\mission_7\start.sqf",
//         "modules\90_missions\example\abort.sqf"
//     ] call KPLIB_fnc_mission_registerMission;

//     [
//         "Destroy_vehicle",
//         {true},
//         false,
//         [0, 0, 0, 0],
//         10,
//         10,
//         "SPEC\other_missions\mission_8\mission_1.sqf",
//         "modules\90_missions\example\abort.sqf"
//     ] call KPLIB_fnc_mission_registerMission;

//     [
//         "Destroy_radar",
//         {true},
//         false,
//         [0, 0, 0, 0],
//         10,
//         10,
//         "SPEC\other_missions\mission_10\start.sqf",
//         "modules\90_missions\example\abort.sqf"
//     ] call KPLIB_fnc_mission_registerMission;

//     [
//         "Recwest_hostage",
//         {true},
//         false,
//         [0, 0, 0, 0],
//         10,
//         10,
//         "SPEC\other_missions\mission_11\start.sqf",
//         "modules\90_missions\example\abort.sqf"
//     ] call KPLIB_fnc_mission_registerMission;

//     [
//         "Kill_general",
//         {true},
//         false,
//         [0, 0, 0, 0],
//         10,
//         10,
//         "SPEC\other_missions\mission_12\start.sqf",
//         "modules\90_missions\example\abort.sqf"
//     ] call KPLIB_fnc_mission_registerMission;

// };



// if (isServer) then {["Module initialized", "POST] [MISSIONS", true] call KPLIB_fnc_common_log;};

// true

if (isServer) then {
    SPEC_other_missions_pool = [];
};

if (isServer) then {
    ["SPEC_liberation_missionEnd", {
        _this call SPEC_fnc_other_missions_liberation_onMissionEnd;
    }] call CBA_fnc_addEventHandler;
};

true
