/*
    KPLIB_fnc_core_postInit

    File: fn_core_postInit.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2017-08-31
    Last Update: 2019-04-22
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        The postInit function of a module takes care of starting/executing the modules functions or scripts.
        Basically it starts/initializes the module functionality to make all provided features usable.

    Parameter(s):
        NONE

    Returns:
        Module postInit finished [BOOL]
*/

SPEC_radio_chatter_sounds = [
    "A3\Sounds_F\sfx\radio\ambient_radio8.wss",
    "A3\Sounds_F\sfx\radio\ambient_radio09.wss",
    "A3\Sounds_F\sfx\radio\ambient_radio11.wss",
    "A3\Sounds_F\sfx\radio\ambient_radio18.wss",
    "A3\Sounds_F\sfx\radio\ambient_radio19.wss",
    "A3\Sounds_F\sfx\radio\ambient_radio20.wss",
    "A3\Sounds_F\sfx\radio\ambient_radio22.wss"
];

// Server section (dedicated and player hosted)
if (isServer) then {
    execVM "SpecBased\radio_chatter\scripts\radioLoop.sqf";
};

// HC section
if (!hasInterface && !isDedicated) then {

};

// Player section
if (hasInterface) then {

};

true
