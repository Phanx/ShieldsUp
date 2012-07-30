--[[--------------------------------------------------------------------
	ShieldsUp
	Text-based shaman shield monitor.
	Copyright (c) 2008-2012 Phanx <addons@phanx.net>. All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info9165-ShieldsUp.html
	http://www.curse.com/addons/wow/shieldsup
------------------------------------------------------------------------
	Localization for frFR / French / Fran�ais
	Last updated 2009-11-15 by krukniak < curse.com >
----------------------------------------------------------------------]]

if GetLocale() ~= "frFR" or select(2, UnitClass("player")) ~= "SHAMAN" then return end

local _, namespace = ...
namespace.L = {
	["L"] = "F",
	["W"] = "E",

	["%s faded!"] = "%s a disparu!",
	["%1$s faded from %2$s!"] = "%1$s a disparu de %2$s!",
	["YOU"] = "VOUS",

	["Click for options."] = "Clic pour afficher la fenêtre d'options.",

	["ShieldsUp is a monitor for your shaman shields. These settings allow you to customize the addon's appearance and behavior."] = "ShieldsUp est un addon permettant de surperviser vos boucliers de chamans. Utilisez ces paramètres pour configurer l'apparence et le comportement de cet addon.",
	["Horizontal Position"] = "Position Horizontale",
	["Move the display left or right relative to the center of the screen."] = "Défini le positionnement horizontal de l'affichage par rapport au centre de l'écran.",
	["Vertical Position"] = "Position Verticale",
	["Move the display up or down relative to the center of the screen."] = "Défini le positionnement vertical de l'affichage par rapport au centre de l'écran.",
	["Horizontal Padding"] = "Espacement horizontal",
	["Change the horizontal distance between the charge counters."] = "Défini l'espacement horizontal entre les compteurs de charges.",
	["Vertical Padding"] = "Espacement vertical",
	["Change the vertical distance between the charge counters and the target name."] = "Défini l'espacement vertical entre le nom de la cible et les compteurs de charges.",
	["Opacity"] = "Opacité",
	["Change the opacity of the display."] = "Défini le niveau d'opacité de l'affichage.",

	["Font"] = "Police de caractère",
	["Change the font used for the display text."] = "Défini la police de caractère utilisée pour l'affichage du texte.",
	["Text Outline"] = "Contour",
	["Choose an outline weight for the display text."] = "Défini l'épaisseur du contour utilisé sur les caractères.",
	["None"] = "Aucun",
	["Thin"] = "Fin",
	["Thick"] = "Epais",
	["Counter Size"] = "Taille du compteur",
	["Change the size of the counter text."] = "Défini la taille du texte du compteur de charges.",
	["Name Size"] = "Taille du nom",
	["Change the size of the name text."] = "Défini la taille du texte du nom de la cible.",
	["Shadow"] = "Ombre",
	["Add a drop shadow effect to the display text."] = "Ajoute une ombre portée au texte affiché.",

	["Colors"] = "Couleur",
	["Set the color for the %s charge counter."] = "Défini la couleur pour le compteur de charges du %s.",
	["Active"] = "Actif",
	["Set the color for the target name while your %s is active."] = "Défini la couleur du  nom de la cible quand %s est actif.",
	["Overwritten"] = "Ecrasé",
	["Set the color for the target name when your %s has been overwritten."] = "Défini la couleur du nom de la cible quand votre %s a été écrasé par un autre chaman.",
	["Inactive"] = "Inactif",
	["Set the color for expired, dispelled, or otherwise inactive shields."] = "Défini la couleur pour les boucliers expirés, dissipés ou inactifs.",

	["Alerts"] = "Alertes",
	["These settings allow you to customize how ShieldsUp alerts you when a shield expires or is removed."] = "Utilisez ces paramètres pour configurer comment ShieldsUp vous alertera quand vos boucliers expirent ou sont écrasés.",
	["Text Alert"] = "Texte d'alerte",
	["Show a message when your %s expires or is removed."] = "Affiche un message texte quand le %s expire.",
	["Sound Alert"] = "Alerte sonore",
	["Play a sound when your %s expires or is removed."] = "Joue un son quand le %s expire.",
	["Sound File"] = "Fichier son",
	["Choose the sound to play when your %s expires or is removed."] = "Selectionnez le fichier son à jouer quand %s expire.",
	--["Alert when overwritten"] = "",
	--["Also alert when another shaman overwrites your %s."] = "",

	["Text Output"] = "Affichage du texte",

	["Visibility"] = "Visibilité",
	["These settings allow you to customize when the ShieldsUp display is shown."] = "Utiliser ces paramètres pour configurer quand l'affichage de ShieldsUp doit être actif ou non.",

	["Show in group types:"] = "Taille du groupe",
	["Solo"] = "Solo",
	["Show the display while you are not in a group."] = "Conserver l'affichage quand vous n'êtes pas groupé.",
	["Party"] = "Groupe",
	["Show the display while you are in a party."] = "Afficher ShieldsUp quand vous êtes dans un groupe de 5.",
	["Raid"] = "Raid",
	["Show the display while you are in a raid."] = "Afficher ShieldsUp quand vous êtes dans un groupe de raid.",

	["Show in zone types:"] = "Type de Zone",
	["World"] = "Monde",
	["Show the display while you are in the outdoor world."] = "Conserver l'affichage quand vous êtes à l'extérieur (hors instance).",
	["Dungeon"] = "Instance",
	["Show the display while you are in a dungeon."] = "Afficher ShieldsUp quand vous êtes en instance 5 joueurs.",
	["Raid Instance"] = "Raid",
	["Show the display while you are in a raid instance."] = "Afficher ShieldsUp quand vous êtes en instance de raid.",
	["Arena"] = "Arène",
	["Show the display while you are in a PvP arena."] = "Afficher ShieldsUp quand vous êtes en arène PvP.",
	["Battleground"] = "Champ de bataille (PvP)",
	["Show the display while you are in a PvP battleground."] = "Afficher ShieldsUp quand vous êtes sur un champ de bataille PvP.",

	["Hide when:"] = "Cacher quand:",
	["Dead"] = "Mort",
	["Hide the display while you are dead."] = "Cacher l'affichage quand vous êtes mort.",
	["Out of Combat"] = "Hors combat",
	["Hide the display while you are out of combat."] = "Cacher l'affichage quand vous hors combat.",
	["Resting"] = "Repos",
	["Hide the display while you are in an inn or major city."] = "Cacher l'affichage quand vous êtes dans une capitale ou une auberge (statut repos).",
	["Vehicle"] = "Véhicule",
	["Hide the display while you are controlling a vehicle."] = "Cacher l'affichage quand vous contrôlez un véhicule.",
}