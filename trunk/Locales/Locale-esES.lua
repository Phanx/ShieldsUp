--[[--------------------------------------------------------------------
	ShieldsUp
	Text-based shaman shield monitor.
	Written by Phanx <addons@phanx.net>
	Maintained by Akkorian <akkorian@hotmail.com>
	Copyright © 2008–2011 Phanx. Some rights reserved. See LICENSE.txt for details.
	http://www.wowinterface.com/downloads/info9165-ShieldsUp.html
	http://www.curse.com/downloads/wow-addons/details/shieldsup.aspx
------------------------------------------------------------------------
	Spanish / Español (EU) + Latin American Spanish / Español (AL)
	Last updated 2010-12-22 by Akkorian
----------------------------------------------------------------------]]

if not (GetLocale() == "esES" or GetLocale() == "esMX") or select(2, UnitClass("player")) ~= "SHAMAN" then return end

local L = { }
local ADDON_NAME, namespace = ...
namespace.L = L

------------------------------------------------------------------------
-- These strings are displayed when shields expire.

L["%s faded!"] = "%s desapareció!"
L["%s faded from %s!"] = "%s desapareció de %s!"
L["YOU"] = "USTED"

------------------------------------------------------------------------
-- These strings are displayed in the configuration GUI.

L["Click for options."] = "Click para abrir las opciones."

L["ShieldsUp is a simple monitor for your shaman shields. Use these settings to configure the addon's appearance and behavior."] = "ShieldsUp es un addon para seguir sus Escudos elementales. Estas opciones te permiten modificar la configuración de ShieldsUp."

L["Horizontal Position"] = "Posición horizontal"
L["Set the horizontal distance from the center of the screen to place the display."] = "Ajusta la posición horizontal del marco de seguimiento de Escudos elementales."

L["Vertical Position"] = "Posición vertical"
L["Set the vertical distance from the center of the screen to place the display."] = "Ajusta la posición vertical del marco de seguimiento de Escudos elementales."

L["Horizontal Padding"] = "Espaciado horizontal"
L["Set the horizontal space between the charge counts."] = "Ajusta el espaciamiento horizontal de los contadores de cargas de Escudos elementales."

L["Vertical Padding"] = "Espaciado vertical"
L["Set the vertical space between the target name and charge counters."] = "Ajusta el espaciamiento vertical de los contadores de cargas de Escudos elementales."

L["Opacity"] = "Opacidad"
L["Set the opacity level for the display."] = "Cambia la opacidad del marco de seguimiento de Escudo elementaless."

L["Overwrite Alert"] = "Alertas de sobrescribir"
L["Print a message in the chat frame alerting you who overwrites your %s."] = "Si activas esta opción, aparecerán mensajes de alertar en el ventana de chat cuando otro chamán sobrescribe su %s."

------------------------------------------------------------------------

L["Font Face"] = "Fuente"
L["Set the font face to use for the display text."] = "Cambia la fuente."

L["Outline"] = "Perfil de fuente"
L["Select an outline width for the display text."] = "Ajusta el perfil de la fuente."
L["None"] = "Ninguno"
L["Thin"] = "Fino"
L["Thick"] = "Grueso"

L["Shadow"] = "Sombra de fuente"
L["Add a drop shadow effect to the display text."] = "Mostrar la sombra de la fuente."

L["Counter Size"] = "Tamaño de contadores"
L["Set the text size for the charge counters."] = "Ajusta el tamaño de la fuente de los contadores de los contadores de cargas de Escudos elementales."

L["Name Size"] = "Tamaño de nombre"
L["Set the text size for the target name."] = "Ajusta el tamaño de la fuente del nombre."

------------------------------------------------------------------------

L["Colors"] = "Colores"
L["Set the color for the %s charge counter."] = "Ajusta el color para la contador de cargas de %s."

L["Active"] = "Activo"
L["Set the color for the target name while your %s is active."] = "Ajusta el color para el nombre de objetivo, mientras que su %s está activo."

L["Overwritten"] = "Sobrescrito"
L["Set the color for the target name when your %s has been overwritten."] = "Ajusta el color para el nombre de objetivo, mientras que su %s ha sido sobrescrito."

L["Inactive"] = "Inactivo"
L["Set the color for expired, dispelled, or otherwise inactive shields."] = "Ajusta el color para la contador de cargas de Escudos elementales inactivos."

L["Colorblind Mode"] = USE_COLORBLIND_MODE -- Leave this as-is unless there is something wrong with Blizzard's translation in your locale
L["Add asterisks around the target name when your %s has been overwritten, in addition to changing the color."] = "Si activas esta opción, aparecerán asteriscos alrededor del nombre de objetivo cuando otro chamán sobrescribe su %s, además de cambiar el color."

------------------------------------------------------------------------

L["Alerts"] = "Alertas"
L["Use these settings to configure how ShieldsUp alerts you when a shield expires or is removed."] = "Estas opciones te permiten modificar la forma ShieldsUp le avisa cuando su Escudos elementales expiran o se quitan."

L["Text Alert"] = "Mostrar mensajes"
L["Show a text message when %s expires."] = "Mostrar un mensaje de alertar cuando expira su %s."

L["Sound Alert"] = "Reproducir sonidos"
L["Play a sound when %s expires."] = "Reproducir un sonido cuando expira su %s."

L["Sound File"] = "Sonido"
L["Select the sound to play when %s expires."] = "Cambia el sonido para reproducir cuando expira su %s."

L["Text Output"] = "Salida de mensajes de alertar"

------------------------------------------------------------------------

L["Visibility"] = "Visibilidad"
L["Enable"] = "Activar"
L["Use these settings to control when ShieldsUp display should be shown or hidden."] = "Estas opciones le permiten modificar en el marco de seguimiento de Escudos elementales se muestran o se ocultan."

L["Group Size"] = "Tamaño del grupo"
-- L["Solo"] = ""
L["Show the display while you are not in a group"] = "Mostrar el marco mientras estás solo."
L["Party"] = "Grupo"
L["Show the display while you are in a party group"] = "Mostrar el marco mientras estás en un grupo de 5."
L["Raid"] = "Raid"
L["Show the display while you are in a raid group"] = "Mostrar el marco mientras estás en un banda."

L["Zone Type"] = "Tipo de Zona"
L["World"] = "Mundo"
L["Show the display while you are in the outdoor world"] = "Mostrar el marco mientras estás en el mundo, no una mazmorra."
L["Dungeon"] = "Mazmorra"
L["Show the display while you are in a party dungeon"] = "Mostrar el marco mientras estás en una mazmorra."
L["Raid Dungeon"] = "Mazmorra de banda"
L["Show the display while you are in a raid dungeon"] = "Mostrar el marco mientras estás en una mazmorra de banda."
-- L["Arena"] = ""
L["Show the display while you are in a PvP arena"] = "Mostrar el marco mientras estás en una arena JcJ."
L["Battleground"] = "Campo de batalla"
L["Show the display while you are in a PvP battleground"] = "Mostrar el marco mientras estás en un campo de batalla JcJ."

L["Exceptions"] = "Excepciones"
L["Dead"] = "Muerto"
L["Hide the display while you are dead"] = "Ocultar el marco mientras estás muerto."
L["Out Of Combat"] = "Fuera de combate"
L["Hide the display while you are out of combat"] = "Ocultar el marco mientras estás fuera de combate."
L["Resting"] = "Reposo"
L["Hide the display while you are in an inn or major city"] = "Ocultar el marco mientras estás en una fonda o gran ciudad (reposo)."
L["Vehicle"] = "Vehículo"
L["Hide the display while you are controlling a vehicle"] = "Ocultar el marco mientras estás manejando un vehículo."

------------------------------------------------------------------------