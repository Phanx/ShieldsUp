--[[--------------------------------------------------------------------
	ShieldsUp
	Text-based shaman shield monitor.
	Written by Phanx <addons@phanx.net>
	Copyright © 2008–2011 Phanx. Some rights reserved. See LICENSE.txt for details.
	http://www.wowinterface.com/downloads/info9165-ShieldsUp.html
	http://www.curse.com/addons/wow/shieldsup
------------------------------------------------------------------------
	Brazilian Portuguese / Português
	Last updated YYYY-MM-DD by YourName < yourname@email.com >
----------------------------------------------------------------------]]

if not (GetLocale() == "ptBR") or select(2, UnitClass("player")) ~= "SHAMAN" then return end

local _, namespace = ...
namespace.L = {

------------------------------------------------------------------------
-- These strings are displayed when shields expire.

--	["%s faded!"] = "",
--	["%s faded from %s!"] = "",
--	["YOU"] = "",

------------------------------------------------------------------------
-- These strings are displayed in the configuration GUI.

--	["Click for options."] = "",

--	["ShieldsUp is a simple monitor for your shaman shields. Use these settings to configure the addon's appearance and behavior."] = "",

--	["Horizontal Position"] = "",
--	["Set the horizontal distance from the center of the screen to place the display."] = "",

--	["Vertical Position"] = "",
--	["Set the vertical distance from the center of the screen to place the display."] = "",

--	["Horizontal Padding"] = "",
--	["Set the horizontal space between the charge counters."] = "",

--	["Vertical Padding"] = "",
--	["Set the vertical space between the target name and charge counters."] = "",

--	["Opacity"] = "",
--	["Set the opacity level for the display."] = "",

--	["Overwrite Alert"] = "",
--	["Print a message in the chat frame alerting you who overwrites your %s."] = "",

------------------------------------------------------------------------

--	["Font Face"] = "",
--	["Set the font face to use for the display text."] = "",

--	["Outline"] = "",
--	["Select an outline width for the display text."] = "",
--	["None"] = "",
--	["Thin"] = "",
--	["Thick"] = "",

--	["Shadow"] = "",
--	["Add a drop shadow effect to the display text."] = "",

--	["Counter Size"] = "",
--	["Set the text size for the charge counters."] = "",

--	["Name Size"] = "",
--	["Set the text size for the target name."] = "",

------------------------------------------------------------------------

--	["Colors"] = "",
--	["Set the color for the %s charge counter."] = "",

--	["Active"] = "",
--	["Set the color for the target name while your %s is active."] = "",

--	["Overwritten"] = "",
--	["Set the color for the target name when your %s has been overwritten."] = "",

--	["Inactive"] = "",
--	["Set the color for expired, dispelled, or otherwise inactive shields."] = "",

--	["Colorblind Mode"] = USE_COLORBLIND_MODE, -- Leave this as-is unless there is something wrong with Blizzard's translation in your locale
--	["Add asterisks around the target name when your %s has been overwritten, in addition to changing the color."] = "",

------------------------------------------------------------------------

--	["Alerts"] = "",
--	["Use these settings to configure how ShieldsUp alerts you when a shield expires or is removed."] = "",

--	["Text Alert"] = "",
--	["Show a text message when %s expires."] = "",

--	["Sound Alert"] = "",
--	["Play a sound when %s expires."] = "",

--	["Sound File"] = "",
--	["Select the sound to play when %s expires."] = "",

--	["Text Output"] = "",

------------------------------------------------------------------------

--	["Visibility"] = "",
--	["Use these settings to control when ShieldsUp should be shown or hidden."] = "",
--	["Enable"] = "",

--	["Group Size"] = "",
--	["Solo"] = "",
--	["Show the display while you are not in a group"] = "",
--	["Party"] = "",
--	["Show the display while you are in a party group"] = "",
--	["Raid"] = "",
--	["Show the display while you are in a raid group"] = "",

--	["Zone Type"] = "",
--	["World"] = "",
--	["Show the display while you are in the outdoor world"] = "",
--	["Dungeon"] = "",
--	["Show the display while you are in a party dungeon"] = "",
--	["Raid Dungeon"] = "",
--	["Show the display while you are in a raid dungeon"] = "",
--	["Arena"] = "",
--	["Show the display while you are in a PvP arena"] = "",
--	["Battleground"] = "",
--	["Show the display while you are in a PvP battleground"] = "",

--	["Exceptions"] = "",
--	["Dead"] = "",
--	["Hide the display while you are dead"] = "",
--	["Out Of Combat"] = "",
--	["Hide the display while you are out of combat"] = "",
--	["Resting"] = "",
--	["Hide the display while you are in an inn or major city"] = "",
--	["Vehicle"] = "",
--	["Hide the display while you are controlling a vehicle"] = "",

------------------------------------------------------------------------

}