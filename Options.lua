--[[--------------------------------------------------------------------
	ShieldsUp
	Text-based shaman shield monitor.
	Copyright (c) 2008-2014 Phanx <addons@phanx.net>. All rights reserved.
	http://www.wowinterface.com/downloads/info9165-ShieldsUp.html
	http://www.curse.com/addons/wow/shieldsup
----------------------------------------------------------------------]]

if select(2, UnitClass("player")) ~= "SHAMAN" then return end

local ADDON_NAME, private = ...
local ShieldsUp = ShieldsUp
local L = private.L

local floor, format = math.floor, string.format

local optionsPanels = {}
ShieldsUp.optionsPanels = optionsPanels

local CreateOptionsPanel = LibStub("PhanxConfig-OptionsPanel").CreateOptionsPanel

------------------------------------------------------------------------

optionsPanels[#optionsPanels + 1] = CreateOptionsPanel(ADDON_NAME, nil, function(self)
	local db = ShieldsUpDB
	local SharedMedia = LibStub("LibSharedMedia-3.0", true)

	local UIWIDTH = UIParent:GetWidth()
	local UIHEIGHT = UIParent:GetHeight()

	local Title, Notes = LibStub("PhanxConfig-Header").CreateHeader(self, ADDON_NAME, L.OptionsDesc)

	---------------------------------------------------------------------

	local PositionX = self:CreateSlider(L.PositionX, nil, floor(UIWIDTH / 10) / 2 * -10, floor(UIWIDTH / 10) / 2 * 10, 5)
	PositionX:SetPoint("TOPLEFT", Notes, "BOTTOMLEFT", -4, -12)
	PositionX:SetPoint("TOPRIGHT", Notes, "BOTTOM", -8, 12)
	function PositionX:Callback(value)
		db.posx = value
		ShieldsUp:UpdateLayout()
	end

	local PositionY = self:CreateSlider(L.PositionY, nil, floor(UIHEIGHT / 10) / 2 * -10, floor(UIHEIGHT / 10) / 2 * 10, 5)
	PositionY:SetPoint("TOPLEFT", PositionX, "BOTTOMLEFT", 0, -12)
	PositionY:SetPoint("TOPRIGHT", PositionX, "BOTTOMRIGHT", 0, -12)
	function PositionY:Callback(value)
		db.posy = value
		ShieldsUp:UpdateLayout()
	end

	local PaddingH = self:CreateSlider(L.PaddingH, L.PaddingH_Desc, 0, floor(UIWIDTH / 10) / 2 * 10, 1)
	PaddingH:SetPoint("TOPLEFT", PositionY, "BOTTOMLEFT", 0, -12)
	PaddingH:SetPoint("TOPRIGHT", PositionY, "BOTTOMRIGHT", 0, -12)
	function PaddingH:Callback(value)
		db.padh = value
		ShieldsUp:UpdateLayout()
	end

	local PaddingV = self:CreateSlider(L.PaddingV, L.PaddingV_Desc, 0, floor(UIWIDTH / 10) / 2 * 10, 1)
	PaddingV:SetPoint("TOPLEFT", PaddingH, "BOTTOMLEFT", 0, -12)
	PaddingV:SetPoint("TOPRIGHT", PaddingH, "BOTTOMRIGHT", 0, -12)
	function PaddingV:Callback(value)
		db.padv = value
		ShieldsUp:UpdateLayout()
	end

	local Opacity = self:CreateSlider(L.Opacity, nil, 0, 1, 0.05, true)
	Opacity:SetPoint("TOPLEFT", PaddingV, "BOTTOMLEFT", 0, -12)
	Opacity:SetPoint("TOPRIGHT", PaddingV, "BOTTOMRIGHT", 0, -12)
	function Opacity:Callback(value)
		db.alpha = value
		ShieldsUp:UpdateLayout()
	end

	---------------------------------------------------------------------

	local Font = self:CreateDropdown(L.Font, nil, SharedMedia:List("font"))
	Font:SetPoint("TOPLEFT", Notes, "BOTTOM", 8, -12)
	Font:SetPoint("TOPRIGHT", Notes, "BOTTOMRIGHT", 0, -12)
	do
		function Font:Callback(value)
			local _, height, flags = self.valueText:GetFont()
			self.valueText:SetFont(SharedMedia:Fetch("font", value), height, flags)

			db.font.face = value
			ShieldsUp:UpdateLayout()
		end

		function Font:ListButtonCallback(button, value, selected)
			if button:IsShown() then
				button:GetFontString():SetFont(SharedMedia:Fetch("font", value), UIDROPDOWNMENU_DEFAULT_TEXT_HEIGHT)
			end
		end

		Font.__SetValue = Font.SetValue
		function Font:SetValue(value)
			local _, height, flags = self.valueText:GetFont()
			self.valueText:SetFont(SharedMedia:Fetch("font", value), height, flags)
			self:__SetValue(value)
		end
	end

	local Outline = self:CreateDropdown(L.Outline)
	Outline:SetPoint("TOPLEFT", Font, "BOTTOMLEFT", 0, -12)
	Outline:SetPoint("TOPRIGHT", Font, "BOTTOMRIGHT", 0, -12)

	function Outline:OnValueChanged(value)
		db.font.outline = value
		ShieldsUp:UpdateLayout()
	end

	Outline:SetList({
		{ value = "NONE", text = L.None },
		{ value = "OUTLINE", text = L.Thin },
		{ value = "THICKOUTLINE", text = L.Thick },
	})

	local CounterSize = self:CreateSlider(L.CounterSize, nil, 6, 32, 1)
	CounterSize:SetPoint("TOPLEFT", Outline, "BOTTOMLEFT", 0, -12)
	CounterSize:SetPoint("TOPRIGHT", Outline, "BOTTOMRIGHT", 0, -12)
	function CounterSize:Callback(value)
		db.font.large = value
		ShieldsUp:UpdateLayout()
	end

	local NameSize = self:CreateSlider(L.NameSize, nil, 6, 32, 1)
	NameSize:SetPoint("TOPLEFT", CounterSize, "BOTTOMLEFT", 0, -12)
	NameSize:SetPoint("TOPRIGHT", CounterSize, "BOTTOMRIGHT", 0, -12)
	function NameSize:Callback(value)
		db.font.small = value
		ShieldsUp:UpdateLayout()
	end

	local Shadow = self:CreateCheckbox(L.Shadow)
	Shadow:SetPoint("TOPLEFT", NameSize, "BOTTOMLEFT", 0, -12)
	function Shadow:Callback(value)
		db.font.shadow = value
		ShieldsUp:UpdateLayout()
	end

	local ClassColor = self:CreateCheckbox(L.ClassColor, format(L.ClassColor_Desc, L.EarthShield))
	ClassColor:SetPoint("TOPLEFT", Shadow, "BOTTOMLEFT", 0, -8)
	function ClassColor:Callback(value)
		db.color.useClassColor = value
		ShieldsUp:UpdateDisplay()
	end

	---------------------------------------------------------------------

	local ColorPanel = self:CreatePanel(L.Colors)
	local py = 5 * (Opacity:GetHeight() + 12)
	ColorPanel:SetPoint("TOPLEFT", Notes, "BOTTOMLEFT", -2, -12 - py)
	ColorPanel:SetPoint("TOPRIGHT", Notes, "BOTTOMRIGHT", 0, -12 - py)

	local ColorEarth = self.CreateColorPicker(ColorPanel, L.EarthShield)
	ColorEarth:SetPoint("TOPLEFT", ColorPanel, 8, -8)
	function ColorEarth:GetColor()
		local color = db.color.earth
		return color.r, color.g, color.b
	end
	function ColorEarth:Callback(r, g, b)
		db.color.earth.r = r
		db.color.earth.g = g
		db.color.earth.b = b
		ShieldsUp:UpdateDisplay()
	end

	local ColorLightning = self.CreateColorPicker(ColorPanel, L.LightningShield)
	ColorLightning:SetPoint("TOPLEFT", ColorEarth, "BOTTOMLEFT", 0, -8)
	function ColorLightning:GetColor()
		local color = db.color.lightning
		return color.r, color.g, color.b
	end
	function ColorLightning:Callback(r, g, b)
		db.color.lightning.r = r
		db.color.lightning.g = g
		db.color.lightning.b = b
		ShieldsUp:UpdateDisplay()
	end

	local ColorWater = self.CreateColorPicker(ColorPanel, L.WaterShield)
	ColorWater:SetPoint("TOPLEFT", ColorLightning, "BOTTOMLEFT", 0, -8)
	function ColorWater:GetColor()
		local color = db.color.water
		return color.r, color.g, color.b
	end
	function ColorWater:Callback(r, g, b)
		db.color.water.r = r
		db.color.water.g = g
		db.color.water.b = b
		ShieldsUp:UpdateDisplay()
	end

	local ColorActive = self.CreateColorPicker(ColorPanel, L.Active, format(L.Active_Desc, L.EarthShield))
	ColorActive:SetPoint("TOPLEFT", ColorPanel, "TOP", 8, -8)
	function ColorActive:GetColor()
		local color = db.color.normal
		return color.r, color.g, color.b
	end
	function ColorActive:Callback(r, g, b)
		db.color.normal.r = r
		db.color.normal.g = g
		db.color.normal.b = b
		ShieldsUp:UpdateDisplay()
	end

	local ColorMissing = self.CreateColorPicker(ColorPanel, L.Missing, L.Missing_Desc)
	ColorMissing:SetPoint("TOPLEFT", ColorActive, "BOTTOMLEFT", 0, -8)
	function ColorMissing:GetColor()
		local color = db.color.alert
		return color.r, color.g, color.b
	end
	function ColorMissing:Callback(r, g, b)
		db.color.alert.r = r
		db.color.alert.g = g
		db.color.alert.b = b
		ShieldsUp:UpdateDisplay()
	end

	ColorPanel:SetHeight(ColorEarth:GetHeight() * 3 + 32)

	---------------------------------------------------------------------

	local outlineValues = {
		NONE = L.None,
		OUTLINE = L.Thin,
		THICKOUTLINE = L.Thick,
	}

	self.refresh = function()
		PositionX:SetValue(db.posx)
		PositionY:SetValue(db.posy)
		PaddingH:SetValue(db.padh)
		PaddingV:SetValue(db.padv)
		Opacity:SetValue(db.alpha)

		Font:SetValue(db.font.face)
		Outline:SetValue(db.font.outline, outlineValues[db.font.outline])
		CounterSize:SetValue(db.font.large)
		NameSize:SetValue(db.font.small)
		Shadow:SetChecked(db.font.shadow)
		ClassColor:SetChecked(db.color.useClassColor)

		ColorEarth:SetValue(db.color.earth)
		ColorLightning:SetValue(db.color.lightning)
		ColorWater:SetValue(db.color.water)
		ColorActive:SetValue(db.color.normal)
		ColorMissing:SetValue(db.color.alert)
	end
end)

------------------------------------------------------------------------

optionsPanels[#optionsPanels +1] = CreateOptionsPanel(L.Alerts, ADDON_NAME, function(self)
	local db = ShieldsUpDB
	local SharedMedia = LibStub("LibSharedMedia-3.0", true)

	local Title, Notes = self:CreateHeader(self.name, L.Alerts_Desc)

	local AlertWhileHidden = self:CreateCheckbox(L.AlertWhileHidden, L.AlertWhileHidden_Desc)
	AlertWhileHidden:SetPoint("TOPLEFT", Notes, "BOTTOMLEFT", -2, -12)
	AlertWhileHidden.Callback = function(this, checked)
		db.alert.alertWhileHidden = checked
	end

	---------------------------------------------------------------------

	local EarthPanel = self:CreatePanel(L.EarthShield)
	EarthPanel:SetPoint("TOPLEFT", Notes, "BOTTOMLEFT", -4, -24 - AlertWhileHidden:GetHeight())
	EarthPanel:SetPoint("TOPRIGHT", Notes, "BOTTOM", -4, -24 - AlertWhileHidden:GetHeight())

	local EarthSound = self.CreateDropdown(EarthPanel, L.AlertSound, format(L.AlertSound_Desc, L.EarthShield), SharedMedia:List("sound"))
	EarthSound:SetPoint("TOPLEFT", EarthPanel, 16, -16)
	EarthSound:SetPoint("TOPRIGHT", EarthPanel, -16, -16)
	function EarthSound:Callback(value)
		db.alert.earth.sound = value
	end
	do
		local function PlayButton_OnClick(self)
			PlaySoundFile(self.sound, "Master")
		end
		function EarthSound:ListButtonCallback(button, value, selected)
			if not button.playButton then
				local play = CreateFrame("Button", nil, button)
				play:SetPoint("RIGHT", button, -2, 0)
				play:SetSize(16, 16)
				play:SetScript("OnClick", PlayButton_OnClick)
				button.playButton = play

				local bg = play:CreateTexture(nil, "BACKGROUND")
				bg:SetTexture("Interface\\Common\\VoiceChat-Speaker")
				bg:SetAllPoints(true)
				play.bg = bg

				local hl = play:CreateTexture(nil, "HIGHLIGHT")
				hl:SetTexture("Interface\\Common\\VoiceChat-On")
				hl:SetAllPoints(true)
				play.highlight = hl
			end
			button.playButton.sound = SharedMedia:Fetch("sound", value)
		end
	end

	local EarthText = self.CreateCheckbox(EarthPanel, L.AlertText, format(L.AlertText_Desc, L.EarthShield))
	EarthText:SetPoint("TOPLEFT", EarthSound, "BOTTOMLEFT", 0, -8)
	function EarthText:Callback(checked)
		db.alert.earth.text = checked
	end

	EarthPanel:SetHeight(16 + EarthSound:GetHeight() + 8 + EarthText:GetHeight() + 16)

	---------------------------------------------------------------------

	local WaterPanel = self:CreatePanel(L.WaterShield)
	WaterPanel:SetPoint("TOPLEFT", Notes, "BOTTOM", 4, -24 - AlertWhileHidden:GetHeight())
	WaterPanel:SetPoint("TOPRIGHT", Notes, "BOTTOMRIGHT", 4, -24 - AlertWhileHidden:GetHeight())

	local WaterSound = self.CreateDropdown(WaterPanel, L.AlertSound, format(L.AlertSound_Desc, L.WaterShield), SharedMedia:List("sound"))
	WaterSound:SetPoint("TOPLEFT", WaterPanel, 16, -16)
	WaterSound:SetPoint("TOPRIGHT", WaterPanel, -16, -16)
	function WaterSound:Callback(value)
		db.alert.water.sound = value
	end
	do
		local function PlayButton_OnClick(self)
			PlaySoundFile(self.sound, "Master")
		end
		function WaterSound:ListButtonCallback(button, value, selected)
			if not button.playButton then
				local play = CreateFrame("Button", nil, button)
				play:SetPoint("RIGHT", button, -2, 0)
				play:SetSize(16, 16)
				play:SetScript("OnClick", PlayButton_OnClick)
				button.playButton = play

				local bg = play:CreateTexture(nil, "BACKGROUND")
				bg:SetTexture("Interface\\Common\\VoiceChat-Speaker")
				bg:SetAllPoints(true)
				play.bg = bg

				local hl = play:CreateTexture(nil, "HIGHLIGHT")
				hl:SetTexture("Interface\\Common\\VoiceChat-On")
				hl:SetAllPoints(true)
				play.highlight = hl
			end
			button.playButton.sound = SharedMedia:Fetch("sound", value)
		end
	end

	local WaterText = self.CreateCheckbox(WaterPanel, L.AlertText, format(L.AlertText_Desc, L.WaterShield))
	WaterText:SetPoint("TOPLEFT", WaterSound, "BOTTOMLEFT", 0, -8)
	function WaterText:Callback(checked)
		db.alert.water.text = checked
	end

	WaterPanel:SetHeight(EarthPanel:GetHeight())

	---------------------------------------------------------------------

	local SinkOptions, SinkList, SinkLabel, SinkPanel, SinkOutput, SinkScrollArea, SinkSticky, SinkPanel_Update
	if ShieldsUp.Pour then
		SinkList = {}
		SinkOptions = ShieldsUp:GetSinkAce2OptionsDataTable().output

		function SinkPanel_Update()
			wipe(SinkList)

			SinkOptions = ShieldsUp:GetSinkAce2OptionsDataTable().output
			for k, v in pairs(SinkOptions.args) do
				if k ~= "Default" and k ~= "Sticky" and k ~= "Channel" and v.type == "toggle" then
					SinkList[k] = v.name
				end
			end

			SinkOutput:SetValue(db.alert.output.sink20OutputSink, SinkList[db.alert.output.sink20OutputSink])

			SinkOptions.set(db.alert.output.sink20OutputSink, true) -- hax!
			for i, v in ipairs(SinkOptions.args.ScrollArea.validate) do
				if v == db.alert.output.sink20ScrollArea then
					SinkScrollArea:SetValue(db.alert.output.sink20ScrollArea)
				end
			end

			SinkSticky:SetChecked(db.alert.output.sink20Sticky)

			if SinkOptions.args.ScrollArea.disabled then
				SinkScrollArea:Hide()
			else
				SinkScrollArea:Show()

				local valid
				local current = db.alert.output.sink20ScrollArea
				for i, scrollArea in ipairs(SinkOptions.args.ScrollArea.validate) do
					if scrollArea == current then
						valid = true
						break
					end
				end
				if not valid then
					SinkScrollArea.valueText:SetText()
				end
			end

			if SinkOptions.args.Sticky.disabled then
				SinkSticky:Hide()
				SinkPanel:SetHeight(16 + SinkOutput:GetHeight() + 16)
			else
				SinkSticky:Show()
				SinkPanel:SetHeight(16 + SinkOutput:GetHeight() + 8 + SinkSticky:GetHeight() + 16)
			end
		end

		SinkPanel = self:CreatePanel(L.AlertTextSink)
		SinkPanel:SetPoint("TOPLEFT", EarthPanel, "BOTTOMLEFT", 0, -16)
		SinkPanel:SetPoint("TOPRIGHT", WaterPanel, "BOTTOMRIGHT", 0, -16)

		SinkOutput = self.CreateDropdown(SinkPanel, SinkOptions.name, SinkOptions.desc) _G.SINKOUT = SinkOutput
		SinkOutput:SetPoint("TOPLEFT", SinkPanel, 16, -16)
		SinkOutput:SetPoint("TOPRIGHT", SinkPanel, "TOP", -8, -16)
		do
			local function OnClick(self)
				local value = self.value
				SinkOptions.set(value, true)
				SinkPanel_Update()
				SinkOutput:SetValue(value, SinkList[value])
			end

			function SinkOutput:Initialize(dropdown, level)
				local info = UIDropDownMenu_CreateInfo()
				info.func = OnClick

				local selected = db.alert.output.sink20OutputSink
				for k, v in pairs(SinkOptions.args) do
					if k ~= "Default" and k ~= "Sticky" and k ~= "Channel" and v.type == "toggle" and not (v.hidden and v:hidden()) then
						info.text = v.name
						info.value = k
						info.checked = v.name == selected
						UIDropDownMenu_AddButton(info)
					end
				end
			end
		end

		SinkScrollArea = self.CreateDropdown(SinkPanel, SinkOptions.args.ScrollArea.name, SinkOptions.args.ScrollArea.desc)
		SinkScrollArea:SetPoint("TOPLEFT", SinkPanel, "TOP", 8, -16) _G.SINKAREA = SinkScrollArea
		SinkScrollArea:SetPoint("TOPRIGHT", SinkPanel, -16, -16)
		do
			local function OnClick(self)
				local value = self.value
				SinkOptions.set("ScrollArea", value)
				SinkPanel_Update()
				SinkScrollArea:SetValue(value, self:GetText())
			end

			function SinkScrollArea:Initialize(dropdown, level)
				local info = UIDropDownMenu_CreateInfo()
				info.func = OnClick

				local selected = db.alert.output.sink20ScrollArea
				for i, v in ipairs(SinkOptions.args.ScrollArea.validate) do
					info.text = v
					info.value = v
					info.checked = v == selected
					UIDropDownMenu_AddButton(info)
				end
			end
		end

		SinkSticky = self.CreateCheckbox(SinkPanel, SinkOptions.args.Sticky.name, SinkOptions.args.Sticky.desc)
		SinkSticky:SetPoint("TOPLEFT", SinkOutput, "BOTTOMLEFT", 0, -8)

		function SinkSticky:Callback(checked)
			SinkOptions.set("Sticky", checked)
			SinkPanel_Update()
		end

		SinkPanel_Update()
	end

	---------------------------------------------------------------------

	self.refresh = function()
		AlertWhileHidden:SetChecked(db.alert.alertWhileHidden)

		EarthText:SetChecked(db.alert.earth.text)
		EarthSound:SetValue(db.alert.earth.sound)

		WaterText:SetChecked(db.alert.water.text)
		WaterSound:SetValue(db.alert.water.sound)

		if SinkPanel_Update then
			SinkPanel_Update()
		end
	end
end)

------------------------------------------------------------------------

optionsPanels[#optionsPanels +1] = CreateOptionsPanel(L.Visibility, ADDON_NAME, function(self)
	local db = ShieldsUpDB

	local Title, Notes = self:CreateHeader(self.name, L.Visibility_Desc)

	---------------------------------------------------------------------

	local HideInfinite = self:CreateCheckbox(L.HideInfinite, L.HideInfinite_Desc)
	HideInfinite:SetPoint("TOPLEFT", Notes, "BOTTOMLEFT", -2, -8)
	HideInfinite.Callback = function(this, checked)
		db.hideInfinite = checked
		ShieldsUp:UpdateDisplay()
	end

	---------------------------------------------------------------------

	local function OnClick(self, checked)
		db[self.key] = checked
		ShieldsUp:UpdateVisibility()
	end

	local ShowLabel = self:CreateFontString(nil, "OVERLAY", "GameFontHighlightMedium")
	ShowLabel:SetPoint("TOPLEFT", Notes, "BOTTOMLEFT", 2, -24 - HideInfinite:GetHeight())
	ShowLabel:SetPoint("TOPRIGHT", Notes, "BOTTOM", -8, -24 - HideInfinite:GetHeight())
	ShowLabel:SetJustifyH("LEFT")
	ShowLabel:SetTextColor(GameFontNormal:GetTextColor())
	ShowLabel:SetText(L.Show)

	local ShowSolo = self:CreateCheckbox(L.ShowSolo)
	ShowSolo:SetPoint("TOPLEFT", ShowLabel, "BOTTOMLEFT", -2, -8)
	ShowSolo.Callback = OnClick
	ShowSolo.key = "showSolo"

	local ShowParty = self:CreateCheckbox(L.ShowParty)
	ShowParty:SetPoint("TOPLEFT", ShowSolo, "BOTTOMLEFT", 0, -8)
	ShowParty.Callback = OnClick
	ShowParty.key = "showInParty"

	local ShowRaid = self:CreateCheckbox(L.ShowRaid)
	ShowRaid:SetPoint("TOPLEFT", ShowParty, "BOTTOMLEFT", 0, -8)
	ShowRaid.Callback = OnClick
	ShowRaid.key = "showInRaid"

	local ShowArena = self:CreateCheckbox(L.ShowArena)
	ShowArena:SetPoint("TOPLEFT", ShowRaid, "BOTTOMLEFT", 0, -8)
	ShowArena.Callback = OnClick
	ShowArena.key = "showInArena"

	local ShowBattleground = self:CreateCheckbox(L.ShowBattleground)
	ShowBattleground:SetPoint("TOPLEFT", ShowArena, "BOTTOMLEFT", 0, -8)
	ShowBattleground.Callback = OnClick
	ShowBattleground.key = "showInBG"

	---------------------------------------------------------------------

	local HideLabel = self:CreateFontString(nil, "OVERLAY", "GameFontHighlightMedium")
	HideLabel:SetPoint("TOPLEFT", Notes, "BOTTOM", 8, -24 - HideInfinite:GetHeight())
	HideLabel:SetPoint("TOPRIGHT", Notes, "BOTTOMRIGHT", -8, -24 - HideInfinite:GetHeight())
	HideLabel:SetJustifyH("LEFT")
	HideLabel:SetTextColor(GameFontNormal:GetTextColor())
	HideLabel:SetText(L.Hide)

	local HideOOC = self:CreateCheckbox(L.HideOOC)
	HideOOC:SetPoint("TOPLEFT", HideLabel, "BOTTOMLEFT", -2, -8)
	HideOOC.Callback = OnClick
	HideOOC.key = "hideOOC"

	local HideResting = self:CreateCheckbox(L.HideResting)
	HideResting:SetPoint("TOPLEFT", HideOOC, "BOTTOMLEFT", 0, -8)
	HideResting.Callback = OnClick
	HideResting.key = "hideResting"

	---------------------------------------------------------------------

	local LowLevelNote = self:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	LowLevelNote:SetPoint("BOTTOMLEFT", 16, 16)
	LowLevelNote:SetPoint("BOTTOMRIGHT", -16, -16)
	LowLevelNote:SetHeight(64)
	LowLevelNote:SetJustifyH("LEFT")
	LowLevelNote:SetJustifyV("BOTTOM")
	LowLevelNote:SetText(L.HiddenLowLevel)

	---------------------------------------------------------------------

	self.refresh = function()
		HideInfinite:SetValue(db.hideInfinite)

		ShowSolo:SetValue(db.showSolo)
		ShowParty:SetValue(db.showInParty)
		ShowRaid:SetValue(db.showInRaid)
		ShowArena:SetValue(db.showInArena)
		ShowBattleground:SetValue(db.showInBG)

		HideOOC:SetValue(db.hideOOC)
		HideResting:SetValue(db.hideResting)

		LowLevelNote:SetShown(UnitLevel("player") < 8)
	end
end)

------------------------------------------------------------------------

optionsPanels[#optionsPanels + 1] = LibStub("LibAboutPanel").new(ADDON_NAME, ADDON_NAME)

------------------------------------------------------------------------

SLASH_SHIELDSUP1 = "/sup"
SLASH_SHIELDSUP2 = "/shieldsup"
SlashCmdList.SHIELDSUP = function()
	InterfaceOptionsFrame_OpenToCategory(optionsPanels[1])
	InterfaceOptionsFrame_OpenToCategory(optionsPanels[1])
	-- Doing it twice works around the longstanding Blizzard bug
	-- that fails to actually open the requested panel if it's
	-- not currently visible in the lefthand list, and scrolling
	-- is required to bring it into view.
end

------------------------------------------------------------------------

LibStub("LibDataBroker-1.1"):NewDataObject(ADDON_NAME, {
	type = "launcher",
	icon = "Interface\\Icons\\Spell_Nature_SkinOfEarth",
	label = ADDON_NAME,
	OnClick = SlashCmdList.SHIELDSUP,
	OnTooltipShow = function(tooltip)
		tooltip:AddLine(ADDON_NAME, 1, 1, 1)
		tooltip:AddLine(L.ClickForOptions)
		tooltip:Show()
	end,
})

------------------------------------------------------------------------