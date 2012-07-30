--[[--------------------------------------------------------------------
	ShieldsUp
	Text-based shaman shield monitor.
	Copyright (c) 2008-2012 Phanx <addons@phanx.net>. All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info9165-ShieldsUp.html
	http://www.curse.com/addons/wow/shieldsup
------------------------------------------------------------------------
	Localization for itIT / Italian / Italiano
	Last updated 2012-07-29 by Phanx
----------------------------------------------------------------------]]

if GetLocale() ~= "itIT" or select(2, UnitClass("player")) ~= "SHAMAN" then return end

local _, namespace = ...
namespace.L = {
	["L"] = "F",
	["W"] = "A",

	["%s faded!"] = "%s svanì!",
	["%1$s faded from %2$s!"] = "%1$s svanì da %2$s!",
	["YOU"] = "VOI",

	["Click for options."] = "Clicca per le opzioni.",

	--["ShieldsUp is a monitor for your shaman shields. These settings allow you to customize the addon's appearance and behavior."] = "",
	["Horizontal Position"] = "Posizione orizzontale",
	--["Move the display left or right relative to the center of the screen."] = "",
	["Vertical Position"] = "Posizione verticale",
	--["Move the display up or down relative to the center of the screen."] = "",
	["Horizontal Padding"] = "Spaziatura orizzontale",
	--["Change the horizontal distance between the charge counters."] = "",
	["Vertical Padding"] = "Spaziatura verticale",
	--["Change the vertical distance between the charge counters and the target name."] = "",
	["Opacity"] = "Opacità",
	--["Change the opacity of the display."] = "",

	["Font"] = "Tipo di carattere",
	--["Change the font used for the display text."] = "",
	["Text Outline"] = "Contorno",
	--["Choose an outline weight for the display text."] = "",
	["None"] = "Non",
	["Thin"] = "Fino",
	["Thick"] = "Grosso",
	["Counter Size"] = "Dimensione di numeri",
	--["Change the size of the counter text."] = "",
	["Name Size"] = "Dimensione del nome",
	--["Change the size of the name text."] = "",
	["Shadow"] = "Ombra",
	--["Add a drop shadow effect to the display text."] = "",

	["Colors"] = "Colori",
	--["Set the color for the %s charge counter."] = "",
	["Active"] = "Attivo",
	--["Set the color for the target name while your %s is active."] = "",
	["Overwritten"] = "Sovrascritto",
	--["Set the color for the target name when your %s has been overwritten."] = "",
	["Inactive"] = "Inattivo",
	--["Set the color for expired, dispelled, or otherwise inactive shields."] = "",

	["Alerts"] = "Avvisi",
	--["These settings allow you to customize how ShieldsUp alerts you when a shield expires or is removed."] = "",
	["Text Alert"] = "Visualizzare il testo",
	--["Show a message when your %s expires or is removed."] = "",
	["Sound Alert"] = "Riprodurre l'audio",
	--["Play a sound when your %s expires or is removed."] = "",
	["Sound File"] = "File audio",
	--["Choose the sound to play when your %s expires or is removed."] = "",
	["Alert when overwritten"] = "Avvisa quando sovrascritto",
	--["Also alert when another shaman overwrites your %s."] = "",

	--["Text Output"] = "",

	["Visibility"] = "Visibilità",
	--["These settings allow you to customize when the ShieldsUp display is shown."] = "",

	["Show in group types:"] = "Mostra in tipi di gruppi:",
	["Solo"] = "Solo",
	["Show the display while you are not in a group."] = "Mostra il quadro quando giochi da solo.",
	["Party"] = "Gruppo",
	["Show the display while you are in a party."] = "Mostra il quadro quando sei in gruppo.",
	["Raid"] = "Incursione",
	["Show the display while you are in a raid."] = "Mostra il quadro quando sei in un'incursione.",

	["Show in zone types:"] = "Mostra in tipi di zone:",
	["World"] = "Mondo",
	["Show the display while you are in the outdoor world."] = "Mostra il quadro quando non sei in un'istanza.",
	["Dungeon"] = "Spedizione",
	["Show the display while you are in a dungeon."] = "Mostra il quadro quando sei in una spedizione.",
	["Raid Instance"] = "Istanza d'incursione",
	["Show the display while you are in a raid instance."] = "Mostra il quadro quando sei in un'istanza d'incursione.",
	["Arena"] = "Arena",
	["Show the display while you are in a PvP arena."] = "Mostra il quadro quando sei in un'arena.",
	["Battleground"] = "Campo di battaglia",
	["Show the display while you are in a PvP battleground."] = "Mostra il quadro quando sei in un'campo di battaglia.",

	["Hide when:"] = "Nascondere quando:",
	["Dead"] = "Morto",
	["Hide the display while you are dead."] = "Nascondere il quadro quando sei morto.",
	["Out of Combat"] = "Fuori dal combattimento",
	["Hide the display while you are out of combat."] = "Nascondere il quadro quando sei fuori dal combattimento.",
	["Resting"] = "Riposo",
	["Hide the display while you are in an inn or major city."] = "Nascondere il quadro quando sei riposo, in una locanda o in una grande città",
	["Vehicle"] = "Veicolo",
	["Hide the display while you are controlling a vehicle."] = "Nascondere il quadro quando sei controlla un veicolo.",
}