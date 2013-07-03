if(isDedicated) exitWith {};

player setVariable ["TEN_canSwitch", true];

// Listens for the calls to "User17" and "User18" actions and applies our logic
TEN_keyHandler = {
	private ["_canSwitch", "_toHandgun", "_toLauncher", "_isSwitch", "_stance", "_type"];

	while {true} do {

		// Listen for the input actions
		waitUntil {
			_toHandgun = inputaction "User17";
			_toLauncher = inputaction "User18";
			(_toHandgun > 0 or _toLauncher > 0);
		};

		// Only override if we're pressing the right key combo and are in the right stance
		_stance = stance player;
		_isSwitch = if(_stance == "STAND" or _stance == "CROUCH") then {true} else {false};
		_canSwitch = player getVariable "TEN_canSwitch";
		
		// Only change stances on the move if we're overriding the default and no other transition is in progress
		if(_isSwitch && _canSwitch) then {
			player setVariable ["TEN_canSwitch", false];
			_type = if(_toHandgun > 0) then {"handgun"} else {"launcher"};
			_type call TEN_determineSwitch;
		};

		sleep 0.3;
	};
	
};

TEN_determineSwitch = {
	private ["_type", "_currentWeapon", "_handgun", "_rifle", "_launcher", "_switchDirection", "_rifleToHandgun", "_handgunToRifle", "_launcherToHandgun", "_nextWeapon"];

	_type = _this;
	_currentWeapon = currentWeapon player;
	_handgun = handgunWeapon player;
	_rifle = primaryWeapon player;
	_launcher = secondaryWeapon player;

	// Possible transitions and their metadata
	// Array contains: Start gesture, end gesture, end gesture delay, next weapon, default cancelling crouch animation
	_rifleToHandgun    = ["TEN_GestureStandingRiflePistolSwitch",   "TEN_GestureStandingRiflePistolSwitchEnd",    0.9, _handgun,  "amovpknlmstpsraswpstdnon"];
	_rifleToLauncher   = ["TEN_GestureStandingRifleLauncherSwitch", "TEN_GestureStandingRifleLauncherSwitchEnd",  1,   _launcher, "amovpknlmstpsraswlnrdnon"];
	_handgunToRifle    = ["TEN_GestureStandingPistolRifleSwitch",   "TEN_GestureStandingPistolRifleSwitchEnd",    1,   _rifle,    "amovpknlmstpsraswrfldnon"];
	_handgunToLauncher = ["TEN_GestureStandingPistolLauncherSwitch","TEN_GestureStandingPistolLauncherSwitchEnd", 1,   _launcher, "amovpknlmstpsraswlnrdnon"];
	_launcherToHandgun = ["TEN_GestureStandingLauncherPistolSwitch","TEN_GestureStandingLauncherPistolSwitchEnd", 1,   _handgun,  "amovpknlmstpsraswpstdnon"];
	_launcherToRifle   = ["TEN_GestureStandingLauncherRifleSwitch", "TEN_GestureStandingLauncherRifleSwitchEnd",  1,   _rifle,    "amovpknlmstpsraswrfldnon"];

	switch true do {
		case (_currentWeapon == _rifle    && _type == "handgun" ) : { _switchDirection = _rifleToHandgun;   };
		case (_currentWeapon == _rifle    && _type == "launcher") : { _switchDirection = _rifleToLauncher;  };
		case (_currentWeapon == _handgun  && _type == "handgun" ) : { _switchDirection = _handgunToRifle;   };
		case (_currentWeapon == _handgun  && _type == "launcher") : { _switchDirection = _handgunToLauncher;};
		case (_currentWeapon == _launcher && _type == "handgun" ) : { _switchDirection = _launcherToHandgun;};
		case (_currentWeapon == _launcher && _type == "launcher") : { _switchDirection = _launcherToRifle;  };
		default { _switchDirection = [] };
	};

	_nextWeapon = _switchDirection select 3;

	// Proceed if we have the next weapon, otherwise let the player try again
	if(_nextWeapon != "") then {
		_switchDirection spawn TEN_performSwitch;
	} else {
		player setVariable ["TEN_canSwitch", true];
	};
};

TEN_performSwitch = {
	private ["_startGesture", "_endGesture", "_delay", "_cancellingCrouch", "_switchMove", "_stance", "_launcher"];

	// Map the input array to some sane variable names
	_startGesture = _this select 0;
	_endGesture = _this select 1;
	_delay = _this select 2;
	_nextWeapon = _this select 3;
	_cancellingCrouch = _this select 4;
	_launcher = secondaryWeapon player;
	_switchMove = "";

	// Switching logic
	player playActionNow _startGesture;

	sleep _delay;

	_stance = stance player;

	// Switchmoving to "" when the launcher is selected, repeats the transition
	if(_nextWeapon == _launcher) then { _switchMove = "amovpercmstpsraswlnrdnon";};

	// Use the crouching default animation if we're crouching, switchmoving to "" will stand us up
	if(_stance == "CROUCH") then { _switchMove = _cancellingCrouch;};

	// And finalise the switch
	player selectWeapon _nextWeapon;
	player switchMove _switchMove;
	player playActionNow _endGesture;
	player setVariable ["TEN_canSwitch", true];
};

// Start spyin' on dem keys harder than certain government agencies
[] spawn TEN_keyHandler;