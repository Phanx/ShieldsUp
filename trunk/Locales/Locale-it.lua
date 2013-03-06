--[[--------------------------------------------------------------------
	ShieldsUp
	Text-based shaman shield monitor.
	Copyright (c) 2008-2013 Phanx <addons@phanx.net>. All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info9165-ShieldsUp.html
	http://www.curse.com/addons/wow/shieldsup
------------------------------------------------------------------------
	Italian localization
	Last updated 2012-07-29 by Phanx
	***
	***
----------------------------------------------------------------------]]

local _, private = ...
if private.UNLOAD or GetLocale() ~= "itIT" then return end

local L = private.L

L.Attivo = "Active"
--L.Active_Desc = "Set the color for the target name when your %s is active."
L.AlertOverwritten = "Avvisa quando sovrascritto"
--L.AlertOverwritten_Desc = "Also alert when someone overwrites your %s."
L.Alerts = "Avvisi"
--L.Alerts_Desc = "Use these options to control how ShieldsUp alerts you when your shields are removed or expire."
L.AlertSound = "Riprodurre l'audio"
--L.AlertSound_Desc = "Choose a sound to play when your %s expires."
L.AlertText = "Visualizzare il testo"
--L.AlertText_Desc = "Show a message when your %s expires."
--L.AlertTextSink = "Message location"
L.Bottom = "Basso"
L.ClassColor = "Colore di classe"
L.ClassColor_Desc = "Colora il nome del bersaglio con l'appropriato colore di classe."
L.ClickForOptions = "Clicca per le opzioni."
L.Colors = "Colori"
L.CounterSize = "Dimensione di numeri"
L.Font = "Tipo di carattere"
L.Hide = "Nascondere quando:"
L.HideDead = "Morto"
L.HideOOC = "Fuori dal combattimento"
L.HideResting = "Riposo"
L.HideVehicle = "In veicolo"
L.Hidden = "Hidden"
L.LightningAbbrev = "F"
L.Missing = "Inattivo"
--L.Missing_Desc = "Set the color to use for missing shields."
L.NamePosition = "Target name position"
L.NameSize = "Dimensione del nome"
L.None = "Non"
L.Opacity = "Opacità"
--L.OptionsDesc = "Use these options to control the appearance of the ShieldsUp display."
L.Outline = "Contorno"
L.Overwritten = "Sovrascritto"
--L.Overwritten_Desc = "Set the color for the target name when your %s has been overwritten."
--L.OverwrittenBy = "Your %1$s has been overwritten by %2$s!"
L.PaddingH = "Spaziatura orizzontale"
--L.PaddingH_Desc = "Change the padding between the two shield counters."
L.PaddingV = "Spaziatura verticale"
--L.PaddingV_Desc = "Change the padding between the shield counters and the target name."
L.PositionX = "Posizione orizzontale"
L.PositionY = "Posizione verticale"
L.Shadow = "Ombra"
L.ShieldFaded = "%s svanì!"
L.ShieldFadedFrom = "%1$s svanì da %2$s!"
L.Show = "Mostra in:"
L.ShowArena = "Arena"
L.ShowBattleground = "Campo di battaglia"
L.ShowParty = "Gruppo"
L.ShowRaid = "Incursione"
L.ShowSolo = "Solo"
L.Thick = "Grosso"
L.Thin = "Fino"
--L.Top = "Top"
L.Visibility = "Visibilità"
--L.Visibility_Desc = "Use these options to control when ShieldsUp is shown or hidden."
L.WaterAbbrev = "A"
L.YOU = "VOI"