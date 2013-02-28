--[[--------------------------------------------------------------------
	ShieldsUp
	Text-based shaman shield monitor.
	Copyright (c) 2008-2013 Phanx <addons@phanx.net>. All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info9165-ShieldsUp.html
	http://www.curse.com/addons/wow/shieldsup
------------------------------------------------------------------------
	Localization for ruRU / Russian / Русский
	Last updated 2008-11-08 by XisRaa < xisraa AT gmail DOT com >
----------------------------------------------------------------------]]

if GetLocale() ~= "ruRU" or select(2, UnitClass("player")) ~= "SHAMAN" then return end

local _, namespace = ...
namespace.L = {
	["L"] = "М",
	["W"] = "В",

	["%s faded!"] = "%s спал!",
	["%1$s faded from %2$s!"] = "%1$s спал с %2$s!",
	["YOU"] = "ВАС",

	["Click for options."] = "Клик - открывает окно настроек.",

	["ShieldsUp is a monitor for your shaman shields. These settings allow you to customize the addon's appearance and behavior."] = "ShieldsUp отслеживает щитов шамана. Эти настройки позволяют настроить внешний вид и поведение модификации.",
	["Horizontal Position"] = "Горизонтальная позиция",
	["Move the display left or right relative to the center of the screen."] = "Установить горизонтальную позицию относительно центра экрана.",
	["Vertical Position"] = "Вертикальная позиция",
	["Move the display up or down relative to the center of the screen."] = "Установить вертикальную позицию относительно центра экрана.",
	["Horizontal Padding"] = "Горизонтальный отступ",
	["Change the horizontal distance between the charge counters."] = "Установить горизонтальный отступ между элементами текста.",
	["Vertical Padding"] = "Вертикальный отступ",
	["Change the vertical distance between the charge counters and the target name."] = "Установить вертикальный отступ между элементами текста.",
	["Opacity"] = "Прозрачность",
	["Change the opacity of the display."] = "Установить уровень прозрачности.",

	["Font"] = "Шрифт",
	["Change the font used for the display text."] = "Установить размер шрифта для имени.",
	["Text Outline"] = "Контур шрифта",
	["Choose an outline weight for the display text."] = "Установить размер контура шрифта.",
	["None"] = "Нету",
	["Thin"] = "Тонкий",
	["Thick"] = "Толстый",
	["Counter Size"] = "Размер числа",
	["Change the size of the counter text."] = "Установить размер шрифта для счетчиков.",
	["Name Size"] = "Размер имени",
	["Change the size of the name text."] = "Установить размер шрифта для имени.",
	["Shadow"] = "Тень шрифта",
	["Add a drop shadow effect to the display text."] = "Отображать эффекта тени шрифта.",
	["Use Class Color"] = "Цвет класса",
	["Color the target name by class color when your %s is active."] = "Окрашивать имя цели цветам, соответствующего класса, в то время как %s активен.",

	["Colors"] = "Цвета",
	["Set the color for the %s charge counter."] = "Использовать этот цвет для счетчика зарядов %s.",
	["Active"] = "Обычные",
	["Set the color for the target name while your %s is active."] = "Использовать этот цвет для цели, на которой %s.",
	["Overwritten"] = "Перебит",
	["Set the color for the target name when your %s has been overwritten."] = "Использовать этот цвет для цели, на которой %s, в случае если чужой щит перебил ваш на этой цели.",
	["Inactive"] = "Предупреждение",
	["Set the color for expired, dispelled, or otherwise inactive shields."] = "Использовать этот цвет, когда счечик зарядов на нуле.",

	["Alerts"] = "Предупреждения",
	["These settings allow you to customize how ShieldsUp alerts you when a shield expires or is removed."] = "Эти настройки позволяют настроить, как ShieldsUp уведомляет вас, когда щит истекает или рассеивается.",
	["Text Alert"] = "Текст",
	["Show a message when your %s expires or is removed."] = "Показывать предупреждение, когда спадает %s.",
	["Sound Alert"] = "Звук",
	["Play a sound when your %s expires or is removed."] = "Проигрывать звук, когда спадает %s.",
	["Sound File"] = "Звуковой файл",
	["Choose the sound to play when your %s expires or is removed."] = "Выберите, какой звук играть, когда спадает %s.",
	["Alert When Overwritten"] = "Уведомление когда заменен",
	["Also alert when another shaman overwrites your %s."] = "Также уведомление, когда другой шаман заменяет ваш щит.",

	["Text Output"] = "Вывода текста",

	["Visibility"] = "Видимость",
	["These settings allow you to customize when the ShieldsUp display is shown."] = "Настройка отображения в зависимости от следующих условий.",

	["Show in group types:"] = "Размер группы",
	["Solo"] = "Соло",
	["Show the display while you are not in a group."] = "Показывать, когда не в группе.",
	["Party"] = "Группа",
	["Show the display while you are in a party."] = "Показывать, когда в группе из 5 человек.",
	["Raid"] = "Рейд",
	["Show the display while you are in a raid."] = "Показывать, когда в рейде.",

	["Show in zone types:"] = "Тип зоны",
	["World"] = "Мир",
	["Show the display while you are in the outdoor world."] = "Показывать, когда в мире.",
	["Dungeon"] = "Подземелье",
	["Show the display while you are in a dungeon."] = "Показывать, когда в подземелье на 5 человек.",
	["Raid Instance"] = "Инстанс-рейд",
	["Show the display while you are in a raid instance."] = "Показывать, когда в инстансе-рейде.",
	["Arena"] = "Арена",
	["Show the display while you are in a PvP arena."] = "Показывать, когда на арене(PvP).",
	["Battleground"] = "Поле боя",
	["Show the display while you are in a PvP battleground."] = "Показывать, когда на поле боя(PvP).",

	["Hide when:"] = "Скрыть, когда:",
	["Dead"] = "Мертвы",
	["Hide the display while you are dead."] = "Скрыть, когда вы мертвы.",
	["Out of Combat"] = "Вне боя",
	["Hide the display while you are out of combat."] = "Скрыть, когда вы вне боя.",
	["Resting"] = "Набирали силу",
	["Hide the display while you are in an inn or major city."] = "Скрыть, когда вы набирали силу.",
	["Vehicle"] = "В машине",
	["Hide the display while you are controlling a vehicle."] = "Скрыть, когда вы в машине.",
}