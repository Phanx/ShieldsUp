--[[--------------------------------------------------------------------
	ShieldsUp
	Text-based shaman shield monitor.
	Copyright (c) 2008-2013 Phanx <addons@phanx.net>. All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info9165-ShieldsUp.html
	http://www.curse.com/addons/wow/shieldsup
------------------------------------------------------------------------
	Localization for deDE / German / Deutsch
	Last updated 2012-03-10 by Estadon on CurseForge
	Previous updates by Søøm < graninibanane AT gmx DOT de >
----------------------------------------------------------------------]]

if GetLocale() ~= "deDE" or select(2, UnitClass("player")) ~= "SHAMAN" then return end

local _, namespace = ...
namespace.L = {
	["L"] = "B",
	["W"] = "W",

	["%s faded!"] = "%s aufgebraucht!",
	["%1$s faded from %2$s!"] = "%1$s von %2$s aufgebraucht!",
	["YOU"] = "DIR",

	["Click for options."] = "Linksklick für Optionen.",

	["ShieldsUp is a monitor for your shaman shields. These settings allow you to customize the addon's appearance and behavior."] = "ShieldsUp is eine einfache Anzeige für die verschiedenen Schilde des Schamanen. Benutze diese Optionen um das Erscheinungsbild und Verhalten zu konfigurieren.",
	["Horizontal Position"] = "Horizontale Position",
	["Move the display left or right relative to the center of the screen."] = "Einstellen des horizontalen Abstandes von der Mitte(des Bildschirms) zum gewünschten Platz von ShieldsUp.",
	["Vertical Position"] = "Vertikale Position",
	["Move the display up or down relative to the center of the screen."] = "Einstellen des vertikalen Abstandes von der Mitte(des Bildschirms) zum gewünschten Platz von ShieldsUp.",
	["Horizontal Padding"] = "Horizontale Abstimmung",
	["Change the horizontal distance between the charge counters."] = "Wähle den Abstand zwischen den Aufladungen der Schilde.",
	["Vertical Padding"] = "Vertikale Abstimmung",
	["Change the vertical distance between the charge counters and the target name."] = "Wähle den Abstand zwischen dem Zielnamen und den Aufladungen.",
	["Opacity"] = "Durschsichtigkeit",
	["Change the opacity of the display."] = "Konfiguriere die Durchsichtigkeit der Anzeige.",

	["Font"] = "Textfont",
	["Change the font used for the display text."] = "Wähle den Font für den angezeigten Text.",
	["Text Outline"] = "Umrandung",
	["Choose an outline weight for the display text."] = "Wähle eine Umrandung für den angezeigten Text.",
	["None"] = "Keine",
	["Thin"] = "Dünn",
	["Thick"] = "Dick",
	["Counter Size"] = "Zahlengröße",
	["Change the size of the counter text."] = "Wähle die Textgröße für die Zahlen.",
	["Name Size"] = "Namensgröße",
	["Change the size of the name text."] = "Wähle die Textgröße des Zielnamens.",
	["Shadow"] = "Schatten",
	["Add a drop shadow effect to the display text."] = "Füge einen Schatteneffekt hinzu.",
	["Use Class Color"] = "Klassenfarben anzeigen",
	["Color the target name by class color when your %s is active."] = "Zeigt den Zielname in der jeweiligen Klassenfarbe, wenn Ihr %s aktiv ist.",

	["Colors"] = "Farben",
	["Set the color for the %s charge counter."] = "Wähle die Farbe der Aufladungen von %s.",
	["Active"] = "Aktiv",
	["Set the color for the target name while your %s is active."] = "Wähle die Farbe für den Namen deines Ziels während %s ist aktiv.",
	["Overwritten"] = "Überschrieben",
	["Set the color for the target name when your %s has been overwritten."] = "Wähle die Farbe für den Zielnamen, falls dein %s von einem anderen Schamanen überzaubert wurde.",
	["Inactive"] = "Inaktiv",
	["Set the color for expired, dispelled, or otherwise inactive shields."] = "Wähe die Farbe für abgelaufene, entzauberte oder inaktive Schilde.",

	["Alerts"] = "Warnungen",
	["These settings allow you to customize how ShieldsUp alerts you when a shield expires or is removed."] = "Verwende diese Optionen um ShieldsUp zu konfigurieren wie es dich bei abgelaufenen oder entzauberten Schilden informieren soll.",
	["Text Alert"] = "Textwarnungen",
	["Show a message when your %s expires or is removed."] = "Zeigt eine Nachricht, wenn %s abläuft.",
	["Sound Alert"] = "Akustische Warnungen",
	["Play a sound when your %s expires or is removed."] = "Spielt einen Ton ab, wenn %s abläuft.",
	["Sound File"] = "Musikdatei",
	["Choose the sound to play when your %s expires or is removed."] = "Wähle eine Musikdatei zum abspielen, wenn %s abläuft.",
	["Alert When Overwritten"] = "Überschreib-Alarm",
	["Also alert when another shaman overwrites your %s."] = "Auch informieren, dein %s von einem anderen Schamanen überzaubert wurde.",

	["Text Output"] = "Textausgabe",

	["Visibility"] = "Sichtbarkeit",
	["These settings allow you to customize when the ShieldsUp display is shown."] = "Ändere diese Einstellungen um ShieldsUp unter bestimmten Voraussetzungen zu zeigen oder zu verstecken.",

	["Show in group types:"] = "Gruppengröße",
	["Solo"] = "Solo",
	["Show the display while you are not in a group."] = "Zeige ShieldsUp außerhalb einer Gruppe.",
	["Party"] = "Gruppe",
	["Show the display while you are in a party."] = "Zeige ShieldsUp in einer 5er Gruppe.",
	["Raid"] = "Schlachtzug",
	["Show the display while you are in a raid."] = "Zeige ShieldsUp wenn man sich in einem Schlachtzug befindet.",

	["Show in zone types:"] = "Art der Zone",
	["World"] = "Welt",
	["Show the display while you are in the outdoor world."] = "Zeige ShieldsUp außerhalb von allen Spezialgebiten (Instanz/Schlachtzug...).",
	["Dungeon"] = "Instanz",
	["Show the display while you are in a dungeon."] = "Zeige ShieldsUp während du dich in einer 5er Instanz befindest.",
	["Raid Instance"] = "Schlachtzugsinstanz",
	["Show the display while you are in a raid instance."] = "Zeige ShieldsUp in einer Schlachtzugsinstanz.",
	["Arena"] = "Arena",
	["Show the display while you are in a PvP arena."] = "Zeige ShieldsUp während du dich in einer Arena befindest.",
	["Battleground"] = "Schlachtfeld",
	["Show the display while you are in a PvP battleground."] = "Zeige ShieldsUp während du dich auf einem Schlachtfeld befindest.",

	["Hide when:"] = "Verstecke während...",
	["Dead"] = "Tot",
	["Hide the display while you are dead."] = "Verstecke ShieldsUp wenn du tot bist.",
	["Out of Combat"] = "Außerhalb eines Kampfes",
	["Hide the display while you are out of combat."] = "Verstecke ShieldsUp außerhalb des Kampfes.",
	["Resting"] = "Erholt",
	["Hide the display while you are in an inn or major city."] = "Verstecke ShieldsUp während du dich bei einem Gastwirt oder in einer Hauptstadt aufhälst.",
	["Vehicle"] = "Fahrzeug",
	["Hide the display while you are controlling a vehicle."] = "Verstecke ShieldsUp während du ein Fahrzeug steuerst.",
}