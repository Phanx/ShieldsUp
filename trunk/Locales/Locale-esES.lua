--[[--------------------------------------------------------------------
	ShieldsUp
	Text-based shaman shield monitor.
	Copyright (c) 2008-2012 Phanx <addons@phanx.net>. All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info9165-ShieldsUp.html
	http://www.curse.com/addons/wow/shieldsup
------------------------------------------------------------------------
	Spanish / Español
	Last updated 2012-07-29 by Phanx
----------------------------------------------------------------------]]

if not (GetLocale() == "esES" or GetLocale() == "esMX") or select(2, UnitClass("player")) ~= "SHAMAN" then return end

local _, namespace = ...
namespace.L = {
	["L"] = "R",
	["W"] = "A",

	["%s faded!"] = "%s desapareció!",
	["%1$s faded from %2$s!"] = "%1$s desapareció de %2$s!",
	["YOU"] = "TI",

	["Click for options."] = "",

	["ShieldsUp is a monitor for your shaman shields. These settings allow you to customize the addon's appearance and behavior."] = "Estes opciones te permiten personalizar como ShieldsUp sigue tus Escudos elementales.",
	["Horizontal Position"] = "Posición horizontal",
	["Move the display left or right relative to the center of the screen."] = "Mueve el marco de la izquierda o la derecha con respecto al centro de la pantalla.",
	["Vertical Position"] = "Posición vertical",
	["Move the display up or down relative to the center of the screen."] = "Mueve el marco arriba o abajo con respecto al centro de la pantalla.",
	["Horizontal Padding"] = "Espaciado horizontal",
	["Change the horizontal distance between the charge counters."] = "Ajusta el espacio horizontal entre los contadores de cargas.",
	["Vertical Padding"] = "Espaciado vertical",
	["Change the vertical distance between the charge counters and the target name."] = "Ajusta el espacio vertical entre los números de cargas y el nombre de objetivo.",
	["Opacity"] = "Opacidad",
	["Change the opacity of the display."] = "Ajusta la opacidad del marco.",

	["Font"] = "Tipo de letra",
	["Change the font used for the display text."] = "Cambia el tipo de letra utilizado por texto en el marco.",
	["Text Outline"] = "Contorno",
	["Choose an outline weight for the display text."] = "Seleccione el grueso del texto.",
	["None"] = "Ninguno",
	["Thin"] = "Fino",
	["Thick"] = "Grueso",
	["Counter Size"] = "Tamaño de números",
	["Change the size of the counter text."] = "Ajusta el tamaño de texto para los números de cargas.",
	["Name Size"] = "Tamaño de nombre",
	["Change the size of the name text."] = "Ajusta el tamaño de texto para el nombre del objetivo.",
	["Shadow"] = "Sombra",
	["Add a drop shadow effect to the display text."] = "Mustra un sombra en el texto.",
	["Use Class Color"] = "Color de clase",
	["Color the target name by class color when your %s is active."] = "Colorea el nombre de objetivo por el color de clase, mientras que tu %s está activo.",

	["Colors"] = "Colores",
	["Set the color for the %s charge counter."] = "Elige el color para los números de cargas de %s.",
	["Active"] = "Activo",
	["Set the color for the target name while your %s is active."] = "Elige el color para el nombre de objetivo, mientras que tu %s está activo.",
	["Overwritten"] = "Sobrescrito",
	["Set the color for the target name when your %s has been overwritten."] = "Elige el color para el nombre de objetivo, cuando otro chamán sobrescribe tu %s.",
	["Inactive"] = "Inactivo",
	["Set the color for expired, dispelled, or otherwise inactive shields."] = "Elige el color para Escudos expirados, disipados, o inactivos.",

	["Alerts"] = "Alertas",
	["These settings allow you to customize how ShieldsUp alerts you when a shield expires or is removed."] = "Estes opciones te permiten cambiar como ShieldsUp te avisa cuando tu Escudos expira o se disipa.",
	["Text Alert"] = "Alertas de texto",
	["Show a message when your %s expires or is removed."] = "Muestra un mensaje cuando tu %s expira o se disipa.",
	["Sound Alert"] = "Alertas de sonido",
	["Play a sound when your %s expires or is removed."] = "Reproduce un sonido cuando tu %s expira o se disipa.",
	["Sound File"] = "Sonido",
	["Choose the sound to play when your %s expires or is removed."] = "Elige el sonido para reproducir cuando tu %s expira o se disipa.",
	["Alert When Overwritten"] = "Alerta cuando sobrescrito",
	["Also alert when another shaman overwrites your %s."] = "También avise cuando otro chamán sobrescribe tu %s.",

	["Text Output"] = "Salida de texto",

	["Visibility"] = "Visibilidad",
	["These settings allow you to customize when the ShieldsUp display is shown."] = "Estas opciones te permiten personalizar cuándo mostrar u ocultar el marco de ShieldsUp.",

	["Show in group types:"] = "Muestra en tipos de grupo:",
	["Solo"] = "Solo",
	["Show the display while you are not in a group."] = "Muestra el marco mientras que estás solo.",
	["Party"] = "Grupo",
	["Show the display while you are in a party."] = "Muestra el marco mientras que estás en un grupo de 5.",
	["Raid"] = "Banda",
	["Show the display while you are in a raid."] = "Muestra el marco mientras que estás en un banda.",

	["Show in zone types:"] = "Muestra en tipos de zona:",
	["World"] = "Mundo",
	["Show the display while you are in the outdoor world."] = "Muestra el marco mientras que no estás en una instancia.",
	["Dungeon"] = "Mazmorra",
	["Show the display while you are in a dungeon."] = "Muestra el marco mientras que estás en una mazmorra.",
	["Raid Instance"] = "Instancia de banda",
	["Show the display while you are in a raid instance."] = "Muestra el marco mientras que estás en una instancia de banda.",
	["Arena"] = "Arena",
	["Show the display while you are in a PvP arena."] = "Muestra el marco mientras que estás en una arena JcJ.",
	["Battleground"] = "Campo de batalla",
	["Show the display while you are in a PvP battleground."] = "Muestra el marco mientras que estás en un campo de batalla.",

	["Hide when:"] = "Oculta cuando:",
	["Dead"] = "Muerto",
	["Hide the display while you are dead."] = "Oculta el marco mientras que estás muerto.",
	["Out of Combat"] = "Fuera de combate",
	["Hide the display while you are out of combat."] = "Oculta el marco mientras que estás fuera de combate.",
	["Resting"] = "Reposo",
	["Hide the display while you are in an inn or major city."] = "Oculta el marco mientras que estás en una fonda o gran ciudad (reposo).",
	["Vehicle"] = "Vehículo",
	["Hide the display while you are controlling a vehicle."] = "Oculta el marco mientras que estás manejando un vehículo.",
}