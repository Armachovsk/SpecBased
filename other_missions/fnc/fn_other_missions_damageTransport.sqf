//exeple
// [pos_mission,class_name_vehicle,vehocle_classname_arry,pos_base] execVM "${somepath\file.sqf}";

    // 	pos_mission - aryy ccordinate
    //	class_name_vehicle - vehicle
    // 	class_name_box - class name box to need recvest
    // 	pos_base - pos base to need delivery MHQ

// done example
// [[200,200,0],"BlackhawkWreck","CargoNet_01_box_F",[1000,1000,0]] execVM "SPEC\other_missions\mission_6\mission_1.sqf";

//param
params ["_pos_mission", "_class_name_vehicle", "_class_name_box", "_pos_base"];


//vehicle
private _Plane_1 = _class_name_vehicle createVehicle _pos_mission;
_Cargo_1 = _class_name_box createVehicle (_Plane_1 getPos [20 + random 40,random 360]);
[_Cargo_1, 1] call ace_cargo_fnc_setSize;

//marker
private _Marker6 = createMarker ["Marker6", _Plane_1 getPos [random 300, random 360]];
"Marker6" setMarkerShape "ELLIPSE";
"Marker6" setMarkerSize [300, 300];
"Marker6" setMarkerColor "ColorBlack";
"Marker6" setMarkerBrush "Cross";

//smoke
private _smoke6 = "test_EmptyObjectForSmoke" createVehicle getPos _Plane_1;
_smoke6 setPos(getPos _Plane_1);
//task
["Task_06", true, ["Эвакуировать черный ящик из подбитого вертолета","Эвакуировать черный ящик из подбитого вертолета","respawn_west"], getMarkerPos _Marker6, "CREATED", 5, true, true, "takeoff", true] call BIS_fnc_setTask;

//wait continer on base
waitUntil{
sleep 10;
(getPos _Cargo_1) inArea [_pos_base, 100, 100, 0, false] or !alive _Cargo_1
};

if(!alive _Cargo_1) exitwith {
    deleteMarker _Marker6;
    ["Task_06","FAILED"] call BIS_fnc_taskSetState;

    private _penalty = createHashMap;
    _penalty set ["intel", 10];
    ["SPEC_liberation_missionEnd", ["SPEC_other_missions_damageTransport", "FAILED", _penalty]] call CBA_fnc_serverEvent;

    sleep 10;
    ["Task_06"] call BIS_fnc_deleteTask;
    deleteVehicle _Plane_1;
    deleteVehicle _smoke6;
};

deleteMarker _Marker6;
["Task_06","SUCCEEDED"] call BIS_fnc_taskSetState;

private _rewards = createHashMap;
_rewards set ["intel", 10];
["SPEC_liberation_missionEnd", ["SPEC_other_missions_damageTransport", "SUCCEEDED", _rewards]] call CBA_fnc_serverEvent;

sleep 10;
["Task_06"] call BIS_fnc_deleteTask;
deleteVehicle _Cargo_1;
deleteVehicle _Plane_1;
deleteVehicle _smoke6;
