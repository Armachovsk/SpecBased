//exeple
// [pos_mission,class_name_artilery,vehocle_classname_arry,_arry_class_name_terorist] execVM "${somepath\file.sqf}";

    // 	pos_mission - aryy ccordinate
    //	class_name_zaloznik - arry class name zaloznika
    // 	arry_class_name_terorist - arry class name terrorists
    // 	radius_find_bild - radius find bilding from pos mission

// done example
/*

[
[1850.51,360.064,0.00161743],
["SpecLib_c_tk_civ_black_brown_jacket",
"SpecLib_c_tk_civ_blue_grey_waistcoat",
"SpecLib_c_tk_civ_grey_brown_waistcoat",
"SpecLib_c_tk_civ_tan_desert_waistcoat",
"SpecLib_c_tk_civ_olive_woodland_waistcoat",
"SpecLib_c_tk_civ_cream_tricolor_waistcoat",
"SpecLib_c_tk_civ_brown_brown_jacket",
"SpecLib_c_tk_civ_white_grey_waistcoat"],
["CPC_ME_O_KAM_soldier_l1a1",
"CPC_ME_O_KAM_soldier",
"CPC_ME_O_KAM_soldier_AR",
"CPC_ME_O_KAM_soldier_MG"]
,200] execVM "SPEC\other_missions\mission_11\mission_1.sqf";

*/

//param
params ["_pos_mission", "_class_name_zaloznik", "_arry_class_name_terorist","_radius_find_bild"];


// find building
private _arry_bilding = nearestObjects [_pos_mission, ["house"], _radius_find_bild];

private _bilding_from_mission_general = [];

    for "_i" from 0 to 100 do
{
    _select_bilding = selectRandom _arry_bilding;
    _bilding_from_mission = [_select_bilding, -1] call BIS_fnc_buildingPositions;
    _count_bolding_pos = count _bilding_from_mission;
    if(_count_bolding_pos >= 8)exitWith{
        _bilding_from_mission_general = _bilding_from_mission;
        };
};


if (_bilding_from_mission_general isEqualTo []) exitWith {
    ["SPEC_liberation_missionEnd", ["SPEC_other_missions_rescueHostage", "ERROR", "No matching buildings found!"]] call CBA_fnc_serverEvent;
};


["Task_11", true, ["Освободить заложнка","Освободить заложнка","respawn_west"], _pos_mission, "CREATED", 5, true, true, "meet", true] call BIS_fnc_setTask;

// create bot terrorist
private _group_terrorist = createGroup [east, true];

private _unit_1 = _group_terrorist createUnit [selectRandom _arry_class_name_terorist, _bilding_from_mission_general select 0, [], 0, "FORM"];
private _unit_2 = _group_terrorist createUnit [selectRandom _arry_class_name_terorist, _bilding_from_mission_general select 1, [], 0, "FORM"];
private _unit_3 = _group_terrorist createUnit [selectRandom _arry_class_name_terorist, _bilding_from_mission_general select 2, [], 0, "FORM"];
private _unit_4 = _group_terrorist createUnit [selectRandom _arry_class_name_terorist, _bilding_from_mission_general select 3, [], 0, "FORM"];
private _unit_5 = _group_terrorist createUnit [selectRandom _arry_class_name_terorist, _bilding_from_mission_general select 4, [], 0, "FORM"];
private _unit_6 = _group_terrorist createUnit [selectRandom _arry_class_name_terorist, _bilding_from_mission_general select 5, [], 0, "FORM"];
private _unit_7 = _group_terrorist createUnit [selectRandom _arry_class_name_terorist, _bilding_from_mission_general select 6, [], 0, "FORM"];

_unit_1 disableAI "Path";
_unit_2 disableAI "Path";
_unit_3 disableAI "Path";
_unit_4 disableAI "Path";
_unit_5 disableAI "Path";
_unit_6 disableAI "Path";
_unit_7 disableAI "Path";

_unit_1 setSkill 1;
_unit_2 setSkill 1;
_unit_3 setSkill 1;
_unit_4 setSkill 1;
_unit_5 setSkill 1;
_unit_6 setSkill 1;
_unit_7 setSkill 1;


private _group_zaloznic = createGroup [CIVILIAN, true];
private _unit_1_zaloznic = _group_zaloznic createUnit [selectRandom _class_name_zaloznik, _bilding_from_mission_general select 7, [], 0, "FORM"];
[_unit_1_zaloznic, true] call ACE_captives_fnc_setHandcuffed;


waitUntil{
    sleep 5;
    if(!alive _unit_1_zaloznic)exitWith{true};
    _state_zaloznic = (_unit_1_zaloznic getVariable ["ace_captives_isHandcuffed",false]);
    _state_zaloznic == false
};

if(!alive _unit_1_zaloznic)exitWith{
    ["Task_11","FAILED"] call BIS_fnc_taskSetState;

    private _penalty = createHashMap;
    _penalty set ["intel", 10];
    ["SPEC_liberation_missionEnd", ["SPEC_other_missions_rescueHostage", "FAILED", _penalty]] call CBA_fnc_serverEvent;

    sleep 10;
    ["Task_11"] call BIS_fnc_deleteTask;
};

["Task_11","SUCCEEDED"] call BIS_fnc_taskSetState;

private _rewards = createHashMap;
_rewards set ["intel", 10];
["SPEC_liberation_missionEnd", ["SPEC_other_missions_rescueHostage", "SUCCEEDED", _rewards]] call CBA_fnc_serverEvent;

sleep 10;
["Task_11"] call BIS_fnc_deleteTask;
