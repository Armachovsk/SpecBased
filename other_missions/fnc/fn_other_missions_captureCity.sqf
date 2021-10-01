private _nearbyLocations = nearestLocations [[0,0,0], ["NameVillage", "Name", "NameCity", "NameCityCapital"], 10000];
private _randomLoacation = getPos selectRandom _nearbyLocations;
private _nearestRoad = [_randomLoacation, 500] call BIS_fnc_nearestRoad;

//marker
private _Marker9 = createMarker ["Marker9", getPos _nearestRoad];
"Marker9" setMarkerShape "ELLIPSE";
"Marker9" setMarkerSize [300, 300];
"Marker9" setMarkerColor "ColorBlack";
"Marker9" setMarkerBrush "Cross";

//task
["Task_09", true, ["Освободить город","Освободить город","respawn_west"], getMarkerPos _Marker9, "ASSIGNED", 5, true, true, "attack", true] call BIS_fnc_setTask;

//bot from defend gorod
[getPos _nearestRoad,7,false,true,[20,40,50],2000] call SPEC_fnc_other_missions_zoneGref;

//spawn heli
private _heli_defend_gorod = [getPos _nearestRoad, 180, selectRandom["CPC_ME_O_KAM_uh1h_gunship", "CPC_ME_O_KAM_Mi24D_Early","CPC_ME_O_KAM_uh1hCPC_ME_O_KAM_uh1h_gunship"], EAST] call BIS_fnc_spawnVehicle;
[_heli_defend_gorod select 2, getPos (_heli_defend_gorod select 0), 1000] call bis_fnc_taskPatrol;

//find pos from zenitki
private _find_pos_from_zenitki = [getPos _nearestRoad, 50, 300, 10, 0, 0.9, 0] call BIS_fnc_findSafePos;
private _find_pos_from_zenitki_1 = [getPos _nearestRoad, 50, 300, 10, 0, 0.9, 0] call BIS_fnc_findSafePos;
private _find_pos_from_zenitki_2 = [getPos _nearestRoad, 50, 300, 10, 0, 0.9, 0] call BIS_fnc_findSafePos;
//find pos from vuhka
private _find_pos_from_vuhka = [getPos _nearestRoad, 50, 300, 10, 0, 0.9, 0] call BIS_fnc_findSafePos;

//spawn zenitki
zenitka_goroda = [_find_pos_from_zenitki, 180, "CPC_ME_O_KAM_ZU23", EAST] call BIS_fnc_spawnVehicle;
zenitka_goroda_1 = [_find_pos_from_zenitki_1, 180, "CPC_ME_O_KAM_ZU23", EAST] call BIS_fnc_spawnVehicle;
zenitka_goroda_2 = [_find_pos_from_zenitki_2, 180, "CPC_ME_O_KAM_ZU23", EAST] call BIS_fnc_spawnVehicle;

//bot from defend zenitki

[getPos (zenitka_goroda select 0),2,false,true,[20,40,50],2000] call SPEC_fnc_other_missions_zoneGref;
[getPos (zenitka_goroda_1 select 0),2,false,true,[20,40,50],2000] call SPEC_fnc_other_missions_zoneGref;
[getPos (zenitka_goroda_2 select 0),2,false,true,[20,40,50],2000] call SPEC_fnc_other_missions_zoneGref;

//task destroin zenitki
["Task_09_1", true, ["Уничтожить зенитные установки","Уничтожить зенитные установки","respawn_west"], getMarkerPos _Marker9, "CREATED", 5, true, true, "destroy", true] call BIS_fnc_setTask;

//create vuhka
vuhka = "Land_Vysilac_FM" createVehicle _find_pos_from_vuhka;

//bot from defend vuhka
[vuhka getPos [20, 45],2,false,true,[20,40,50],2000] call SPEC_fnc_other_missions_zoneGref;

//task destroin vshka
["Task_09_2", true, ["Уничтожить вышку","Уничтожить вышку","respawn_west"], getMarkerPos _Marker9, "CREATED", 5, true, true, "destroy", true] call BIS_fnc_setTask;

//find pos from sklad boepripasow
private _find_pos_from_sklad_boepripasow = [getPos _nearestRoad, 50, 300, 10, 0, 0.9, 0] call BIS_fnc_findSafePos;

//spawn sklad boepripasow
sklad_boepripasow = "Box_EAF_AmmoVeh_F" createVehicle _find_pos_from_vuhka;
private _sklad_boepripasow_1 = "Box_EAF_AmmoVeh_F" createVehicle getPos sklad_boepripasow;
private _sklad_boepripasow_2 = "Box_EAF_AmmoVeh_F" createVehicle getPos sklad_boepripasow;

//task destroin vshka
["Task_09_3", true, ["Уничтожить склад боеприпасов","Уничтожить склад боеприпасов","respawn_west"], getMarkerPos _Marker9, "CREATED", 5, true, true, "destroy", true] call BIS_fnc_setTask;

//bot from defend sklad boepripasow
[sklad_boepripasow getPos [20, 45],4,false,true,[20,40,50],2000] call SPEC_fnc_other_missions_zoneGref;

//wait complite zadaniya
private _zadanie_zenitka_complite = false;
private _zadanie_vuhka_complite = false;
private _zadanie_vuhka_complite = false;

waitUntil{
    if(!alive (zenitka_goroda select 0) && !alive (zenitka_goroda_1 select 0) && !alive (zenitka_goroda_2 select 0))then{_zadanie_zenitka_complite = true; ["Task_09_1","SUCCEEDED"] call BIS_fnc_taskSetState;};
    if(!alive vuhka)then{_zadanie_vuhka_complite = true;["Task_09_2","SUCCEEDED"] call BIS_fnc_taskSetState;};
    if(!alive sklad_boepripasow && !alive _sklad_boepripasow_1 && !alive _sklad_boepripasow_2)then{_zadanie_vuhka_complite = true;["Task_09_3","SUCCEEDED"] call BIS_fnc_taskSetState;};
    sleep 20;
    _zadanie_zenitka_complite && _zadanie_vuhka_complite && _zadanie_vuhka_complite
};

["Task_09","SUCCEEDED"] call BIS_fnc_taskSetState;
deleteMarker _Marker9;
sleep 10;
["Task_09"] call BIS_fnc_deleteTask;
["Task_09_1"] call BIS_fnc_deleteTask;
["Task_09_2"] call BIS_fnc_deleteTask;
["Task_09_3"] call BIS_fnc_deleteTask;
