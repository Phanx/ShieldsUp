--[[--------------------------------------------------------------------
	ShieldsUp
	Text-based shaman shield monitor.
	Copyright (c) 2008-2014 Phanx <addons@phanx.net>. All rights reserved.
	http://www.wowinterface.com/downloads/info9165-ShieldsUp.html
	http://www.curse.com/addons/wow/shieldsup

	Please DO NOT upload this addon to other websites, or post modified
	versions of it. However, you are welcome to use any/all of its code
	in your own addon, as long as you do not use my name or the name of
	this addon ANYWHERE in your addon, including in its name, outside of
	an optional attribution. You are also welcome to include this addon
	WITHOUT CHANGES in compilations posted on Curse and/or WoWInterface.
------------------------------------------------------------------------
	English localization
	These strings are used if no localized version overrides them.
----------------------------------------------------------------------]]

local _, private = ...
if select(2, UnitClass("player")) ~= "SHAMAN" then private.UNLOAD = true return end

local L = {}
private.L = L

L.Active = "Active"
L.Active_Desc = "Set the color for the target name when your %s is active."
L.AlertOverwritten = "Alert on overwrites"
L.AlertOverwritten_Desc = "Also alert when someone overwrites your %s."
L.Alerts = "Alerts"
L.Alerts_Desc = "Use these options to control how ShieldsUp alerts you when your shields are removed or expire."
L.AlertSound = "Play sound"
L.AlertSound_Desc = "Choose a sound to play when your %s expires."
L.AlertText = "Show message"
L.AlertText_Desc = "Show a message when your %s expires."
L.AlertTextSink = "Message location"
L.AlertWhileHidden = "Alert while hidden"
L.AlertWhileHidden_Desc = "Show alert messages and play alert sounds while ShieldsUp is hidden due to your visibility settings."
L.Bottom = "Bottom"
L.ClassColor = "Use class color"
L.ClassColor_Desc = "Color the target name by class when your %s is active."
L.ClickForOptions = "Click for options."
L.Colors = "Colors"
L.CounterSize = "Counter text size"
L.Font = "Font"
L.HiddenLowLevel = "|cffffd100ATTENTION:|r Regardless of your settings above, ShieldsUp is currently hidden because your character's level is too low. Once you reach Level 8 and learn Lightning Shield, ShieldsUp will show and hide normally."
L.Hide = "Hide when:"
L.HideDead = "Dead"
L.HideInfinite = "Hide infinite shields"
L.HideInfinite_Desc = "Hide the letter indicator for active shields that don't have a limited number of charges. Missing shields will still be shown."
L.HideOOC = "Out of combat"
L.HideResting = "Resting"
L.HideVehicle = "In a vehicle"
L.Hidden = "Hidden"
L.LightningAbbrev = "L"
L.Missing = "Missing"
L.Missing_Desc = "Set the color to use for missing shields."
L.NamePosition = "Target name position"
L.NameSize = "Name text size"
L.None = "None"
L.Opacity = "Opacity"
L.OptionsDesc = "Use these options to control the appearance of the ShieldsUp display."
L.Outline = "Outline"
L.Overwritten = "Overwritten"
L.Overwritten_Desc = "Set the color for the target name when your %s has been overwritten."
L.OverwrittenBy = "Your %1$s has been overwritten by %2$s!"
L.PaddingH = "Horizontal padding"
L.PaddingH_Desc = "Change the padding between the two shield counters."
L.PaddingV = "Vertical padding"
L.PaddingV_Desc = "Change the padding between the shield counters and the target name."
L.PositionX = "Horizontal position"
L.PositionY = "Vertical position"
L.Shadow = "Shadow"
L.ShieldFaded = "%s faded!"
L.ShieldFadedFrom = "%1$s faded from %2$s!"
L.Show = "Show in:"
L.ShowArena = "Arena"
L.ShowBattleground = "Battleground"
L.ShowParty = "Party"
L.ShowRaid = "Raid"
L.ShowSolo = "Solo"
L.Thick = "Thick"
L.Thin = "Thin"
L.Top = "Top"
L.Visibility = "Visibility"
L.Visibility_Desc = "Use these options to control when ShieldsUp is shown or hidden."
L.WaterAbbrev = "W"
L.YOU = "YOU"