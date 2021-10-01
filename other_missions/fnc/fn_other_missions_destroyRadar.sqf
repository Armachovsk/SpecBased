private _nearbyLocations = nearestLocations [[0,0,0], ["NameVillage", "Name", "NameCity", "NameCityCapital"], 10000];
private _randomLoacation = getPos selectRandom _nearbyLocations;
private _find_pos = [_randomLoacation, 500, 1000, 30, 0, 0.9, 0] call BIS_fnc_findSafePos;

_radar_1 = "rhs_prv13" createVehicle _find_pos;

//marker
private _Marker10 = createMarker ["Marker10", _radar_1 getPos [random 500, random 360]];
"Marker10" setMarkerShape "ELLIPSE";
"Marker10" setMarkerSize [500, 500];
"Marker10" setMarkerColor "ColorBlack";
"Marker10" setMarkerBrush "Cross";

["Task_10", true, ["Уничтожить РЛС","Уничтожить РЛС","respawn_west"], getMarkerPos _Marker10, "CREATED", 5, true, true, "meet", true] call BIS_fnc_setTask;

[
    getPos _radar_1,	// массив координатов где будет центр здания

    EAST,	// сторона ботов можнт быть: EAST, WEST, independent

    ["CPC_ME_O_KAM_soldier_Medic",
"CPC_ME_O_KAM_soldier_AR",
"CPC_ME_O_KAM_soldier_TL",
"CPC_ME_O_KAM_soldier_AA",
"CPC_ME_O_KAM_soldier_LAT"],

    ["CPC_ME_O_KAM_uaz_spg9",
"CPC_ME_O_KAM_uaz_dshkm"],

    ["CPC_ME_O_KAM_BTR70",
"CPC_ME_O_KAM_BRDM2",
"CPC_ME_O_KAM_BMP1",
"CPC_ME_O_KAM_T72B"],

    ["CPC_ME_O_KAM_ZSU",
"CPC_ME_O_KAM_ural_Zu23"],

    ["CPC_ME_O_KAM_uh1h_gunship",
"CPC_ME_O_KAM_Mi24D_Early"],

    ["CPC_ME_O_KAM_DSHKM",
"CPC_ME_O_KAM_Igla_AA_pod",
"CPC_ME_O_KAM_ZU23",
"CPC_ME_O_KAM_2b14_82mm"],

    200, // радиус (от центра) размещения статичных орудий(м)

    6, // количество статичных орудий

    4,	// количество легких машин которые будут патрулировать зону

    1,	// количество тяжолой техники которая будует патрулировать зону

    1,	// количество самоходных зенитныйх установок которые будут патрулировать зону

    0,	//	количество вертолетов которые будут патрулировать зону

    3,	// количество групп ботов которые будет охранять зону

    3,	//	количество ботов в группах которые будут охранять зону

    30,	// шанс появления бота в здании(на крыше) в % от 0 до 100

    2000, // радиус активации игроком

    200,	// радиус патрулирования ботов

    200,	// радиус размещения легких машин которые будут патрулировать зону(чем больше машин тем больше зону лучше сделать)

    400,	// радиус патрулирования всех машин и легких танков

    1000,	// радиус патрулирования вертолетов

    false	// удалять ли зону после активации если в зоне активации не осталось игроков

] execVM "SPEC\other_missions\fnc\fn_other_missions_spawnEnemyBot.sqf";

waitUntil{
    sleep 10;
    !alive _radar_1
};

["Task_10","SUCCEEDED"] call BIS_fnc_taskSetState;
deleteMarker _Marker10;
sleep 10;
["Task_03"] call BIS_fnc_deleteTask;
