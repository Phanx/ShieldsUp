--[[--------------------------------------------------------------------
	ShieldsUp
	Text-based shaman shield monitor.
	Copyright (c) 2008-2013 Phanx <addons@phanx.net>. All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info9165-ShieldsUp.html
	http://www.curse.com/addons/wow/shieldsup
------------------------------------------------------------------------
	Brazilian Portuguese localization
	Last updated 2013-11-20 by Phanx
	***
	***
----------------------------------------------------------------------]]

local _, private = ...
if private.UNLOAD or GetLocale() ~= "ptBR" then return end

local L = private.L

L.Active = "Ativo"
L.Active_Desc = "Selecionar a cor para o nome do alvo quando seu %s está ativo."
L.AlertOverwritten = "Alertar quando sobrescrito"
L.AlertOverwritten_Desc = "Alertar quando seu %s foi substituído."
L.Alerts = "Alertas"
L.Alerts_Desc = "Estas definições permitem que você alterar a forma como ShieldsUp avisa quando um escudo expirar ou for removido."
L.AlertSound = "Reproduzir sons"
L.AlertSound_Desc = "Selecionar o som a reproduzir quando o %s expirar ou for removido."
L.AlertText = "Alertas textuais"
L.AlertText_Desc = "Mostrar uma mensagem quando o %s expirar ou for removido."
L.AlertTextSink = "Saída de texto"
L.Bottom = "Fundo"
L.ClassColor = "Cor da classe"
L.ClassColor_Desc = "Mostrar a nom do alvo com a cor da classe relevante."
L.ClickForOptions = "Clique para abrir as opções."
L.Colors = "Cores"
L.CounterSize = "Tamanho dos números"
L.Font = "Tipo de letra"
L.Hide = "Ocultar enquanto:"
L.HideDead = "Morto"
L.HideInfinite = "Ocultar escudos sem cargas"
L.HideInfinite_Desc = "Ocultar a carta de indicação para escudos ativos que não têm um quantidade limitado de cargas. Escudos inativos será sempre mostrado, independentemente desta opção."
L.HideOOC = "Fora de combate"
L.HideResting = "Descansando"
L.HideVehicle = "Controlando um veículo"
L.Hidden = "Oculto"
L.LightningAbbrev = "R"
L.Missing = "Inativo"
L.Missing_Desc = "Selecionar a cor de escudos que estão expiradas, removidos ou inativos."
L.NamePosition = "Posição do nome"
L.NameSize = "Tamanho do nome"
L.None = "Nenhum"
L.Opacity = "Opacidade"
L.OptionsDesc = "Estas opções permitem modificar a forma como ShieldsUp acompanha os Escudos Elementais."
L.Outline = "Contorno"
L.Overwritten = "Sobrescrito"
L.Overwritten_Desc = "Selecionar a cor para o nome do alvo quando seu %s foi substituído."
L.OverwrittenBy = "Seu %1$s foi substituído por %2$s!"
L.PaddingH = "Espaçamento horizontal"
L.PaddingH_Desc = "Definir a quantidade de espaço horizontal entre os marcadores de cargas."
L.PaddingV = "Espaçamento vertical"
L.PaddingV_Desc = "Definir a quantidade de espaço vertical entre o nome do alvo e os marcadores de cargas."
L.PositionX = "Posição horizontal"
L.PositionY = "Posição vertical"
L.Shadow = "Sombra"
L.ShieldFaded = "%s desaparecido!"
L.ShieldFadedFrom = "%1$s desapareceu de %2$s!"
L.Show = "Mostrar:"
L.ShowArena = "Arena"
L.ShowBattleground = "Campo del batalha"
L.ShowParty = "Grupo"
L.ShowRaid = "Raide"
L.ShowSolo = "Sozinho"
L.Thick = "Grosso"
L.Thin = "Fino"
L.Top = "Topo"
L.Visibility = "Visibilidade"
L.Visibility_Desc = "Essas configurações permitem que você controle quando ShieldsUp é mostrado ou oculto."
L.WaterAbbrev = "W"
L.YOU = "VOCÊ"