--[[--------------------------------------------------------------------
	ShieldsUp
	Text-based shaman shield monitor.
	Copyright (c) 2008-2014 Phanx <addons@phanx.net>. All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info9165-ShieldsUp.html
	http://www.curse.com/addons/wow/shieldsup
------------------------------------------------------------------------
	Russian localization
	Last updated 2014-08-18 by Yafis
	Previous contributors: XisRaa
----------------------------------------------------------------------]]

local _, private = ...
if private.UNLOAD or GetLocale() ~= "ruRU" then return end

local L = private.L

L.Active = "Обычные"
L.Active_Desc = "Использовать этот цвет для цели, на которой %s."
L.AlertOverwritten = "Уведомление когда заменен"
L.AlertOverwritten_Desc = "Также уведомление, когда другой шаман заменяет ваш щит."
L.Alerts = "Предупреждения"
L.Alerts_Desc = "Эти настройки позволяют настроить, как ShieldsUp уведомляет вас, когда щит истекает или рассеивается."
L.AlertSound = "Звук"
L.AlertSound_Desc = "Выберите, какой звук играть, когда спадает %s."
L.AlertText = "Текст"
L.AlertText_Desc = "Показывать предупреждение, когда спадает %s."
L.AlertTextSink = "Вывода текста"
L.AlertWhileHidden = "Предупреждение пока скрыты"
L.AlertWhileHidden_Desc = "Показывать предупредительные сообщения и проигрывать звуки при скрытом ShieldsUp  в ваших настройках видимости."
L.Bottom = "Внизу"
L.ClassColor = "Цвет класса"
L.ClassColor_Desc = "Окрашивать имя цели цветам, соответствующего класса, в то время как %s активен."
L.ClickForOptions = "Клик, открывает окно настроек."
L.Colors = "Цвета"
L.CounterSize = "Размер числа"
L.Font = "Шрифт"
L.HiddenLowLevel = "|cffffd100ВНИМАНИЕ:|r в независимости от ваших настроек, ShieldsUp скрывается из за вашего низкого уровня. После того как вы достигните 8-го уровня все будет работать как обычно! "
L.Hide = "Скрыть, когда:"
L.HideDead = "Мертвы"
L.HideInfinite = "Скрыть бесконечные щиты"
L.HideInfinite_Desc = "Спрятать индикатор для активных щитов, которые не имеют ограниченное количество зарядов. Недостающие щиты будут по-прежнему отображаться."
L.HideOOC = "Вне боя"
L.HideResting = "Набирали силу"
L.HideVehicle = "В машине"
L.Hidden = "Скрытый"
L.LightningAbbrev = "М"
L.Missing = "Предупреждение"
L.Missing_Desc = "Использовать этот цвет, когда счечик зарядов на нуле."
L.NamePosition = "Позиция имени цели"
L.NameSize = "Размер имени"
L.None = "Нету"
L.Opacity = "Opacity"
L.OptionsDesc = "ShieldsUp отслеживает щитов шамана. Эти настройки позволяют настроить внешний вид и поведение модификации."
L.Outline = "Контур"
L.Overwritten = "Перебит"
L.Overwritten_Desc = "Использовать этот цвет для цели, на которой %s, в случае если чужой щит перебил ваш на этой цели."
L.OverwrittenBy = "Ваш %1$s быз изменен на %2$s!"
L.PaddingH = "Горизонтальный отступ"
L.PaddingH_Desc = "Установить горизонтальный отступ между элементами текста."
L.PaddingV = "Вертикальный отступ"
L.PaddingV_Desc = "Установить вертикальный отступ между элементами текста."
L.PositionX = "Горизонтальная позиция"
L.PositionY = "Вертикальная позиция"
L.Shadow = "Тень"
L.ShieldFaded = "%s спал!"
L.ShieldFadedFrom = "%1$s спал с %2$s!"
L.Show = "Показать в:"
L.ShowArena = "Арена"
L.ShowBattleground = "Поле боя"
L.ShowParty = "Группа"
L.ShowRaid = "Рейд"
L.ShowSolo = "Соло"
L.Thick = "Толстый"
L.Thin = "Тонкий"
L.Top = "Вверху"
L.Visibility = "Видимость"
L.Visibility_Desc = "Настройка отображения в зависимости от следующих условий."
L.WaterAbbrev = "В"
L.YOU = "ВАС"