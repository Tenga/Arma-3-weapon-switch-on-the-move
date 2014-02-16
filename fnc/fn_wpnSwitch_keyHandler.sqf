/*
	Author: Sniperwolf572

	Description:
		Handles the keybinds for Use Action 17 and Use Action 18

	Parameter(s):
		None

	Returns:
		Nothing
*/

private ["_toHandgun", "_toLauncher", "_unit", "_canSwitch", "_stance", "_isSwitch", "_type"];

while {true} do {

	// Listen for the input actions. Done this way so the switch is responsive, allows for any keybind that
	// can be mapped and  avoids custom code for detecting the mouse keys and key combos
	waitUntil {
		_toHandgun = inputaction "User17";
		_toLauncher = inputaction "User18";
		(_toHandgun > 0 or {_toLauncher > 0});
	};

	_unit = player;

	// Only override if we're pressing the right key combo and are in the right stance
	_stance = stance _unit;
	_isSwitch = if(_stance == "STAND" or {_stance == "CROUCH"} or {_stance == "PRONE"}) then {true} else {false};

	// Only change stances on the move if we're overriding the default and no other transition is in progress
	if _isSwitch then {
		_type = if(_toHandgun > 0) then {"handgun"} else {"launcher"};
		[_unit, _type] call TEN_fnc_wpnSwitch_determineSwitch;
	};

	sleep 0.3;
};
