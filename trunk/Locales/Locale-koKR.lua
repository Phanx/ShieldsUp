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
	["L"] = "번개",
	["W"] = "물",

	--["%s faded!"] = "",
	--["%1$s faded from %2$s!"] = "",
	["YOU"] = "당신",

	--["Click for options."] = "",

	--["ShieldsUp is a monitor for your shaman shields. These settings allow you to customize the addon's appearance and behavior."] = "",
	--["Horizontal Position"] = "",
	--["Move the display left or right relative to the center of the screen."] = "",
	["Vertical Position"] = "수직 위치",
	--["Move the display up or down relative to the center of the screen."] = "",
	--["Horizontal Padding"] = "",
	--["Change the horizontal distance between the charge counters."] = "",
	["Vertical Padding"] = "수직 여백",
	--["Change the vertical distance between the charge counters and the target name."] = "",
	--["Opacity"] = "",
	--["Change the opacity of the display."] = "",

	--["Font"] = "",
	--["Change the font used for the display text."] = "",
	--["Text Outline"] = "",
	--["Choose an outline weight for the display text."] = "",
	--["None"] = "",
	--["Thin"] = "",
	--["Thick"] = "",
	--["Counter Size"] = "",
	--["Change the size of the counter text."] = "",
	--["Name Size"] = "",
	--["Change the size of the name text."] = "",
	--["Shadow"] = "",
	--["Add a drop shadow effect to the display text."] = "",
	--["Use Class Color"] = "",
	--["Color the target name by class color when your %s is active."] = "",

	--["Colors"] = "",
	--["Set the color for the %s charge counter."] = "",
	--["Active"] = "",
	--["Set the color for the target name while your %s is active."] = "",
	--["Overwritten"] = "",
	--["Set the color for the target name when your %s has been overwritten."] = "",
	--["Inactive"] = "",
	--["Set the color for expired, dispelled, or otherwise inactive shields."] = "",

	["Alerts"] = "알라미",
	["These settings allow you to customize how ShieldsUp alerts you when a shield expires or is removed."] = "방어막이 만료 또는 제거되었을 때 경고를하는 방법 최대 보호막 구성하려면이 설정을 사용하십시오.",
	["Text Alert"] = "텍스트 경고",
	["Show a message when your %s expires or is removed."] = "%s 은이 만료되면 문자 메시지를 표시합니다.",
	["Sound Alert"] = "경보 소리",
	["Play a sound when your %s expires or is removed."] = "%s 은이 만료 사운드를 재생합니다.",
	["Sound File"] = "사운드 파일",
	["Choose the sound to play when your %s expires or is removed."] = "%s 은이 만료되면 재생할 사운드를 선택합니다.",
	--["Alert When Overwritten"] = "",
	--["Also alert when another shaman overwrites your %s."] = "",

	["Text Output"] = "텍스트 출력",

	["Visibility"] = "시정",
	["These settings allow you to customize when the ShieldsUp display is shown."] = "최대 보호막을 표시하거나 숨길 수 있어야 할 때 제어하기 위해이 설정을 사용하십시오.",

	["Show in group types:"] = "그룹 크기",
	["Solo"] = "만료",
	["Show the display while you are not in a group."] = "당신이 그룹에없는 동안 디스플레이를 표시.",
	["Party"] = "파티",
	["Show the display while you are in a party."] = "당신은 파티 그룹에있는 동안 디스플레이를 표시.",
	["Raid"] = "공격대",
	["Show the display while you are in a raid."] = "당신의 공격대 그룹에있는 동안 디스플레이를 표시.",

	--["Show in zone types:"] = "",
	--["World"] = "",
	--["Show the display while you are in the outdoor world."] = "",
	["Dungeon"] = "던전",
	["Show the display while you are in a dungeon."] = "당신은 파티 던전에있는 동안 디스플레이를 표시.",
	["Raid Instance"] = "레이드 던전",
	["Show the display while you are in a raid instance."] = "당신은 공격대 던전에있는 동안 디스플레이를 표시.",
	["Arena"] = "투기장",
	["Show the display while you are in a PvP arena."] = "당신 PVP 경기장에있는 동안 디스플레이를 표시.",
	["Battleground"] = "전쟁터",
	["Show the display while you are in a PvP battleground."] = "당신은 PVP의 전쟁터에있는 동안 디스플레이를 표시.",

	--["Hide when:"] = "",
	--["Dead"] = "",
	--["Hide the display while you are dead."] = "",
	--["Out of Combat"] = "",
	--["Hide the display while you are out of combat."] = "",
	--["Resting"] = "",
	--["Hide the display while you are in an inn or major city."] = "",
	--["Vehicle"] = "",
	--["Hide the display while you are controlling a vehicle."] = "",
}