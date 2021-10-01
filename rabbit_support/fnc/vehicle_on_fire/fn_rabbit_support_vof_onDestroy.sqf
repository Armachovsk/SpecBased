params ["_time_to_destroid","_vehicle_select", "_Fire", "_Smoke", "_light"];

{_x setDamage 1} forEach crew _vehicle_select;
_vehicle_select setDamage 1;
deleteVehicle _Fire;
deleteVehicle _Smoke;
deleteVehicle _light;

true
