--[[--------------------------------------------------------------------
	ShieldsUp
	Text-based shaman shield monitor.
	Copyright (c) 2008-2012 Phanx <addons@phanx.net>. All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info9165-ShieldsUp.html
	http://www.curse.com/addons/wow/shieldsup
------------------------------------------------------------------------
	Brazilian Portuguese / Português Brasileiro
	Last updated 2012-07-29 by Phanx
----------------------------------------------------------------------]]

if GetLocale() ~= "ptBR" or select(2, UnitClass("player")) ~= "SHAMAN" then return end

local _, namespace = ...
namespace.L = {
	["L"] = "R",
	["W"] = "Á",

	["%s faded!"] = "%s desaparecido!",
	["%1$s faded from %2$s!"] = "%1$s desapareceu de %2$s!",
	["YOU"] = "VOCÊ",

	["Click for options."] = "Clique para abrir as opções.",

	["ShieldsUp is a monitor for your shaman shields. These settings allow you to customize the addon's appearance and behavior."] = "Estas opções permitem modificar a forma como ShieldsUp acompanha os Escudos Elementais.",
	["Horizontal Position"] = "Posição horizontal",
	["Move the display left or right relative to the center of the screen."] = "Definir a distância horizontal entre o centro da tela para colocar o exibição.",
	["Vertical Position"] = "Posição vertical",
	["Move the display up or down relative to the center of the screen."] = "Definir a distância vertical entre o centro da tela para colocar o exibição.",
	["Horizontal Padding"] = "Espaçamento horizontal",
	["Change the horizontal distance between the charge counters."] = "Definir a quantidade de espaço horizontal entre os marcadores de cargas.",
	["Vertical Padding"] = "Espaçamento vertical",
	["Change the vertical distance between the charge counters and the target name."] = "Definir a quantidade de espaço vertical entre o nome do alvo e os marcadores de cargas.",
	["Opacity"] = "Opacidade",
	["Change the opacity of the display."] = "Definir o nível de opacidade.",

	["Font"] = "Tipo de letra",
	["Change the font used for the display text."] = "Selecionar o tipo de letra para o texto.",
	["Text Outline"] = "Contorno",
	["Choose an outline weight for the display text."] = "Selecionar uma grossura para o contorno no texto.",
	["None"] = "Nenhum",
	["Thin"] = "Fino",
	["Thick"] = "Grosso",
	["Counter Size"] = "Tamanho dos números",
	["Change the size of the counter text."] = "Definir o tamanho do texto para os marcadores de cargas.",
	["Name Size"] = "Tamanho do nome",
	["Change the size of the name text."] = "Definir o tamanho do texto para o nome do alvo.",
	["Shadow"] = "Sombra",
	["Add a drop shadow effect to the display text."] = "Adicionar um efeito de sombra ao texto.",

	["Colors"] = "Cores",
	["Set the color for the %s charge counter."] = "Selecionar a cor para o marcador de cargas no %s.",
	["Active"] = "Ativo",
	["Set the color for the target name while your %s is active."] = "Selecionar a cor para o nome do alvo quando seu %s está ativo.",
	["Overwritten"] = "Sobrescrito",
	["Set the color for the target name when your %s has been overwritten."] = "Selecionar a cor para o nome do alvo quando seu %s foi substituído.",
	["Inactive"] = "Inativo",
	["Set the color for expired, dispelled, or otherwise inactive shields."] = "Selecionar a cor de escudos que estão expiradas, removidos ou inativos.",

	["Alerts"] = "Alertas",
	["These settings allow you to customize how ShieldsUp alerts you when a shield expires or is removed."] = "Estas definições permitem que você alterar a forma como ShieldsUp avisa quando um escudo expirar ou for removido.",
	["Text Alert"] = "Alertas textuais",
	["Show a message when your %s expires or is removed."] = "Mostrar uma mensagem quando o %s expirar ou for removido.",
	["Sound Alert"] = "Alertas sonoros",
	["Play a sound when your %s expires or is removed."] = "Reproduzir um som quando o %s expirar ou for removido.",
	["Sound File"] = "Som",
	["Choose the sound to play when your %s expires or is removed."] = "Selecionar o som a reproduzir quando o %s expirar ou for removido.",
	["Alert when overwritten"] = "Alertar quando sobrescrito",
	["Also alert when another shaman overwrites your %s."] = "Alertar quando seu %s foi substituído.",

	["Text Output"] = "Saída de texto",

	["Visibility"] = "Visibilidade",
	["These settings allow you to customize when the ShieldsUp display is shown."] = "Essas configurações permitem que você controle quando ShieldsUp é mostrado ou oculto.",

	["Show in group types:"] = "Tipo do grupo",
	["Solo"] = "Sozinho",
	["Show the display while you are not in a group."] = "Mostrar enquanto você está sozinho.",
	["Party"] = "Grupo",
	["Show the display while you are in a party."] = "Mostrar enquanto você está em um grupo.",
	["Raid"] = "Raide",
	["Show the display while you are in a raid."] = "Mostrar enquanto você está em um raide.",

	["Show in zone types:"] = "Tipo de zona",
	["World"] = "Mundo",
	["Show the display while you are in the outdoor world."] = "Mostrar enquanto você está no mundo exterior.",
	["Dungeon"] = "Masmorra",
	["Show the display while you are in a dungeon."] = "Mostrar enquanto você está em uma masmorra.",
	["Raid Instance"] = "Instância de raide",
	["Show the display while you are in a raid instance."] = "Mostrar enquanto você está em uma instância de raide.",
	["Arena"] = "Arena",
	["Show the display while you are in a PvP arena."] = "Mostrar enquanto você está em uma arena.",
	["Battleground"] = "Campo del batalha",
	["Show the display while you are in a PvP battleground."] = "Mostrar enquanto você está em um campo de batalha.",

	["Hide when:"] = "Ocultar enquanto:",
	["Dead"] = "Morto",
	["Hide the display while you are dead."] = "Ocultar enquanto você está morto.",
	["Out of Combat"] = "Fora de combate",
	["Hide the display while you are out of combat."] = "Ocultar enquanto você está fora de combate.",
	["Resting"] = "Descansando",
	["Hide the display while you are in an inn or major city."] = "Ocultar enquanto você está em uma estalagem ou grande cidade.",
	["Vehicle"] = "Em veículo",
	["Hide the display while you are controlling a vehicle."] = "Ocultar enquanto você está controlando um veículo.",
}