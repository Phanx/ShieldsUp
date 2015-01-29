--[[--------------------------------------------------------------------
	ShieldsUp
	Text-based shaman shield monitor.
	Copyright (c) 2008-2015 Phanx <addons@phanx.net>. All rights reserved.
	http://www.wowinterface.com/downloads/info9165-ShieldsUp.html
	http://www.curse.com/addons/wow/shieldsup
----------------------------------------------------------------------]]
-- TODO: add name position dropdown, consider spacing max values

if select(2, UnitClass("player")) ~= "SHAMAN" then return end

local SHIELDSUP, ShieldsUp = ...
local L = ShieldsUp.L

local optionsPanels = {}
ShieldsUp.OptionsPanels = optionsPanels

optionsPanels[#optionsPanels + 1] = LibStub("PhanxConfig-OptionsPanel"):New(SHIELDSUP, nil, function(self)
	local db = ShieldsUpDB

	local UIWIDTH  = floor(UIParent:GetWidth()  / 10) * 5 - 40
	local UIHEIGHT = floor(UIParent:GetHeight() / 10) * 5 - 25

	local title, notes, version = self:CreateHeader(SHIELDSUP, true)
	notes:SetHeight(16)

	---------------------------------------------------------------------

	local offsetX = self:CreateSlider(L["Horizontal Position"], L["Relative to the center of the screen."], -UIWIDTH, UIWIDTH, 5)
	offsetX:SetPoint("TOPLEFT", notes, "BOTTOMLEFT", -4, -12)
	offsetX:SetPoint("TOPRIGHT", notes, "BOTTOM", -8, 12)
	function offsetX:OnValueChanged(value)
		db.offsetX = ((value / UIWIDTH) + 1) / 2
		ShieldsUp:RestorePosition()
	end

	local offsetY = self:CreateSlider(L["Vertical Position"], L["Relative to the center of the screen."], -UIHEIGHT, UIHEIGHT, 5)
	offsetY:SetPoint("TOPLEFT", offsetX, "BOTTOMLEFT", 0, -12)
	offsetY:SetPoint("TOPRIGHT", offsetX, "BOTTOMRIGHT", 0, -12)
	function offsetY:OnValueChanged(value)
		db.offsetY = ((value / UIHEIGHT) + 1) / 2
		ShieldsUp:RestorePosition()
	end

	local spacingX = self:CreateSlider(L["Horizontal Spacing"], nil, 0, 400, 1)
	spacingX:SetPoint("TOPLEFT", offsetY, "BOTTOMLEFT", 0, -12)
	spacingX:SetPoint("TOPRIGHT", offsetY, "BOTTOMRIGHT", 0, -12)
	function spacingX:OnValueChanged(value)
		db.spacingX = value
		ShieldsUp:ApplySettings()
	end

	local spacingY = self:CreateSlider(L["Vertical Spacing"], nil, 0, 100, 1)
	spacingY:SetPoint("TOPLEFT", spacingX, "BOTTOMLEFT", 0, -12)
	spacingY:SetPoint("TOPRIGHT", spacingX, "BOTTOMRIGHT", 0, -12)
	function spacingY:OnValueChanged(value)
		db.spacingY = value
		ShieldsUp:ApplySettings()
	end

	local opacity = self:CreateSlider(L["Opacity"], nil, 0.1, 1, 0.05, true)
	opacity:SetPoint("TOPLEFT", spacingY, "BOTTOMLEFT", 0, -12)
	opacity:SetPoint("TOPRIGHT", spacingY, "BOTTOMRIGHT", 0, -12)
	function opacity:OnValueChanged(value)
		db.alpha = value
		ShieldsUp:ApplySettings()
	end

	local lock = self:CreateCheckbox(L["Locked"])
	lock:SetPoint("TOPLEFT", opacity, "BOTTOMLEFT", 0, -12)
	function lock:OnValueChanged(value)
		ShieldsUp:LockDisplay(value)
	end

	---------------------------------------------------------------------

	local nameFont = self:CreateMediaDropdown(L["Name Font"], nil, "font")
	nameFont:SetPoint("TOPLEFT", notes, "BOTTOM", 8, -12)
	nameFont:SetPoint("TOPRIGHT", notes, "BOTTOMRIGHT", 0, -12)
	function nameFont:OnValueChanged(value)
		db.nameFont = value
		ShieldsUp:ApplySettings()
	end

	local nameSize = self:CreateSlider(L["Name Size"], nil, 6, 32, 1)
	nameSize:SetPoint("TOPLEFT", nameFont, "BOTTOMLEFT", 0, -12)
	nameSize:SetPoint("TOPRIGHT", nameFont, "BOTTOMRIGHT", 0, -12)
	function nameSize:OnValueChanged(value)
		db.nameSize = value
		ShieldsUp:ApplySettings()
	end

	local numberFont = self:CreateMediaDropdown(L["Number Font"], nil, "font")
	numberFont:SetPoint("TOPLEFT", nameSize, "BOTTOMLEFT", 0, -12)
	numberFont:SetPoint("TOPRIGHT", nameSize, "BOTTOMRIGHT", 0, -12)
	function numberFont:OnValueChanged(value)
		db.numberFont = value
		ShieldsUp:ApplySettings()
	end

	local numberSize = self:CreateSlider(L["Number Size"], nil, 6, 32, 1)
	numberSize:SetPoint("TOPLEFT", numberFont, "BOTTOMLEFT", 0, -12)
	numberSize:SetPoint("TOPRIGHT", numberFont, "BOTTOMRIGHT", 0, -12)
	function numberSize:OnValueChanged(value)
		db.numberSize = value
		ShieldsUp:ApplySettings()
	end

	local outline = self:CreateDropdown(L["Text Outline"], nil, {
		{ value = "NONE", text = L["None"] },
		{ value = "OUTLINE", text = L["Outline"] },
		{ value = "THICKOUTLINE", text = L["Thick Outline"] },
	})
	outline:SetPoint("TOPLEFT", numberSize, "BOTTOMLEFT", 0, -12)
	outline:SetPoint("TOPRIGHT", numberSize, "BOTTOMRIGHT", 0, -12)
	function outline:OnValueChanged(value)
		db.outline = value
		ShieldsUp:ApplySettings()
	end

	local shadow = self:CreateCheckbox(L["Text Shadow"])
	shadow:SetPoint("TOPLEFT", outline, "BOTTOMLEFT", 0, -12)
	function shadow:OnValueChanged(value)
		db.shadow = value
		ShieldsUp:ApplySettings()
	end

	---------------------------------------------------------------------

	local colorPanel = self:CreatePanel(L["Colors"])
	colorPanel:SetPoint("BOTTOMLEFT", 16, 16)
	colorPanel:SetPoint("BOTTOMRIGHT", -16, 16)

	local colorEarth = self.CreateColorPicker(colorPanel, L.EarthShield)
	colorEarth:SetPoint("TOPLEFT", colorPanel, 12, -12)
	function colorEarth:GetColor()
		local color = db.colors.earth
		return color.r, color.g, color.b
	end
	function colorEarth:OnValueChanged(r, g, b)
		db.colors.earth.r = r
		db.colors.earth.g = g
		db.colors.earth.b = b
		ShieldsUp:UpdateDisplay()
	end

	local colorLightning = self.CreateColorPicker(colorPanel, L.LightningShield)
	colorLightning:SetPoint("TOPLEFT", colorEarth, "BOTTOMLEFT", 0, -6)
	function colorLightning:GetColor()
		local color = db.colors.lightning
		return color.r, color.g, color.b
	end
	function colorLightning:OnValueChanged(r, g, b)
		db.colors.lightning.r = r
		db.colors.lightning.g = g
		db.colors.lightning.b = b
		ShieldsUp:UpdateDisplay()
	end

	local colorWater = self.CreateColorPicker(colorPanel, L.WaterShield)
	colorWater:SetPoint("TOPLEFT", colorLightning, "BOTTOMLEFT", 0, -6)
	function colorWater:GetColor()
		local color = db.colors.water
		return color.r, color.g, color.b
	end
	function colorWater:OnValueChanged(r, g, b)
		db.colors.water.r = r
		db.colors.water.g = g
		db.colors.water.b = b
		ShieldsUp:UpdateDisplay()
	end

	local colorMissing = self.CreateColorPicker(colorPanel, L["Missing"])
	colorMissing:SetPoint("TOPLEFT", colorPanel, "TOP", 8, -12)
	function colorMissing:GetColor()
		local color = db.colors.missing
		return color.r, color.g, color.b
	end
	function colorMissing:OnValueChanged(r, g, b)
		db.colors.missing.r = r
		db.colors.missing.g = g
		db.colors.missing.b = b
		ShieldsUp:UpdateDisplay()
	end

	local colorActive = self.CreateColorPicker(colorPanel, L["Name Color"])
	colorActive:SetPoint("TOPLEFT", colorMissing, "BOTTOMLEFT", 0, -6)
	function colorActive:GetColor()
		local color = db.colors.active
		return color.r, color.g, color.b
	end
	function colorActive:OnValueChanged(r, g, b)
		db.colors.active.r = r
		db.colors.active.g = g
		db.colors.active.b = b
		ShieldsUp:UpdateDisplay()
	end

	local nameUsesClassColor = self:CreateCheckbox(L["Name uses class color"])
	nameUsesClassColor:SetPoint("TOPLEFT", colorActive, "BOTTOMLEFT", 0, -6)
	function nameUsesClassColor:OnValueChanged(value)
		db.nameUsesClassColor = value
		ShieldsUp:UpdateDisplay()
		colorActive:SetEnabled(not value)
	end

	colorPanel:SetHeight(36 + (colorEarth:GetHeight() * 3))

	---------------------------------------------------------------------

	self.refresh = function()
		offsetX:SetValue(db.offsetX and ((db.offsetX * 2 - 1) * UIWIDTH) or 0) -- 0 = -1, 0.25 = -0.5, 0.5 = 0, 0.75 = 0.5, 1 = 1
		offsetY:SetValue(db.offsetY and (db.offsetY * 2 - 1) or 0)
		spacingX:SetValue(db.spacingX)
		spacingY:SetValue(db.spacingY)
		opacity:SetValue(db.alpha)
		lock:SetValue(ShieldsUpFrame.locked)

		nameFont:SetValue(db.nameFont)
		nameSize:SetValue(db.nameSize)
		numberFont:SetValue(db.numberFont)
		numberSize:SetValue(db.numberSize)
		outline:SetValue(db.outline)
		shadow:SetChecked(db.shadow)

		colorEarth:SetValue(db.colors.earth)
		colorLightning:SetValue(db.colors.lightning)
		colorWater:SetValue(db.colors.water)

		colorMissing:SetValue(db.colors.missing)
		colorActive:SetValue(db.colors.active)
		colorActive:SetEnabled(not db.nameUsesClassColor)
		nameUsesClassColor:SetChecked(db.nameUsesClassColor)
	end
end)

------------------------------------------------------------------------

optionsPanels[#optionsPanels + 1] = LibStub("PhanxConfig-OptionsPanel"):New(L["Behavior"], SHIELDSUP, function(self)
	local db = ShieldsUpDB

	local title, notes = self:CreateHeader(self.name, L.Alerts_Desc)

	---------------------------------------------------------------------

	local earthPanel = self:CreatePanel(L.EarthShield)
	earthPanel:SetPoint("TOPLEFT", notes, "BOTTOMLEFT", 0, -12)
	earthPanel:SetPoint("TOPRIGHT", notes, "BOTTOM", -8, -12)

	local earthText = self.CreateCheckbox(earthPanel, L["Show message"])
	earthText:SetPoint("TOPLEFT", earthPanel, 16, -16)
	function earthText:OnValueChanged(checked)
		db.alerts.earth.text = checked
	end

	local earthSound = self.CreateMediaDropdown(earthPanel, L["Play Sound"], nil, "sound")
	earthSound:SetPoint("BOTTOMLEFT", earthPanel, 16, 16)
	earthSound:SetPoint("BOTTOMRIGHT", earthPanel, -16, 16)
	function earthSound:OnValueChanged(value)
		db.alerts.earth.sound = value
	end

	earthPanel:SetHeight(16 + earthSound:GetHeight() + 8 + earthText:GetHeight() + 16)

	---------------------------------------------------------------------

	local waterPanel = self:CreatePanel(L.LightningShield .. " & " .. L.WaterShield)
	waterPanel:SetPoint("TOPLEFT", earthPanel, "BOTTOMLEFT", 0, -12)
	waterPanel:SetPoint("TOPRIGHT", earthPanel, "BOTTOMRIGHT", 0, -12)

	local waterText = self.CreateCheckbox(waterPanel, L["Show message"])
	waterText:SetPoint("TOPLEFT", waterPanel, 16, -16)
	function waterText:OnValueChanged(checked)
		db.alerts.water.text = checked
	end

	local waterSound = self.CreateMediaDropdown(waterPanel, L["Play Sound"], nil, "sound")
	waterSound:SetPoint("BOTTOMLEFT", waterPanel, 16, 16)
	waterSound:SetPoint("BOTTOMRIGHT", waterPanel, -16, 16)
	function waterSound:OnValueChanged(value)
		db.alerts.water.sound = value
	end

	waterPanel:SetHeight(16 + waterSound:GetHeight() + 8 + waterText:GetHeight() + 16)

	---------------------------------------------------------------------

	local sinkOptionsTable = ShieldsUp:GetSinkAce2OptionsDataTable().output
	local sinkOutputList, sinkScrollAreaList = {}, {}

	local sinkPanel = self:CreatePanel(L["Message Options"])
	sinkPanel:SetPoint("TOPLEFT", waterPanel, "BOTTOMLEFT", 0, -12)
	sinkPanel:SetPoint("TOPRIGHT", waterPanel, "BOTTOMRIGHT", 0, -12)
	sinkPanel:SetPoint("BOTTOM", 0, 16)

	local sinkOutput = self.CreateDropdown(sinkPanel, sinkOptionsTable.name, sinkOptionsTable.desc, sinkOutputList)
	sinkOutput:SetPoint("TOPLEFT", sinkPanel, 16, -16)
	sinkOutput:SetPoint("TOPRIGHT", sinkPanel, -16, -16)
	sinkOutput.OnValueChanged = function(dropdown, value, text)
		sinkOptionsTable.set(value, true)
		self:refresh()
	end

	local sinkScrollArea = self.CreateDropdown(sinkPanel, sinkOptionsTable.args.ScrollArea.name, sinkOptionsTable.args.ScrollArea.desc, sinkScrollAreaList)
	sinkScrollArea:SetPoint("TOPLEFT", sinkOutput, "BOTTOMLEFT", 0, -12)
	sinkScrollArea:SetPoint("TOPRIGHT", sinkOutput, "BOTTOMRIGHT", 0, -12)
	sinkScrollArea.OnValueChanged = function(dropdown, value, text)
		sinkOptionsTable.set("ScrollArea", value)
		self:refresh()
	end

	local sinkSticky = self.CreateCheckbox(sinkPanel, sinkOptionsTable.args.Sticky.name, sinkOptionsTable.args.Sticky.desc)
	sinkSticky:SetPoint("TOPLEFT", sinkScrollArea, "BOTTOMLEFT", 0, -6)
	sinkSticky.OnValueChanged = function(dropdown, checked)
		sinkOptionsTable.set("Sticky", checked)
		self:refresh()
	end

	---------------------------------------------------------------------

	local showPanel = self:CreatePanel(L["Visibility"])
	showPanel:SetPoint("TOPLEFT", notes, "BOTTOM", 8, -12)
	showPanel:SetPoint("BOTTOMLEFT", sinkPanel, "BOTTOMRIGHT", 8, 0)
	showPanel:SetPoint("RIGHT", -16, 0)

	local showSolo = self.CreateCheckbox(showPanel, L["Show while solo"])
	showSolo:SetPoint("TOPLEFT", 16, -16)
	function showSolo:OnValueChanged(value)
		db.show.solo = value
	end

	local showParty = self.CreateCheckbox(showPanel, L["Show in party"])
	showParty:SetPoint("TOPLEFT", showSolo, "BOTTOMLEFT", 0, -8)
	function showParty:OnValueChanged(value)
		db.show.party = value
	end

	local showRaid = self.CreateCheckbox(showPanel, L["Show in raid"])
	showRaid:SetPoint("TOPLEFT", showParty, "BOTTOMLEFT", 0, -8)
	function showRaid:OnValueChanged(value)
		db.show.raid = value
	end

	local showArena = self.CreateCheckbox(showPanel, L["Show in arena"])
	showArena:SetPoint("TOPLEFT", showRaid, "BOTTOMLEFT", 0, -8)
	function showArena:OnValueChanged(value)
		db.show.arena = value
	end

	local showBattleground = self.CreateCheckbox(showPanel, L["Show in battleground"])
	showBattleground:SetPoint("TOPLEFT", showArena, "BOTTOMLEFT", 0, -8)
	function showBattleground:OnValueChanged(value)
		db.show.battleground = value
	end

	local divider = showPanel:CreateTexture(nil, "BORDER")
	divider:SetPoint("TOPLEFT", showBattleground, "BOTTOMLEFT", 4, -14)
	divider:SetPoint("RIGHT", -20, 0)
	divider:SetHeight(8)
	divider:SetTexture("Interface\\Common\\UI-TooltipDivider-Transparent")

	local showOOC = self.CreateCheckbox(showPanel, L["Show out of combat"])
	showOOC:SetPoint("TOPLEFT", divider, "BOTTOMLEFT", -4, -14)
	function showOOC:OnValueChanged(value)
		db.alerts.nocombat = value
	end

	local showResting = self.CreateCheckbox(showPanel, L["Show when resting"])
	showResting:SetPoint("TOPLEFT", showOOC, "BOTTOMLEFT", 0, -8)
	function showResting:OnValueChanged(value)
		db.alerts.resting = value
	end

	divider = showPanel:CreateTexture(nil, "BORDER")
	divider:SetPoint("TOPLEFT", showResting, "BOTTOMLEFT", 4, -14)
	divider:SetPoint("RIGHT", -20, 0)
	divider:SetHeight(8)
	divider:SetTexture("Interface\\Common\\UI-TooltipDivider-Transparent")

	local hideInfinite = self:CreateCheckbox(L["Hide unlimited shields"], L["Hide the indicator for active shields that don't have multiple charges."])
	hideInfinite:SetPoint("TOPLEFT", divider, "BOTTOMLEFT", -4, -14)
	function hideInfinite:OnValueChanged(value)
		db.hideInfinite = value
		ShieldsUp:UpdateDisplay()
	end

	local alertsWhileHidden = self.CreateCheckbox(showPanel, L["Alerts while hidden"], L["Show alert messages and play alert sounds even when the display is hidden."])
	alertsWhileHidden:SetPoint("TOPLEFT", hideInfinite, "BOTTOMLEFT", 0, -8)
	function alertsWhileHidden:OnValueChanged(value)
		db.alerts.whileHidden = value
	end

	---------------------------------------------------------------------

	local argsToIgnore = {
		Default = true,
		Channel = true,
		ScrollArea = true,
		Sticky = true,
	}

	self.refresh = function()
		-- alertsWhileHidden:SetChecked(db.alerts.whileHidden)

		earthText:SetChecked(db.alerts.earth.text)
		earthSound:SetValue(db.alerts.earth.sound)

		waterText:SetChecked(db.alerts.water.text)
		waterSound:SetValue(db.alerts.water.sound)

		sinkOptionsTable.set(db.alerts.sink20OutputSink, true) -- force options table update
		sinkOptionsTable = ShieldsUp:GetSinkAce2OptionsDataTable().output -- _G.SINKOPTIONS = sinkOptionsTable
		wipe(sinkOutputList) -- _G.SINKOUTPUT = sinkOutputList
		for k, v in pairs(sinkOptionsTable.args) do
			if v.type == "toggle" and not argsToIgnore[k] and not (v.hidden and v.hidden()) then
				tinsert(sinkOutputList, { text = v.name, value = k })
			end
		end
		wipe(sinkScrollAreaList) -- _G.SINKSCROLLS = sinkScrollAreaList
		for i, v in ipairs(sinkOptionsTable.args.ScrollArea.validate) do
			tinsert(sinkScrollAreaList, v)
		end

		sinkOutput:SetValue(db.alerts.sink20OutputSink)
		sinkScrollArea:SetShown(not sinkOptionsTable.args.ScrollArea.disabled)
		sinkScrollArea:SetValue(db.alerts.sink20ScrollArea)
		sinkSticky:SetShown(not sinkOptionsTable.args.Sticky.disabled)
		sinkSticky:SetValue(db.alerts.sink20Sticky)

		showSolo:SetValue(db.show.solo)
		showParty:SetValue(db.show.party)
		showRaid:SetValue(db.show.raid)
		showArena:SetValue(db.show.arena)
		showBattleground:SetValue(db.show.battleground)

		showOOC:SetValue(db.show.nocombat)
		showResting:SetValue(db.show.resting)

		hideInfinite:SetValue(db.hideInfinite)
		alertsWhileHidden:SetValue(db.alerts.whileHidden)
	end
end)

------------------------------------------------------------------------

local AboutPanel = LibStub("LibAboutPanel").new(SHIELDSUP, SHIELDSUP)

------------------------------------------------------------------------

SLASH_SHIELDSUP1 = "/sup"
SLASH_SHIELDSUP2 = "/shieldsup"
SlashCmdList.SHIELDSUP = function(arg)
	arg = arg and string.trim(string.lower(arg))
	if arg == "lock" then
		return ShieldsUp:LockDisplay()
	end
	InterfaceOptionsFrame_OpenToCategory(SHIELDSUP)
end

------------------------------------------------------------------------

local LibDataBroker = LibStub("LibDataBroker-1.1", true)
if LibDataBroker then
	LibDataBroker:NewDataObject(SHIELDSUP, {
		type = "launcher",
		icon = "Interface\\Icons\\Spell_Nature_SkinOfEarth",
		OnClick = function(_, button)
			SlashCmdList.SHIELDSUP(button == "LeftButton" and "lock" or nil)
		end,
		OnTooltipShow = function(tooltip)
			tooltip:AddLine(SHIELDSUP, 1, 1, 1)
			tooltip:AddLine(L["Click to lock or unlock the frame."])
			tooltip:AddLine(L["Right-click for options."])
			tooltip:Show()
		end,
	})
end
