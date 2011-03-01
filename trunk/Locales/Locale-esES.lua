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

L["Click for options."] = "Haz clic para abrir las opciones."

L["ShieldsUp is a simple monitor for your shaman shields. Use these settings to configure the addon's appearance and behavior."] = "Estas opciones te permiten modificar la configuración de ShieldsUp, un addon para seguir tus Escudos elementales."

L["Horizontal Position"] = "Posición horizontal"
L["Set the horizontal distance from the center of the screen to place the display."] = "Ajustar la distancia horizontal desde el centro de la pantalla para colocar el marco."

L["Vertical Position"] = "Posición vertical"
L["Set the vertical distance from the center of the screen to place the display."] = "Ajustar la distancia vertical desde el centro de la pantalla para colocar el marco."

L["Horizontal Padding"] = "Espaciado horizontal"
L["Set the horizontal space between the charge counts."] = "Ajustar el espacio horizontal entre los números de cargas."

L["Vertical Padding"] = "Espaciado vertical"
L["Set the vertical space between the target name and charge counters."] = "Ajustar el espacio vertical entre el nombre objetivo y los números de cargas."

L["Opacity"] = "Opacidad"
L["Set the opacity level for the display."] = "Ajustar la opacidad del marco."

L["Overwrite Alert"] = "Aviso en sobrescrito"
L["Print a message in the chat frame alerting you who overwrites your %s."] = "Mostrar una aviso en la ventana de chat cuando otro chamán sobrescribe tu %s."

------------------------------------------------------------------------

L["Font Face"] = "Fuente"
L["Set the font face to use for the display text."] = "Cambiar la fuente."

L["Outline"] = "Perfil de fuente"
L["Select an outline width for the display text."] = "Ajustar el perfil de la fuente."
L["None"] = "Ninguno"
L["Thin"] = "Fino"
L["Thick"] = "Grueso"

L["Shadow"] = "Sombra de fuente"
L["Add a drop shadow effect to the display text."] = "Mostrar la sombra de la fuente."

L["Counter Size"] = "Tamaño de números"
L["Set the text size for the charge counters."] = "Ajustar el tamaño de los números de cargas."

L["Name Size"] = "Tamaño de nombre"
L["Set the text size for the target name."] = "Ajustar el tamaño de la fuente del nombre objetivo."

------------------------------------------------------------------------

L["Colors"] = "Colores"
L["Set the color for the %s charge counter."] = "Establecer el color del número de cargas en tu %s."

L["Active"] = "Activo"
L["Set the color for the target name while your %s is active."] = "Establecer el color del nombre objetivo, mientras que su %s está activo."

L["Overwritten"] = "Sobrescrito"
L["Set the color for the target name when your %s has been overwritten."] = "Ajusta el color del nombre objetivo, mientras que tu %s se ha sobrescrito."

L["Inactive"] = "Inactivo"
L["Set the color for expired, dispelled, or otherwise inactive shields."] = "Ajusta el color de los números de cargas en Escudos inactivos."

L["Colorblind Mode"] = USE_COLORBLIND_MODE -- Leave this as-is unless there is something wrong with Blizzard's translation in your locale
L["Add asterisks around the target name when your %s has been overwritten, in addition to changing the color."] = "Añadir asteriscos alrededor del nombre de objetivo cuando otro chamán sobrescribe tu %s, además de cambiar el color."

------------------------------------------------------------------------

L["Alerts"] = "Alertas"
L["Use these settings to configure how ShieldsUp alerts you when a shield expires or is removed."] = "Estas opciones te permiten cambiar la forma en ShieldsUp te avisa en un Escudo expira o se quita."

L["Text Alert"] = "Alertas de texto"
L["Show a text message when %s expires."] = "Mostrar un mensaje de alerta cuando expira tu %s."

L["Sound Alert"] = "Alertas de sonido"
L["Play a sound when %s expires."] = "Reproducir un sonido cuando expira tu %s."

L["Sound File"] = "Sonido"
L["Select the sound to play when %s expires."] = "Establecer el sonido a reproducir cuando expira su %s."

L["Text Output"] = "Salida de alertas de texto"

------------------------------------------------------------------------

L["Visibility"] = "Visibilidad"
L["Use these settings to control when ShieldsUp display should be shown or hidden."] = "Estas opciones le permiten controlar cuando el marco de ShieldsUp se muestran o se ocultan."
L["Enable"] = "Activar"

L["Group Size"] = "Tamaño de grupo"
-- L["Solo"] = ""
L["Show the display while you are not in a group"] = "Mostrar el marco mientras estás solo."
L["Party"] = "Grupo"
L["Show the display while you are in a party group"] = "Mostrar el marco mientras estás en un grupo de 5."
L["Raid"] = "Banda"
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