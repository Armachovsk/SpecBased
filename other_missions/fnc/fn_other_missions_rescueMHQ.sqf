//exeple
// [pos_mission,vehicle_to_recwest,vehocle_classname_arry,pos_base] execVM "${somepath\file.sqf}";

    // 	pos_mission - aryy ccordinate
    //	vehicle_to_recwest - vehicle to need recvest
    // 	vehocle_classname_arry - class name vehicle in colonna
    // 	pos_base - pos base to need delivery MHQ

// done example
// [[200,200,0],"rhsusf_m1152_sicps_usarmy_d",["rhsusf_m1025_d_m2", "rhsusf_M1117_D", "rhsusf_m113d_usarmy"],[1000,1000,0]] execVM "SPEC\other_missions\mission_5\mission_1.sqf";

//param
params ["_pos_mission", "_vehicle_to_recwest", "_vehocle_classname_arry", "_pos_base"];

//vehicle
private _Vehicle_1 = _vehicle_to_recwest createVehicle _pos_mission;
private _Vehicle_2 = selectRandom _vehocle_classname_arry createVehicle (_pos_mission getPos [80 + random 50,random 360]);
private _Vehicle_3 = selectRandom _vehocle_classname_arry createVehicle (_pos_mission getPos [15 + random 50,random 360]);
private _Vehicle_4 = selectRandom _vehocle_classname_arry createVehicle (_pos_mission getPos [20 + random 50,random 360]);

_Vehicle_1 setDamage 0.5;
_Vehicle_2 setDamage 0.7;
_Vehicle_3 setDamage 0.7;
_Vehicle_4 setDamage 0.7;

_Vehicle_1 setVehicleAmmo 0.3;
_Vehicle_2 setVehicleAmmo 0.3;
_Vehicle_3 setVehicleAmmo 0.3;
_Vehicle_4 setVehicleAmmo 0.3;

_Vehicle_1 setFuel random 1;
_Vehicle_2 setFuel random 1;
_Vehicle_3 setFuel random 1;
_Vehicle_4 setFuel random 1;

_Vehicle_1 setVehicleLock "LOCKED";

//marker
private _Marker5 = createMarker ["Marker5", _Vehicle_1 getPos [random 300, random 360]];
"Marker5" setMarkerShape "ELLIPSE";
"Marker5" setMarkerSize [300, 300];
"Marker5" setMarkerColor "ColorBlack";
"Marker5" setMarkerBrush "Cross";

//task
["Task_05", true, ["Эвакуировать КШМ на базу","Эвакуировать КШМ на базу","respawn_west"], getMarkerPos _Marker5, "CREATED", 5, true, true, "car", true] call BIS_fnc_setTask;

//wait prp on base or destroid
waitUntil{
sleep 10;
(getPos _Vehicle_1) inArea [_pos_base, 100, 100, 0, false] or !alive _Vehicle_1
};

if(!alive _Vehicle_1) exitwith {
    deleteMarker _Marker5;
    ["Task_05","FAILED"] call BIS_fnc_taskSetState;

    private _penalty = createHashMap;
    _penalty set ["intel", 10];
    ["SPEC_liberation_missionEnd", ["SPEC_other_missions_rescueMHQ", "FAILED", _penalty]] call CBA_fnc_serverEvent;

    sleep 10;
    ["Task_05"] call BIS_fnc_deleteTask;
};

deleteMarker _Marker5;
["Task_05","SUCCEEDED"] call BIS_fnc_taskSetState;

private _rewards = createHashMap;
_rewards set ["intel", 10];
["SPEC_liberation_missionEnd", ["SPEC_other_missions_rescueMHQ", "SUCCEEDED", _rewards]] call CBA_fnc_serverEvent;

sleep 10;
["Task_05"] call BIS_fnc_deleteTask;
deleteVehicle _Vehicle_1;
