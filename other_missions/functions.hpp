/*
    KP LIBERATION MODULE FUNCTIONS

    File: functions.hpp
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2019-06-22
    Last Update: 2019-06-22
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
*/

class other_missions {
    file = "other_missions\fnc";

    class other_missions_captureCity {};

    class other_missions_damageTransport {};

    class other_missions_destroyArty {};

    class other_missions_destroyHeli {};

    class other_missions_destroyRadar {};

    class other_missions_destroyTank {};

    class other_missions_destroyVehicle {};

    class other_missions_killGeneral {};

    class other_missions_rescueHostage {};

    class other_missions_rescueMHQ {};

    class other_missions_rescuePilots {};

    class other_missions_destroyBCW {};
};

class other_missions_init {
    file = "other_missions\fnc\init";

    // Module post initialization
    class other_missions_postInit {
        postInit = 1;
    };
};

class other_missions_utils {
    file = "other_missions\fnc\utils";

    class other_missions_spawnEnemyBot {};

    class other_missions_findPosFromMision {};
};

class other_missions_rescue_intel {
    file = "other_missions\fnc\rescue_intel";

    class other_missions_rescue_intel_botAttack {};

    class other_missions_rescue_intel_downloadData {};

    class other_missions_rescue_intel_fromUAV {};
};

class other_missions_liberation {
    file = "other_missions\fnc\liberation";

    class other_missions_liberation_createMissions {};

    class other_missions_liberation_onMissionEnd {};

    class other_missions_liberation_eventsInit {
        postInit = 1;
    };
};
