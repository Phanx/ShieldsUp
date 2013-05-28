--[[--------------------------------------------------------------------
	ShieldsUp
	Text-based shaman shield monitor.
	Copyright (c) 2008-2013 Phanx <addons@phanx.net>. All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info9165-ShieldsUp.html
	http://www.curse.com/addons/wow/shieldsup
------------------------------------------------------------------------
	Korean localization
	Last updated 2012-02-18 by moom21
	***
	***
----------------------------------------------------------------------]]

local _, private = ...
if private.UNLOAD or GetLocale() ~= "koKR" then return end

local L = private.L

--L.Active = "Active"
--L.Active_Desc = "Set the color for the target name when your %s is active."
--L.AlertOverwritten = "Alert on overwrites"
--L.AlertOverwritten_Desc = "Also alert when someone overwrites your %s."
L.Alerts = "알라미"
L.Alerts_Desc = "방어막이 만료 또는 제거되었을 때 경고를하는 방법 최대 보호막 구성하려면이 설정을 사용하십시오."
L.AlertSound = "경보 소리"
L.AlertSound_Desc = "%s 은이 만료되면 재생할 사운드를 선택합니다."
L.AlertText = "텍스트 경고"
L.AlertText_Desc = "%s 은이 만료되면 문자 메시지를 표시합니다."
L.AlertTextSink = "텍스트 출력"
--L.Bottom = "Bottom"
--L.ClassColor = "Use class color"
--L.ClassColor_Desc = "Color the target name by class when your %s is active."
--L.ClickForOptions = "Click for options."
--L.Colors = "Colors"
--L.CounterSize = "Counter text size"
--L.Font = "Font"
--L.Hide = "Hide when:"
--L.HideDead = "Dead"
--L.HideInfinite = "Hide infinite shields"
--L.HideInfinite_Desc = "Hide the letter indicator for active shields that don't have a limited number of charges. Missing shields will still be shown."
--L.HideOOC = "Out of combat"
--L.HideResting = "Resting"
--L.HideVehicle = "In a vehicle"
--L.Hidden = "Hidden"
L.LightningAbbrev = "번개"
--L.Missing = "Missing"
--L.Missing_Desc = "Set the color to use for missing shields."
--L.NamePosition = "Target name position"
--L.NameSize = "Name text size"
--L.None = "None"
--L.Opacity = "Opacity"
--L.OptionsDesc = "Use these options to control the appearance of the ShieldsUp display."
--L.Outline = "Outline"
--L.Overwritten = "Overwritten"
--L.Overwritten_Desc = "Set the color for the target name when your %s has been overwritten."
--L.OverwrittenBy = "Your %1$s has been overwritten by %2$s!"
--L.PaddingH = "Horizontal padding"
--L.PaddingH_Desc = "Change the padding between the two shield counters."
L.PaddingV = "수직 여백"
--L.PaddingV_Desc = "Change the padding between the shield counters and the target name."
--L.PositionX = "Horizontal position"
L.PositionY = "수직 위치"
--L.Shadow = "Shadow"
--L.ShieldFaded = "%s faded!"
--L.ShieldFadedFrom = "%1$s faded from %2$s!"
--L.Show = "Show in:"
L.ShowArena = "투기장"
L.ShowBattleground = "전쟁터"
L.ShowParty = "파티"
L.ShowRaid = "공격대"
L.ShowSolo = "만료"
--L.Thick = "Thick"
--L.Thin = "Thin"
--L.Top = "Top"
L.Visibility = "시정"
L.Visibility_Desc = "최대 보호막을 표시하거나 숨길 수 있어야 할 때 제어하기 위해이 설정을 사용하십시오."
L.WaterAbbrev = "물"
L.YOU = "당신"