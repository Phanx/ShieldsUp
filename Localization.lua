--[[--------------------------------------------------------------------
	ShieldsUp
	Text-based shaman shield monitor.
	Copyright (c) 2008-2015 Phanx <addons@phanx.net>. All rights reserved.
	http://www.wowinterface.com/downloads/info9165-ShieldsUp.html
	http://www.curse.com/addons/wow/shieldsup
----------------------------------------------------------------------]]

if select(2, UnitClass("player")) ~= "SHAMAN" then return end

local _, ShieldsUp = ...
local L = ShieldsUp.L

-- THE REST OF THIS FILE IS AUTOMATICALLY GENERATED. APPLY UPDATES HERE:
-- http://wow.curseforge.com/addons/shieldsup/localization/

L[">> YOU <<"] = ">> YOU <<"
L["Alerts while hidden"] = "Alerts while hidden"
L["Behavior"] = "Behavior"
L["Bottom"] = "Bottom"
L["Click to lock or unlock the frame."] = "Click to lock or unlock the frame."
L["Colors"] = "Colors"
L["Hidden"] = "Hidden"
L["Hide the indicator for active shields that don't have multiple charges."] = "Hide the indicator for active shields that don't have multiple charges."
L["Hide unlimited shields"] = "Hide unlimited shields"
L["Horizontal Position"] = "Horizontal Position"
L["Horizontal Spacing"] = "Horizontal Spacing"
L["Locked"] = "Locked"
L["Message Options"] = "Message Options"
L["Missing"] = "Missing"
L["Name Color"] = "Name Color"
L["Name Font"] = "Name Font"
L["Name Position"] = "Name Position"
L["Name Size"] = "Name Size"
L["Name uses class color"] = "Name uses class color"
L["None"] = "None"
L["Number Font"] = "Number Font"
L["Number Size"] = "Number Size"
L["Opacity"] = "Opacity"
L["Outline"] = "Outline"
L["Play Sound"] = "Play Sound"
L["Relative to the center of the screen."] = "Relative to the center of the screen."
L["Right-click for options."] = "Right-click for options."
L["Show alert messages and play alert sounds even when the display is hidden."] = "Show alert messages and play alert sounds even when the display is hidden."
L["Show in arena"] = "Show in arena"
L["Show in battleground"] = "Show in battleground"
L["Show in party"] = "Show in party"
L["Show in raid"] = "Show in raid"
L["Show message"] = "Show message"
L["Show out of combat"] = "Show out of combat"
L["Show when resting"] = "Show when resting"
L["Show while solo"] = "Show while solo"
L["Text Outline"] = "Text Outline"
L["Text Shadow"] = "Text Shadow"
L["Thick Outline"] = "Thick Outline"
L["Top"] = "Top"
L["Use these options to change when ShieldsUp is visible and how it alerts you about lost shields."] = "Use these options to change when ShieldsUp is visible and how it alerts you about lost shields."
L["Vertical Position"] = "Vertical Position"
L["Vertical Spacing"] = "Vertical Spacing"
L["Visibility"] = "Visibility"

-- if GetLocale() == "deDE" then

L[">> YOU <<"] = ">> EUCH <<"
L["Alerts while hidden"] = "Warnungen während versteckt"
L["Behavior"] = "Verhalten"
L["Bottom"] = "Unterhalb"
L["Click to lock or unlock the frame."] = "Klick, um das Fenster zu blockieren oder freigeben."
L["Colors"] = "Farben"
L["Hidden"] = "Versteckt"
L["Hide the indicator for active shields that don't have multiple charges."] = "Versteckt den Indikator für aktiven Schilde, die keine Stapel haben."
L["Hide unlimited shields"] = "Unendlich Schilde verstecken"
L["Horizontal Position"] = "Horizontale Position"
L["Horizontal Spacing"] = "Horizontaler Abstand"
L["Locked"] = "Fenster blockieren"
L["Message Options"] = "Nachrichtenoptionen"
L["Missing"] = "Fehlende Schilde"
L["Name Color"] = "Namensfarbe"
L["Name Font"] = "Namensschrift"
L["Name Position"] = "Namensposition"
L["Name Size"] = "Namensgröße"
L["Name uses class color"] = "Name in Klassenfarbe"
L["None"] = "Keiner"
L["Number Font"] = "Zahlschrift"
L["Number Size"] = "Zahlgröße"
L["Opacity"] = "Opazität"
L["Play Sound"] = "Sound abspielen"
L["Relative to the center of the screen."] = "Von dem Bildschirmszentrum abhängig."
L["Right-click for options."] = "Rechtsklick für Optionen."
L["Show alert messages and play alert sounds even when the display is hidden."] = "Zeigt Warnungsnachrichten an, und spielt Warnungssounds ab, auch wenn das Fenster versteckt ist."
L["Show in arena"] = "In Arena anzeigen"
L["Show in battleground"] = "In Schlachtfeld anzeigen"
L["Show in party"] = "In Gruppe anzeigen"
L["Show in raid"] = "In Schlachtzug anzeigen"
L["Show message"] = "Nachricht anzeigen"
L["Show out of combat"] = "Außerhalb des Kampfes anzeigen"
L["Show when resting"] = "Beim Ausruhen anzeigen"
L["Show while solo"] = "Solo anzeigen"
L["Text Outline"] = "Textumriss"
L["Text Shadow"] = "Textschatten"
L["Thick"] = "Dicker"
L["Thin"] = "Dünner"
L["Top"] = "Oberhalb"
L["Use these options to change when ShieldsUp is visible and how it alerts you about lost shields."] = "Mit diesen Einstellungen könnt Ihr konfigurieren, wie ShieldsUp Euch über die abgelaufenen oder entzauberten Schilden informieren wird, und wann es angezeigt wird."
L["Vertical Position"] = "Vertikale Position"
L["Vertical Spacing"] = "Vertikaler Abstand"
L["Visibility"] = "Sichtbarkeit"

-- end
