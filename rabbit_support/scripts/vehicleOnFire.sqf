// arry vehicle in fire
SPEC_rabbit_support_vehicleOnFirePool = [];

SPEC_rabbit_support_vehicleOnFilePFH = [{
    // all vehicle
    _nearsetVehicles = entities [["Car"], [], false, true];
    {
        if(_x getHitPointDamage "hitEngine" > 0.8) then {
            if (_x in SPEC_rabbit_support_vehicleOnFirePool or !alive _x) exitWith {};
            SPEC_rabbit_support_vehicleOnFirePool pushBack _x;

            _vehicle_select = _x;
            //find engine
            _pos_fire_in_vehicle = [0, 1.5, -0.7];
            if(_vehicle_select selectionPosition "hit_engine" isNotEqualTo [0,0,0])then{
                _pos_fire_in_vehicle = _vehicle_select selectionPosition "hit_engine";
                _pos_fire_in_vehicle set [0,0];
            };
            if(_vehicle_select selectionPosition "motor" isNotEqualTo [0,0,0])then{
                _pos_fire_in_vehicle = _vehicle_select selectionPosition "motor";
                _pos_fire_in_vehicle set [0,0];
            };
            // create fire
            _Fire = "#particlesource" createVehicle [0,0,0];
            _Fire setParticleClass "MediumDestructionFire";
            _Fire attachTo [_vehicle_select, _pos_fire_in_vehicle];
            // create smoke
            _Smoke = "#particlesource" createVehicle [0,0,0];
            _Smoke setParticleClass "MediumDestructionSmoke";
            _Smoke attachTo [_vehicle_select, _pos_fire_in_vehicle];
            // create light
            _light = createVehicle ["#lightpoint", [0,0,0], [], 0, "CAN_COLLIDE"];
            _light attachTo [_vehicle_select, _pos_fire_in_vehicle];
            _light setLightBrightness 1.0;
            _light setLightColor [1,0.85,0.6];
            _light setLightAmbient [1,0.3,0];
            _light setLightIntensity 400;
            _light setLightAttenuation [0,0,0,2];
            _light setLightDayLight true;
            // time to destroid
            _time_to_destroid = createHashMap;
            _time_to_destroid set ["time", 60 + round random 40];
            // talk about vehicle in fine
            [_vehicle_select] call SPEC_fnc_rabbit_support_vof_sendMsg;

            [
                _time_to_destroid,
                _vehicle_select,
                _Fire
            ] spawn SPEC_fnc_rabbit_support_vof_playFire;

            // wait until !alive vehicle or "hitEngine" <= 0.6
            [
                {
                    _this call SPEC_fnc_rabbit_support_vof_condition;
                },
                {
                    _this call SPEC_fnc_rabbit_support_vof_onDestroy;
                    SPEC_rabbit_support_vehicleOnFirePool = SPEC_rabbit_support_vehicleOnFirePool - [_this # 0];
                },
                [
                    _time_to_destroid,
                    _vehicle_select,
                    _Fire,
                    _Smoke,
                    _light
                ],
                (_time_to_destroid get "time"),
                {
                    _this call SPEC_fnc_rabbit_support_vof_onDestroy;
                    SPEC_rabbit_support_vehicleOnFirePool = SPEC_rabbit_support_vehicleOnFirePool - [_this # 0];
                }
            ] call CBA_fnc_waitUntilAndExecute;
        };
    } forEach _nearsetVehicles;
}, 10, []] call CBA_fnc_addPerFrameHandler;

[{!isNil "SPEC_rabbit_support_vehicleOnFilePFH" && {SPEC_rabbit_support_stopVehicleOnFire}}, {
    [SPEC_rabbit_support_vehicleOnFilePFH] call CBA_fnc_removePerFrameHandler;
}] call CBA_fnc_waitUntilAndExecute;
