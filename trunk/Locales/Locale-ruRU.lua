--[[--------------------------------------------------------------------
	ShieldsUp
	Text-based shaman shield monitor.
	Copyright (c) 2008-2012 Phanx <addons@phanx.net>. All rights reserved.
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

	--["ShieldsUp is a monitor for your shaman shields. These settings allow you to customize the addon's appearance and behavior."] = "",
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
	["Text Outline"] = "Обрисовка",
	--["Choose an outline weight for the display text."] = "",
	--["None"] = "",
	--["Thin"] = "",
	--["Thick"] = "",
	["Counter Size"] = "Размер числа",
	["Change the size of the counter text."] = "Установить размер шрифта для счетчиков.",
	["Name Size"] = "Размер имени",
	["Change the size of the name text."] = "Использовать этот цвет для счетчика зарядов %s.",
	--["Shadow"] = "",
	--["Add a drop shadow effect to the display text."] = "",
	["Use Class Color"] = "Цвет класса",
	["Color the target name by class color when your %s is active."] = "Окрашивать имя цветам, соответствующими классу.",

	["Colors"] = "Цвета",
	["Set the color for the %s charge counter."] = "Использовать этот цвет для счетчика зарядов %s.",
	["Active"] = "Обычные",
	["Set the color for the target name while your %s is active."] = "Использовать этот цвет для цели, на которой %s.",
	["Overwritten"] = "Перебит",
	["Set the color for the target name when your %s has been overwritten."] = "Использовать этот цвет для цели, на которой %s, в случае если чужой щит перебил ваш на этой цели.",
	["Inactive"] = "Предупреждение",
	["Set the color for expired, dispelled, or otherwise inactive shields."] = "Использовать этот цвет, когда счечик зарядов на нуле.",

	["Alerts"] = "Предупреждения",
	--["These settings allow you to customize how ShieldsUp alerts you when a shield expires or is removed."] = "",
	["Text Alert"] = "Текст",
	["Show a message when your %s expires or is removed."] = "Показывать предупреждение, когда спадает %s.",
	["Sound Alert"] = "Звук",
	["Play a sound when your %s expires or is removed."] = "Проигрывать звук, когда спадает %s.",
	["Sound File"] = "Звуковой файл",
	--["Choose the sound to play when your %s expires or is removed."] = "",
	--["Alert When Overwritten"] = "",
	--["Also alert when another shaman overwrites your %s."] = "",

	--["Text Output"] = "",

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

	--["Hide when:"] = "",
	--["Dead"] = "",
	--["Hide the display while you are dead."] = "",
	--["Out of Combat"] = "",
	--["Hide the display while you are out of combat."] = "",
	--["Resting"] = "",
	--["Hide the display while you are in an inn or major city."] = "",
	--["Vehicle"] = "",
	--["Hide the display while you are controlling a vehicle."] = "",
}