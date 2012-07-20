--[[--------------------------------------------------------------------
	ShieldsUp
	Text-based shaman shield monitor.
	Copyright (c) 2008-2012 Phanx <addons@phanx.net>. All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info9165-ShieldsUp.html
	http://www.curse.com/addons/wow/shieldsup
------------------------------------------------------------------------
	Korean (한국어)
	Last updated 2012-02-18 by moom21 on CurseForge
----------------------------------------------------------------------]]

if GetLocale() ~= "koKR" or select(2, UnitClass("player")) ~= "SHAMAN" then return end

local _, namespace = ...
namespace.L = {

------------------------------------------------------------------------
-- These strings are displayed when shields expire.

--	["%s faded!"] = "",
--	["%s faded from %s!"] = "",
	["YOU"] = "당신",

------------------------------------------------------------------------
-- These strings are displayed in the configuration GUI.

--	["Click for options."] = "",

--	["ShieldsUp is a simple monitor for your shaman shields. Use these settings to configure the addon's appearance and behavior."] = "",

--	["Horizontal Position"] = "",
--	["Set the horizontal distance from the center of the screen to place the display."] = "",

	["Vertical Position"] = "수직 위치",
--	["Set the vertical distance from the center of the screen to place the display."] = "",

--	["Horizontal Padding"] = "",
--	["Set the horizontal space between the charge counters."] = "",

	["Vertical Padding"] = "수직 여백",
--	["Set the vertical space between the target name and charge counters."] = "",

--	["Opacity"] = "",
--	["Set the opacity level for the display."] = "",

--	["Overwrite Alert"] = "",
--	["Print a message in the chat frame alerting you who overwrites your %s."] = "",

------------------------------------------------------------------------

--	["Font Face"] = "",
--	["Set the font face to use for the display text."] = "",

--	["Outline"] = "",
--	["Select an outline width for the display text."] = "",
--	["None"] = "",
--	["Thin"] = "",
--	["Thick"] = "",

--	["Shadow"] = "",
--	["Add a drop shadow effect to the display text."] = "",

--	["Counter Size"] = "",
--	["Set the text size for the charge counters."] = "",

--	["Name Size"] = "",
--	["Set the text size for the target name."] = "",

------------------------------------------------------------------------

--	["Colors"] = "",
--	["Set the color for the %s charge counter."] = "",

--	["Active"] = "",
--	["Set the color for the target name while your %s is active."] = "",

--	["Overwritten"] = "",
--	["Set the color for the target name when your %s has been overwritten."] = "",

--	["Inactive"] = "",
--	["Set the color for expired, dispelled, or otherwise inactive shields."] = "",

	["Colorblind Mode"] = USE_COLORBLIND_MODE, -- Leave this as-is unless there is something wrong with Blizzard's translation in your locale
--	["Add asterisks around the target name when your %s has been overwritten, in addition to changing the color."] = "",

------------------------------------------------------------------------

	["Alerts"] = "알라미",
	["Use these settings to configure how ShieldsUp alerts you when a shield expires or is removed."] = "방어막이 만료 또는 제거되었을 때 경고를하는 방법 최대 보호막 구성하려면이 설정을 사용하십시오.",

	["Text Alert"] = "텍스트 경고",
	["Show a text message when %s expires."] = "% s은이 만료되면 문자 메시지를 표시합니다.",

	["Sound Alert"] = "경보 소리",
	["Play a sound when %s expires."] = "%s 은이 만료 사운드를 재생합니다.",

	["Sound File"] = "사운드 파일",
	["Select the sound to play when %s expires."] = "%s 은이 만료되면 재생할 사운드를 선택합니다.",

	["Text Output"] = "텍스트 출력",

------------------------------------------------------------------------

	["Visibility"] = "시정",
	["Use these settings to control when ShieldsUp should be shown or hidden."] = "최대 보호막을 표시하거나 숨길 수 있어야 할 때 제어하기 위해이 설정을 사용하십시오.",
	["Enable"] = "활성화",

	["Group Size"] = "그룹 크기",
	["Solo"] = "만료",
	["Show the display while you are not in a group"] = "당신이 그룹에없는 동안 디스플레이를 표시.",
	["Party"] = "파티",
	["Show the display while you are in a party group"] = "당신은 파티 그룹에있는 동안 디스플레이를 표시.",
	["Raid"] = "공격대",
	["Show the display while you are in a raid group"] = "당신의 공격대 그룹에있는 동안 디스플레이를 표시.",

--	["Zone Type"] = "",
--	["World"] = "",
--	["Show the display while you are in the outdoor world"] = "",
	["Dungeon"] = "던전",
	["Show the display while you are in a party dungeon"] = "당신은 파티 던전에있는 동안 디스플레이를 표시.",
	["Raid Dungeon"] = "레이드 던전",
	["Show the display while you are in a raid dungeon"] = "당신은 공격대 던전에있는 동안 디스플레이를 표시.",
	["Arena"] = "투기장",
	["Show the display while you are in a PvP arena"] = "당신 PVP 경기장에있는 동안 디스플레이를 표시.",
	["Battleground"] = "전쟁터",
	["Show the display while you are in a PvP battleground"] = "당신은 PVP의 전쟁터에있는 동안 디스플레이를 표시.",

--	["Exceptions"] = "",
--	["Dead"] = "",
--	["Hide the display while you are dead"] = "",
--	["Out Of Combat"] = "",
--	["Hide the display while you are out of combat"] = "",
--	["Resting"] = "",
--	["Hide the display while you are in an inn or major city"] = "",
--	["Vehicle"] = "",
--	["Hide the display while you are controlling a vehicle"] = "",

------------------------------------------------------------------------

}