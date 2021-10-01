params ["_time_to_destroid","_vehicle_select", "_Fire"];

while {!(_this call SPEC_fnc_rabbit_support_vof_condition)} do {
    if ((_time_to_destroid get "time") in [8,16,24,32,40,48,56,64,72,80,88,96]) then {
        playSound3D ["A3\Sounds_F\sfx\fire1_loop.wss", _Fire]
    };
};

true
