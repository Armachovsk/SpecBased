
//exeple
// [pos_mission,class_name_artilery,vehocle_classname_arry,pos_base] execVM "${somepath\file.sqf}";

    // 	pos_mission - aryy ccordinate
    //	class_name_artilery - vehicle class name spawn artilery
    // 	arry_pos_bombing - where bobbing arty

// done example
// [[200,200,0],"CPC_ME_O_KAM_D30",[400,400,0]] execVM "SPEC\other_missions\mission_7\mission_1.sqf";

//param
params [
    "_spawnPointSector",
    "_class_name_artilery",
    "_arry_pos_bombing",
    ["_bot_spawn_cb", {}, [{}]]
];


//artilery
private _artilery_1 = _class_name_artilery createVehicle (getMarkerPos _spawnPointSector);
private _artilery_2 = _class_name_artilery createVehicle (_artilery_1 getPos[10 + random 10,random 360]);
private _artilery_3 = _class_name_artilery createVehicle (_artilery_1 getPos[30 + random 10,random 360]);


//bombing
hint "";
_area_pos_bombing_x = (_arry_pos_bombing select 0) + selectRandom[+100,-100] + random [-200, 0, 200];
_area_pos_bombing_y = (_arry_pos_bombing select 1) + selectRandom[+100,-100] + random [-200, 0, 200];
private	_bomb_1 = createVehicle ["BO_GBU12_LGB",[_area_pos_bombing_x, _area_pos_bombing_y, _arry_pos_bombing select 2], [], 0, "FLY"];
sleep 2 + random 20;
_area_pos_bombing_x = (_arry_pos_bombing select 0) + selectRandom[+100,-100] + random [-200, 0, 200];
_area_pos_bombing_y = (_arry_pos_bombing select 1) + selectRandom[+100,-100] + random [-200, 0, 200];
private	_bomb_1 = createVehicle ["BO_GBU12_LGB",[_area_pos_bombing_x, _area_pos_bombing_y, _arry_pos_bombing select 2], [], 0, "FLY"];
sleep 2 + random 20;
_area_pos_bombing_x = (_arry_pos_bombing select 0) + selectRandom[+100,-100] + random [-200, 0, 200];
_area_pos_bombing_y = (_arry_pos_bombing select 1) + selectRandom[+100,-100] + random [-200, 0, 200];
private	_bomb_1 = createVehicle ["BO_GBU12_LGB",[_area_pos_bombing_x, _area_pos_bombing_y, _arry_pos_bombing select 2], [], 0, "FLY"];
sleep 2 + random 20;
_area_pos_bombing_x = (_arry_pos_bombing select 0) + selectRandom[+100,-100] + random [-200, 0, 200];
_area_pos_bombing_y = (_arry_pos_bombing select 1) + selectRandom[+100,-100] + random [-200, 0, 200];
private	_bomb_1 = createVehicle ["BO_GBU12_LGB",[_area_pos_bombing_x, _area_pos_bombing_y, _arry_pos_bombing select 2], [], 0, "FLY"];
sleep 2 + random 20;
_area_pos_bombing_x = (_arry_pos_bombing select 0) + selectRandom[+100,-100] + random [-200, 0, 200];
_area_pos_bombing_y = (_arry_pos_bombing select 1) + selectRandom[+100,-100] + random [-200, 0, 200];
private	_bomb_1 = createVehicle ["BO_GBU12_LGB",[_area_pos_bombing_x, _area_pos_bombing_y, _arry_pos_bombing select 2], [], 0, "FLY"];

[[], {hint "Вражеская артелерия обстреливает мирные города! Уничтожте артелерию!"}] remoteExec ["call"];

//marker
private _Marker7 = createMarker ["Marker7", _artilery_1 getPos [random 300, random 360]];
"Marker7" setMarkerShape "ELLIPSE";
"Marker7" setMarkerSize [300, 300];
"Marker7" setMarkerColor "ColorBlack";
"Marker7" setMarkerBrush "Cross";

//task
["Task_07", true, ["Уничтожить артелерию","Уничтожить артелерию","respawn_west"], getMarkerPos _Marker7, "ASSIGNED", 5, true, true, "destroy", true] call BIS_fnc_setTask;

([_spawnPointSector] call _bot_spawn_cb) params ["_onDestroy", "_onDestroyArgs"];

waitUntil {
    sleep 10;
    !alive _artilery_1 && !alive _artilery_2 && !alive _artilery_3
};

deleteMarker _Marker7;
["Task_07","SUCCEEDED"] call BIS_fnc_taskSetState;

private _rewards = createHashMap;
_rewards set ["intel", 0];
["SPEC_liberation_missionEnd", ["SPEC_other_missions_destroyArty", "SUCCEEDED", _rewards]] call CBA_fnc_serverEvent;

sleep 10;
["Task_07"] call BIS_fnc_deleteTask;

sleep 600;
_onDestroyArgs call _onDestroy;
