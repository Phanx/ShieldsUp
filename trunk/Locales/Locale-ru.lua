--[[--------------------------------------------------------------------
	ShieldsUp
	Text-based shaman shield monitor.
	Copyright (c) 2008-2014 Phanx <addons@phanx.net>. All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info9165-ShieldsUp.html
	http://www.curse.com/addons/wow/shieldsup
------------------------------------------------------------------------
	Russian localization
	Last updated 2008-11-08 by XisRaa
	***
	***
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
L.Bottom = "Внизу"
L.ClassColor = "Цвет класса"
L.ClassColor_Desc = "Окрашивать имя цели цветам, соответствующего класса, в то время как %s активен."
L.ClickForOptions = "Клик, открывает окно настроек."
L.Colors = "Цвета"
L.CounterSize = "Размер числа"
L.Font = "Шрифт"
L.Hide = "Скрыть, когда:"
L.HideDead = "Мертвы"
--L.HideInfinite = "Hide infinite shields"
--L.HideInfinite_Desc = "Hide the letter indicator for active shields that don't have a limited number of charges. Missing shields will still be shown."
L.HideOOC = "Вне боя"
L.HideResting = "Набирали силу"
L.HideVehicle = "В машине"
--L.Hidden = "Hidden"
L.LightningAbbrev = "М"
L.Missing = "Предупреждение"
L.Missing_Desc = "Использовать этот цвет, когда счечик зарядов на нуле."
--L.NamePosition = "Target name position"
L.NameSize = "Размер имени"
L.None = "Нету"
L.Opacity = "Opacity"
L.OptionsDesc = "ShieldsUp отслеживает щитов шамана. Эти настройки позволяют настроить внешний вид и поведение модификации."
L.Outline = "Контур"
L.Overwritten = "Перебит"
L.Overwritten_Desc = "Использовать этот цвет для цели, на которой %s, в случае если чужой щит перебил ваш на этой цели."
--L.OverwrittenBy = "Your %1$s has been overwritten by %2$s!"
L.PaddingH = "Горизонтальный отступ"
L.PaddingH_Desc = "Установить горизонтальный отступ между элементами текста."
L.PaddingV = "Вертикальный отступ"
L.PaddingV_Desc = "Установить вертикальный отступ между элементами текста."
L.PositionX = "Горизонтальная позиция"
L.PositionY = "Вертикальная позиция"
L.Shadow = "Тень"
L.ShieldFaded = "%s спал!"
L.ShieldFadedFrom = "%1$s спал с %2$s!"
--L.Show = "Show in:"
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