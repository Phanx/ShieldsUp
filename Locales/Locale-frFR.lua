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

------------------------------------------------------------------------
-- These strings are displayed when shields expire.

	["%s faded!"] = "%s a disparu!",
	["%s faded from %s!"] = "%s a disparu de %s!",
	["YOU"] = "VOUS",

------------------------------------------------------------------------
-- These strings are displayed in the configuration GUI.

	["Click for options."] = "Clic pour afficher la fen�tre d'options.",

	["ShieldsUp is a simple monitor for your shaman shields. Use these settings to configure the addon's appearance and behavior."] = "ShieldsUp est un addon permettant de surperviser vos boucliers de chamans. Utilisez ces param�tres pour configurer l'apparence et le comportement de cet addon.",

	["Horizontal Position"] = "Position Horizontale",
	["Set the horizontal distance from the center of the screen to place the display."] = "D�fini le positionnement horizontal de l'affichage par rapport au centre de l'�cran.",

	["Vertical Position"] = "Position Verticale",
	["Set the vertical distance from the center of the screen to place the display."] = "D�fini le positionnement vertical de l'affichage par rapport au centre de l'�cran.",

	["Horizontal Padding"] = "Espacement horizontal",
	["Set the horizontal space between the charge counters."] = "D�fini l'espacement horizontal entre les compteurs de charges.",

	["Vertical Padding"] = "Espacement vertical",
	["Set the vertical space between the target name and charge counters."] = "D�fini l'espacement vertical entre le nom de la cible et les compteurs de charges.",

	["Opacity"] = "Opacit�",
	["Set the opacity level for the display."] = "D�fini le niveau d'opacit� de l'affichage.",

--	["Overwrite Alert"] = "",
--	["Print a message in the chat frame alerting you who overwrites your %s."] = "",

------------------------------------------------------------------------

	["Font Face"] = "Police de caract�re",
	["Set the font face to use for the display text."] = "D�fini la police de caract�re utilis�e pour l'affichage du texte.",

	["Outline"] = "Contour",
	["Select an outline width for the display text."] = "D�fini l'�paisseur du contour utilis� sur les caract�res.",
	["None"] = "Aucun",
	["Thin"] = "Fin",
	["Thick"] = "Epais",

	["Shadow"] = "Ombre",
	["Add a drop shadow effect to the display text."] = "Ajoute une ombre port�e au texte affich�.",

	["Counter Size"] = "Taille du compteur",
	["Set the text size for the charge counters."] = "D�fini la taille du texte du compteur de charges.",

	["Name Size"] = "Taille du nom",
	["Set the text size for the target name."] = "D�fini la taille du texte du nom de la cible.",

------------------------------------------------------------------------

	["Colors"] = "Couleur",
	["Set the color for the %s charge counter."] = "D�fini la couleur pour le compteur de charges du %s.",

	["Active"] = "Actif",
	["Set the color for the target name while your %s is active."] = "D�fini la couleur du  nom de la cible quand %s est actif.",

	["Overwritten"] = "Ecras�",
	["Set the color for the target name when your %s has been overwritten."] = "D�fini la couleur du nom de la cible quand votre %s a �t� �cras� par un autre chaman.",

	["Inactive"] = "Inactif",
	["Set the color for expired, dispelled, or otherwise inactive shields."] = "D�fini la couleur pour les boucliers expir�s, dissip�s ou inactifs.",

	["Colorblind Mode"] = USE_COLORBLIND_MODE, -- Leave this as-is unless there is something wrong with Blizzard's translation in your locale
	["Add asterisks around the target name when your %s has been overwritten, in addition to changing the color."] = "Ajoute des ast�risques de chaque cot� du nom de la cible quand votre %s est �cras� (en plus du changement de couleur).",

------------------------------------------------------------------------

	["Alerts"] = "Alertes",
	["Use these settings to configure how ShieldsUp alerts you when a shield expires or is removed."] = "Utilisez ces param�tres pour configurer comment ShieldsUp vous alertera quand vos boucliers expirent ou sont �cras�s.",

	["Text Alert"] = "Texte d'alerte",
	["Show a text message when %s expires."] = "Affiche un message texte quand le %s expire.",

	["Sound Alert"] = "Alerte sonore",
	["Play a sound when %s expires."] = "Joue un son quand le %s expire.",

	["Sound File"] = "Fichier son",
	["Select the sound to play when %s expires."] = "Selectionnez le fichier son � jouer quand %s expire.",

	["Text Output"] = "Affichage du texte",

------------------------------------------------------------------------

	["Visibility"] = "Visibilit�",
	["Use these settings to control when ShieldsUp should be shown or hidden."] = "Utiliser ces param�tres pour configurer quand l'affichage de ShieldsUp doit �tre actif ou non.",
	["Enable"] = "Activ�",

	["Group Size"] = "Taille du groupe",
--	["Solo"] = "",
	["Show the display while you are not in a group"] = "Conserver l'affichage quand vous n'�tes pas group�.",
	["Party"] = "Groupe",
	["Show the display while you are in a party group"] = "Afficher ShieldsUp quand vous �tes dans un groupe de 5.",
--	["Raid"] = "",
	["Show the display while you are in a raid group"] = "Afficher ShieldsUp quand vous �tes dans un groupe de raid.",

	["Zone Type"] = "Type de Zone",
	["World"] = "Monde",
	["Show the display while you are in the outdoor world"] = "Conserver l'affichage quand vous �tes � l'ext�rieur (hors instance).",
	["Dungeon"] = "Instance",
	["Show the display while you are in a party dungeon"] = "Afficher ShieldsUp quand vous �tes en instance 5 joueurs.",
	["Raid Dungeon"] = "Raid",
	["Show the display while you are in a raid dungeon"] = "Afficher ShieldsUp quand vous �tes en instance de raid.",
	["Arena"] = "Ar�ne",
	["Show the display while you are in a PvP arena"] = "Afficher ShieldsUp quand vous �tes en ar�ne PvP.",
	["Battleground"] = "Champ de bataille (PvP)",
	["Show the display while you are in a PvP battleground"] = "Afficher ShieldsUp quand vous �tes sur un champ de bataille PvP.",

--	["Exceptions"] = "",
	["Dead"] = "Mort",
	["Hide the display while you are dead"] = "Cacher l'affichage quand vous �tes mort.",
	["Out Of Combat"] = "Hors combat",
	["Hide the display while you are out of combat"] = "Cacher l'affichage quand vous hors combat.",
	["Resting"] = "Repos",
	["Hide the display while you are in an inn or major city"] = "Cacher l'affichage quand vous �tes dans une capitale ou une auberge (statut repos).",
	["Vehicle"] = "V�hicule",
	["Hide the display while you are controlling a vehicle"] = "Cacher l'affichage quand vous contr�lez un v�hicule.",

------------------------------------------------------------------------

}