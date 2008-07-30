--[[
	ShieldsUp: a shaman shield monitor
	by Phanx < addons AT phanx net>
	http://www.wowinterface.com/downloads/info9165-ShieldsUp.html
	http://www.curse.com/downloads/details/13180/

	See the included README.TXT for license and additional information.
--]]

if not ShieldsUp then return end
if not (GetRealmName() == "Sargeras" and UnitName("player") == "Bherasha") then return end

local ShieldsUp = ShieldsUp
local SharedMedia = LibStub("LibSharedMedia-3.0", true)
local Sink = LibStub("LibSink-2.0", true)
local tekHeading = LibStub("tekKonfig-Heading")
local tekCheck = LibStub("tekKonfig-Checkbox")
local xSlider = LibStub("xConfig-Slider")

local frame = CreateFrame("Frame", "ShieldsUpConfig", UIParent)
frame.name = GetAddOnMetadata("ShieldsUp", "Title")
frame:SetScript("OnShow", function(self)
	local db, L = ShieldsUpDB, ShieldsUp.L

	local title, notes = tekHeading.new(self, self.name, GetAddOnMetadata("ShieldsUp", "Notes"))

	local max_width = math.floor(UIParent:GetWidth() / 3)
	local max_height = math.floor(UIParent:GetHeight() / 3)

	local x = xSlider.new(self, L["Horizontal Position"], -max_width, max_width, 0.05, "TOPLEFT", notes, "BOTTOMLEFT", -3, -8)
	x.tip = L["Set the horizontal offset from the center of the screen"]
	x.slider:SetValue(floor(db.x + 0.05))
	x.current:SetText(db.x)
	x.func = function(v)
		db.x = v
		ShieldsUp:SetPoint("CENTER", db.x, db.y)
	end

	local y = xSlider.new(self, L["Horizontal Position"], -max_width, max_width, 0.05, "TOPLEFT", x, "TOPRIGHT", 8, 0)
	y.tip = L["Set the horizontal offset from the center of the screen"]
	y.slider:SetValue(floor(db.x + 0.05))
	y.current:SetText(db.x)
	y.func = function(v)
		db.y = v
		ShieldsUp:SetPoint("CENTER", db.x, db.y)
	end

	local h = xSlider.new(self, L["Horizontal Spacing"], 0, max_width * 2, 10, "TOPLEFT", y, "BOTTOMLEFT", 0, -8)
	h.tip = L["Set the horizontal distance between text elements"]
	h.slider:SetValue(floor(db.h + 0.05))
	h.current:SetText(db.h)
	h.func = function(v)
		db.h = v
		ShieldsUp:ApplySettings()
	end

	local v = xSlider.new(self, L["Vertical Spacing"], 0, max_heigh * 2, 10, "TOPLEFT", h, "BOTTOMLEFT", 0, -8)
	v.tip = L["Set the horizontal distance between text elements"]
	v.slider:SetValue(floor(db.v + 0.05))
	v.current:SetText(db.v)
	v.func = function(v)
		db.v = v
		ShieldsUp:ApplySettings()
	end

	local a = xSlider.new(self, L["Transparency"], 0.05, 1, 0.5, "TOPLEFT", h, "BOTTOMLEFT", 0, -8)
	a.isPercent = true
	a.tip = L["Set the transparency level"]
	a.slider:SetValue(floor(db.a + 0.05))
	a.current:SetText(db.a)
	a.func = function(v)
		db.alpha = v
		ShieldsUp:SetAlpha(v)
	end

	self:SetScript("OnShow", nil)
end)
ShieldsUp.configFrame = frame
InterfaceOptions_AddCategory(frame)

local frame2 = CreateFrame("Frame", nil, UIParent)
frame2.name = "Colors"
frame2.parent = frame.name
frame2:SetScript("OnShow", function(self)
	local db, L = ShieldsUpDB, ShieldsUp.L

	local title, notes = tekHeading.new(self, "Colors", "Configure the colors used for various states")

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
frame3.parent = frame.name
frame3:SetScript("OnShow", function(self)
	local db, L = ShieldsUpDB, ShieldsUp.L

	local title, notes = tekHeading.new(self, "Fonts", "Configure how you'd like the monitor fonts to look")

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
frame4.parent = frame.name
frame4:SetScript("OnShow", function(self)
	local db, L = ShieldsUpDB, ShieldsUp.L

	local title, notes = tekHeading.new(self, "Alerts", "Configure how you'd like to be alerted of lost shields")

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
frame5.parent = frame.name
frame5:SetScript("OnShow", function(self)
	local db, L = ShieldsUpDB, ShieldsUp.L

	local title, notes = tekHeading.new(self, "Show/Hide", "Configure when you'd like ShieldsUp to hide or show itself")

	-- enable

	-- group types

	-- instance types

	self:SetScript("OnShow", nil)
end)
InterfaceOptions_AddCategory(frame5)

LibStub("tekKonfig-AboutPanel").new("ShieldsUp", "ShieldsUp")

SLASH_SHIELDSUP1 = "/shieldsup"
SLASH_SHIELDSUP2 = "/sup"
SlashCmdList.SHIELDSUP = function()
	InterfaceOptionsFrame_OpenToFrame(ShieldsUp.configFrame)
end