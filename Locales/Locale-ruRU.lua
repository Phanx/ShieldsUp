--[[--------------------------------------------------------------------
	ShieldsUp
	Text-based shaman shield monitor.
	by Phanx < addons@phanx.net >
	Currently maintained by Akkorian < akkorian@hotmail.com >
	Copyright © 2008–2010 Phanx. Some rights reserved. See LICENSE.txt for details.
	http://www.wowinterface.com/downloads/info9165-ShieldsUp.html
	http://www.curse.com/downloads/wow-addons/details/shieldsup.aspx
------------------------------------------------------------------------
	Localization for ruRU / Russian / Русский
	Last updated 2008-11-08 by XisRaa < xisraa AT gmail DOT com >
----------------------------------------------------------------------]]

if GetLocale() ~= "ruRU" or select(2, UnitClass("player")) ~= "SHAMAN" then return end

local L = { }
local ADDON_NAME, namespace = ...
namespace.L = L

------------------------------------------------------------------------
-- These strings are displayed when shields expire.

L["%s faded!"] = "%s спал!"
L["%s faded from %s!"] = "%s спал с %s!"
L["YOU"] = "ВАС"

------------------------------------------------------------------------
-- These strings are displayed in the configuration GUI.

-- L["ShieldsUp is a monitor for your shaman shields. Use these settings to configure the addon's appearance and behavior."] = ""

L["Horizontal Position"] = "Горизонтальная позиция"
L["Set the horizontal distance from the center of the screen to place the display."] = "Установить горизонтальную позицию относительно центра экрана."

L["Vertical Position"] = "Вертикальная позиция"
L["Set the vertical distance from the center of the screen to place the display."] = "Установить вертикальную позицию относительно центра экрана."

L["Horizontal Padding"] = "Горизонтальный отступ"
L["Set the horizontal space between the charge counters."] = "Установить горизонтальный отступ между элементами текста."

L["Vertical Padding"] = "Вертикальный отступ"
L["Set the vertical space between the target name and charge counters."] = "Установить вертикальный отступ между элементами текста."

L["Opacity"] = "Прозрачность"
L["Set the opacity level for the display."] = "Установить уровень прозрачности."

-- L["Overwrite Alert"] = ""
-- L["Print a message in the chat frame alerting you who overwrites your %s."] = ""

------------------------------------------------------------------------

L["Font Face"] = "Шрифт"
L["Set the font face to use for the display text."] = "Установить размер шрифта для имени."

L["Outline"] = "Обрисовка"
-- L["Select an outline width for the display text."] = ""
-- L["None"] = ""
-- L["Thin"] = ""
-- L["Thick"] = ""

-- L["Shadow"] = ""
-- L["Add a drop shadow effect to the display text."] = ""

L["Counter Size"] = "Размер числа"
L["Set the text size for the charge counters."] = "Установить размер шрифта для счетчиков."

L["Name Size"] = "Размер имени"
L["Set the text size for the target name."] = "Установить размер шрифта для имени."

------------------------------------------------------------------------

L["Colors"] = "Цвета"
L["Set the color for the %s charge counter."] = "Использовать этот цвет для счетчика зарядов %s."

L["Active"] = "Обычные"
L["Set the color for the target name while your %s is active."] = "Использовать этот цвет для цели, на которой %s."

L["Overwritten"] = "Перебит"
L["Set the color for the target name when your %s has been overwritten."] = "Использовать этот цвет для цели, на которой %s, в случае если чужой щит перебил ваш на этой цели."

L["Inactive"] = "Предупреждение"
L["Set the color for expired, dispelled, or otherwise inactive shields."] = "Использовать этот цвет, когда счечик зарядов на нуле."

L["Colorblind Mode"] = USE_COLORBLIND_MODE -- Leave this as-is unless there is something wrong with Blizzard's translation in your locale
-- L["Add asterisks around the target name when your %s has been overwritten, in addition to changing the color."] = ""

------------------------------------------------------------------------

L["Alerts"] = "Предупреждения"
-- L["Use these settings to configure how ShieldsUp alerts you when a shield expires or is removed."] = ""

L["Text Alert"] = "Текст"
L["Show a text message when %s expires."] = "Показывать предупреждение, когда спадает %s."

L["Sound Alert"] = "Звук"
L["Play a sound when %s expires."] = "Проигрывать звук, когда спадает %s."

L["Sound File"] = "Звуковой файл"
-- L["Select the sound to play when %s expires."] = ""

-- L["Text Output"] = ""

------------------------------------------------------------------------

L["Visibility"] = "Видимость"
L["Use these settings to control when the ShieldsUp display should be shown or hidden."] = "Настройка отображения в зависимости от следующих условий."

L["Group Size"] = "Размер группы"
L["Solo"] = "Соло"
L["Show while not in a group."] = "Показывать, когда не в группе."
L["Party"] = "Группа"
L["Show while in a 5-man party."] = "Показывать, когда в группе из 5 человек."
L["Raid"] = "Рейд"
L["Show while in a raid group."] = "Показывать, когда в рейд.е"

L["Zone Type"] = "Тип зоны"
L["World"] = "Мир"
L["Show while in the world"] = "Показывать, когда в мире."
L["Party Dungeon"] = "Подземелье"
L["Show while in a 5-man dungeon"] = "Показывать, когда в подземелье на 5 человек."
L["Raid Dungeon"] = "Инстанс-рейд"
L["Show while in an raid dungeon"] = "Показывать, когда в инстансе-рейде."
L["Arena"] = "Арена"
L["Show while in a PvP arena"] = "Показывать, когда на арене(PvP)."
L["Battleground"] = "Поле боя"
L["Show while in a PvP battleground"] = "Показывать, когда на поле боя(PvP)."

-- L["Exceptions"] = ""
-- L["Dead"] = ""
-- L["Hide the display while you are dead"] = ""
-- L["Out Of Combat"] = ""
-- L["Hide the display while you are out of combat"] = ""
-- L["Resting"] = ""
-- L["Hide the display while you are in an inn or major city"] = ""
-- L["Vehicle"] = ""
-- L["Hide the display while you are controlling a vehicle"] = ""

------------------------------------------------------------------------