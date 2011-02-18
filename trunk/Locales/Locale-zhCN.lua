--[[--------------------------------------------------------------------
	ShieldsUp
	Text-based shaman shield monitor.
	Written by Phanx <addons@phanx.net>
	Maintained by Akkorian <akkorian@hotmail.com>
	Copyright © 2008–2011 Phanx. Some rights reserved. See LICENSE.txt for details.
	http://www.wowinterface.com/downloads/info9165-ShieldsUp.html
	http://www.curse.com/downloads/wow-addons/details/shieldsup.aspx
------------------------------------------------------------------------
	Localization for zhCN / Simplified Chinese / 简体中文
	Last updated 2009-07-15 by www.wowui.cn
----------------------------------------------------------------------]]

if GetLocale() ~= "zhCN" or select(2, UnitClass("player")) ~= "SHAMAN" then return end

local L = { }
local ADDON_NAME, namespace = ...
if not namespace then namespace = { } _G.ShieldsUpNamespace = namespace end namespace.L = L

------------------------------------------------------------------------
-- These strings are displayed when shields expire.

L["%s faded!"] = "%s 已消失"
L["%s faded from %s!"] = "%s 在 %s 上消失!"
L["YOU"] = "自身"

------------------------------------------------------------------------
-- These strings are displayed in the configuration GUI.

-- L["Click for options."] = ""

L["ShieldsUp is a monitor for your shaman shields. Use these settings to configure the addon's appearance and behavior."] = "ShieldsUp是一个萨满护盾的监视器。使用这些设定来配置插件的外观和行为."

L["Horizontal Position"] = "水平位置"
L["Set the horizontal distance from the center of the screen to place the display."] = "设定插件显示的相对于屏幕中间的水平位置."

L["Vertical Position"] = "垂直位置"
L["Set the vertical distance from the center of the screen to place the display."] = "设定插件显示的相对于屏幕中间的水平位置."

L["Horizontal Padding"] = "水平间距"
L["Set the horizontal space between the charge counts."] = "设定计数器的水平距离."

L["Vertical Padding"] = "垂直间距"
L["Set the vertical space between the target name and charge counters."] = "设定目标名字和计数器的垂直距离."

L["Opacity"] = "不透明度"
L["Set the opacity level for the display."] = "设定显示的不透明度等级."

-- L["Overwrite Alert"] = ""
-- L["Print a message in the chat frame alerting you who overwrites your %s."] = ""

------------------------------------------------------------------------

L["Font Face"] = "字体"
L["Set the font face to use for the display text."] = "设定显示文字的字体."

L["Outline"] = "描边"
L["Select an outline width for the display text."] = "设定显示文字的描边宽度"
L["None"] = "无"
L["Thin"] = "细描边"
L["Thick"] = "粗描边"

L["Shadow"] = "阴影效果"
L["Add a drop shadow effect to the display text."] = "为显示文字增加一个阴影效果."

L["Counter Size"] = "计数器大小"
L["Set the text size for the charge counters."] = "设定计数器的文字大小."

L["Name Size"] = "名字大小"
L["Set the text size for the target name."] = "设定目标名字的文字大小."

------------------------------------------------------------------------

L["Colors"] = "颜色"
L["Set the color for the %s charge counter."] = "设定 %s 计数器的颜色."

L["Active"] = "激活"
L["Set the color for the target name while your %s is active."] = "设定当你的 %s 已激活时目标名字的颜色."

L["Overwritten"] = "覆盖"
L["Set the color for the target name when your %s has been overwritten."] = "设定当你的 %s 被其他人覆盖时目标名字的颜色"

L["Inactive"] = "未激活"
L["Set the color for expired, dispelled, or otherwise inactive shields."] = "设定当你的护盾过期，被驱散或者其他未被激活的情况下的颜色."

L["Colorblind Mode"] = USE_COLORBLIND_MODE -- Leave this as-is unless there is something wrong with Blizzard's translation in your locale
L["Add asterisks around the target name when your %s has been overwritten, in addition to changing the color."] = "当你的 %s 被其他人覆盖时除了改变颜色外, 还为目标名字增加 * 号."

------------------------------------------------------------------------

L["Alerts"] = "警报"
L["Use these settings to configure how ShieldsUp alerts you when a shield expires or is removed."] = "使用这些警报来配置当一个护盾过期或者被移除时发出 ShieldsUp 警报."

L["Text Alert"] = "文字警报"
L["Show a text message when %s expires."] = "当 %s 到期时显示一个文本讯息."

L["Sound Alert"] = "音效警报"
L["Play a sound when %s expires."] = "当 %s 到期时播放一个音效警报."

L["Sound File"] = "音效文件"
L["Select the sound to play when %s expires."] = "选择当 %s 到期时音效警报的文件"

L["Text Output"] = "文字输出"

------------------------------------------------------------------------

L["Visibility"] = "能见度"
L["Enable"] = "开启"
L["Use these settings to control when the ShieldsUp display should be shown or hidden."] = "使用这些设定来控制 ShieldsUp 什么时候显示或隐藏."

L["Group Size"] = "队伍大小"
L["Solo"] = "独自战斗"
L["Show the display while you are not in a group"] = "当你不在一个队伍时显示"
L["Party"] = "小队"
L["Show the display while you are in a party group"] = "当你在一个小队时显示"
L["Raid"] = "团队"
L["Show the display while you are in a raid group"] = "当你在团队时显示"

L["Zone Type"] = "区域类型"
L["World"] = "户外"
L["Show the display while you are in the outdoor world"] = "当你在户外世界时显示."
L["Party Dungeon"] = "小队副本"
L["Show the display while you are in a party dungeon"] = "当你在小队副本时显示."
L["Raid Dungeon"] = "团队副本"
L["Show the display while you are in a raid dungeon"] = "当你在团队副本时显示"
L["Arena"] = "竞技场"
L["Show the display while you are in a PvP arena"] = "当你在一个PvP竞技场时显示"
L["Battleground"] = "战场"
L["Show the display while you are in a PvP battleground"] = "当你在一个PvP战场时显示."

L["Exceptions"] = "排除"
L["Dead"] = "死亡"
L["Hide the display while you are dead"] = "当你死亡时隐藏"
L["Out Of Combat"] = "脱离战斗状态"
L["Hide the display while you are out of combat"] = "当你脱离战斗状态时隐藏"
L["Resting"] = "休息状态"
L["Hide the display while you are in an inn or major city"] = "当你在旅馆或者在主城时隐藏"
L["Vehicle"] = "载具"
L["Hide the display while you are controlling a vehicle"] = "当你正在控制一个载具时隐藏"

------------------------------------------------------------------------