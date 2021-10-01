private _nearbyLocations = nearestLocations [[0,0,0], ["NameVillage", "Name", "NameCity", "NameCityCapital"], 10000];
private _randomLoacation = getPos selectRandom _nearbyLocations;
private _nearestRoad = [_randomLoacation, 500] call BIS_fnc_nearestRoad;
private _find_pos = [_randomLoacation, 10, 500, 20, 0, 0.9, 0] call BIS_fnc_findSafePos;

//BMP
private _BMP_delivery_explousion = [_find_pos, 180, "CPC_ME_O_KAM_gaz66_r142", EAST] call BIS_fnc_spawnVehicle;

//marker
private _Marker8 = createMarker ["Marker8", _BMP_delivery_explousion select 0 getPos [100 + random 200, random 360]];
"Marker8" setMarkerShape "ELLIPSE";
"Marker8" setMarkerSize [300, 300];
"Marker8" setMarkerColor "ColorBlack";
"Marker8" setMarkerBrush "Cross";

//task
["Task_08", true, ["Уничтожить технику","Уничтожить технику","respawn_west"], getMarkerPos _Marker8, "CREATED", 5, true, true, "kill", true] call BIS_fnc_setTask;

_fnc_find_pos_delivery ={

nearbyLocations_1 = nearestLocations [[0,0,0], ["NameVillage", "Name", "NameCity", "NameCityCapital"], 10000];
randomLoacation_1 = getPos selectRandom nearbyLocations_1;
nearestRoad_1 = [randomLoacation_1, 500] call BIS_fnc_nearestRoad;
};

waitUntil{
sleep 0.1;
[] call _fnc_find_pos_delivery;
_randomLoacation distance randomLoacation_1 > 4000
};

//waipoint for BMP
private _wp_for_bot_go_tu_drone_heli = (_BMP_delivery_explousion select 2) addWaypoint [getPos nearestRoad_1, 0];
_wp_for_bot_go_tu_drone_heli setWaypointType "MOVE";
_wp_for_bot_go_tu_drone_heli setWaypointSpeed "FULL";
[(_BMP_delivery_explousion select 2), 0] setWaypointCombatMode "BLUE";

//marker from delivery
private _Marker8_1 = createMarker ["Marker8_1", getPos nearestRoad_1];
"Marker8_1" setMarkerShape "Icon";
"Marker8_1" setMarkerType "hd_flag";
"Marker8_1" setMarkerText "Конечная точка техники";

//wait when alive bmp or he on marker
waitUntil{
    sleep 10;
    "Marker8" setMarkerPos ((_BMP_delivery_explousion select 0) getPos [100 + random 200, random 360]);
    ["Task_08",getMarkerPos "Marker8"] call BIS_fnc_taskSetDestination;
    !alive (_BMP_delivery_explousion select 0) or (getPos (_BMP_delivery_explousion select 0)) inArea [nearestRoad_1, 100, 100, 0, false]
};

// if alive BMP
if(!alive (_BMP_delivery_explousion select 0))then{
["Task_08","SUCCEEDED"] call BIS_fnc_taskSetState;
deleteMarker _Marker8;
deleteMarker _Marker8_1;
sleep 10;
["Task_08"] call BIS_fnc_deleteTask;
};

//if bmp deliver to marker
if((getPos (_BMP_delivery_explousion select 0)) inArea [nearestRoad_1, 100, 100, 0, false]) then{
["Task_08","SUCCEEDED"] call BIS_fnc_taskSetState;
deleteMarker _Marker8;
deleteMarker _Marker8_1;
sleep 10;
["Task_08"] call BIS_fnc_deleteTask;
deleteVehicle _BMP_delivery_explousion;
};
