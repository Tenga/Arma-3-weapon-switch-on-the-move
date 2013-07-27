private ["_unit", "_switchData", "_stance", "_nextWeapon", "_rifle", "_startGesture", "_endGesture", "_delay", "_cancellingCrouch", "_launcher", "_switchMove"];

_unit = _this select 0;
_switchData = _this select 1;
_stance = stance _unit;
_nextWeapon = _switchData select 3;
_rifle = primaryWeapon _unit;

// If the player is prone, do the regular weapon switch	
if(_stance == "PRONE") then {

	// Apparently switching from handgun to rifle plays no animations, yay
	if(_nextWeapon == _rifle) then {
		_unit playMoveNow "amovppnemstpsraswpstdnon_amovppnemstpsraswrfldnon";
	};

	_unit selectWeapon _nextWeapon;
	

} else {

	// If he's not laying on the floor being a lazy bum, he can switch weapons via gestures
	_startGesture = _switchData select 0;
	_endGesture = _switchData select 1;
	_delay = _switchData select 2;
	_cancellingCrouch = _switchData select 4;
	_launcher = secondaryWeapon _unit;
	_switchMove = "";

	// Switching logic
	_unit playActionNow _startGesture;

	sleep _delay;

	// We need to know the stance again after the delay in case it changed
	_stance = stance _unit;

	// Switchmoving to "" when the launcher is selected, repeats the transition
	if(_nextWeapon == _launcher) then { _switchMove = "amovpercmstpsraswlnrdnon";};

	// Use the crouching default animation if we're crouching, switchmoving to "" will stand us up
	if(_stance == "CROUCH") then { _switchMove = _cancellingCrouch;};

	// And finalise the switch
	_unit selectWeapon _nextWeapon;
	_unit switchMove _switchMove;
	_unit playActionNow _endGesture;
};
