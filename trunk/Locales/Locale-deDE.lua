--[[--------------------------------------------------------------------
	German translations for ShieldsUp
	Last updated 2009-07-14 by Søøm
	Contributors:
		Søøm < graninibanane AT gmx DOT de >
----------------------------------------------------------------------]]

if GetLocale() ~= "deDE" or select(2, UnitClass("player")) ~= "SHAMAN" then return end

local L = { }
local ADDON_NAME, namespace = ...
namespace.L = L

------------------------------------------------------------------------
-- These strings are displayed when shields expire.

L["%s faded!"] = "%s aufgebraucht!"
L["%s faded from %s!"] = "%s von %s aufgebraucht!"
L["YOU"] = "DIR"

------------------------------------------------------------------------
-- These strings are displayed in the configuration GUI.

L["ShieldsUp is a simple monitor for your shaman shields. Use these settings to configure the addon's appearance and behavior."] = "ShieldsUp is eine einfache Anzeige für die verschiedenen Schilde des Schamanen. Benutze diese Optionen um das Erscheinungsbild und Verhalten zu konfigurieren."

L["Horizontal Position"] = "Horizontale Position"
L["Set the horizontal distance from the center of the screen to place the display."] = "Einstellen des horizontalen Abstandes von der Mitte(des Bildschirms) zum gewünschten Platz von ShieldsUp."

L["Vertical Position"] = "Vertikale Position"
L["Set the vertical distance from the center of the screen to place the display."] = "Einstellen des vertikalen Abstandes von der Mitte(des Bildschirms) zum gewünschten Platz von ShieldsUp."

L["Horizontal Padding"] = "Horizontale Abstimmung"
L["Set the horizontal space between the charge counts."] = "Wähle den Abstand zwischen den Aufladungen der Schilde."

L["Vertical Padding"] = "Vertikale Abstimmung"
L["Set the vertical space between the target name and charge counters."] = "Wähle den Abstand zwischen dem Zielnamen und den Aufladungen."

L["Opacity"] = "Durchsichtigkeit"
L["Set the opacity level for the display."] = "Konfiguriere die Durchsichtigkeit der Anzeige."

-- L["Overwrite Alert"] = ""
-- L["Print a message in the chat frame alerting you who overwrites your %s."] = ""

------------------------------------------------------------------------

L["Font Face"] = "Textfont"
L["Set the font face to use for the display text."] = "Wähle den Font für den angezeigten Text."

L["Outline"] = "Umrandung"
L["Select an outline width for the display text."] = "Wähle eine Umrandung für den angezeigten Text"
L["None"] = "Keine"
L["Thin"] = "Dünn"
L["Thick"] = "Dick"

L["Shadow"] = "Schatten"
L["Add a drop shadow effect to the display text."] = "Füge einen Schatteneffekt hinzu."

L["Counter Size"] = "Zahlengröße"
L["Set the text size for the charge counters."] = "Wähle die Textgröße für die Zahlen."

L["Name Size"] = "Namensgröße"
L["Set the text size for the target name."] = "Wähle die Textgröße des Zielnamens."

------------------------------------------------------------------------

L["Colors"] = "Farben"
L["Set the color for the %s charge counter."] = "Wähle die Textgröße der Aufladungen von %s."

L["Active"] = "Aktiv"
L["Set the color for the target name while your %s is active."] = "Wähle die Farbe für den Namen deines Ziels während %s ist aktiv."

L["Overwritten"] = "Überschrieben"
L["Set the color for the target name when your %s has been overwritten."] = "Wähle die Farbe für den Zielnamen, falls dein %s von einem anderen Schamanen überzaubert wurde"

L["Inactive"] = "Inaktiv"
L["Set the color for expired, dispelled, or otherwise inactive shields."] = "Wähe die Farbe für abgelaufene, entzauberte oder inaktive Schilde."

L["Colorblind Mode"] = USE_COLORBLIND_MODE -- Leave this as-is unless there is something wrong with Blizzard's translation in your locale
L["Add asterisks around the target name when your %s has been overwritten, in addition to changing the color."] = "Fügt * um den Zielnamen, falls dein %s auf dem Ziel überzaubert wurde, zusätzlich zum Farbenwechsel."

------------------------------------------------------------------------

L["Alerts"] = "Warnungen"
L["Use these settings to configure how ShieldsUp alerts you when a shield expires or is removed."] = "Verwende diese Optionen um ShieldsUp zu konfigurieren wie es dich bei abgelaufenen oder entzauberten Schilden informieren soll."

L["Text Alert"] = "Textwarnungen"
L["Show a text message when %s expires."] = "Zeigt eine Nachricht, wenn %s abläuft."

L["Sound Alert"] = "Akustische Warnungen"
L["Play a sound when %s expires."] = "Spielt einen Ton ab, wenn %s abläuft."

L["Sound File"] = "Musikdatei"
L["Select the sound to play when %s expires."] = "Wähle eine Musikdatei zum abspielen, wenn %s abläuft"

L["Text Output"] = "Textausgabe"

------------------------------------------------------------------------

L["Visibility"] = "Sichtbarkeit"
L["Enable"] = "Aktivieren"
L["Use these settings to control when ShieldsUp display should be shown or hidden."] = "Ändere diese Einstellungen um ShieldsUp unter bestimmten Voraussetzungen zu zeigen oder zu verstecken."

L["Group Size"] = "Gruppengröße"
-- L["Solo"] = ""
L["Show the display while you are not in a group"] = "Zeige ShieldsUp außerhalb einer Gruppe."
-- L["Party"] = ""
L["Show the display while you are in a party group"] = "Zeige ShieldsUp in einer 5er Gruppe."
L["Raid"] = "Schlachtzug"
L["Show the display while you are in a raid group"] = "Zeige ShieldsUp wenn man sich in einem Schlachtzug befindet"

L["Zone Type"] = "Art der Zone"
L["World"] = "Welt"
L["Show the display while you are in the outdoor world"] = "Zeige ShieldsUp außerhalb von allen Spezialgebiten (Instanz/Schlachtzug...) ."
L["Dungeon"] = "Instanz"
L["Show the display while you are in a party dungeon"] = "Zeige ShieldsUp während du dich in einer 5er Instanz befindest."
L["Raid Dungeon"] = "Schlachtzugsinstanz"
L["Show the display while you are in a raid dungeon"] = "Zeige ShieldsUp in einer Schlachtzugsinstanz "
-- L["Arena"] = ""
L["Show the display while you are in a PvP arena"] = "Zeige ShieldsUp während du dich in einer Arena befindest."
L["Battleground"] = "Schlachtfeld"
L["Show the display while you are in a PvP battleground"] = "Zeige ShieldsUp während du dich auf einem Schlachtfeld befindest."

L["Exceptions"] = "Außnahmen"
L["Dead"] = "Tot"
L["Hide the display while you are dead"] = "Verstecke ShieldsUp wenn du tot bist"
L["Out Of Combat"] = "Außerhalb eines Kampfes"
L["Hide the display while you are out of combat"] = "Verstecke ShieldsUp außerhalb des Kampfes"
L["Resting"] = "Erholt"
L["Hide the display while you are in an inn or major city"] = "Verstecke ShieldsUp während du dich bei einem Gastwirt oder in einer Hauptstadt aufhälst"
L["Vehicle"] = "Fahrzeug"
L["Hide the display while you are controlling a vehicle"] = "Verstecke ShieldsUp während du ein Fahrzeug steuerst"

------------------------------------------------------------------------