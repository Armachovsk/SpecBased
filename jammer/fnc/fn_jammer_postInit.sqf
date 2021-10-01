// Player section
if (hasInterface) then {
    [{!isNil "SPEC_sectorJammers" && {(count KPLIB_sectors_tower) == (count SPEC_sectorJammers)}}, {
        private _towers = SPEC_sectorJammers apply {_x select 2};
        [_towers, 1000, 50, {
            params ["_jammer", "_jammers", "_thisArgs"];
            SPEC_sectorJammers findIf {
                _jammer isEqualTo (_x # 2) && (_x # 0) in KPLIB_sectors_player
            } == -1
        }, []] spawn SPEC_fnc_jammer_tfarJamRadios;
    }] call CBA_fnc_waitUntilAndExecute;
};

if (isServer) then {
    if (isNil "SPEC_sectorJammers") then {
        SPEC_sectorJammers = [];
    };
    ["KPLIB_sectorTowerSpawned", {
        SPEC_sectorJammers pushBack _this;
    }] call CBA_fnc_addEventHandler;

    if (!isNil "KPLIB_sectors_tower") then {
        [{(count KPLIB_sectors_tower) == (count SPEC_sectorJammers)}, {
            publicVariable "SPEC_sectorJammers";
        }] call CBA_fnc_waitUntilAndExecute;
    };
};
