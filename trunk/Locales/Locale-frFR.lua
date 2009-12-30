--[[--------------------------------------------------------------------
	French translations for ShieldsUp
	Last updated 2009-11-15 by krukniak
	Contributors:
		krukniak < curse.com >  
----------------------------------------------------------------------]]

if GetLocale() ~= "frFR" or select(2, UnitClass("player")) ~= "SHAMAN" then return end

local L = { }
local ADDON_NAME, namespace = ...
namespace.L = L

------------------------------------------------------------------------
-- These strings are displayed when shields expire.

L["%s faded!"] = "%s a disparu!"
L["%s faded from %s!"] = "%s a disparu de %s!"
L["YOU"] = "VOUS"

------------------------------------------------------------------------
-- These strings are displayed in the configuration GUI.

L["ShieldsUp is a simple monitor for your shaman shields. Use these settings to configure the addon's appearance and behavior."] = "ShieldsUp est un addon permettant de surperviser vos boucliers de chamans. Utilisez ces paramètres pour configurer l'apparence et le comportement de cet addon."

L["Horizontal Position"] = "Position Horizontale"
L["Set the horizontal distance from the center of the screen to place the display."] = "Défini le positionnement horizontal de l'affichage par rapport au centre de l'écran."

L["Vertical Position"] = "Position Verticale"
L["Set the vertical distance from the center of the screen to place the display."] = "Défini le positionnement vertical de l'affichage par rapport au centre de l'écran."

L["Horizontal Padding"] = "Espacement horizontal"
L["Set the horizontal space between the charge counts."] = "Défini l'espacement horizontal entre les compteurs de charges."

L["Vertical Padding"] = "Espacement vertical"
L["Set the vertical space between the target name and charge counters."] = "Défini l'espacement vertical entre le nom de la cible et les compteurs de charges."

L["Opacity"] = "Opacité"
L["Set the opacity level for the display."] = "Défini le niveau d'opacité de l'affichage."

------------------------------------------------------------------------

L["Font Face"] = "Police de caractère"
L["Set the font face to use for the display text."] = "Défini la police de caractère utilisée pour l'affichage du texte."

L["Outline"] = "Contour"
L["Select an outline width for the display text."] = "Défini l'épaisseur du contour utilisé sur les caractères."
L["None"] = "Aucun"
L["Thin"] = "Fin"
L["Thick"] = "Epais"

L["Shadow"] = "Ombre"
L["Add a drop shadow effect to the display text."] = "Ajoute une ombre portée au texte affiché."

L["Counter Size"] = "Taille du compteur"
L["Set the text size for the charge counters."] = "Défini la taille du texte du compteur de charges."

L["Name Size"] = "Taille du nom"
L["Set the text size for the target name."] = "Défini la taille du texte du nom de la cible."

------------------------------------------------------------------------

L["Colors"] = "Couleur"
L["Set the color for the %s charge counter."] = "Défini la couleur pour le compteur de charges du %s."

L["Active"] = "Actif"
L["Set the color for the target name while your %s is active."] = "Défini la couleur du  nom de la cible quand %s est actif."

L["Overwritten"] = "Ecrasé"
L["Set the color for the target name when your %s has been overwritten."] = "Défini la couleur du nom de la cible quand votre %s a été écrasé par un autre chaman."

L["Inactive"] = "Inactif"
L["Set the color for expired, dispelled, or otherwise inactive shields."] = "Défini la couleur pour les boucliers expirés, dissipés ou inactifs."

L["Colorblind Mode"] = USE_COLORBLIND_MODE -- Leave this as-is unless there is something wrong with Blizzard's translation in your locale
L["Add asterisks around the target name when your %s has been overwritten, in addition to changing the color."] = "Ajoute des astérisques de chaque coté du nom de la cible quand votre %s est écrasé (en plus du changement de couleur)."

------------------------------------------------------------------------

L["Alerts"] = "Alertes"
L["Use these settings to configure how ShieldsUp alerts you when a shield expires or is removed."] = "Utilisez ces paramètres pour configurer comment ShieldsUp vous alertera quand vos boucliers expirent ou sont écrasés."

L["Text Alert"] = "Texte d'alerte"
L["Show a text message when %s expires."] = "Affiche un message texte quand le %s expire."

L["Sound Alert"] = "Alerte sonore"
L["Play a sound when %s expires."] = "Joue un son quand le %s expire."

L["Sound File"] = "Fichier son"
L["Select the sound to play when %s expires."] = "Selectionnez le fichier son à jouer quand %s expire."

L["Text Output"] = "Affichage du texte"

------------------------------------------------------------------------

L["Visibility"] = "Visibilité"
L["Enable"] = "Activé"
L["Use these settings to control when ShieldsUp display should be shown or hidden."] = "Utiliser ces paramètres pour configurer quand l'affichage de ShieldsUp doit être actif ou non."

L["Group Size"] = "Taille du groupe"
-- L["Solo"] = ""
L["Show the display while you are not in a group"] = "Conserver l'affichage quand vous n'êtes pas groupé."
L["Party"] = "Groupe"
L["Show the display while you are in a party group"] = "Afficher ShieldsUp quand vous êtes dans un groupe de 5."
-- L["Raid"] = ""
L["Show the display while you are in a raid group"] = "Afficher ShieldsUp quand vous êtes dans un groupe de raid."

L["Zone Type"] = "Type de Zone"
L["World"] = "Monde"
L["Show the display while you are in the outdoor world"] = "Conserver l'affichage quand vous êtes à l'extérieur (hors instance)."
L["Dungeon"] = "Instance"
L["Show the display while you are in a party dungeon"] = "Afficher ShieldsUp quand vous êtes en instance 5 joueurs."
L["Raid Dungeon"] = "Raid"
L["Show the display while you are in a raid dungeon"] = "Afficher ShieldsUp quand vous êtes en instance de raid."
L["Arena"] = "Arène"
L["Show the display while you are in a PvP arena"] = "Afficher ShieldsUp quand vous êtes en arène PvP."
L["Battleground"] = "Champ de bataille (PvP)"
L["Show the display while you are in a PvP battleground"] = "Afficher ShieldsUp quand vous êtes sur un champ de bataille PvP."

-- L["Exceptions"] = ""
L["Dead"] = "Mort"
L["Hide the display while you are dead"] = "Cacher l'affichage quand vous êtes mort."
L["Out Of Combat"] = "Hors combat"
L["Hide the display while you are out of combat"] = "Cacher l'affichage quand vous hors combat."
L["Resting"] = "Repos"
L["Hide the display while you are in an inn or major city"] = "Cacher l'affichage quand vous êtes dans une capitale ou une auberge (statut repos)."
L["Vehicle"] = "Véhicule"
L["Hide the display while you are controlling a vehicle"] = "Cacher l'affichage quand vous contrôlez un véhicule."

------------------------------------------------------------------------