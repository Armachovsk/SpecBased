if (isServer) then {
    ["KPLIB_sectorActivated", {
        if (5 > random 100 && {KPLIB_enemyReadiness >= 75}) then {
            KPLIB_secondary_in_progress = 1;
            publicVariable "KPLIB_secondary_in_progress";

            private _sector = selectRandom (KPLIB_sectors_player select {_x in KPLIB_sectors_city});
            private _spawnPointSector = [2000,5000,true] call KPLIB_fnc_getOpforSpawnPoint;

            [
                _spawnPointSector,
                "CPC_ME_O_KAM_D30",
                getMarkerPos _sector,
                {
                    private _squad1 = [] call KPLIB_fnc_getSquadComp;
                    private _grp = [(_this # 0), _squad1] call KPLIB_fnc_spawnRegularSquad;
                    [_grp, getMarkerPos (_this # 0)] spawn add_defense_waypoints;

                    [{
                        {
                            if (_x isKindOf "Man") then {
                                if (side group _x != KPLIB_side_player) then {
                                    deleteVehicle _x;
                                };
                            } else {
                                if (!isNull _x) then {
                                    [_x] call KPLIB_fnc_cleanOpforVehicle;
                                };
                            };
                        } forEach (_this # 0);
                    }, [units _grp]]
                }
            ] spawn SPEC_fnc_other_missions_destroyArty;
        };
    }] call CBA_fnc_addEventHandler;
};
