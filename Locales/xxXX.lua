--[[
	xxXX translations for ShieldsUp
	Contributed by NAME < CONTACT INFO >
	Last updated DATE
--]]

if select(2, UnitClass("player")) ~= "SHAMAN" or GetLocale() ~= "xxXX" then return end

SHIELDSUP_LOCALE = {
	["%s faded from %s!"] = "%s faded from %s!", -- The first %s = localized Earth Shield; the second %s = name of the person it was on.
	["YOU"] = "YOU",
	["%s faded!"] = "%s faded!", -- %s = localized Water Shield.

	["Alerts"] = "Alerts",
	["Text"] = "Text",
	["Show a text alert when Earth Shield fades"] = "Show a text alert when Earth Shield fades",
	["Show a text alert when Water Shield fades"] = "Show a text alert when Water Shield fades",
	["Sound"] = "Sound",
	["Play an alert sound when Earth Shield fades"] = "Play an alert sound when Earth Shield fades",
	["Play an alert sound when Water Shield fades"] = "Play an alert sound when Water Shield fades",
	["Sound File"] = "Sound File",

	["Colors"] = "Colors",
	["Normal"] = "Normal",
	["Use this color for the Earth Shield target name"] = "Use this color for the Earth Shield target name",
	["Overwritten"] = "Overwritten",
	["Use this color for the Earth Shield target name when someone overwrites your shield"] = "Use this color for the Earth Shield target name when someone overwrites your shield",
	["Alert"] = "Alert",
	["Use this color for the shield charge counters when at zero"] = "Use this color for the shield charge counters when at zero",
	["Use this color for the Earth Shield charge counter"] = "Use this color for the Earth Shield charge counter",
	["Use this color for the Water Shield charge counter"] = "Use this color for the Water Shield charge counter",

	["Font"] = "Font",
	["Face"] = "Face",
	["Outline"] = "Outline",
	["Count Size"] = "Count Size",
	["Set the font size for the counters"] = "Set the font size for the counters",
	["Name Size"] = "Name Size",
	["Set the font size for the name"] = "Set the font size for the name",
	["Shadow Offset"] = "Shadow Offset",

	["Frame"] = "Frame",
	["Horizontal Position"] = "Horizontal Position",
	["Set the horizontal placement relative to the center of the screen"] = "Set the horizontal placement relative to the center of the screen",
	["Vertical Position"] = "Vertical Position",
	["Set the vertical placement relative to the center of the screen"] = "Set the vertical placement relative to the center of the screen",
	["Horizontal Spacing"] = "Horizontal Spacing",
	["Set the horizontal spacing between text elements"] = "Set the horizontal spacing between text elements",
	["Vertical Spacing"] = "Vertical Spacing",
	["Set the vertical spacing between text elements"] = "Set the vertical spacing between text elements",
	["Alpha"] = "Alpha",
	["Set the opacity level"] = "Set the opacity level",

	["Visibility"] = "Visibility",
	["Enable"] = "Enable",
	["Allow the display to hide or show itself based on the conditions below"] = "Allow the display to hide or show itself based on the conditions below",
	["Group Size"] = "Group Size",
	["Solo"] = "Solo",
	["Show while not in a group"] = "Show while not in a group",
	["Party"] = "Party",
	["Show while in a 5-man party"] = "Show while in a 5-man party",
	["Raid"] = "Raid",
	["Show while in a raid group"] = "Show while in a raid group",
	["Zone Type"] = "Zone Type",
	["World"] = "World",
	["Show while in the world"] = "Show while in the world",
	["Dungeon"] = "Dungeon",
	["Show while in a 5-man instanced dungeon"] = "Show while in a 5-man instanced dungeon",
	["Raid Dungeon"] = "Raid Dungeon",
	["Show while in an instanced raid dungeon"] = "Show while in an instanced raid dungeon",
	["Arena"] = "Arena",
	["Show while in a PvP arena"] = "Show while in a PvP arena",
	["Battleground"] = "Battleground",
	["Show while in a PvP battleground"] = "Show while in a PvP battleground",
}

SHIELDSUP_ABOUTTEXT = [[
ShieldsUp is a shaman shield monitor that provides text displays of remaining charges on Water Shield and Earth Shield, as well as the name of the person your Earth Shield is currently active (or was last active) on.

The appearance, behavior, and placement are all configurable through the options presented here.

|cffffcc00Please note that ShieldsUp is currently in beta stages|r and may or may not be fully functional; it is certainly not yet complete!

|cffffcc00Credits|r
ShieldsUp is written by Bherasha @ US Sargeras Horde, and based on beSch by Infineon.
]]