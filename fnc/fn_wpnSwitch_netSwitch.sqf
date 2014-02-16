/*
	Author: Sniperwolf572

	Description:
		This function gets called during the weapon switch with movement enabled.
		It reduces the graphical glitching of the unit that is switching the weapons that appears on the clients.

	Parameter(s):
		None

	Returns:
		Nothing
*/

private ["_unit", "_switchMove", "_nextWeapon"];

_unit = _this select 0;
_switchMove = _this select 1;
_nextWeapon = _this select 2;

// Workaround: selectWeapon is also executed on the client, so that the network lag will 
// not cause the gestures to repeat, have no weapon in hands and cause some visual sliding.
// Might cause issues.
_unit selectWeapon _nextWeapon;
_unit switchMove _switchMove;