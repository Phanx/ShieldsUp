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

L["ShieldsUp is a simple monitor for your shaman shields. Use these settings to configure the addon's appearance and behavior."] = "ShieldsUp est un addon permettant de surperviser vos boucliers de chamans. Utilisez ces param�tres pour configurer l'apparence et le comportement de cet addon."

L["Horizontal Position"] = "Position Horizontale"
L["Set the horizontal distance from the center of the screen to place the display."] = "D�fini le positionnement horizontal de l'affichage par rapport au centre de l'�cran."

L["Vertical Position"] = "Position Verticale"
L["Set the vertical distance from the center of the screen to place the display."] = "D�fini le positionnement vertical de l'affichage par rapport au centre de l'�cran."

L["Horizontal Padding"] = "Espacement horizontal"
L["Set the horizontal space between the charge counts."] = "D�fini l'espacement horizontal entre les compteurs de charges."

L["Vertical Padding"] = "Espacement vertical"
L["Set the vertical space between the target name and charge counters."] = "D�fini l'espacement vertical entre le nom de la cible et les compteurs de charges."

L["Opacity"] = "Opacit�"
L["Set the opacity level for the display."] = "D�fini le niveau d'opacit� de l'affichage."

------------------------------------------------------------------------

L["Font Face"] = "Police de caract�re"
L["Set the font face to use for the display text."] = "D�fini la police de caract�re utilis�e pour l'affichage du texte."

L["Outline"] = "Contour"
L["Select an outline width for the display text."] = "D�fini l'�paisseur du contour utilis� sur les caract�res."
L["None"] = "Aucun"
L["Thin"] = "Fin"
L["Thick"] = "Epais"

L["Shadow"] = "Ombre"
L["Add a drop shadow effect to the display text."] = "Ajoute une ombre port�e au texte affich�."

L["Counter Size"] = "Taille du compteur"
L["Set the text size for the charge counters."] = "D�fini la taille du texte du compteur de charges."

L["Name Size"] = "Taille du nom"
L["Set the text size for the target name."] = "D�fini la taille du texte du nom de la cible."

------------------------------------------------------------------------

L["Colors"] = "Couleur"
L["Set the color for the %s charge counter."] = "D�fini la couleur pour le compteur de charges du %s."

L["Active"] = "Actif"
L["Set the color for the target name while your %s is active."] = "D�fini la couleur du  nom de la cible quand %s est actif."

L["Overwritten"] = "Ecras�"
L["Set the color for the target name when your %s has been overwritten."] = "D�fini la couleur du nom de la cible quand votre %s a �t� �cras� par un autre chaman."

L["Inactive"] = "Inactif"
L["Set the color for expired, dispelled, or otherwise inactive shields."] = "D�fini la couleur pour les boucliers expir�s, dissip�s ou inactifs."

L["Colorblind Mode"] = USE_COLORBLIND_MODE -- Leave this as-is unless there is something wrong with Blizzard's translation in your locale
L["Add asterisks around the target name when your %s has been overwritten, in addition to changing the color."] = "Ajoute des ast�risques de chaque cot� du nom de la cible quand votre %s est �cras� (en plus du changement de couleur)."

------------------------------------------------------------------------

L["Alerts"] = "Alertes"
L["Use these settings to configure how ShieldsUp alerts you when a shield expires or is removed."] = "Utilisez ces param�tres pour configurer comment ShieldsUp vous alertera quand vos boucliers expirent ou sont �cras�s."

L["Text Alert"] = "Texte d'alerte"
L["Show a text message when %s expires."] = "Affiche un message texte quand le %s expire."

L["Sound Alert"] = "Alerte sonore"
L["Play a sound when %s expires."] = "Joue un son quand le %s expire."

L["Sound File"] = "Fichier son"
L["Select the sound to play when %s expires."] = "Selectionnez le fichier son � jouer quand %s expire."

L["Text Output"] = "Affichage du texte"

------------------------------------------------------------------------

L["Visibility"] = "Visibilit�"
L["Enable"] = "Activ�"
L["Use these settings to control when ShieldsUp display should be shown or hidden."] = "Utiliser ces param�tres pour configurer quand l'affichage de ShieldsUp doit �tre actif ou non."

L["Group Size"] = "Taille du groupe"
-- L["Solo"] = ""
L["Show the display while you are not in a group"] = "Conserver l'affichage quand vous n'�tes pas group�."
L["Party"] = "Groupe"
L["Show the display while you are in a party group"] = "Afficher ShieldsUp quand vous �tes dans un groupe de 5."
-- L["Raid"] = ""
L["Show the display while you are in a raid group"] = "Afficher ShieldsUp quand vous �tes dans un groupe de raid."

L["Zone Type"] = "Type de Zone"
L["World"] = "Monde"
L["Show the display while you are in the outdoor world"] = "Conserver l'affichage quand vous �tes � l'ext�rieur (hors instance)."
L["Dungeon"] = "Instance"
L["Show the display while you are in a party dungeon"] = "Afficher ShieldsUp quand vous �tes en instance 5 joueurs."
L["Raid Dungeon"] = "Raid"
L["Show the display while you are in a raid dungeon"] = "Afficher ShieldsUp quand vous �tes en instance de raid."
L["Arena"] = "Ar�ne"
L["Show the display while you are in a PvP arena"] = "Afficher ShieldsUp quand vous �tes en ar�ne PvP."
L["Battleground"] = "Champ de bataille (PvP)"
L["Show the display while you are in a PvP battleground"] = "Afficher ShieldsUp quand vous �tes sur un champ de bataille PvP."

-- L["Exceptions"] = ""
L["Dead"] = "Mort"
L["Hide the display while you are dead"] = "Cacher l'affichage quand vous �tes mort."
L["Out Of Combat"] = "Hors combat"
L["Hide the display while you are out of combat"] = "Cacher l'affichage quand vous hors combat."
L["Resting"] = "Repos"
L["Hide the display while you are in an inn or major city"] = "Cacher l'affichage quand vous �tes dans une capitale ou une auberge (statut repos)."
L["Vehicle"] = "V�hicule"
L["Hide the display while you are controlling a vehicle"] = "Cacher l'affichage quand vous contr�lez un v�hicule."

------------------------------------------------------------------------