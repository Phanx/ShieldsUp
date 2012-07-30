--[[--------------------------------------------------------------------
	ShieldsUp
	Text-based shaman shield monitor.
	Copyright (c) 2008-2012 Phanx <addons@phanx.net>. All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info9165-ShieldsUp.html
	http://www.curse.com/addons/wow/shieldsup
------------------------------------------------------------------------
	Localization for zhCN / Simplified Chinese / 简体中文
	Last updated 2009-07-15 by www.wowui.cn
----------------------------------------------------------------------]]

if GetLocale() ~= "zhCN" or select(2, UnitClass("player")) ~= "SHAMAN" then return end

local _, namespace = ...; if not namespace then namespace = { } _G.ShieldsUpNamespace = namespace end
namespace.L = {
	["L"] = "闪",
	["W"] = "水",

	["%s faded!"] = "%s 已消失",
	["%1$s faded from %2$s!"] = "%1$s 在 %2$s 上消失!",
	["YOU"] = "自身",

	--["Click for options."] = "",

	["ShieldsUp is a monitor for your shaman shields. These settings allow you to customize the addon's appearance and behavior."] = "ShieldsUp是一个萨满护盾的监视器。使用这些设定来配置插件的外观和行为。",
	["Horizontal Position"] = "水平位置",
	["Move the display left or right relative to the center of the screen."] = "设定插件显示的相对于屏幕中间的水平位置。",
	["Vertical Position"] = "垂直位置",
	["Move the display up or down relative to the center of the screen."] = "设定插件显示的相对于屏幕中间的水平位置。",
	["Horizontal Padding"] = "水平间距",
	["Change the horizontal distance between the charge counters."] = "设定计数器的水平距离。",
	["Vertical Padding"] = "垂直间距",
	["Change the vertical distance between the charge counters and the target name."] = "设定目标名字和计数器的垂直距离。",
	["Opacity"] = "不透明度",
	["Change the opacity of the display."] = "设定显示的不透明度等级。",

	["Font"] = "字体",
	["Change the font used for the display text."] = "设定显示文字的字体。",
	["Text Outline"] = "描边",
	["Choose an outline weight for the display text."] = "设定显示文字的描边宽度。",
	["None"] = "无",
	["Thin"] = "细描边",
	["Thick"] = "粗描边",
	["Counter Size"] = "计数器大小",
	["Change the size of the counter text."] = "设定计数器的文字大小。",
	["Name Size"] = "名字大小",
	["Change the size of the name text."] = "设定目标名字的文字大小。",
	["Shadow"] = "阴影效果",
	["Add a drop shadow effect to the display text."] = "为显示文字增加一个阴影效果。",

	["Colors"] = "颜色",
	["Set the color for the %s charge counter."] = "设定 %s 计数器的颜色。",
	["Active"] = "激活",
	["Set the color for the target name while your %s is active."] = "设定当你的 %s 已激活时目标名字的颜色。",
	["Overwritten"] = "覆盖",
	["Set the color for the target name when your %s has been overwritten."] = "设定当你的 %s 被其他人覆盖时目标名字的颜色。",
	["Inactive"] = "未激活",
	["Set the color for expired, dispelled, or otherwise inactive shields."] = "设定当你的护盾过期，被驱散或者其他未被激活的情况下的颜色。",

	["Alerts"] = "警报",
	["These settings allow you to customize how ShieldsUp alerts you when a shield expires or is removed."] = "使用这些警报来配置当一个护盾过期或者被移除时发出 ShieldsUp 警报。",
	["Text Alert"] = "文字警报",
	["Show a message when your %s expires or is removed."] = "当 %s 到期时显示一个文本讯息。",
	["Sound Alert"] = "音效警报",
	["Play a sound when your %s expires or is removed."] = "当 %s 到期时播放一个音效警报。",
	["Sound File"] = "音效文件",
	["Choose the sound to play when your %s expires or is removed."] = "选择当 %s 到期时音效警报的文件。",
	--["Alert when overwritten"] = "",
	--["Also alert when another shaman overwrites your %s."] = "",

	["Text Output"] = "文字输出",

	["Visibility"] = "能见度",
	["These settings allow you to customize when the ShieldsUp display is shown."] = "使用这些设定来控制 ShieldsUp 什么时候显示或隐藏。",

	["Show in group types:"] = "队伍大小",
	["Solo"] = "独自战斗",
	["Show the display while you are not in a group."] = "当你不在一个队伍时显示。",
	["Party"] = "小队",
	["Show the display while you are in a party."] = "当你在一个小队时显示。",
	["Raid"] = "团队",
	["Show the display while you are in a raid."] = "当你在团队时显示。",

	["Show in zone types:"] = "区域类型",
	["World"] = "户外",
	["Show the display while you are in the outdoor world."] = "当你在户外世界时显示。",
	["Dungeon"] = "小队副本",
	["Show the display while you are in a dungeon."] = "当你在小队副本时显示。",
	["Raid Instance"] = "团队副本",
	["Show the display while you are in a raid instance."] = "当你在团队副本时显示。",
	["Arena"] = "竞技场",
	["Show the display while you are in a PvP arena."] = "当你在一个PvP竞技场时显示。",
	["Battleground"] = "战场",
	["Show the display while you are in a PvP battleground."] = "当你在一个PvP战场时显示。",

	["Hide when:"] = "排除",
	["Dead"] = "死亡",
	["Hide the display while you are dead."] = "当你死亡时隐藏。",
	["Out of Combat"] = "脱离战斗状态",
	["Hide the display while you are out of combat."] = "当你脱离战斗状态时隐藏。",
	["Resting"] = "休息状态",
	["Hide the display while you are in an inn or major city."] = "当你在旅馆或者在主城时隐藏。",
	["Vehicle"] = "载具",
	["Hide the display while you are controlling a vehicle."] = "当你正在控制一个载具时隐藏。",
}