params ["_vehicle_select"];

[[], {
    hint(parseText "<t color='#ff0000'><t size='2.0'>Двигатель горит!!!</t></t>");
    sleep 10;
    hint "";
}] remoteExec ["spawn", crew _vehicle_select apply {parseNumber ((_x call BIS_fnc_netId splitString ":") # 1)}];

true
