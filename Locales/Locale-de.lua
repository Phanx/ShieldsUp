--[[--------------------------------------------------------------------
	ShieldsUp
	Text-based shaman shield monitor.
	Copyright (c) 2008-2013 Phanx <addons@phanx.net>. All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info9165-ShieldsUp.html
	http://www.curse.com/addons/wow/shieldsup
------------------------------------------------------------------------
	German localization
	Last updated 2012-03-10 by Estadon
	Previous contributors:
	- Søøm
----------------------------------------------------------------------]]

local _, private = ...
if private.UNLOAD or GetLocale() ~= "deDE" then return end

local L = private.L

L.Active = "Aktiv"
L.Active_Desc = "Wähle die Farbe für den Namen deines Ziels während %s ist aktiv."
L.AlertOverwritten = "Überschreib-Alarm"
L.AlertOverwritten_Desc = "Auch informieren, dein %s von einem anderen Schamanen überzaubert wurde."
L.Alerts = "Warnungen"
L.Alerts_Desc = "Verwende diese Optionen um ShieldsUp zu konfigurieren wie es dich bei abgelaufenen oder entzauberten Schilden informieren soll."
L.AlertSound = "Akustische Warnungen"
L.AlertSound_Desc = "Wähle eine Musikdatei zum abspielen, wenn %s abläuft."
L.AlertText = "Textwarnungen"
L.AlertText_Desc = "Zeigt eine Nachricht, wenn %s abläuft."
L.AlertTextSink = "Textausgabe"
L.Bottom = "Unten"
L.ClassColor = "Klassenfarben anzeigen"
L.ClassColor_Desc = "Zeigt den Zielname in der jeweiligen Klassenfarbe, wenn Ihr %s aktiv ist."
L.ClickForOptions = "Linksklick für Optionen."
L.Colors = "Farben"
L.CounterSize = "Zahlengröße"
L.Font = "Textfont"
L.Hide = "Verstecke während..."
L.HideDead = "Tot"
L.HideInfinite = "Schilde ohne Aufladungen verstecken"
L.HideInfinite_Desc = "Versteckt die Indikatoren für Aktive Schilde ohne Aufladungen. Inaktive Schilde werden immer angezeigt."
L.HideOOC = "Außerhalb eines Kampfes"
L.HideResting = "Erholt"
L.HideVehicle = "Fahrzeug"
L.Hidden = "Versteckt"
L.LightningAbbrev = "B"
L.Missing = "Inaktiv"
L.Missing_Desc = "Wähe die Farbe für abgelaufene, entzauberte oder inaktive Schilde."
L.NamePosition = "Namensposition"
L.NameSize = "Namensgröße"
L.None = "Keine"
L.Opacity = "Durschsichtigkeit"
L.OptionsDesc = "ShieldsUp is eine einfache Anzeige für die verschiedenen Schilde des Schamanen. Benutze diese Optionen um das Erscheinungsbild und Verhalten zu konfigurieren."
L.Outline = "Umrandung"
L.Overwritten = "Überschrieben"
L.Overwritten_Desc = "Wähle die Farbe für den Zielnamen, falls dein %s von einem anderen Schamanen überzaubert wurde."
L.OverwrittenBy = "Dein %1$s wurde von %2$s überschrieben!"
L.PaddingH = "Horizontale Abstimmung"
L.PaddingH_Desc = "Wähle den Abstand zwischen den Aufladungen der Schilde."
L.PaddingV = "Vertikale Abstimmung"
L.PaddingV_Desc = "Wähle den Abstand zwischen dem Zielnamen und den Aufladungen."
L.PositionX = "Horizontale Position"
L.PositionY = "Vertikale Position"
L.Shadow = "Schatten"
L.ShieldFaded = "%s aufgebraucht!"
L.ShieldFadedFrom = "%1$s von %2$s aufgebraucht!"
L.Show = "Zeigen in..."
L.ShowArena = "Arena"
L.ShowBattleground = "Schlachtfeld"
L.ShowParty = "Gruppe"
L.ShowRaid = "Schlachtzug"
L.ShowSolo = "Solo"
L.Thick = "Dick"
L.Thin = "Dünn"
L.Top = "Oben"
L.Visibility = "Sichtbarkeit"
L.Visibility_Desc = "Ändere diese Einstellungen um ShieldsUp unter bestimmten Voraussetzungen zu zeigen oder zu verstecken."
L.WaterAbbrev = "W"
L.YOU = "DIR"