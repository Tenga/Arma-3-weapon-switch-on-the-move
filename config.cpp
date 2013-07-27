class CfgPatches {

	class TEN_switchWeaponsWhileMoving {
		units[] = {};
		weapons[] = {};
		requiredAddons[] = {};
		version = "1.4.2";
		author[]= {"Sniperwolf572", "Deadfast"};
		authorUrl = "https://twitter.com/tenga6";
	};

};

class CfgFunctions
{
	class TEN
	{
		tag = "TEN";

		class switchWeaponsWhileMoving
		{
			file = "x\TEN\addons\TEN_switchWeaponsWhileMoving\fnc";
			
			class wpnSwitch_keyHandler
			{
			};
			class wpnSwitch_determineSwitch
			{
			};
			class wpnSwitch_performSwitch
			{
			};
			class wpnSwitch_init
			{
				postInit = 1;
			};
		};
	};
};

class CfgMovesBasic {

	class ManActions {
		TEN_GestureStandingRiflePistolSwitch[]    = {"TEN_GestureStandingRiflePistolSwitch","Gesture"};
		TEN_GestureStandingRifleLauncherSwitch[]  = {"TEN_GestureStandingRifleLauncherSwitch","Gesture"};
		TEN_GestureStandingPistolRifleSwitch[]    = {"TEN_GestureStandingPistolRifleSwitch","Gesture"};
		TEN_GestureStandingPistolLauncherSwitch[] = {"TEN_GestureStandingPistolLauncherSwitch","Gesture"};
		TEN_GestureStandingLauncherRifleSwitch[]  = {"TEN_GestureStandingLauncherRifleSwitch","Gesture"};
		TEN_GestureStandingLauncherPistolSwitch[] = {"TEN_GestureStandingLauncherPistolSwitch","Gesture"};

		TEN_GestureStandingRiflePistolSwitchEnd[]    = {"TEN_GestureStandingRiflePistolSwitchEnd","Gesture"};
		TEN_GestureStandingRifleLauncherSwitchEnd[]  = {"TEN_GestureStandingRifleLauncherSwitchEnd","Gesture"};
		TEN_GestureStandingPistolRifleSwitchEnd[]    = {"TEN_GestureStandingPistolRifleSwitchEnd","Gesture"};
		TEN_GestureStandingPistolLauncherSwitchEnd[] = {"TEN_GestureStandingPistolLauncherSwitchEnd","Gesture"};
		TEN_GestureStandingLauncherRifleSwitchEnd[]  = {"TEN_GestureStandingLauncherRifleSwitchEnd","Gesture"};
		TEN_GestureStandingLauncherPistolSwitchEnd[] = {"TEN_GestureStandingLauncherPistolSwitchEnd","Gesture"};
	};
};

class CfgGesturesMale {

	class Default;

	class States {

		class TEN_GestureStandingRiflePistolSwitch: Default {
			speed = 1;
			file = "\A3\anims_f\Data\Anim\Sdr\Mov\erc\stp\ras\rfl\AmovPercMstpSrasWrflDnon_AmovPercMstpSrasWpstDnon.rtm";
			mask = "handsWeapon"; // upperTorso
			disableWeapons = 1;
			interpolationRestart = 2;
			leftHandIKCurve[] = {0.759,1,0.929,0};
			rightHandIKCurve[] = {0.17,1,0.298,0};
			weaponIK = 1;
		};

		class TEN_GestureStandingRifleLauncherSwitch: Default {
			file = "\A3\anims_f\Data\Anim\Sdr\mov\erc\stp\ras\rfl\amovpercmstpsraswrfldnon_amovpercmstpsraswlnrdnon.rtm";
			mask = "launcher";
			speed = 1;
			disableWeapons = 1;
			disableWeaponsLong = 1;
			enableMissile = 0;
			canPullTrigger = 0;
			interpolationRestart = 2;
			leaningFactorBeg = 1;
			leaningFactorEnd = 0.5;
			rightHandIKCurve[] = {0.136,1,0.288,0};
			leftHandIKCurve[] = {0.5,1,0.773,0};
			weaponIK = 1;
		};

		class TEN_GestureStandingPistolRifleSwitch: Default {
			file = "\A3\anims_f\Data\Anim\Sdr\Mov\erc\stp\ras\pst\AmovPercMstpSrasWpstDnon_AmovPercMstpSrasWrflDnon";
			speed = 1;
			disableWeapons = 1;
			mask = "handsWeapon"; // upperTorso
		};

		class TEN_GestureStandingPistolLauncherSwitch: Default {
			file = "\A3\anims_f\Data\Anim\Sdr\mov\erc\stp\ras\pst\amovpercmstpsraswpstdnon_amovpercmstpsraswlnrdnon.rtm";
			mask = "launcher";
			speed = 1;
			disableWeapons = 1;
			disableWeaponsLong = 1;
			enableMissile = 0;
			canPullTrigger = 0;
			interpolationRestart = 2;
			weaponIK = 2;
			leftHandIKEnd = 0;
			leftHandIKBeg = 0;
			leftHandIKCurve[] = {};
		};

		class TEN_GestureStandingLauncherRifleSwitch: Default {
			file = "\A3\anims_f\Data\Anim\Sdr\mov\erc\stp\ras\lnr\amovpercmstpsraswlnrdnon_amovpercmstpsraswrfldnon.rtm";
			mask = "launcher";
			speed = 1;
			disableWeapons = 1;
			disableWeaponsLong = 1;
			enableMissile = 0;
			canPullTrigger = 0;
			interpolationRestart = 2;
			leftHandIKBeg = 0;
			leftHandIKEnd = 0;
			rightHandIKBeg = 0;
			rightHandIKEnd = 0;
			leaningFactorEnd = 1;
			leaningFactorBeg = 0.5;
			rightHandIKCurve[] = {0.245,1,0.449,0};
			leftHandIKCurve[] = {0.643,1,0.724,0};
			weaponIK = 4;
		};

		class TEN_GestureStandingLauncherPistolSwitch: Default {
			file = "\A3\anims_f\Data\Anim\Sdr\mov\erc\stp\ras\lnr\amovpercmstpsraswlnrdnon_amovpercmstpsraswpstdnon.rtm";
			mask = "launcher";
			speed = 1;
			disableWeapons = 1;
			disableWeaponsLong = 1;
			enableMissile = 0;
			canPullTrigger = 0;
			interpolationRestart = 2;
			rightHandIKEnd = 0;
			rightHandIKBeg = 0;
			leftHandIKEnd = 0;
			leftHandIKBeg = 0;
			rightHandIKCurve[] = {0.639,1,0.778,0};
			leftHandIKCurve[] = {0.819,1,0.917,0};
			weaponIK = 4;
		};

		class TEN_GestureStandingRiflePistolSwitchEnd: Default {
			speed = 1.666;
			file = "\A3\anims_f\Data\Anim\Sdr\Mov\erc\stp\ras\rfl\AmovPercMstpSrasWrflDnon_AmovPercMstpSrasWpstDnon_end";
			mask = "handsWeapon"; // upperTorso
			disableWeapons = 1;
		};

		class TEN_GestureStandingRifleLauncherSwitchEnd: Default {
			file = "\A3\anims_f\Data\Anim\Sdr\mov\erc\stp\ras\rfl\amovpercmstpsraswrfldnon_amovpercmstpsraswlnrdnon_end.rtm";
			mask = "launcher";
			speed = 1;
			disableWeapons = 1;
			disableWeaponsLong = 1;
			enableMissile = 0;
			canPullTrigger = 0;
			interpolationRestart = 2;
			leftHandIKBeg = 0;
			leftHandIKEnd = 0;
			rightHandIKBeg = 0;
			rightHandIKEnd = 0;
			leaningFactorEnd = 1;
			leaningFactorBeg = 0.5;
			rightHandIKCurve[] = {0.252,0,0.411,1};
			leftHandIKCurve[] = {0.093,0,0.243,1};
			weaponIK = 4;
		};

		class TEN_GestureStandingPistolRifleSwitchEnd: Default {
			file = "\A3\anims_f\Data\Anim\Sdr\Mov\erc\stp\ras\pst\AmovPercMstpSrasWpstDnon_AmovPercMstpSrasWrflDnon_end";
			speed = 1;
			disableWeapons = 1;
			mask = "handsWeapon"; // upperTorso
			aiming = "aimingDefault";
			aimingBody = "aimingUpDefault";
			interpolationSpeed = 20;
			rightHandIKCurve[] = {0.3,0,0.4,1};
			leftHandIKCurve[] = {0.406,0,0.492,1};
			weaponIK = 1;
		};

		class TEN_GestureStandingPistolLauncherSwitchEnd: Default {
			file = "\A3\anims_f\Data\Anim\Sdr\mov\erc\stp\ras\pst\amovpercmstpsraswpstdnon_amovpercmstpsraswlnrdnon_end.rtm";
			mask = "launcher";
			speed = 1;
			disableWeapons = 1;
			disableWeaponsLong = 1;
			enableMissile = 0;
			canPullTrigger = 0;
			interpolationRestart = 2;
			rightHandIKEnd = 0;
			rightHandIKBeg = 0;
			rightHandIKCurve[] = {0.414,0,0.493,1};
			leftHandIKCurve[] = {0.132,0,0.257,1};
			leftHandIKEnd = 0;
			leftHandIKBeg = 0;
			weaponIK = 4;
		};

		class TEN_GestureStandingLauncherRifleSwitchEnd: Default {
			file = "\A3\anims_f\Data\Anim\Sdr\mov\erc\stp\ras\lnr\amovpercmstpsraswlnrdnon_amovpercmstpsraswrfldnon_end.rtm";
			mask = "launcher";
			speed = 1;
			disableWeapons = 1;
			disableWeaponsLong = 1;
			enableMissile = 0;
			canPullTrigger = 0;
			interpolationRestart = 2;
			leftHandIKBeg = 0;
			leftHandIKEnd = 0;
			rightHandIKBeg = 0;
			rightHandIKEnd = 0;
			leaningFactorEnd = 1;
			leaningFactorBeg = 0.5;
			rightHandIKCurve[] = {0.843,0,0.935,1};
			leftHandIKCurve[] = {0.481,0,0.694,1};
			weaponIK = 1;
		};

		class TEN_GestureStandingLauncherPistolSwitchEnd: Default {
			file = "\A3\anims_f\Data\Anim\Sdr\mov\erc\stp\ras\lnr\amovpercmstpsraswlnrdnon_amovpercmstpsraswpstdnon_end.rtm";
			mask = "launcher";
			speed = 1;
			disableWeapons = 1;
			disableWeaponsLong = 1;
			enableMissile = 0;
			canPullTrigger = 0;
			interpolationRestart = 2;
			leftHandIKBeg = 0;
			leftHandIKCurve[] = {};
			leftHandIKEnd = 0;
		};
	};
};
