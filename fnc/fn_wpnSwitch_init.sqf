/*
	Author: Deadfast

	Description:
		Initializes the weapon switch with movement enabled

	Parameter(s):
		None

	Returns:
		Nothing
*/

if (!isDedicated) then
{
	// Start spyin' on dem keys harder than certain government agencies
	[] spawn TEN_fnc_wpnSwitch_keyHandler;
};
