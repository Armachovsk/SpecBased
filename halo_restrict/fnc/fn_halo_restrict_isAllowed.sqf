params ["_pos", "_markerToUpdate"];

if (isDedicated && !hasInterface) exitWith {};

private _radius = [500, 1000, 2000] param [(KPLIB_param_haloMode - 1), 500];

if (!([_pos, _radius] call SPEC_fnc_halo_restrict_findAvailableSector)) exitWith {
    _markerToUpdate setMarkerPosLocal _pos;
    _markerToUpdate setMarkerTextLocal (localize "STR_HALO_YOUCANNOTJUMPHERE");
    _markerToUpdate setMarkerColor "ColorRed";

    false
};

_markerToUpdate setMarkerPosLocal _pos;
_markerToUpdate setMarkerTextLocal (localize "STR_HALO_PARAM");
_markerToUpdate setMarkerColor "ColorGreen";

true
