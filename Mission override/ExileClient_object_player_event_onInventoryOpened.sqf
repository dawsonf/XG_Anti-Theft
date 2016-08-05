/**
 * ExileClient_object_player_event_onInventoryOpened
 *
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_cancelEvent","_container"];
systemChat "Inventory Opened";
_cancelEvent = false;
_container = _this select 1;
try 
{
	if (ExileIsPlayingRussianRoulette) then 
	{
		throw true;
	};
	if (ExileClientIsHandcuffed) then 
	{
		throw true;
	};
	if (ExileClientActionDelayShown) then 
	{
		throw true;
	};
	if (ExileClientIsInConstructionMode) then 
	{
		throw true;
	};
	if ((locked _container) isEqualTo 2) then
	{
		throw true;
	};
	if (_container getVariable ["ExileIsLocked", 1] isEqualTo -1) then 
	{
		throw true;
	};
	_vehicleInfo = _container getVariable ["XG_AntiTheftInfo",[]];
	if!(_vehicleInfo isEqualTo []) then
	{
		_family = player getVariable ["ExileClanID","No Family"];
		_vehicleInfo params [["_group",0],["_vifamily","No Family"],["_evhID",-1],["_ownerUID",""],["_evhID1",-1]];
		if(_group isEqualTo "No Group") then
		{
			if!(_family isEqualTo "No Family") then
			{
				if!((_family isEqualTo _vifamily) || (getPlayerUID player) isEqualTo _ownerUID) exitWith
				{
					throw true;
				};
			}
			else
			{
				if!((getPlayerUID player) isEqualTo _ownerUID) exitWith
				{
					throw true;
				};
			};
		}
		else
		{
			if!(_family isEqualTo "No Family") then
			{
				if!((str(group player) isEqualTo _group) || (_family isEqualTo _vifamily) || (getPlayerUID player) isEqualTo _ownerUID) exitWith
				{
					throw true;
				};
			}
			else
			{
				if!((str(group player) isEqualTo _group) || (getPlayerUID player) isEqualTo _ownerUID) exitWith
				{
					throw true;
				};
			};
		};
	}
	else
	{
		if(ExilePlayerInSafezone) then
		{
			["XG_CheckVariable",[_container,player]] call ExileClient_system_network_send;
		};
	};
	ExileClientInventoryOpened = true;
	ExileClientCurrentInventoryContainer = _container;
}
catch 
{
	_cancelEvent = _exception;
};
_cancelEvent