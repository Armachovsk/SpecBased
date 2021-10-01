params ["_halo_position", "_limit"];

private _nearestSector = [_limit, _halo_position] call KPLIB_fnc_getNearestSector;

if (_nearestSector in KPLIB_sectors_all - KPLIB_sectors_player) exitWith {
    false
};

true
