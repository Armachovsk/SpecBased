params [
    "_soldiers",
    "_side"
];

// fin pos
_nearbyLocations = nearestLocations [[0,0,0], ["NameMarine"], 20000];
_pos_from_mission = [0,0,0];
waitUntil{
 _select_location = selectRandom _nearbyLocations;
 _locationPos = locationPosition _select_location;
 _pos_from_mission = _locationPos getPos [1000, random 360];
 _pos_from_mission set [2,0];
 ((ASLToATL _pos_from_mission)select 2) >= 10 and ((ASLToATL _pos_from_mission)select 2) <= 40
};

// create c130
_C_130 = "C130J_wreck_EP1" createVehicle _pos_from_mission;
// create container
kontainer_for_mission_rabbit = "CBRNContainer_01_closed_yellow_F" createVehicle _pos_from_mission;
kontainer_for_mission_rabbit attachTo [_C_130, [0, -7, -4]];
publicVariable "kontainer_for_mission_rabbit";
// create action
[[], {
 _action_1 = ["TestAction 1","<t color='#ff2e2e'>Уничтожить</t>","",{
  deleteVehicle kontainer_for_mission_rabbit
 },{true}] call ace_interact_menu_fnc_createAction;
 [kontainer_for_mission_rabbit, 0, ["ACE_MainActions"], _action_1] call ace_interact_menu_fnc_addActionToObject;
}] remoteExec ["call"];

// create task
["Task_13", true, ["Уничтожить образцы хим оружия","Уничтожить образцы хим оружия","respawn_west"], getPos _C_130, "CREATED", 5, true, true, "search", true] call BIS_fnc_setTask;

// create bmk
_pos_from_mission set [2,0];
_bmk = "rhs_bmk_t" createVehicle _pos_from_mission;

_group_BMK = createGroup [_side,true];
_unit_bmk = _group_BMK createUnit [_soldiers, getPos _bmk, [], 0, "FORM"];
_unit_bmk moveInDriver _bmk;
_unit_bmk lock true;
// task patrol
[_group_BMK, [0,0,0], 200] call bis_fnc_taskPatrol;
// create attac Zy 23 2 attacet to BMK
_zy_23_2 = [getPos _bmk, 180, "rhsgref_tla_g_ZU23", _side] call BIS_fnc_spawnVehicle;

(_zy_23_2 select 0) attachTo [_bmk, [0, -1.5, 1.3]];

(_zy_23_2 select 0) lock true;

// create lodka with DHK
_lodka = "ffaa_ar_supercat" createVehicle (_bmk getPos [10+random 10, random 360]);

_group_lodka = createGroup [_side,true];
_unit_lodka = _group_BMK createUnit [_soldiers, getPos _lodka, [], 0, "FORM"];
_unit_lodka moveInDriver _lodka;
_unit_lodka lock true;
[_group_lodka, [0,0,0], 200] call bis_fnc_taskPatrol;

_DHKM = [getPos _lodka, 180, "rhsgref_ins_g_DSHKM", _side] call BIS_fnc_spawnVehicle;

(_DHKM select 0) attachTo [_lodka, [0.2, 1, 0.5]];

waitUntil{
 sleep 5;
 !alive kontainer_for_mission_rabbit
};

["Task_13","SUCCEEDED"] call BIS_fnc_taskSetState;

private _rewards = createHashMap;
_rewards set ["intel", 10];
["SPEC_liberation_missionEnd", ["SPEC_other_missions_destroyBCW", "SUCCEEDED", _rewards]] call CBA_fnc_serverEvent;

sleep 10;
["Task_13"] call BIS_fnc_deleteTask;

sleep 300;
deleteVehicle _C_130;
