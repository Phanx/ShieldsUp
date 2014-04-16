--[[--------------------------------------------------------------------
	ShieldsUp
	Text-based shaman shield monitor.
	Copyright (c) 2008-2014 Phanx <addons@phanx.net>. All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info9165-ShieldsUp.html
	http://www.curse.com/addons/wow/shieldsup
------------------------------------------------------------------------
	Spanish localization
	Last updated 2014-02-23 by Phanx
	***
----------------------------------------------------------------------]]

local _, private = ...
if private.UNLOAD or not strmatch(GetLocale(), "^es") then return end

local L = private.L

L.Active = "Activo"
L.Active_Desc = "Establecer el color para el nombre de objetivo, mientras que tu %s está activo."
L.AlertOverwritten = "Alerta cuando reemplazado"
L.AlertOverwritten_Desc = "Altertar también cuando un otro chamán reemplaza tu %s."
L.Alerts = "Alertas"
L.Alerts_Desc = "Estes opciones te permiten cambiar como ShieldsUp te avisa cuando tu Escudos expira o se disipa."
L.AlertSound = "Alertas de sonido"
L.AlertSound_Desc = "Seleccionar el sonido para reproducir cuando tu %s expira o se disipa."
L.AlertText = "Alertas de texto"
L.AlertText_Desc = "Mostrar un mensaje cuando tu %s expira o se disipa."
L.AlertTextSink = "Salida de texto"
L.AlertWhileHidden = "Alertas cuando oculto"
L.AlertWhileHidden_Desc = "Mostrar los mensajes y reproducir los sonidos de alerta incluso cuando ShieldsUp está oculta debido a tus configuración de visibilidad."
L.Bottom = "Abajo"
L.ClassColor = "Usar color de clase"
L.ClassColor_Desc = "Colorar el nombre de objetivo por el color de clase, mientras que tu %s está activo."
L.ClickForOptions = "Clic para opciones."
L.Colors = "Colores"
L.CounterSize = "Tamaño de números"
L.Font = "Tipo de letra"
L.HiddenLowLevel = "|cffffd100ATENCIÓN:|r Independientemente de los ajustes superiores, ShieldsUp está corrientemente oculta porque el nivel de tu personaje es demasiado bajo. Después de alcanzar el nivel 8, ShieldsUp se mostrará y ocultará normalmente."
L.Hide = "Oculta cuando:"
L.HideDead = "Muerto"
L.HideInfinite = "Oculta escudos sin cargas"
L.HideInfinite_Desc = "Oculta los letras de indicación para los escudos ativos que no tienen cargas limidatas. Escudos que faltan siempre se muestran."
L.HideOOC = "Fuera de combate"
L.HideResting = "Reposo"
L.HideVehicle = "Manejando un vehículo"
L.Hidden = "Oculto"
L.LightningAbbrev = "R"
L.Missing = "Desaparecido"
L.Missing_Desc = "Establecer el color para Escudos expirados, disipados, o inactivos."
L.NamePosition = "Posición de nombre"
L.NameSize = "Tamaño de nombre"
L.None = "Ninguno"
L.Opacity = "Opacidad"
L.OptionsDesc = "Estes opciones te permiten personalizar como ShieldsUp sigue tus Escudos elementales."
L.Outline = "Contorno"
L.Overwritten = "Reemplazado"
L.Overwritten_Desc = "Establecer el color para el nombre de objetivo, cuando tu %s ha sido reemplazado por otro chamán."
L.OverwrittenBy = "Tu %1$s ha sido reemplazado por %2$s!"
L.PaddingH = "Espaciado horizontal"
L.PaddingH_Desc = "Ajusta el espacio horizontal entre los dos contadores de cargas."
L.PaddingV = "Espaciado vertical"
L.PaddingV_Desc = "Ajusta el espacio vertical entre los números de cargas y el nombre de objetivo."
L.PositionX = "Posición horizontal"
L.PositionY = "Posición vertical"
L.Shadow = "Sombra"
L.ShieldFaded = "%s desapareció!"
L.ShieldFadedFrom = "%1$s desapareció de %2$s!"
L.Show = "Muestra en:"
L.ShowArena = "Arena"
L.ShowBattleground = "Campo de batalla"
L.ShowParty = "Grupo"
L.ShowRaid = "Banda"
L.ShowSolo = "Solo"
L.Thick = "Grueso"
L.Thin = "Fino"
L.Top = "Arriba"
L.Visibility = "Visibilidad"
L.Visibility_Desc = "Estas opciones te permiten personalizar cuándo mostrar u ocultar el marco de ShieldsUp."
L.WaterAbbrev = "A"
L.YOU = "TI"