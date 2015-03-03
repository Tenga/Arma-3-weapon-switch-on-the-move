/*
	Author: Sniperwolf572

	Description:
		Performs the weapon switch with movement enabled

	Parameter(s):
		0: OBJECT - the unit that will perform the switch (Should be player for now)
		1: ARRAY  - Switch metadata: [string startGesture, string endGesture, float endGestureDelay, string nextWeapon, string cancellingCrouchAnimation];

	Returns:
		Nothing
*/


private ["_unit", "_switchData", "_stance", "_nextWeapon", "_rifle", "_startGesture", "_endGesture", "_delay", "_cancellingCrouch", "_launcher", "_switchMove", "_preventFiring"];

_unit = _this select 0;
_switchData = _this select 1;
_stance = stance _unit;
_nextWeapon = _switchData select 3;
_rifle = primaryWeapon _unit;

switch true do {

	// Do the regular weapon switch	in prone
	case (_stance == "PRONE") : {
		_unit selectWeapon _nextWeapon;
	};

	// Regular weapon switch in FFV
	case (!(vehicle _unit isEqualTo player)) : {

		// No switching to launchers in FFV
		if(!(_nextWeapon isEqualTo (secondaryWeapon _unit))) then {
			_unit selectWeapon _nextWeapon;
		};

	};

	default {

		// If he's not laying on the floor being a lazy bum, he can switch weapons via gestures
		_startGesture = _switchData select 0;
		_endGesture = _switchData select 1;
		_delay = _switchData select 2;
		_cancellingCrouch = _switchData select 4;
		_launcher = secondaryWeapon _unit;
		_switchMove = "";

		// Switching logic
		_unit playActionNow _startGesture;

		// Prevent launcher firing
		_preventFiring = [format ["TEN_wpnSwitch_noFiring_%1", diag_frameno], "onEachFrame", {

			// TODO: Replace player reference with unit reference once we can pass params to the stacked event handlers
			player setWeaponReloadingTime [gunner player, secondaryWeapon player, 1]; 
			
		}] call BIS_fnc_addStackedEventHandler;

		// Wait until the first part of the switch is done
		sleep _delay;

		// We need to know the stance again after the delay in case it changed
		_stance = stance _unit;

		// Workaround - Switchmoving to "" when the launcher is selected, repeats the transition
		if(_nextWeapon == _launcher) then { _switchMove = "amovpercmstpsraswlnrdnon"; };

		// Workaround - Use the crouching default animation if we're crouching, switchmoving to "" will stand us up
		if(_stance == "CROUCH") then { _switchMove = _cancellingCrouch;};

		// And finalise the switch, execute globally to prevent sliding and jerking
		[[_unit, _switchMove, _nextWeapon], "TEN_fnc_wpnSwitch_netSwitch"] call BIS_fnc_MP;

		_unit playActionNow _endGesture;

		// Re-enable launcher firing, spawning this so it does not block the next switch and break the interrupt functionality
		[_preventFiring] spawn {
			sleep 0.8;
			[_this select 0, "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
		};
	};
};