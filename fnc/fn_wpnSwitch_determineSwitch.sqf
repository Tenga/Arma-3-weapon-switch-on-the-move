/*
	Author: Sniperwolf572

	Description:
		Determines and triggers the weapon switch with movement enabled depending on the type of switch provided

	Parameter(s):
		0: OBJECT - the unit that will perform the switch (Should be player for now)
		1: STRING - Type of switch to do, should be "handgun" or "launcher"

	Returns:
		Nothing
*/

private ["_unit", "_type", "_currentWeapon", "_handgun", "_rifle", "_launcher", "_performingSwitch", "_rifleToHandgun", "_rifleToLauncher", "_handgunToRifle", "_handgunToLauncher", "_launcherToHandgun", "_launcherToRifle", "_switchDirection", "_nextWeapon"];

_unit = _this select 0;
_type = _this select 1;
_currentWeapon = currentWeapon _unit;
_handgun = handgunWeapon _unit;
_rifle = primaryWeapon _unit;
_launcher = secondaryWeapon _unit;
_performingSwitch = false;

// Possible transitions and their metadata
// Array contains: Start gesture, end gesture, end gesture delay, next weapon, default cancelling crouch animation
_rifleToHandgun    = ["TEN_GestureStandingRiflePistolSwitch",   "TEN_GestureStandingRiflePistolSwitchEnd",    0.9, _handgun,  "amovpknlmstpsraswpstdnon"];
_rifleToLauncher   = ["TEN_GestureStandingRifleLauncherSwitch", "TEN_GestureStandingRifleLauncherSwitchEnd",  1,   _launcher, "amovpknlmstpsraswlnrdnon"];
_handgunToRifle    = ["TEN_GestureStandingPistolRifleSwitch",   "TEN_GestureStandingPistolRifleSwitchEnd",    1,   _rifle,    "amovpknlmstpsraswrfldnon"];
_handgunToLauncher = ["TEN_GestureStandingPistolLauncherSwitch","TEN_GestureStandingPistolLauncherSwitchEnd", 1,   _launcher, "amovpknlmstpsraswlnrdnon"];
_launcherToHandgun = ["TEN_GestureStandingLauncherPistolSwitch","TEN_GestureStandingLauncherPistolSwitchEnd", 1,   _handgun,  "amovpknlmstpsraswpstdnon"];
_launcherToRifle   = ["TEN_GestureStandingLauncherRifleSwitch", "TEN_GestureStandingLauncherRifleSwitchEnd",  1,   _rifle,    "amovpknlmstpsraswrfldnon"];

switch true do {
	case (_currentWeapon == _rifle    && { _type == "handgun" }) : { _switchDirection = _rifleToHandgun;   };
	case (_currentWeapon == _rifle    && { _type == "launcher"}) : { _switchDirection = _rifleToLauncher;  };
	case (_currentWeapon == _handgun  && { _type == "handgun" }) : { _switchDirection = _handgunToRifle;   };
	case (_currentWeapon == _handgun  && { _type == "launcher"}) : { _switchDirection = _handgunToLauncher;};
	case (_currentWeapon == _launcher && { _type == "handgun" }) : { _switchDirection = _launcherToHandgun;};
	case (_currentWeapon == _launcher && { _type == "launcher"}) : { _switchDirection = _launcherToRifle;  };
};

if(!isNil "_switchDirection") then {
	_nextWeapon = _switchDirection select 3;

	// Proceed if we have the next weapon, otherwise let the player try again
	if(_nextWeapon != "") then {
		[_unit, _switchDirection] call TEN_fnc_wpnSwitch_performSwitch;
	};
};
