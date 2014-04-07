--[[--------------------------------------------------------------------
	ShieldsUp
	Text-based shaman shield monitor.
	Copyright (c) 2008-2014 Phanx <addons@phanx.net>. All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info9165-ShieldsUp.html
	http://www.curse.com/addons/wow/shieldsup
------------------------------------------------------------------------
	Traditional Chinese localization
	Last updated 2012-08-30 by awaited @ CurseForge
	Previous contributors: wowuicn
----------------------------------------------------------------------]]

local _, private = ...
if private.UNLOAD or GetLocale() ~= "zhTW" then return end

local L = private.L

L.Active = "激活"
L.Active_Desc = "設定當你的 %s 已激活時目標名字的顏色。"
L.AlertOverwritten = "被覆蓋時提示"
L.AlertOverwritten_Desc = "當%s被其他薩滿覆蓋時提示。"
L.Alerts = "警報"
L.Alerts_Desc = "使用這些警報來配置當一個護盾過期或者被移除時發出 ShieldsUp 警報。"
L.AlertSound = "音效警報"
L.AlertSound_Desc = "選擇當 %s 到期時音效警報的檔案。"
L.AlertText = "文字警報"
L.AlertText_Desc = "當 %s 到期時顯示一個文本訊息。"
L.AlertTextSink = "文字輸出"
--L.AlertWhileHidden = "Alert while hidden"
--L.AlertWhileHidden_Desc = "Show alert messages and play alert sounds while ShieldsUp is hidden due to your visibility settings."
L.Bottom = "下"
L.ClassColor = "啟用職業顏色"
L.ClassColor_Desc = "當 %s 作用時以職業顏色顯示目標名稱。"
L.ClickForOptions = "點擊 開啟選單。"
L.Colors = "顏色"
L.CounterSize = "計數器大小"
L.Font = "字型"
--L.HiddenLowLevel = "|cffffd100ATTENTION:|r Regardless of your settings above, ShieldsUp is currently hidden because your character's level is too low. Once you reach Level 8 and learn Lightning Shield, ShieldsUp will show and hide normally."
L.Hide = "排除"
L.HideDead = "死亡"
--L.HideInfinite = "Hide infinite shields"
--L.HideInfinite_Desc = "Hide the letter indicator for active shields that don't have a limited number of charges. Missing shields will still be shown."
L.HideOOC = "脫離戰斗狀態"
L.HideResting = "休息狀態"
L.HideVehicle = "載具"
L.Hidden = "隱"
L.LightningAbbrev = "閃"
L.Missing = "未激活"
L.Missing_Desc = "設定當你的護盾過期，被驅散或者其他未被激活的情況下的顏色。"
L.NamePosition = "名字位置"
L.NameSize = "名字大小"
L.None = "無"
L.Opacity = "不透明度"
--L.OptionsDesc = "Use these options to control the appearance of the ShieldsUp display."
L.Outline = "描邊"
L.Overwritten = "覆蓋"
L.Overwritten_Desc = "設定當你的 %s 被其他人覆蓋時目標名字的顏色。"
--L.OverwrittenBy = "Your %1$s has been overwritten by %2$s!"
L.PaddingH = "水平間距"
L.PaddingH_Desc = "設定計數器的水平距離。"
L.PaddingV = "垂直間距"
L.PaddingV_Desc = "設定目標名字和計數器的垂直距離。"
L.PositionX = "水平位置"
L.PositionY = "垂直位置"
L.Shadow = "陰影效果"
L.ShieldFaded = "%s 已消失!"
L.ShieldFadedFrom = "%1$s 在 %2$s 上消失!"
--L.Show = "Show in:"
L.ShowArena = "競技場"
L.ShowBattleground = "戰場"
L.ShowParty = "小隊"
L.ShowRaid = "團隊"
L.ShowSolo = "獨自戰斗"
L.Thick = "細描邊"
L.Thin = "粗描邊"
L.Top = "上"
L.Visibility = "能見度"
L.Visibility_Desc = "使用這些設定來控制 ShieldsUp 什么時候顯示或隱藏。"
L.WaterAbbrev = "水"
L.YOU = "自身"