--[[--------------------------------------------------------------------
	ShieldsUp
	Text-based shaman shield monitor.
	Copyright (c) 2008-2014 Phanx <addons@phanx.net>. All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info9165-ShieldsUp.html
	http://www.curse.com/addons/wow/shieldsup
------------------------------------------------------------------------
	Simplified Chinese localization
	Last updated 2009-07-15 by wowuicn
	***
----------------------------------------------------------------------]]

local _, private = ...
if private.UNLOAD or GetLocale() ~= "zhCN" then return end

local L = private.L

L.Active = "激活"
L.Active_Desc = "设定当你的 %s 已激活时目标名字的颜色。"
--L.AlertOverwritten = "Alert on overwrites"
--L.AlertOverwritten_Desc = "Also alert when someone overwrites your %s."
L.Alerts = "警报"
L.Alerts_Desc = "使用这些警报来配置当一个护盾过期或者被移除时发出 ShieldsUp 警报。"
L.AlertSound = "音效警报"
L.AlertSound_Desc = "选择当 %s 到期时音效警报的文件。"
L.AlertText = "文字警报"
L.AlertText_Desc = "当 %s 到期时显示一个文本讯息。"
L.AlertTextSink = "文字输出"
--L.AlertWhileHidden = "Alert while hidden"
--L.AlertWhileHidden_Desc = "Show alert messages and play alert sounds while ShieldsUp is hidden due to your visibility settings."
L.Bottom = "底部"
--L.ClassColor = "Use class color"
--L.ClassColor_Desc = "Color the target name by class when your %s is active."
--L.ClickForOptions = "Click for options."
L.Colors = "颜色"
L.CounterSize = "计数器大小"
L.Font = "字体"
--L.HiddenLowLevel = "|cffffd100ATTENTION:|r Regardless of your settings above, ShieldsUp is currently hidden because your character's level is too low. Once you reach Level 8 and learn Lightning Shield, ShieldsUp will show and hide normally."
L.Hide = "排除"
L.HideDead = "死亡"
--L.HideInfinite = "Hide infinite shields"
--L.HideInfinite_Desc = "Hide the letter indicator for active shields that don't have a limited number of charges. Missing shields will still be shown."
L.HideOOC = "脱离战斗状态"
L.HideResting = "休息状态"
L.HideVehicle = "载具"
--L.Hidden = "Hidden"
L.LightningAbbrev = "闪"
L.Missing = "未激活"
L.Missing_Desc = "设定当你的护盾过期，被驱散或者其他未被激活的情况下的颜色。"
--L.NamePosition = "Target name position"
L.NameSize = "名字大小"
L.None = "无"
L.Opacity = "不透明度"
L.OptionsDesc = "ShieldsUp是一个萨满护盾的监视器。使用这些设定来配置插件的外观和行为。"
L.Outline = "描边"
L.Overwritten = "覆盖"
L.Overwritten_Desc = "设定当你的 %s 被其他人覆盖时目标名字的颜色。"
--L.OverwrittenBy = "Your %1$s has been overwritten by %2$s!"
L.PaddingH = "水平间距"
L.PaddingH_Desc = "设定计数器的水平距离。"
L.PaddingV = "垂直间距"
L.PaddingV_Desc = "设定目标名字和计数器的垂直距离。"
L.PositionX = "水平位置"
L.PositionY = "垂直位置"
L.Shadow = "阴影效果"
L.ShieldFaded = "%s 已消失!"
L.ShieldFadedFrom = "%1$s 在 %2$s 上消失"
--L.Show = "Show in:"
L.ShowArena = "竞技场"
L.ShowBattleground = "战场"
L.ShowParty = "小队"
L.ShowRaid = "团队"
L.ShowSolo = "独自战斗"
L.Thick = "粗"
L.Thin = "细"
L.Top = "顶部"
L.Visibility = "能见度"
L.Visibility_Desc = "使用这些设定来控制 ShieldsUp 什么时候显示或隐藏。"
L.WaterAbbrev = "水"
L.YOU = "自身"