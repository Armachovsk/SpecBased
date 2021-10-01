/*
    File: script_component.hpp
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2019-06-13
    Last Update: 2019-06-13
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Description:
        Defines for mission module scripts
*/

// Mission get var
#define MGVAR(var, defVal)      (SPEC_other_missions_pool getVariable [var, defVal])
// Mission set var
#define MSVAR(var, val)         (SPEC_other_missions_pool setVariable [var, val, true])
