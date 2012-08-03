--[[--------------------------------------------------------------------
	ShieldsUp
	Text-based shaman shield monitor.
	Copyright (c) 2008-2012 Phanx <addons@phanx.net>. All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info9165-ShieldsUp.html
	http://www.curse.com/addons/wow/shieldsup
------------------------------------------------------------------------
	Localization for zhTW / Traditional Chinese / 繁體中文
	Last updated 2009-07-15 by www.wowui.cn
----------------------------------------------------------------------]]

if GetLocale() ~= "zhTW" or select(2, UnitClass("player")) ~= "SHAMAN" then return end

local _, namespace = ...
namespace.L = {
	["L"] = "閃",
	["W"] = "水",

	["%s faded!"] = "%s 已消失",
	["%1$s faded from %2$s!"] = "%1$s 在 %2$s 上消失!",
	["YOU"] = "自身",

	--["Click for options."] = "",

	["ShieldsUp is a monitor for your shaman shields. These settings allow you to customize the addon's appearance and behavior."] = "ShieldsUp是一個薩滿護盾的監視器。使用這些設定來配置插件的外觀和行為。",
	["Horizontal Position"] = "水平位置",
	["Move the display left or right relative to the center of the screen."] = "設定插件顯示的相對于屏幕中間的水平位置。",
	["Vertical Position"] = "垂直位置",
	["Move the display up or down relative to the center of the screen."] = "設定插件顯示的相對于屏幕中間的水平位置。",
	["Horizontal Padding"] = "水平間距",
	["Change the horizontal distance between the charge counters."] = "設定計數器的水平距離。",
	["Vertical Padding"] = "垂直間距",
	["Change the vertical distance between the charge counters and the target name."] = "設定目標名字和計數器的垂直距離。",
	["Opacity"] = "不透明度",
	["Change the opacity of the display."] = "設定顯示的不透明度等級。",

	["Font"] = "字型",
	["Change the font used for the display text."] = "設定顯示文字的字型。",
	["Text Outline"] = "描邊",
	["Choose an outline weight for the display text."] = "設定顯示文字的描邊寬度。",
	["None"] = "無",
	["Thin"] = "細描邊",
	["Thick"] = "粗描邊",
	["Counter Size"] = "計數器大小",
	["Change the size of the counter text."] = "設定計數器的文字大小。",
	["Name Size"] = "名字大小",
	["Change the size of the name text."] = "設定目標名字的文字大小。",
	["Shadow"] = "陰影效果",
	["Add a drop shadow effect to the display text."] = "為顯示文字增加一個陰影效果。",
	--["Use Class Color"] = "",
	--["Color the target name by class color when your %s is active."] = "",

	["Colors"] = "顏色",
	["Set the color for the %s charge counter."] = "設定 %s 計數器的顏色。",
	["Active"] = "激活",
	["Set the color for the target name while your %s is active."] = "設定當你的 %s 已激活時目標名字的顏色。",
	["Overwritten"] = "覆蓋",
	["Set the color for the target name when your %s has been overwritten."] = "設定當你的 %s 被其他人覆蓋時目標名字的顏色。",
	["Inactive"] = "未激活",
	["Set the color for expired, dispelled, or otherwise inactive shields."] = "設定當你的護盾過期，被驅散或者其他未被激活的情況下的顏色。",

	["Alerts"] = "警報",
	["These settings allow you to customize how ShieldsUp alerts you when a shield expires or is removed."] = "使用這些警報來配置當一個護盾過期或者被移除時發出 ShieldsUp 警報。",
	["Text Alert"] = "文字警報",
	["Show a message when your %s expires or is removed."] = "當 %s 到期時顯示一個文本訊息。",
	["Sound Alert"] = "音效警報",
	["Play a sound when your %s expires or is removed."] = "當 %s 到期時播放一個音效警報。",
	["Sound File"] = "音效檔案",
	["Choose the sound to play when your %s expires or is removed."] = "選擇當 %s 到期時音效警報的檔案。",
	--["Alert When Overwritten"] = "",
	--["Also alert when another shaman overwrites your %s."] = "",

	["Text Output"] = "文字輸出",

	["Visibility"] = "能見度",
	["These settings allow you to customize when the ShieldsUp display is shown."] = "使用這些設定來控制 ShieldsUp 什么時候顯示或隱藏。",

	["Show in group types:"] = "隊伍大小",
	["Solo"] = "獨自戰斗",
	["Show the display while you are not in a group."] = "當你不在一個隊伍時顯示。",
	["Party"] = "小隊",
	["Show the display while you are in a party."] = "當你在一個小隊時顯示。",
	["Raid"] = "團隊",
	["Show the display while you are in a raid."] = "當你在團隊時顯示。",

	["Show in zone types:"] = "區域類型",
	["World"] = "戶外",
	["Show the display while you are in the outdoor world."] = "當你在戶外世界時顯示。",
	["Dungeon"] = "地城",
	["Show the display while you are in a dungeon."] = "當你在小隊地城時顯示。",
	["Raid Instance"] = "團隊副本",
	["Show the display while you are in a raid instance."] = "當你在團隊副本時顯示。",
	["Arena"] = "競技場",
	["Show the display while you are in a PvP arena."] = "當你在一個PvP競技場時顯示。",
	["Battleground"] = "戰場",
	["Show the display while you are in a PvP battleground."] = "當你在一個PvP戰場時顯示。",

	["Hide when:"] = "排除",
	["Dead"] = "死亡",
	["Hide the display while you are dead."] = "當你死亡時隱藏。",
	["Out of Combat"] = "脫離戰斗狀態",
	["Hide the display while you are out of combat."] = "當你脫離戰斗狀態時隱藏。",
	["Resting"] = "休息狀態",
	["Hide the display while you are in an inn or major city."] = "當你在旅館或者在主城時隱藏。",
	["Vehicle"] = "載具",
	["Hide the display while you are controlling a vehicle."] = "當你正在控制一個載具時隱藏。",
}