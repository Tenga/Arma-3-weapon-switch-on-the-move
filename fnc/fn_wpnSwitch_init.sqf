diag_log [__FILE__, "CALLED"];

if (!isDedicated) then
{
	// Start spyin' on dem keys harder than certain government agencies
	[] spawn TEN_fnc_wpnSwitch_keyHandler;
};
