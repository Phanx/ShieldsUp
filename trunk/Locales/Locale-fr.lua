--[[--------------------------------------------------------------------
	ShieldsUp
	Text-based shaman shield monitor.
	Copyright (c) 2008-2014 Phanx <addons@phanx.net>. All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info9165-ShieldsUp.html
	http://www.curse.com/addons/wow/shieldsup
------------------------------------------------------------------------
	French localization
	Last updated 2009-11-15 by krukniak
	***
----------------------------------------------------------------------]]

local _, private = ...
if private.UNLOAD or GetLocale() ~= "frFR" then return end

local L = private.L

L.Active = "Actif"
L.Active_Desc = "Défini la couleur du nom de la cible quand %s est actif."
L.AlertOverwritten = "Alerter quand recouvert"
L.AlertOverwritten_Desc = "En outre alerter quand un autre chaman recouvre votre %s."
L.Alerts = "Alertes"
L.Alerts_Desc = "Utilisez ces paramètres pour configurer comment ShieldsUp vous alertera quand vos boucliers expirent ou sont écrasés."
L.AlertSound = "Alerte sonore"
L.AlertSound_Desc = "Selectionnez le fichier son à jouer quand %s expire."
L.AlertText = "Texte d'alerte"
L.AlertText_Desc = "Affiche un message texte quand le %s expire."
L.AlertTextSink = "Affichage du texte"
--L.AlertWhileHidden = "Alert while hidden"
--L.AlertWhileHidden_Desc = "Show alert messages and play alert sounds while ShieldsUp is hidden due to your visibility settings."
L.Bottom = "Bas"
L.ClassColor = "Couleur de classe"
L.ClassColor_Desc = "Colore le nom de la cible avec la couleur de classe appropriée."
L.ClickForOptions = "Clic pour afficher la fenêtre d'options."
L.Colors = "Couleur"
L.CounterSize = "Taille du compteur"
L.Font = "Police"
--L.HiddenLowLevel = "|cffffd100ATTENTION:|r Regardless of your settings above, ShieldsUp is currently hidden because your character's level is too low. Once you reach Level 8 and learn Lightning Shield, ShieldsUp will show and hide normally."
L.Hide = "Cacher quand:"
L.HideDead = "Mort"
L.HideInfinite = "Cacher boucliers sans charges"
--L.HideInfinite_Desc = "Hide the letter indicator for active shields that don't have a limited number of charges. Missing shields will still be shown."
L.HideOOC = "Hors combat"
L.HideResting = "Repos"
L.HideVehicle = "Contrôlez un véhicule"
L.Hidden = "Caché"
L.LightningAbbrev = "F"
L.Missing = "Inactif"
L.Missing_Desc = "Défini la couleur pour les boucliers expirés, dissipés ou inactifs."
L.NamePosition = "Position du nom"
L.NameSize = "Taille du nom"
L.None = "Aucun"
L.Opacity = "Opacité"
L.OptionsDesc = "ShieldsUp est un addon permettant de surperviser vos boucliers de chamans. Utilisez ces paramètres pour configurer l'apparence et le comportement de cet addon."
L.Outline = "Contour"
L.Overwritten = "Ecrasé"
L.Overwritten_Desc = "Défini la couleur du nom de la cible quand votre %s a été écrasé par un autre chaman."
L.OverwrittenBy = "Votre %1$s a été écrasé par %2$s!"
L.PaddingH = "Espacement horizontal"
L.PaddingH_Desc = "Défini l'espacement horizontal entre les compteurs de charges."
L.PaddingV = "Espacement vertical"
L.PaddingV_Desc = "Défini l'espacement vertical entre le nom de la cible et les compteurs de charges."
L.PositionX = "Position horizontal"
L.PositionY = "Position vertical"
L.Shadow = "Ombre"
L.ShieldFaded = "%s a disparu!"
L.ShieldFadedFrom = "%1$s a disparu de %2$s!"
L.Show = "Afficher dans:"
L.ShowArena = "Arène"
L.ShowBattleground = "Champ de bataille"
L.ShowParty = "Groupe"
L.ShowRaid = "Raid"
L.ShowSolo = "Solo"
L.Thick = "Epais"
L.Thin = "Fin"
L.Top = "Haut"
L.Visibility = "Visibilité"
L.Visibility_Desc = "Utiliser ces paramètres pour configurer quand l'affichage de ShieldsUp doit être actif ou non."
L.WaterAbbrev = "E"
L.YOU = "VOUS"