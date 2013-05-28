--[[--------------------------------------------------------------------
	ShieldsUp
	Text-based shaman shield monitor.
	Copyright (c) 2008-2013 Phanx <addons@phanx.net>. All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info9165-ShieldsUp.html
	http://www.curse.com/addons/wow/shieldsup
----------------------------------------------------------------------]]

if select(2, UnitClass("player")) ~= "SHAMAN" then return end

local ADDON_NAME, private = ...
local ShieldsUp = ShieldsUp
local L = private.L

local floor, format, unpack = math.floor, string.format, unpack

local optionsPanels = { }
ShieldsUp.optionsPanels = optionsPanels

local CreateOptionsPanel = LibStub("PhanxConfig-OptionsPanel").CreateOptionsPanel

------------------------------------------------------------------------

optionsPanels[#optionsPanels + 1] = CreateOptionsPanel(ADDON_NAME, nil, function(self)
	local db = ShieldsUpDB
	local SharedMedia = LibStub("LibSharedMedia-3.0", true)

	local UIWIDTH = UIParent:GetWidth()
	local UIHEIGHT = UIParent:GetHeight()

	local CreateCheckbox = LibStub("PhanxConfig-Checkbox").CreateCheckbox
	local CreateColorPicker = LibStub("PhanxConfig-ColorPicker").CreateColorPicker
	local CreateDropdown = LibStub("PhanxConfig-Dropdown").CreateDropdown
	local CreatePanel = LibStub("PhanxConfig-Panel").CreatePanel
	local CreateSlider = LibStub("PhanxConfig-Slider").CreateSlider

	local Title, Notes = LibStub("PhanxConfig-Header").CreateHeader(self, ADDON_NAME, L.OptionsDesc)

	--------------------------------------------------------------------

	local PositionX = CreateSlider(self, L.PositionX, nil, floor(UIWIDTH / 10) / 2 * -10, floor(UIWIDTH / 10) / 2 * 10, 5)
	PositionX:SetPoint("TOPLEFT", Notes, "BOTTOMLEFT", -4, -12)
	PositionX:SetPoint("TOPRIGHT", Notes, "BOTTOM", -8, 12)
	function PositionX:OnValueChanged(value)
		db.posx = value
		ShieldsUp:UpdateLayout()
	end

	local PositionY = CreateSlider(self, L.PositionY, nil, floor(UIHEIGHT / 10) / 2 * -10, floor(UIHEIGHT / 10) / 2 * 10, 5)
	PositionY:SetPoint("TOPLEFT", PositionX, "BOTTOMLEFT", 0, -12)
	PositionY:SetPoint("TOPRIGHT", PositionX, "BOTTOMRIGHT", 0, -12)
	function PositionY:OnValueChanged(value)
		db.posy = value
		ShieldsUp:UpdateLayout()
	end

	local PaddingH = CreateSlider(self, L.PaddingH, L.PaddingH_Desc, 0, floor(UIWIDTH / 10) / 2 * 10, 1)
	PaddingH:SetPoint("TOPLEFT", PositionY, "BOTTOMLEFT", 0, -12)
	PaddingH:SetPoint("TOPRIGHT", PositionY, "BOTTOMRIGHT", 0, -12)
	function PaddingH:OnValueChanged(value)
		db.padh = value
		ShieldsUp:UpdateLayout()
	end

	local PaddingV = CreateSlider(self, L.PaddingV, L.PaddingV_Desc, 0, floor(UIWIDTH / 10) / 2 * 10, 1)
	PaddingV:SetPoint("TOPLEFT", PaddingH, "BOTTOMLEFT", 0, -12)
	PaddingV:SetPoint("TOPRIGHT", PaddingH, "BOTTOMRIGHT", 0, -12)
	function PaddingV:OnValueChanged(value)
		db.padv = value
		ShieldsUp:UpdateLayout()
	end

	local Opacity = CreateSlider(self, L.Opacity, nil, 0, 1, 0.05, true)
	Opacity:SetPoint("TOPLEFT", PaddingV, "BOTTOMLEFT", 0, -12)
	Opacity:SetPoint("TOPRIGHT", PaddingV, "BOTTOMRIGHT", 0, -12)
	function Opacity:OnValueChanged(value)
		db.alpha = value
		ShieldsUp:UpdateLayout()
	end

	--------------------------------------------------------------------

	local Font = LibStub("PhanxConfig-ScrollingDropdown").CreateScrollingDropdown(self, L.Font, nil, ShieldsUp.fonts)
	Font:SetPoint("TOPLEFT", Notes, "BOTTOM", 8, -12)
	Font:SetPoint("TOPRIGHT", Notes, "BOTTOMRIGHT", 0, -12)
	do
		local _, height, flags = Font.valueText:GetFont()
		Font.valueText:SetFont(SharedMedia:Fetch("font", db.font.face or "Friz Quadrata TT"), height, flags)

		function Font:OnValueChanged(value)
			local _, height, flags = self.valueText:GetFont()
			self.valueText:SetFont(SharedMedia:Fetch("font", value), height, flags)
			db.font.face = value
			ShieldsUp:UpdateLayout()
		end

		function Font.dropdown:OnListButtonChanged(button, item, selected)
			if button.value and button:IsShown() then
				button.label:SetFont(SharedMedia:Fetch("font", button.value), UIDROPDOWNMENU_DEFAULT_TEXT_HEIGHT)
			end
		end
	end

	--------------------------------------------------------------------

	local outlineValues = {
		NONE = L.None,
		OUTLINE = L.Thin,
		THICKOUTLINE = L.Thick,
	}
	local Outline
	do
		local function OnClick(self)
			db.font.outline = self.value
			ShieldsUp:UpdateLayout()
			Outline:SetValue(self.value, self.text or outlineValues[self.text])
		end
		Outline = CreateDropdown(self, L.Outline, nil, function()
			local selected = db.font.outline

			local info = UIDropDownMenu_CreateInfo()
			info.func = OnClick

			info.text = L.None
			info.value = "NONE"
			info.checked = "NONE" == selected
			UIDropDownMenu_AddButton(info)

			info.text = L.Thin
			info.value = "OUTLINE"
			info.checked = "OUTLINE" == selected
			UIDropDownMenu_AddButton(info)

			info.text = L.Thick
			info.value = "THICKOUTLINE"
			info.checked = "THICKOUTLINE" == selected
			UIDropDownMenu_AddButton(info)
		end)
		Outline:SetPoint("TOPLEFT", Font, "BOTTOMLEFT", 0, -12)
		Outline:SetPoint("TOPRIGHT", Font, "BOTTOMRIGHT", 0, -12)
	end

	local CounterSize = CreateSlider(self, L.CounterSize, nil, 6, 32, 1)
	CounterSize:SetPoint("TOPLEFT", Outline, "BOTTOMLEFT", 0, -12)
	CounterSize:SetPoint("TOPRIGHT", Outline, "BOTTOMRIGHT", 0, -12)
	function CounterSize:OnValueChanged(value)
		db.font.large = value
		ShieldsUp:UpdateLayout()
	end

	local NameSize = CreateSlider(self, L.NameSize, nil, 6, 32, 1)
	NameSize:SetPoint("TOPLEFT", CounterSize, "BOTTOMLEFT", 0, -12)
	NameSize:SetPoint("TOPRIGHT", CounterSize, "BOTTOMRIGHT", 0, -12)
	function NameSize:OnValueChanged(value)
		db.font.small = value
		ShieldsUp:UpdateLayout()
	end

	local Shadow = CreateCheckbox(self, L.Shadow)
	Shadow:SetPoint("TOPLEFT", NameSize, "BOTTOMLEFT", 0, -12)
	function Shadow:OnValueChanged(value)
		db.font.shadow = value
		ShieldsUp:UpdateLayout()
	end

	local ClassColor = CreateCheckbox(self, L.ClassColor, format(L.ClassColor_Desc, L.EarthShield))
	ClassColor:SetPoint("TOPLEFT", Shadow, "BOTTOMLEFT", 0, -8)
	function ClassColor:OnValueChanged(value)
		db.color.useClassColor = value
		ShieldsUp:UpdateDisplay()
	end

	--------------------------------------------------------------------

	local ColorPanel = CreatePanel(self)

	ColorPanel.label = ColorPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	ColorPanel.label:SetPoint("BOTTOMLEFT", ColorPanel, "TOPLEFT", 4, 0)
	ColorPanel.label:SetText(L.Colors)

	local py = 5 * (Opacity:GetHeight() + 12)
	ColorPanel:SetPoint("TOPLEFT", Notes, "BOTTOMLEFT", -2, -12 - py - ColorPanel.label:GetHeight())
	ColorPanel:SetPoint("TOPRIGHT", Notes, "BOTTOMRIGHT", 0, -12 - py - ColorPanel.label:GetHeight())

	local ColorEarth = CreateColorPicker(self, L.EarthShield)
	ColorEarth:SetPoint("TOPLEFT", ColorPanel, 8, -8)
	ColorEarth.GetColor = function() return unpack(db.color.earth) end
	ColorEarth.OnColorChanged = function(self, r, g, b)
		db.color.earth[1] = r
		db.color.earth[2] = g
		db.color.earth[3] = b
		ShieldsUp:UpdateDisplay()
	end

	local ColorLightning = CreateColorPicker(self, L.LightningShield)
	ColorLightning:SetPoint("TOPLEFT", ColorEarth, "BOTTOMLEFT", 0, -8)
	ColorLightning.GetColor = function() return unpack(db.color.lightning) end
	ColorLightning.OnColorChanged = function(self, r, g, b)
		db.color.lightning[1] = r
		db.color.lightning[2] = g
		db.color.lightning[3] = b
		ShieldsUp:UpdateDisplay()
	end

	local ColorWater = CreateColorPicker(self, L.WaterShield)
	ColorWater:SetPoint("TOPLEFT", ColorLightning, "BOTTOMLEFT", 0, -8)
	ColorWater.GetColor = function() return unpack(db.color.water) end
	ColorWater.OnColorChanged = function(self, r, g, b)
		db.color.water[1] = r
		db.color.water[2] = g
		db.color.water[3] = b
		ShieldsUp:UpdateDisplay()
	end

	local ColorActive = CreateColorPicker(self, L.Active, format(L.Active_Desc, L.EarthShield))
	ColorActive:SetPoint("TOPLEFT", ColorPanel, "TOP", 8, -8)
	ColorActive.GetColor = function() return unpack(db.color.normal) end
	ColorActive.OnColorChanged = function(self, r, g, b)
		db.color.normal[1] = r
		db.color.normal[2] = g
		db.color.normal[3] = b
		ShieldsUp:UpdateDisplay()
	end

	local ColorOverwritten = CreateColorPicker(self, L.Overwritten, format(L.Overwritten_Desc, L.EarthShield))
	ColorOverwritten:SetPoint("TOPLEFT", ColorActive, "BOTTOMLEFT", 0, -8)
	ColorOverwritten.GetColor = function() return unpack(db.color.overwritten) end
	ColorOverwritten.OnColorChanged = function(self, r, g, b)
		db.color.overwritten[1] = r
		db.color.overwritten[2] = g
		db.color.overwritten[3] = b
		ShieldsUp:UpdateDisplay()
	end

	local ColorMissing = CreateColorPicker(self, L.Missing, L.Missing_Desc)
	ColorMissing:SetPoint("TOPLEFT", ColorOverwritten, "BOTTOMLEFT", 0, -8)
	ColorMissing.GetColor = function() return unpack(db.color.alert) end
	ColorMissing.OnColorChanged = function(self, r, g, b)
		db.color.alert[1] = r
		db.color.alert[2] = g
		db.color.alert[3] = b
		ShieldsUp:UpdateDisplay()
	end

	ColorPanel:SetHeight(ColorEarth:GetHeight() * 3 + 32)

	--------------------------------------------------------------------

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
		ColorOverwritten:SetValue(db.color.overwritten)
		ColorMissing:SetValue(db.color.alert)
	end
end)

------------------------------------------------------------------------

optionsPanels[#optionsPanels +1] = CreateOptionsPanel(L.Alerts, ADDON_NAME, function(self)
	local db = ShieldsUpDB

	local SharedMedia = LibStub("LibSharedMedia-3.0", true)

	local CreatePanel = LibStub("PhanxConfig-Panel").CreatePanel
	local CreateCheckbox = LibStub("PhanxConfig-Checkbox").CreateCheckbox
	local CreateDropdown = LibStub("PhanxConfig-Dropdown").CreateDropdown

	local Title, Notes = LibStub("PhanxConfig-Header").CreateHeader(self, self.name, L.Alerts_Desc)

	--------------------------------------------------------------------

	local EarthPanel = CreatePanel(self)

	local EarthLabel = EarthPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	EarthLabel:SetPoint("BOTTOMLEFT", EarthPanel, "TOPLEFT", 4, 0)
	EarthLabel:SetText(L.EarthShield)

	EarthPanel:SetPoint("TOPLEFT", Notes, "BOTTOMLEFT", -4, -12 - EarthLabel:GetHeight())
	EarthPanel:SetPoint("TOPRIGHT", Notes, "BOTTOM", -4, -12 - EarthLabel:GetHeight())

	local EarthSound
	do
		local function OnClick(self)
			PlaySoundFile(SharedMedia:Fetch("sound", self.value), "Master")
			db.alert.earth.sound = self.value
			EarthSound:SetValue(self.value, self.text)
		end
		EarthSound = CreateDropdown(self, L.AlertSound, format(L.AlertSound_Desc, L.EarthShield), function(self)
			local info = UIDropDownMenu_CreateInfo()
			local selected = db.alert.earth.sound
			for i, sound in ipairs(ShieldsUp.sounds) do
				info.text = sound
				info.value = sound
				info.func = OnClick
				info.checked = sound == selected
				UIDropDownMenu_AddButton(info)
			end
		end)
		EarthSound:SetPoint("TOPLEFT", EarthPanel, 16, -16)
		EarthSound:SetPoint("TOPRIGHT", EarthPanel, -16, -16)
	end

	local EarthText = CreateCheckbox(self, L.AlertText, format(L.AlertText_Desc, L.EarthShield))
	EarthText:SetPoint("TOPLEFT", EarthSound, "BOTTOMLEFT", 0, -8)
	EarthText.OnValueChanged = function(self, checked)
		db.alert.earth.text = checked
	end

	local AlertOverwritten = CreateCheckbox(self, L.AlertOverwritten, format(L.AlertOverwritten_Desc, L.EarthShield))
	AlertOverwritten:SetPoint("TOPLEFT", EarthText, "BOTTOMLEFT", 0, -8)
	AlertOverwritten.OnValueChanged = function(self, checked)
		db.alert.earth.overwritten = checked
	end

	EarthPanel:SetHeight(16 + EarthSound:GetHeight() + 8 + EarthText:GetHeight() + 8 + AlertOverwritten:GetHeight() + 16)

	--------------------------------------------------------------------

	local WaterPanel = CreatePanel(self)

	local WaterLabel = WaterPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	WaterLabel:SetPoint("BOTTOMLEFT", WaterPanel, "TOPLEFT", 4, 0)
	WaterLabel:SetText(L.WaterShield)

	WaterPanel:SetPoint("TOPLEFT", Notes, "BOTTOM", 4, -12 - WaterLabel:GetHeight())
	WaterPanel:SetPoint("TOPRIGHT", Notes, "BOTTOMRIGHT", 4, -12 - WaterLabel:GetHeight())

	local WaterSound
	do
		local function OnClick(self)
			PlaySoundFile(SharedMedia:Fetch("sound", self.value), "Master")
			db.alert.water.sound = self.value
			WaterSound:SetValue(self.value, self.text)
		end
		WaterSound = CreateDropdown(self, L.AlertSound, format(L.AlertSound_Desc, L.WaterShield), function(self)
			local info = UIDropDownMenu_CreateInfo()
			local selected = db.alert.water.sound
			for i, sound in ipairs(ShieldsUp.sounds) do
				info.text = sound
				info.value = sound
				info.func = OnClick
				info.checked = sound == selected
				UIDropDownMenu_AddButton(info)
			end
		end)
		WaterSound:SetPoint("TOPLEFT", WaterPanel, 16, -16)
		WaterSound:SetPoint("TOPRIGHT", WaterPanel, -16, -16)
	end

	local WaterText = CreateCheckbox(self, L.AlertText, format(L.AlertText_Desc, L.WaterShield))
	WaterText:SetPoint("TOPLEFT", WaterSound, "BOTTOMLEFT", 0, -8)
	WaterText.OnValueChanged = function(self, checked)
		db.alert.water.text = checked
	end

	WaterPanel:SetHeight(16 + WaterSound:GetHeight() + 8 + WaterText:GetHeight() + 16)

	--------------------------------------------------------------------

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

		SinkPanel = CreatePanel(self)

		SinkLabel = SinkPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
		SinkLabel:SetPoint("BOTTOMLEFT", SinkPanel, "TOPLEFT", 4, 0)
		SinkLabel:SetText(L.AlertTextSink)

		SinkPanel:SetPoint("TOPLEFT", EarthPanel, "BOTTOMLEFT", 0, -12 - SinkLabel:GetHeight())
		SinkPanel:SetPoint("TOPRIGHT", WaterPanel, "BOTTOMRIGHT", 0, -12 - SinkLabel:GetHeight())

		do
			local function OnClick(self)
				SinkOptions.set(self.value, true)
				SinkPanel_Update()
				SinkOutput:SetValue(self.value, self.text or SinkList[self.value])
			end
			SinkOutput = CreateDropdown(self, SinkOptions.name, SinkOptions.desc, function()
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
			end)
			SinkOutput:SetPoint("TOPLEFT", SinkPanel, 16, -16)
			SinkOutput:SetPoint("TOPRIGHT", SinkPanel, "TOP", -8, -16)
		end

		do
			local function OnClick(self)
				SinkOptions.set("ScrollArea", self.value)
				SinkPanel_Update()
				SinkScrollArea:SetValue(self.value, self.text)
			end
			SinkScrollArea = CreateDropdown(self, SinkOptions.args.ScrollArea.name, SinkOptions.args.ScrollArea.desc, function()
				local info = UIDropDownMenu_CreateInfo()
				info.func = OnClick

				local selected = db.alert.output.sink20ScrollArea
				for i, v in ipairs(SinkOptions.args.ScrollArea.validate) do
					info.text = v
					info.value = v
					info.checked = v == selected
					UIDropDownMenu_AddButton(info)
				end
			end)
			SinkScrollArea:SetPoint("TOPLEFT", SinkPanel, "TOP", 8, -16)
			SinkScrollArea:SetPoint("TOPRIGHT", SinkPanel, -16, -16)
		end

		SinkSticky = CreateCheckbox(self, SinkOptions.args.Sticky.name, SinkOptions.args.Sticky.desc)
		SinkSticky:SetPoint("TOPLEFT", SinkOutput, "BOTTOMLEFT", 0, -8)
		SinkSticky.OnValueChanged = function(self, checked)
			SinkOptions.set("Sticky", checked)
			SinkPanel_Update()
		end

		SinkPanel_Update()
	end

	--------------------------------------------------------------------

	self.refresh = function()
		EarthText:SetChecked(db.alert.earth.text)
		EarthSound:SetValue(db.alert.earth.sound)
		AlertOverwritten:SetChecked(db.alert.earth.overwritten)

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

	local CreatePanel = LibStub("PhanxConfig-Panel").CreatePanel
	local CreateCheckbox = LibStub("PhanxConfig-Checkbox").CreateCheckbox

	local function OnClick(self, checked)
		db[self.key] = checked
		ShieldsUp:UpdateVisibility()
	end

	--------------------------------------------------------------------

	local Title, Notes = LibStub("PhanxConfig-Header").CreateHeader(self, self.name, L.Visibility_Desc)

	--------------------------------------------------------------------

	local HideInfinite = CreateCheckbox(self, L.HideInfinite, L.HideInfinite_Desc)
	HideInfinite:SetPoint("TOPLEFT", Notes, "BOTTOMLEFT", -2, -8)
	HideInfinite.OnClick = function(this, checked)
		db.hideInfinite = checked
		ShieldsUp:UpdateDisplayMode()
	end

	--------------------------------------------------------------------

	local ShowLabel = self:CreateFontString(nil, "OVERLAY", "GameFontHighlightMedium")
	ShowLabel:SetPoint("TOPLEFT", Notes, "BOTTOMLEFT", 2, -24 - HideInfinite:GetHeight())
	ShowLabel:SetPoint("TOPRIGHT", Notes, "BOTTOM", -8, -24 - HideInfinite:GetHeight())
	ShowLabel:SetJustifyH("LEFT")
	ShowLabel:SetTextColor(GameFontNormal:GetTextColor())
	ShowLabel:SetText(L.Show)

	local ShowSolo = CreateCheckbox(self, L.ShowSolo)
	ShowSolo:SetPoint("TOPLEFT", ShowLabel, "BOTTOMLEFT", -2, -8)
	ShowSolo.key = "showSolo"

	local ShowParty = CreateCheckbox(self, L.ShowParty)
	ShowParty:SetPoint("TOPLEFT", ShowSolo, "BOTTOMLEFT", 0, -8)
	ShowParty.OnClick = OnClick
	ShowParty.key = "showInParty"

	local ShowRaid = CreateCheckbox(self, L.ShowRaid)
	ShowRaid:SetPoint("TOPLEFT", ShowParty, "BOTTOMLEFT", 0, -8)
	ShowRaid.OnClick = OnClick
	ShowRaid.key = "showInRaid"

	local ShowArena = CreateCheckbox(self, L.ShowArena)
	ShowArena:SetPoint("TOPLEFT", ShowRaid, "BOTTOMLEFT", 0, -8)
	ShowArena.OnClick = OnClick
	ShowArena.key = "showInArena"

	local ShowBattleground = CreateCheckbox(self, L.ShowBattleground)
	ShowBattleground:SetPoint("TOPLEFT", ShowArena, "BOTTOMLEFT", 0, -8)
	ShowBattleground.OnClick = OnClick
	ShowBattleground.key = "showInBG"

	--------------------------------------------------------------------

	local HideLabel = self:CreateFontString(nil, "OVERLAY", "GameFontHighlightMedium")
	HideLabel:SetPoint("TOPLEFT", Notes, "BOTTOM", 8, -24 - HideInfinite:GetHeight())
	HideLabel:SetPoint("TOPRIGHT", Notes, "BOTTOMRIGHT", -8, -24 - HideInfinite:GetHeight())
	HideLabel:SetJustifyH("LEFT")
	HideLabel:SetTextColor(GameFontNormal:GetTextColor())
	HideLabel:SetText(L.Hide)

	local HideOOC = CreateCheckbox(self, L.HideOOC)
	HideOOC:SetPoint("TOPLEFT", HideLabel, "BOTTOMLEFT", -2, -8)
	HideOOC.OnClick = OnClick
	HideOOC.key = "hideOOC"

	local HideResting = CreateCheckbox(self, L.HideResting)
	HideResting:SetPoint("TOPLEFT", HideOOC, "BOTTOMLEFT", 0, -8)
	HideResting.OnClick = OnClick
	HideResting.key = "hideResting"

	--------------------------------------------------------------------

	self.refresh = function()
		HideInfinite:SetValue(db.hideInfinite)

		ShowSolo:SetValue(db.showSolo)
		ShowParty:SetValue(db.showInParty)
		ShowRaid:SetValue(db.showInRaid)
		ShowArena:SetValue(db.showInArena)
		ShowBattleground:SetValue(db.showInBG)

		HideOOC:SetValue(db.hideOOC)
		HideResting:SetValue(db.hideResting)
	end
end)

------------------------------------------------------------------------

optionsPanels[#optionsPanels +1] = LibStub("LibAboutPanel").new(ADDON_NAME, ADDON_NAME)

------------------------------------------------------------------------

SLASH_SHIELDSUP1 = "/sup"
SLASH_SHIELDSUP2 = "/shieldsup"
SlashCmdList.SHIELDSUP = function()
	InterfaceOptionsFrame_OpenToCategory(optionsPanels[#optionsPanels])
	InterfaceOptionsFrame_OpenToCategory(optionsPanels[1])
end

------------------------------------------------------------------------

local LibDataBroker = LibStub("LibDataBroker-1.1", true)
if LibDataBroker then
	LibDataBroker:NewDataObject(ADDON_NAME, {
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
end

------------------------------------------------------------------------