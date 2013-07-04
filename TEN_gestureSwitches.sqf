if(isDedicated) exitWith {};

// Listens for the calls to "User17" and "User18" actions and applies our logic
TEN_keyHandler = {
	private ["_unit", "_canSwitch", "_toHandgun", "_toLauncher", "_isSwitch", "_stance", "_type"];

	while {true} do {

		// Listen for the input actions
		waitUntil {
			_toHandgun = inputaction "User17";
			_toLauncher = inputaction "User18";
			(_toHandgun > 0 or {_toLauncher > 0});
		};

		_unit = player;
		_canSwitch = _unit getVariable "TEN_canSwitch";
		
		// Unit does not have a switch definition
		if(isNil "_canSwitch") then {
			_unit setVariable ["TEN_canSwitch", true];
			_canSwitch = true;
		};

		// Only override if we're pressing the right key combo and are in the right stance
		_stance = stance _unit;
		_isSwitch = if(_stance == "STAND" or {_stance == "CROUCH"} or {_stance == "PRONE"}) then {true} else {false};

		// Only change stances on the move if we're overriding the default and no other transition is in progress
		if(_isSwitch && {_canSwitch}) then {
			_unit setVariable ["TEN_canSwitch", false];
			_type = if(_toHandgun > 0) then {"handgun"} else {"launcher"};
			[_unit, _type] call TEN_determineSwitch;
		};

		sleep 0.3;
	};
	
};

TEN_determineSwitch = {
	private ["_unit", "_type", "_currentWeapon", "_handgun", "_rifle", "_launcher", "_switchDirection", "_rifleToHandgun", "_handgunToRifle", "_launcherToHandgun", "_nextWeapon"];

	_unit = _this select 0;
	_type = _this select 1;
	_currentWeapon = currentWeapon _unit;
	_handgun = handgunWeapon _unit;
	_rifle = primaryWeapon _unit;
	_launcher = secondaryWeapon _unit;

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
		default { _switchDirection = [] };
	};

	_nextWeapon = _switchDirection select 3;

	// Proceed if we have the next weapon, otherwise let the player try again
	if(_nextWeapon != "") then {
		[_unit, _switchDirection] spawn TEN_performSwitch;
	} else {
		_unit setVariable ["TEN_canSwitch", true];
	};
};

TEN_performSwitch = {
	private ["_unit", "_switchData", "_startGesture", "_endGesture", "_delay", "_cancellingCrouch", "_switchMove", "_stance", "_rifle", "_launcher"];

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

	_unit setVariable ["TEN_canSwitch", true];
};

// Start spyin' on dem keys harder than certain government agencies
[] spawn TEN_keyHandler;