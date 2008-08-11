--[[
	ruRU translations for ShieldsUp
	Contributed by XisRaa < xisraa AT gmail com >
	Last updated 11/08/2008
--]]

if select(2, UnitClass("player")) ~= "SHAMAN" or GetLocale() ~= "ruRU" then return end

SHIELDSUP_LOCALE = {
	["%s faded from %s!"] = "%s спал с %s!",
	["YOU"] = "ВАС",
	["%s faded!"] = "%s спал!", -- %s = localized Water Shield.

	["Alerts"] = "Предупреждения",
	["Text"] = "Текст",
	["Show a text alert when Earth Shield fades"] = "Показывать предупреждение, когда спадает Щит Земли",
	["Show a text alert when Water Shield fades"] = "Показывать предупреждение, когда спадает водяной щит",
	["Sound"] = "Звук",
	["Play an alert sound when Earth Shield fades"] = "Проигрывать звук, когда спадает Щит Земли",
	["Play an alert sound when Water Shield fades"] = "Проигрывать звук, когда спадает водяной щит",
	["Sound File"] = "Звуковой файл",

	["Colors"] = "Цвета",
	["Normal"] = "Обычные",
	["Use this color for the Earth Shield target name"] = "Использовать этот цвет для цели, на которой Щит Земли",
	["Overwritten"] = "Перебит",
	["Use this color for the Earth Shield target name when someone overwrites your shield"] = "Использовать этот цвет для цели, на которой Щит Земли, в случае если чужой щит перебил ваш на этой цели",
	["Alert"] = "Предупреждение",
	["Use this color for the shield charge counters when at zero"] = "Использовать этот цвет, когда счечик зарядов на нуле",
	["Use this color for the Earth Shield charge counter"] = "Использовать этот цвет для счетчика зарядов Щита Земли",
	["Use this color for the Water Shield charge counter"] = "Использовать этот цвет для счетчика зарядов водного щита",

	["Font"] = "Шрифт",
	["Face"] = "Тип",
	["Outline"] = "Обрисовка",
	["Count Size"] = "Размер числа",
	["Set the font size for the counters"] = "Установить размер шрифта для счетчиков",
	["Name Size"] = "Размер имени",
	["Set the font size for the name"] = "Установить размер шрифта для имени",
	["Shadow Offset"] = "Отступ тени",

	["Frame"] = "Фрейм",
	["Horizontal Position"] = "Горизонтальная позиция",
	["Set the horizontal placement relative to the center of the screen"] = "Установить горизонтальную позицию относительно центра экрана",
	["Vertical Position"] = "Вертикальная позиция",
	["Set the vertical placement relative to the center of the screen"] = "Установить вертикальную позицию относительно центра экрана",
	["Horizontal Spacing"] = "Горизонтальный отступ",
	["Set the horizontal spacing between text elements"] = "Установить горизонтальный отступ между элементами текста",
	["Vertical Spacing"] = "Вертикальный отступ",
	["Set the vertical spacing between text elements"] = "Установить вертикальный отступ между элементами текста",
	["Alpha"] = "Прозрачность",
	["Set the opacity level"] = "Установить уровень прозрачности",

	["Visibility"] = "Видимость",
	["Enable"] = "Включено",
	["Allow the display to hide or show itself based on the conditions below"] = "Настройка отображения в зависимости от следующих условий:",
	["Group Size"] = "Размер группы",
	["Solo"] = "Соло",
	["Show while not in a group"] = "Показывать, когда не в группе",
	["Party"] = "Группа",
	["Show while in a 5-man party"] = "Показывать, когда в группе из 5 человек",
	["Raid"] = "Рейд",
	["Show while in a raid group"] = "Показывать, когда в рейде",
	["Zone Type"] = "Тип зоны",
	["World"] = "Мир",
	["Show while in the world"] = "Показывать, когда в мире",
	["Dungeon"] = "Подземелье",
	["Show while in a 5-man instanced dungeon"] = "Показывать, когда в подземелье на 5 человек",
	["Raid Dungeon"] = "Инстанс-рейд",
	["Show while in an instanced raid dungeon"] = "Показывать, когда в инстансе-рейде",
	["Arena"] = "Арена",
	["Show while in a PvP arena"] = "Показывать, когда на арене(PvP)",
	["Battleground"] = "Поле боя",
	["Show while in a PvP battleground"] = "Показывать, когда на поле боя(PvP)",
}

SHIELDSUP_ABOUTTEXT = [[
ShieldsUp дает шаману возможность отслеживать состояние щитов, показывая количество оставшихся зарядов Щитов Земли и водяного щита, а так же имя персонажа, на котором находится (или был) Щит Земли.

Внешний вид, поведение и расположение аддона можно настроить с помощью представленных здесь опций.

|cffffcc00Обратите внимание, ShieldsUp в данный момент на этапе бета-тестирования|r и может частично или полностью не функционировать; работа еще ведется!

|cffffcc00Имена|r
ShieldsUp написан Bherasha @ US Sargeras Орда, и основнан на beSch от Infineon.
]]