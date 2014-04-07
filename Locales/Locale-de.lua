--[[--------------------------------------------------------------------
	ShieldsUp
	Text-based shaman shield monitor.
	Copyright (c) 2008-2014 Phanx <addons@phanx.net>. All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info9165-ShieldsUp.html
	http://www.curse.com/addons/wow/shieldsup
------------------------------------------------------------------------
	German localization
	Last updated 2014-02-23 by Phanx
	Previous contributors: Estadon, Søøm
----------------------------------------------------------------------]]

local _, private = ...
if private.UNLOAD or GetLocale() ~= "deDE" then return end

local L = private.L

L.Active = "Aktiv"
L.Active_Desc = "Einstellt die Farbe für den Namen Eures Ziels, während %s aktiv ist."
L.AlertOverwritten = "Überschreib-Alarm"
L.AlertOverwritten_Desc = "ShieldsUp wird Euch auch informieren, wenn Euer %s von einem anderen Schamanen überzaubert wurde."
L.Alerts = "Warnungen"
L.Alerts_Desc = "Mit diesen Einstellungen könnt Ihr konfigurieren, wie ShieldsUp Euch über die abgelaufenen oder entzauberten Schilden informieren wird."
L.AlertSound = "Sound-Warnungen"
L.AlertSound_Desc = "Einstellt ein Sound zum abspielen, wenn %s abläuft."
L.AlertText = "Textwarnungen"
L.AlertText_Desc = "Zeigt eine Nachricht, wenn %s abläuft."
L.AlertTextSink = "Textausgabe"
L.AlertWhileHidden = "Warnungen während versteckt"
L.AlertWhileHidden_Desc = "Zeigt Warnungsnachrichten und spielt Warnung-Sounds auch wenn ShieldsUp wegen Euer Sichtbarkeit-Einstellungen versteckt ist."
L.Bottom = "Unten"
L.ClassColor = "Klassenfarben"
L.ClassColor_Desc = "Zeigt den Zielname in der jeweiligen Klassenfarbe, wenn Euer %s aktiv ist."
L.ClickForOptions = "Linksklick für Optionen."
L.Colors = "Farben"
L.CounterSize = "Zahlengröße"
L.Font = "Textfont"
L.HiddenLowLevel = "|cffffd100ACHTUNG:|r Unabhängig von diesen Einstellungen ist ShieldsUp derzeit versteckt, weil der Charakter zu niedrigstufig ist. Wenn die 8. Stufe erreicht ist, wird ShieldsUp normalerweise angezeigt und versteckt."
L.Hide = "Versteckt während..."
L.HideDead = "Tot"
L.HideInfinite = "Schilde ohne Aufladungen verstecken"
L.HideInfinite_Desc = "Versteckt die Indikatoren für aktive Schilde ohne Aufladungen. Inaktive Schilde werden immer angezeigt."
L.HideOOC = "Außerhalb des Kampfes"
L.HideResting = "Erholt"
L.HideVehicle = "Im Fahrzeug"
L.Hidden = "Versteckt"
L.LightningAbbrev = "B"
L.Missing = "Inaktiv"
L.Missing_Desc = "Stellt die Farbe für abgelaufene, entzauberte oder inaktive Schilde ein."
L.NamePosition = "Namensposition"
L.NameSize = "Namensgröße"
L.None = "Keine"
L.Opacity = "Durschsichtigkeit"
L.OptionsDesc = "ShieldsUp ist eine einfache Anzeige für die verschiedenen Schilde des Schamanen. Mit diesen Einstellungen könnt Ihr das Aussehen und Verhalten von ShieldsUp konfigurieren."
L.Outline = "Umrandung"
L.Overwritten = "Überschrieben"
L.Overwritten_Desc = "Stellt die Farbe für den Zielnamen ein, falls dein %s von einem anderen Schamanen überzaubert wurde."
L.OverwrittenBy = "Dein %1$s wurde von %2$s überschrieben!"
L.PaddingH = "Horizontale Abstimmung"
L.PaddingH_Desc = "Stellt den Abstand zwischen den Aufladungen der Schilde ein."
L.PaddingV = "Vertikale Abstimmung"
L.PaddingV_Desc = "Stellt den Abstand zwischen dem Zielnamen und den Aufladungen ein."
L.PositionX = "Horizontale Position"
L.PositionY = "Vertikale Position"
L.Shadow = "Schatten"
L.ShieldFaded = "%s hat aufgebraucht!"
L.ShieldFadedFrom = "%1$s hat von %2$s aufgebraucht!"
L.Show = "Zeigt in..."
L.ShowArena = "Arena"
L.ShowBattleground = "Schlachtfeld"
L.ShowParty = "Gruppe"
L.ShowRaid = "Schlachtzug"
L.ShowSolo = "Solo"
L.Thick = "Dicke"
L.Thin = "Dünne"
L.Top = "Oben"
L.Visibility = "Sichtbarkeit"
L.Visibility_Desc = "Mit diesen Einstellungen könnt Ihr die Bedingungen konfigurieren, unter denen ShieldsUp versteckt oder angezeigt wird."
L.WaterAbbrev = "W"
L.YOU = "EUCH"