--[[--------------------------------------------------------------------
	ShieldsUp
	Text-based shaman shield monitor.
	by Phanx < addons@phanx.net >
	Copyright © 2008–2010 Phanx. Some rights reserved. See LICENSE.txt for details.
	http://www.wowinterface.com/downloads/info9165-ShieldsUp.html
	http://www.curse.com/downloads/wow-addons/details/shieldsup.aspx
------------------------------------------------------------------------
	Localization for zhTW / Traditional Chinese / 正體中文
	Last updated 2009-07-15 by www.wowui.cn
----------------------------------------------------------------------]]

if GetLocale() ~= "zhTW" or select(2, UnitClass("player")) ~= "SHAMAN" then return end

local L = { }
local ADDON_NAME, namespace = ...
namespace.L = L

------------------------------------------------------------------------
-- These strings are displayed when shields expire.

L["%s faded!"] = "%s 已消失"
L["%s faded from %s!"] = "%s 在 %s 上消失!"
L["YOU"] = "自身"

------------------------------------------------------------------------
-- These strings are displayed in the configuration GUI.

L["ShieldsUp is a monitor for your shaman shields. Use these settings to configure the addon's appearance and behavior."] = "ShieldsUp是一個薩滿護盾的監視器。使用這些設定來配置插件的外觀和行為."

L["Horizontal Position"] = "水平位置"
L["Set the horizontal distance from the center of the screen to place the display."] = "設定插件顯示的相對于屏幕中間的水平位置."

L["Vertical Position"] = "垂直位置"
L["Set the vertical distance from the center of the screen to place the display."] = "設定插件顯示的相對于屏幕中間的水平位置."

L["Horizontal Padding"] = "水平間距"
L["Set the horizontal space between the charge counts."] = "設定計數器的水平距離."

L["Vertical Padding"] = "垂直間距"
L["Set the vertical space between the target name and charge counters."] = "設定目標名字和計數器的垂直距離."

L["Opacity"] = "不透明度"
L["Set the opacity level for the display."] = "設定顯示的不透明度等級."

-- L["Overwrite Alert"] = ""
-- L["Print a message in the chat frame alerting you who overwrites your %s."] = ""

------------------------------------------------------------------------

L["Font Face"] = "字型"
L["Set the font face to use for the display text."] = "設定顯示文字的字型."

L["Outline"] = "描邊"
L["Select an outline width for the display text."] = "設定顯示文字的描邊寬度"
L["None"] = "無"
L["Thin"] = "細描邊"
L["Thick"] = "粗描邊"

L["Shadow"] = "陰影效果"
L["Add a drop shadow effect to the display text."] = "為顯示文字增加一個陰影效果."

L["Counter Size"] = "計數器大小"
L["Set the text size for the charge counters."] = "設定計數器的文字大小."

L["Name Size"] = "名字大小"
L["Set the text size for the target name."] = "設定目標名字的文字大小."

------------------------------------------------------------------------

L["Colors"] = "顏色"
L["Set the color for the %s charge counter."] = "設定 %s 計數器的顏色."

L["Active"] = "激活"
L["Set the color for the target name while your %s is active."] = "設定當你的 %s 已激活時目標名字的顏色."

L["Overwritten"] = "覆蓋"
L["Set the color for the target name when your %s has been overwritten."] = "設定當你的 %s 被其他人覆蓋時目標名字的顏色"

L["Inactive"] = "未激活"
L["Set the color for expired, dispelled, or otherwise inactive shields."] = "設定當你的護盾過期，被驅散或者其他未被激活的情況下的顏色."

L["Colorblind Mode"] = USE_COLORBLIND_MODE -- Leave this as-is unless there is something wrong with Blizzard's translation in your locale
L["Add asterisks around the target name when your %s has been overwritten, in addition to changing the color."] = "當你的 %s 被其他人覆蓋時除了改變顏色外, 還為目標名字增加 * 號."

------------------------------------------------------------------------

L["Alerts"] = "警報"
L["Use these settings to configure how ShieldsUp alerts you when a shield expires or is removed."] = "使用這些警報來配置當一個護盾過期或者被移除時發出 ShieldsUp 警報."

L["Text Alert"] = "文字警報"
L["Show a text message when %s expires."] = "當 %s 到期時顯示一個文本訊息."

L["Sound Alert"] = "音效警報"
L["Play a sound when %s expires."] = "當 %s 到期時播放一個音效警報."

L["Sound File"] = "音效檔案"
L["Select the sound to play when %s expires."] = "選擇當 %s 到期時音效警報的檔案"

L["Text Output"] = "文字輸出"

------------------------------------------------------------------------

L["Visibility"] = "能見度"
L["Enable"] = "開啟"
L["Use these settings to control when the ShieldsUp display should be shown or hidden."] = "使用這些設定來控制 ShieldsUp 什么時候顯示或隱藏."

L["Group Size"] = "隊伍大小"
L["Solo"] = "獨自戰斗"
L["Show the display while you are not in a group"] = "當你不在一個隊伍時顯示"
L["Party"] = "小隊"
L["Show the display while you are in a party group"] = "當你在一個小隊時顯示"
L["Raid"] = "團隊"
L["Show the display while you are in a raid group"] = "當你在團隊時顯示"

L["Zone Type"] = "區域類型"
L["World"] = "戶外"
L["Show the display while you are in the outdoor world"] = "當你在戶外世界時顯示."
L["Party Dungeon"] = "地城"
L["Show the display while you are in a party dungeon"] = "當你在小隊地城時顯示."
L["Raid Dungeon"] = "團隊副本"
L["Show the display while you are in a raid dungeon"] = "當你在團隊副本時顯示"
L["Arena"] = "競技場"
L["Show the display while you are in a PvP arena"] = "當你在一個PvP競技場時顯示"
L["Battleground"] = "戰場"
L["Show the display while you are in a PvP battleground"] = "當你在一個PvP戰場時顯示."

L["Exceptions"] = "排除"
L["Dead"] = "死亡"
L["Hide the display while you are dead"] = "當你死亡時隱藏"
L["Out Of Combat"] = "脫離戰斗狀態"
L["Hide the display while you are out of combat"] = "當你脫離戰斗狀態時隱藏"
L["Resting"] = "休息狀態"
L["Hide the display while you are in an inn or major city"] = "當你在旅館或者在主城時隱藏"
L["Vehicle"] = "載具"
L["Hide the display while you are controlling a vehicle"] = "當你正在控制一個載具時隱藏"

------------------------------------------------------------------------