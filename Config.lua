--[[
	ShieldsUp: a shaman shield monitor
	by Phanx < addons AT phanx net>
	http://wow.curseforge.com/projects/shieldsup
	http://www.wowinterface.com/downloads/info

	DO NOT include this addon in compilations or otherwise
	redistribute it without the consent of its author.

	See the included README.TXT file for more information.
--]]

if not ShieldsUp then return end

local ShieldsUp = ShieldsUp
local SharedMedia = LibStub("LibSharedMedia-3.0", true)
local Sink = LibStub("LibSink-2.0", true)
local config = xConfig

local frame = CreateFrame("Frame", "ShieldsUpConfig", UIParent)
frame.name = GetAddOnMetadata("ShieldsUp", "Title")
frame:SetScript("OnShow", function(self)
	local db, L = ShieldsUpDB, ShieldsUp.L

	local title, notes = config.CreateHeading(self, self.name, GetAddOnMetadata("ShieldsUp", "Notes"))

	local max_width = math.floor(UIParent:GetWidth() / 3)
	local max_height = math.floor(UIParent:GetHeight() / 3)

	-- x
	local x = config.CreateSlider(self, L["Horizontal Position"], -max_width, max_width, 0.05, "TOPLEFT", notes, "BOTTOMLEFT", -3, -8)
	x.tip = L["Set the horizontal offset from the center of the screen"]
	x.slider:SetValue(floor(db.x + 0.05))
	x.current:SetText(db.x)
	x.func = function(v)
		db.x = v
		ShieldsUp:SetPoint("CENTER", db.x, db.y)
	end

	-- y
	local y = config.CreateSlider(self, L["Horizontal Position"], -max_width, max_width, 0.05, "TOPLEFT", x, "TOPRIGHT", 8, 0)
	y.tip = L["Set the horizontal offset from the center of the screen"]
	y.slider:SetValue(floor(db.x + 0.05))
	y.current:SetText(db.x)
	y.func = function(v)
		db.y = v
		ShieldsUp:SetPoint("CENTER", db.x, db.y)
	end

	-- h
	local y = config.CreateSlider(self, L["Horizontal Spacing"], 0, max_width, 10, "TOPLEFT", x, "BOTTOMLEFT", 0, -8)
	h.tip = L["Set the horizontal distance between text elements"]
	h.slider:SetValue(floor(db.x + 0.05))
	h.current:SetText(db.x)
	h.func = function(v)
		db.h = v
		ShieldsUp:SetPoint("CENTER", db.x, db.y)
	end

	-- v

	-- a

	self:SetScript("OnShow", nil)
end)
Feeder.configpanel = frame
InterfaceOptions_AddCategory(frame)

local frame2 = CreateFrame("Frame", nil, UIParent)
frame2.name = "Colors"
frame2.parent = frame
frame2:SetScript("OnShow", function(self)
	local title, notes = tekHeading.new("Colors", "Configure the colors used for various states")

	-- normal (default: white)

	-- overwritten (default: yellow)

	-- alert (default: red)

	-- earth (default: brown)

	-- water (default: blue)

	self:SetScript("OnShow", nil)
end)
InterfaceOptions_AddCategory(frame2)

local frame3 = CreateFrame("Frame", nil, UIParent)
frame3.name = "Fonts"
frame3.parent = frame
frame3:SetScript("OnShow", function(self)
	local title, notes = tekHeading.new("Fonts", "Configure how you'd like the monitor fonts to look")

	-- large size

	-- small size

	-- face

	-- outline

	-- shadow

	self:SetScript("OnShow", nil)
end)
InterfaceOptions_AddCategory(frame3)

local frame4 = CreateFrame("Frame", nil, UIParent)
frame4.name = "Alerts"
frame4.parent = frame
frame4:SetScript("OnShow", function(self)
	local title, notes = tekHeading.new("Alerts", "Configure how you'd like to be alerted of lost shields")

	-- earth text

	-- earth sound

	-- earth sound file

	-- water text

	-- water sound

	-- water sound file

	-- sink output (some magic needed here)

	self:SetScript("OnShow", nil)
end)
InterfaceOptions_AddCategory(frame4)

local frame5 = CreateFrame("Frame", nil, UIParent)
frame5.name = "Show/Hide"
frame5.parent = frame
frame5:SetScript("OnShow", function(self)
	local title, notes = tekHeading.new("Fonts", "Configure when you'd like ShieldsUp to hide or show itself")

	-- enable

	-- group types

	-- instance types

	self:SetScript("OnShow", nil)
end)
InterfaceOptions_AddCategory(frame5)

LibStub("tekKonfig-AboutPanel").new("ShieldsUp", "ShieldsUp")

SLASH_SHIELDSUP1 = "/shieldsup"
SLASH_SHIELDSUP2 = "/sup
SlashCmdList.SHIELDSUP = function()
	InterfaceOptionsFrame_OpenToFrame(frame.name)
end