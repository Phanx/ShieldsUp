--[[--------------------------------------------------------------------
	Spanish translations for ShieldsUp
	Last updated 2009-11-16 by Phanx
	Contributors:
		your name here < your contact info here >
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

L["ShieldsUp is a simple monitor for your shaman shields. Use these settings to configure the addon's appearance and behavior."] = "ShieldsUp es un monitor sencillo para sus escudos chamán. Utilice estos ajustes para configurar el aspecto y el comportamiento de ShieldsUp."

L["Horizontal Position"] = "Posición Horizontal"
L["Set the horizontal distance from the center of the screen to place the display."] = "Ajuste la distancia horizontal desde el centro de la pantalla para colocar el monitor."

L["Vertical Position"] = "Posición Vertical"
L["Set the vertical distance from the center of the screen to place the display."] = "Ajuste la distancia vertical desde el centro de la pantalla para colocar el monitor."

L["Horizontal Padding"] = "Espaciado Horizontal"
L["Set the horizontal space between the charge counts."] = "Ajuste el espacio horizontal entre los contadores de carga."

L["Vertical Padding"] = "Espaciado Vertical"
L["Set the vertical space between the target name and charge counters."] = "Ajuste el espacio vertical entre los contadores de carga."

L["Opacity"] = "Opacidad"
L["Set the opacity level for the display."] = "Ajuste la opacidad para el monitor."

-- L["Overwrite Alert"] = ""
-- L["Print a message in the chat frame alerting you who overwrites your %s."] = ""

------------------------------------------------------------------------

L["Font Face"] = "Tipo de letra"
L["Set the font face to use for the display text."] = "Seleccione el tipo de letra a utilizar para el texto del monitor."

L["Outline"] = "Frontera de letra"
L["Select an outline width for the display text."] = "Seleccione un grosor de borde para el texto del monitor."
L["None"] = "Ninguno"
L["Thin"] = "Fino"
L["Thick"] = "Grueso"

L["Shadow"] = "Smbra de letra"
L["Add a drop shadow effect to the display text."] = "Añadir una sombra al texto del monitor."

L["Counter Size"] = "Tamaño de Contadores"
L["Set the text size for the charge counters."] = "Establezca el tamaño del texto para los contadores de cargas."

L["Name Size"] = "Tamaño de Nombre"
L["Set the text size for the target name."] = "Establezca el tamaño del texto para el nombre."

------------------------------------------------------------------------

L["Colors"] = "Colores"
L["Set the color for the %s charge counter."] = "Establezca el color del texto para los contadores de cargas de %s."

L["Active"] = "Activo"
L["Set the color for the target name while your %s is active."] = "Establezca el color del nombre cuando su %s está activo."

L["Overwritten"] = "Sobrescrito"
L["Set the color for the target name when your %s has been overwritten."] = "Establezca el color del nombre cuando su %s ha sido sobrescrito."

L["Inactive"] = "Inactivo"
L["Set the color for expired, dispelled, or otherwise inactive shields."] = "Establecer el color de escudos vencimiento, disipado, o inactivo."

L["Colorblind Mode"] = USE_COLORBLIND_MODE -- Leave this as-is unless there is something wrong with Blizzard's translation in your locale
L["Add asterisks around the target name when your %s has been overwritten, in addition to changing the color."] = "Añadir asteriscos alrededor del nombre cuando su %s ha sido sobrescrito, además de cambiar el color."

------------------------------------------------------------------------

L["Alerts"] = "Alertas"
L["Use these settings to configure how ShieldsUp alerts you when a shield expires or is removed."] = "Utilice estas opciones para configurar cómo ShieldsUp le avisa cuando un escudo caduca o se elimina."

L["Text Alert"] = "Alertas de Texto"
L["Show a text message when %s expires."] = "Mostrar un mensaje de texto cuando expira su %s."

L["Sound Alert"] = "Alertas de Sonido"
L["Play a sound when %s expires."] = "Reproducir un sonido cuando expira su %s."

L["Sound File"] = "Sonido"
L["Select the sound to play when %s expires."] = "Establecer el sonido para reproducir cuando expira su %s."

L["Text Output"] = "Salida de Texto"

------------------------------------------------------------------------

L["Visibility"] = "Visibilidad"
L["Enable"] = "Activar"
L["Use these settings to control when ShieldsUp display should be shown or hidden."] = "Utilice estos ajustes para controlar cuando ShieldsUp deben mostrarse u ocultarse."

L["Group Size"] = "Tamaño del Grupo"
-- L["Solo"] = ""
L["Show the display while you are not in a group"] = "Mostrar el monitor mientras usted está solo"
L["Party"] = "Grupo"
L["Show the display while you are in a party group"] = "Mostrar el monitor mientras usted está en un grupo de 5"
L["Raid"] = "Raid"
L["Show the display while you are in a raid group"] = "Mostrar el monitor mientras usted está en un banda amistosos"

L["Zone Type"] = "Tipo de Zona"
L["World"] = "Mundo"
L["Show the display while you are in the outdoor world"] = "Mostrar el monitor mientras usted está en el mundo (no estancia)"
L["Dungeon"] = "Estancia"
L["Show the display while you are in a party dungeon"] = "Mostrar el monitor mientras usted está en estancia"
L["Raid Dungeon"] = "Estancia de Bandas"
L["Show the display while you are in a raid dungeon"] = "Mostrar el monitor mientras usted está en estancia de banda amistosos"
-- L["Arena"] = ""
L["Show the display while you are in a PvP arena"] = "Mostrar el monitor mientras usted está en arena"
L["Battleground"] = "Campo de Batalla"
L["Show the display while you are in a PvP battleground"] = "Mostrar el monitor mientras usted está en un campo de batalla"

L["Exceptions"] = "Excepciones"
L["Dead"] = "Muerto"
L["Hide the display while you are dead"] = "Ocultar el monitor mientras usted está muerto"
L["Out Of Combat"] = "Fuera de Combate"
L["Hide the display while you are out of combat"] = "Ocultar el monitor mientras usted está fuera de combate"
L["Resting"] = "Reposo"
L["Hide the display while you are in an inn or major city"] = "Ocultar el monitor mientras usted está en una fonda o gran ciudad (reposo)"
L["Vehicle"] = "Vehículo"
L["Hide the display while you are controlling a vehicle"] = "Ocultar el monitor mientras usted está manejando un vehículo"

------------------------------------------------------------------------