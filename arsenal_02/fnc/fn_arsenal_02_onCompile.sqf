params ["_preset","_regenerate"];

if (isNil "SPEC_arsenal_02_virtualItemsStore" ||
    (!isNil "SPEC_arsenal_02_virtualItemsStore" && {count SPEC_arsenal_02_virtualItemsStore > 0}) ||
    _regenerate
) then {
    SPEC_arsenal_02_virtualItemsStore = createHashMap;

    private _virtualCargo = [] call SPEC_fnc_arsenal_02_addAllVirtualCargo;
    private _presets = [_preset] call SPEC_fnc_arsenal_02_initBlacklistPresets;

    private _virtualItems = [_virtualCargo, _presets] call SPEC_fnc_arsenal_02_filter;
    private _cargo = [(_virtualItems getOrDefault ["ace_items", true])] call SPEC_fnc_arsenal_02_aceVirtualItems;

    SPEC_arsenal_02_virtualItemsStore set ["_virtualItems", _virtualItems];
    SPEC_arsenal_02_virtualItemsStore set ["_cargo", _cargo];
};

["SPEC_arsenal_02_presetsCompiled", SPEC_arsenal_02_virtualItemsStore] call CBA_fnc_globalEvent;

true
