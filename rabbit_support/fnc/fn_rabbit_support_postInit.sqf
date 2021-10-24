#include "script_component.hpp"

if (!isDedicated && hasInterface) then {
    [
        [
            ["TestAction_call_help","Запросить поддержку","z\SSS\addons\main\ui\icons\heli.paa",{ [objNull, player, [player, QUOTE(CALL_HELP_VDV_TYPE)]] call SPEC_fnc_rabbit_support_selectPosition; }],
            ["TestAction_call_help","Запросить сброс транспорта","\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\supplydrop_ca.paa",{ [objNull, player, [player, QUOTE(CALL_DROP_TRANSPORT_TYPE)]] call SPEC_fnc_rabbit_support_selectPosition; }],
            ["TestAction_call_help","Запросить сброс тяжелого транспорта","\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\supplydrop_ca.paa",{ [objNull, player, [player, QUOTE(CALL_DROP_TRANSPORT_V2_TYPE)]] call SPEC_fnc_rabbit_support_selectPosition; }],
            ["TestAction_call_help","Запросить десантников","z\SSS\addons\main\ui\icons\gunship.paa",{ [objNull, player, [player, QUOTE(CALL_HELP_PARADROP_TYPE)]] call SPEC_fnc_rabbit_support_selectPosition; }]
        ]
    ] call SPEC_fnc_rabbit_support_compileSimpleActions;
};

if (isServer) then {
    execVM "SpecBased\rabbit_support\scripts\vehicleOnFire.sqf";
};
