--[[
	ShieldsUp
	Simple shaman shield monitor.
	by Phanx < addons@phanx.net >
	http://www.wowinterface.com/downloads/info9165-ShieldsUp.html
	Copyright © 2008 Alyssa S. Kinley, a.k.a Phanx
	See included README for license terms and additional information.

	This file adds GUI configuration for ShieldsUp via the Blizzard Interface Options frame.
--]]

if not ShieldsUp then return end

------------------------------------------------------------------------

local CreatePanel
do
	local panelBackdrop = GameTooltip:GetBackdrop()
	function CreatePanel(parent, width, height)
		local frame = CreateFrame("Frame", nil, parent)
		frame:SetFrameStrata(parent:GetFrameStrata())
		frame:SetFrameLevel(parent:GetFrameLevel() + 1)

		frame:SetBackdrop(panelBackdrop)
		frame:SetBackdropColor(0.1, 0.1, 0.1, 0.5)
		frame:SetBackdropBorderColor(0.8, 0.8, 0.8, 0.5)

		frame:SetWidth(width or 1)
		frame:SetHeight(height or 1)

		return frame
	end
end

------------------------------------------------------------------------

local CreateCheckbox
do
	local function OnEnter(self)
		if self.tiptext then
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:SetText(self.tiptext, nil, nil, nil, nil, true)
		end
	end

	local function OnLeave()
		GameTooltip:Hide()
	end

	function CreateCheckbox(parent, text, size)
		local check = CreateFrame("CheckButton", nil, parent)
		check:SetWidth(size or 26)
		check:SetHeight(size or 26)

		check:SetHitRectInsets(0, -100, 0, 0)

		check:SetNormalTexture("Interface\\Buttons\\UI-CheckBox-Up")
		check:SetPushedTexture("Interface\\Buttons\\UI-CheckBox-Down")
		check:SetHighlightTexture("Interface\\Buttons\\UI-CheckBox-Highlight")
		check:SetDisabledCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled")
		check:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")

		check:SetScript("OnEnter", OnEnter)
		check:SetScript("OnLeave", OnLeave)

		check:SetScript("OnClick", Checkbox_OnClick)

		local label = check:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
		label:SetPoint("LEFT", check, "RIGHT", 0, 1)
		label:SetText(text)

		check.label = label

		return check
	end
end

------------------------------------------------------------------------

local CreateColorPicker
do
	local function OnEnter(self)
		local color = NORMAL_FONT_COLOR
		self.bg:SetVertexColor(color.r, color.g, color.b)

		if self.tiptext then
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:SetText(self.tiptext, nil, nil, nil, nil, true)
		end
	end

	local function OnLeave(self)
		local color = HIGHLIGHT_FONT_COLOR
		self.bg:SetVertexColor(color.r, color.g, color.b)

		GameTooltip:Hide()
	end

	local function OnClick(self)
		OnLeave(self)

		if ColorPickerFrame:IsShown() then
			ColorPickerFrame:Hide()
		else
			self.r, self.g, self.b = self:GetValue()

			UIDropDownMenuButton_OpenColorPicker(self)
			ColorPickerFrame:SetFrameStrata("TOOLTIP")
			ColorPickerFrame:Raise()
		end
	end

	local function SetColor(self, r, g, b)
	--	print("SetColor: " .. tostring(r) .. " " .. tostring(g) .. " " .. tostring(b))
		self.swatch:SetVertexColor(r, g, b)
		if not ColorPickerFrame:IsShown() then
			self:SetValue(r, g, b)
		end
	end

	function CreateColorPicker(parent, name)
		local frame = CreateFrame("Button", nil, parent)
		frame:SetHeight(19)
		frame:SetWidth(100)

		local swatch = frame:CreateTexture(nil, "OVERLAY")
		swatch:SetTexture("Interface\\ChatFrame\\ChatFrameColorSwatch")
		swatch:SetPoint("LEFT")
		swatch:SetWidth(19)
		swatch:SetHeight(19)

		local bg = frame:CreateTexture(nil, "BACKGROUND")
		bg:SetTexture(1, 1, 1)
		bg:SetPoint("CENTER", swatch)
		bg:SetWidth(16)
		bg:SetHeight(16)

		local label = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
		label:SetPoint("LEFT", swatch, "RIGHT", 4, 1)
		label:SetHeight(19)
		label:SetText(name)

		frame.SetColor = SetColor
		frame.swatchFunc = function() frame:SetColor(ColorPickerFrame:GetColorRGB()) end
		frame.cancelFunc = function() frame:SetColor(frame.r, frame.g, frame.b) end

		frame:SetScript("OnClick", OnClick)
		frame:SetScript("OnEnter", OnEnter)
		frame:SetScript("OnLeave", OnLeave)

		local width = 19 + 4 + label:GetStringWidth()
		if width > 100 then
			frame:SetWidth(width)
		end

		frame.swatch = swatch
		frame.bg = bg
		frame.label = label

		return frame
	end
end

------------------------------------------------------------------------

local CreateDropdown
do
	local function OnEnter(self)
		if self.tiptext then
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:SetText(self.tiptext, nil, nil, nil, nil, true)
		end
	end

	local function OnLeave()
		GameTooltip:Hide()
	end

	local function OnClick(self)
		PlaySound("igMainMenuOptionCheckBoxOn")
		ToggleDropDownMenu(nil, nil, self:GetParent())
	end

	local function OnHide()
		CloseDropDownMenus()
	end

	function CreateDropdown(parent, name)
		local frame = CreateFrame("Frame", nil, parent)
		frame:SetHeight(42)
		frame:SetWidth(162)
		frame:EnableMouse(true)
		frame:SetScript("OnEnter", OnEnter)
		frame:SetScript("OnLeave", OnLeave)
		frame:SetScript("OnHide", OnHide)

		local dropdown = CreateFrame("Frame", "ShieldsUp" .. name:gsub(" %a", string.upper):gsub(" ", "") .. "Dropdown", frame)
		dropdown:SetPoint("TOPLEFT", frame, -16, -14)
		dropdown:SetPoint("TOPRIGHT", frame, 16, -14)
		dropdown:SetHeight(32)

		local ltex = dropdown:CreateTexture(dropdown:GetName() .. "Left", "ARTWORK")
		ltex:SetTexture("Interface\\Glues\\CharacterCreate\\CharacterCreate-LabelFrame")
		ltex:SetTexCoord(0, 0.1953125, 0, 1)
		ltex:SetPoint("TOPLEFT", dropdown, 0, 17)
		ltex:SetWidth(25)
		ltex:SetHeight(64)

		local rtex = dropdown:CreateTexture(nil, "ARTWORK")
		rtex:SetTexture("Interface\\Glues\\CharacterCreate\\CharacterCreate-LabelFrame")
		rtex:SetTexCoord(0.8046875, 1, 0, 1)
		rtex:SetPoint("TOPRIGHT", dropdown, 0, 17)
		rtex:SetWidth(25)
		rtex:SetHeight(64)

		local mtex = dropdown:CreateTexture(nil, "ARTWORK")
		mtex:SetTexture("Interface\\Glues\\CharacterCreate\\CharacterCreate-LabelFrame")
		mtex:SetTexCoord(0.1953125, 0.8046875, 0, 1)
		mtex:SetPoint("LEFT", ltex, "RIGHT")
		mtex:SetPoint("RIGHT", rtex, "LEFT")
		mtex:SetHeight(64)

		local label = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
		label:SetPoint("BOTTOMLEFT", dropdown, "TOPLEFT", 20, 0)
		label:SetPoint("BOTTOMRIGHT", dropdown, "TOPRIGHT", -20, 0)
		label:SetJustifyH("LEFT")
		label:SetText(name)

		local value = dropdown:CreateFontString(dropdown:GetName() .. "Text", "ARTWORK", "GameFontHighlightSmall")
		value:SetPoint("LEFT", ltex, 26, 2)
		value:SetPoint("RIGHT", rtex, -43, 2)
		value:SetJustifyH("LEFT")
		value:SetHeight(10)

		local button = CreateFrame("Button", nil, dropdown)
		button:SetPoint("TOPRIGHT", rtex, -16, -18)
		button:SetWidth(24)
		button:SetHeight(24)
		button:SetScript("OnClick", OnClick)

		button:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up")
		button:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Down")
		button:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")
		button:SetDisabledTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Disabled")
		button:GetHighlightTexture():SetBlendMode("ADD")

		frame.dropdown = dropdown
		frame.label = label
		frame.value = value

		return frame
	end
end

------------------------------------------------------------------------

local CreateSlider
do
	local function OnEnter(self)
		if self.tiptext then
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:SetText(self.tiptext, nil, nil, nil, nil, true)
		end
	end

	local function OnLeave()
		GameTooltip:Hide()
	end

	local function OnMouseWheel(self, delta)
		local step = self:GetValueStep() * delta
		local minValue, maxValue = self:GetMinMaxValues()

		if step > 0 then
			self:SetValue(min(self:GetValue() + step, maxValue))
		else
			self:SetValue(max(self:GetValue() + step, minValue))
		end
	end

	local sliderBG = {
		bgFile = "Interface\\Buttons\\UI-SliderBar-Background",
		edgeFile = "Interface\\Buttons\\UI-SliderBar-Border",
		edgeSize = 8, tile = true, tileSize = 8,
		insets = { left = 3, right = 3, top = 6, bottom = 6 }
	}

	function CreateSlider(parent, name, lowvalue, highvalue, valuestep)
		local frame = CreateFrame("Frame", nil, parent)
		frame:SetWidth(144)
		frame:SetHeight(42)

	--	local bg = frame:CreateTexture(nil, "BACKGROUND")
	--	bg:SetAllPoints(frame)
	--	bg:SetTexture(0, 0, 0)

		local slider = CreateFrame("Slider", nil, frame)
		slider:SetPoint("LEFT")
		slider:SetPoint("RIGHT")
		slider:SetHeight(17)
		slider:SetHitRectInsets(0, 0, -10, -10)
		slider:SetOrientation("HORIZONTAL")
		slider:SetThumbTexture("Interface\\Buttons\\UI-SliderBar-Button-Horizontal")
		slider:SetBackdrop(sliderBG)

		local label = slider:CreateFontString(nil, "ARTWORK", "GameFontNormal")
		label:SetPoint("BOTTOMLEFT", slider, "TOPLEFT")
		label:SetPoint("BOTTOMRIGHT", slider, "TOPRIGHT")
		label:SetJustifyH("LEFT")
		label:SetText(name)

		local low = slider:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
		low:SetPoint("TOPLEFT", slider, "BOTTOMLEFT", -4, 3)
		low:SetText(lowvalue)

		local high = slider:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
		high:SetPoint("TOPRIGHT", slider, "BOTTOMRIGHT", 4, 3)
		high:SetText(highvalue)

		local value = slider:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
		value:SetPoint("TOP", slider, "BOTTOM", 0, 3)
		value:SetTextColor(1, 0.8, 0)

		slider:SetMinMaxValues(lowvalue, highvalue)
		slider:SetValueStep(valuestep or 1)

		slider:EnableMouseWheel(true)
		slider:SetScript("OnMouseWheel", OnMouseWheel)
		slider:SetScript("OnEnter", OnEnter)
		slider:SetScript("OnLeave", OnLeave)

		slider.label = label
		slider.low = low
		slider.high = high
		slider.value = value

		return slider
	end
end

------------------------------------------------------------------------

local panel = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
panel.name = GetAddOnMetadata("ShieldsUp", "Title")
panel:Hide()
panel:SetScript("OnShow", function(self)
	local L = ShieldsUp.L
	local db = ShieldsUpDB

	local screenwidth = UIParent:GetWidth()
	local screenheight = UIParent:GetHeight()

	-------------------------------------------------------------------

	local title = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	title:SetPoint("TOPLEFT", 16, -16)
	title:SetText(self.name)

	local notes = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	notes:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
	notes:SetPoint("RIGHT", self, -32, 0)
	notes:SetHeight(32)
	notes:SetJustifyH("LEFT")
	notes:SetJustifyV("TOP")
	notes:SetNonSpaceWrap(true)
	notes:SetText(L["ShieldsUp is a simple monitor for your shaman shields. Use these settings to configure the addon's appearance and behavior."])

	-------------------------------------------------------------------

	local posx = CreateSlider(self, L["Horizontal Position"], math.floor(screenwidth / 10) / 2 * -10, math.floor(screenwidth / 10) / 2 * 10, 5)
	posx.tiptext = L["Set the horizontal distance from the center of the screen."]
	posx:GetParent():SetPoint("TOPLEFT", notes, "BOTTOMLEFT", 0, -16)
	posx:GetParent():SetPoint("TOPRIGHT", notes, "BOTTOM", -8, 16)
	posx:SetValue(db.posx or 0)
	posx.value:SetText(db.posx or 0)
	posx:SetScript("OnValueChanged", function(self)
		db.posx = math.floor(self:GetValue())
		self.value:SetText(db.posx)
		ShieldsUp:ApplySettings()
	end)

	-------------------------------------------------------------------

	local posy = CreateSlider(self, L["Vertical Position"], floor(screenheight / 10) / 2 * -10, floor(screenheight / 10) / 2 * 10, 5)
	posy.tiptext = L["Set the vertical distance from the center of the screen."]
	posy:GetParent():SetPoint("TOPLEFT", posx, "BOTTOMLEFT", 0, -24)
	posy:GetParent():SetPoint("TOPRIGHT", posx, "BOTTOMRIGHT", 0, -24)
	posy:SetValue(db.posy or -150)
	posy.value:SetText(db.posy or 0)
	posy:SetScript("OnValueChanged", function(self)
		db.posy = floor(self:GetValue())
		self.value:SetText(db.posy)
		ShieldsUp:ApplySettings()
	end)

	-------------------------------------------------------------------

	local padh = CreateSlider(self, L["Horizontal Padding"], 0, floor(screenwidth / 10) / 2 * 10, 1)
	padh.tiptext = L["Set the horizontal space between display elements."]
	padh:GetParent():SetPoint("TOPLEFT", posy, "BOTTOMLEFT", 0, -24)
	padh:GetParent():SetPoint("TOPRIGHT", posy, "BOTTOMRIGHT", 0, -24)
	padh:SetValue(db.padh or 0)
	padh.value:SetText(db.padh or 0)
	padh:SetScript("OnValueChanged", function(self)
		db.padh = floor(self:GetValue())
		self.value:SetText(db.padh)
		ShieldsUp:ApplySettings()
	end)

	-------------------------------------------------------------------

	local padv = CreateSlider(self, L["Vertical Padding"], 0, floor(screenwidth / 10) / 2 * 10, 1)
	padv.tiptext = L["Set the vertical space between display elements."]
	padv:GetParent():SetPoint("TOPLEFT", padh, "BOTTOMLEFT", 0, -24)
	padv:GetParent():SetPoint("TOPRIGHT", padh, "BOTTOMRIGHT", 0, -24)
	padv:SetValue(db.padv or 0)
	padv.value:SetText(db.padv or 0)
	padv:SetScript("OnValueChanged", function(self)
		db.padv = floor(self:GetValue())
		self.value:SetText(db.padv)
		ShieldsUp:ApplySettings()
	end)

	-------------------------------------------------------------------

	local font = CreateDropdown(self, L["Typeface"])
	font.tiptext = L["Select a font face."]
	font:SetPoint("TOPLEFT", notes, "BOTTOM", 8, -16)
	font:SetPoint("TOPRIGHT", notes, "BOTTOMRIGHT", 2, -16)
	font.value:SetText(db.font.face or "Friz Quadrata TT")
	do
		local function OnClick(self)
			db.font.face = self.value
			font.value:SetText(self.value)
			UIDropDownMenu_SetSelectedValue(font.dropdown, self.value)
			ShieldsUp:ApplySettings()
		end

		UIDropDownMenu_Initialize(font.dropdown, function()
			local selected = UIDropDownMenu_GetSelectedValue(font.dropdown) or font.value:GetText()
			local info = UIDropDownMenu_CreateInfo()

			for i, font in ipairs(ShieldsUp.fonts) do
				info.text = font
				info.value = font
				info.func = OnClick
				info.checked = name == selected
				UIDropDownMenu_AddButton(info)
			end
		end)

		UIDropDownMenu_SetSelectedValue(font.dropdown, db.font.face or "Friz Quadrata TT")
	end

	-------------------------------------------------------------------

	local outline = CreateDropdown(self, L["Outline"])
	outline.tiptext = L["Select a outline face."]
	outline:SetPoint("TOPLEFT", font, "BOTTOMLEFT", 0, -8)
	outline:SetPoint("TOPRIGHT", font, "BOTTOMRIGHT", 0, -8)
	outline.value:SetText(db.font.outline or L["None"])
	do
		local outlines = { ["NONE"] = L["None"], ["OUTLINE"] = L["Thin"], ["THICKOUTLINE"] = L["Thick"] }

		local function OnClick(self)
			db.font.outline = self.value
			outline.value:SetText(self.text)
			UIDropDownMenu_SetSelectedValue(outline.dropdown, self.value)
			ShieldsUp:ApplySettings()
		end

		UIDropDownMenu_Initialize(outline.dropdown, function()
			local selected = outlines[UIDropDownMenu_GetSelectedValue(outline.dropdown)] or outline.value:GetText()
			local info = UIDropDownMenu_CreateInfo()

			for value, name in pairs(outlines) do
				info.text = name
				info.value = value
				info.func = OnClick
				info.checked = name == selected
				UIDropDownMenu_AddButton(info)
			end
		end)

		UIDropDownMenu_SetSelectedValue(outline.dropdown, db.font.outline or L["None"])
	end

	-------------------------------------------------------------------

	local shadow = CreateCheckbox(self, L["Shadow"])
	shadow.tiptext = L["Toggle the drop shadow effect."]
	shadow:SetPoint("TOPLEFT", outline, "BOTTOMLEFT", 0, -8)
	shadow:SetChecked(db.font.shadow)
	shadow:SetScript("OnClick", function(self)
		local checked = self:GetChecked()
		PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")
		db.font.shadow = checked and true or false
		ShieldsUp:ApplySettings()
	end)

	-------------------------------------------------------------------

	local colors = CreatePanel(self)
	colors:SetPoint("TOPLEFT", padv, "BOTTOMLEFT", -4, -32)
	colors:SetPoint("TOPRIGHT", notes, "BOTTOMRIGHT", 4, -16 - posx:GetHeight() - 24 - posy:GetHeight() - 24 - padh:GetHeight() - 24 - padv:GetHeight() - 24 - padv.label:GetHeight() - 32)
	colors:SetHeight(8 + 19 + 8 + 19 + 8 + 19 + 8)

	colors.label = self:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	colors.label:SetPoint("BOTTOMLEFT", colors, "TOPLEFT", 8, 0)
	colors.label:SetText(L["Colors"])

	-------------------------------------------------------------------

	local earth = CreateColorPicker(self, L["Earth Shield"])
	earth.tiptext = string.format(L["Set the color for the %s charge counter"], L["Earth Shield"])
	earth.GetValue = function() return unpack(db.color.earth) end
	earth.SetValue = function(self, r, g, b)
		db.color.earth[1] = r
		db.color.earth[2] = g
		db.color.earth[3] = b
		ShieldsUp:Update()
	end
	earth:SetPoint("TOPLEFT", colors, 8, -8)
	earth:SetPoint("TOPRIGHT", colors, "TOP", -8, -8)
	earth:SetColor(unpack(db.color.earth))

	-------------------------------------------------------------------

	local lightning = CreateColorPicker(self, L["Lightning Shield"])
	lightning.tiptext = string.format(L["Set the color for the %s charge counter"], L["Lightning Shield"])
	lightning.GetValue = function() return unpack(db.color.lightning) end
	lightning.SetValue = function(self, r, g, b)
		db.color.lightning[1] = r
		db.color.lightning[2] = g
		db.color.lightning[3] = b
		ShieldsUp:Update()
	end
	lightning:SetPoint("TOPLEFT", earth, "BOTTOMLEFT", 0, -8)
	lightning:SetPoint("TOPRIGHT", earth, "BOTTOMRIGHT", 0, -8)
	lightning:SetColor(unpack(db.color.lightning))

	-------------------------------------------------------------------

	local water = CreateColorPicker(self, L["Water Shield"])
	earth.tiptext = string.format(L["Set the color for the %s charge counter"], L["Water Shield"])
	water.GetValue = function() return unpack(db.color.water) end
	water.SetValue = function(self, r, g, b)
		db.color.water[1] = r
		db.color.water[2] = g
		db.color.water[3] = b
		ShieldsUp:Update()
	end
	water:SetPoint("TOPLEFT", lightning, "BOTTOMLEFT", 0, -8)
	water:SetPoint("TOPRIGHT", lightning, "BOTTOMRIGHT", 0, -8)
	water:SetColor(unpack(db.color.water))

	-------------------------------------------------------------------

	local normal = CreateColorPicker(self, L["Active"])
	normal.tiptext = string.format(L["Set the color for the target name while your %s is active."], L["Earth Shield"])
	normal.GetValue = function() return unpack(db.color.normal) end
	normal.SetValue = function(self, r, g, b)
		db.color.normal[1] = r
		db.color.normal[2] = g
		db.color.normal[3] = b
		ShieldsUp:Update()
	end
	normal:SetPoint("TOPLEFT", colors, "TOP", 8, -8)
	normal:SetPoint("TOPRIGHT", colors, -8, -8)
	normal:SetColor(unpack(db.color.normal))

	-------------------------------------------------------------------

	local overwritten = CreateColorPicker(self, L["Overwritten"])
	overwritten.tiptext = string.format(L["Set the color for the target name when your %s has been overwritten."], L["Earth Shield"])
	overwritten.GetValue = function() return unpack(db.color.overwritten) end
	overwritten.SetValue = function(self, r, g, b)
		db.color.overwritten[1] = r
		db.color.overwritten[2] = g
		db.color.overwritten[3] = b
		ShieldsUp:Update()
	end
	overwritten:SetPoint("TOPLEFT", normal, "BOTTOMLEFT", 0, -8)
	overwritten:SetPoint("TOPRIGHT", normal, "BOTTOMRIGHT", 0, -8)
	overwritten:SetColor(unpack(db.color.overwritten))

	-------------------------------------------------------------------

	local alert = CreateColorPicker(self, L["Zero"])
	alert.tiptext = string.format(L["Set the color for expired or otherwise inactive shields."])
	alert.GetValue = function() return unpack(db.color.alert) end
	alert.SetValue = function(self, r, g, b)
		db.color.alert[1] = r
		db.color.alert[2] = g
		db.color.alert[3] = b
		ShieldsUp:Update()
	end
	alert:SetPoint("TOPLEFT", overwritten, "BOTTOMLEFT", 0, -8)
	alert:SetPoint("TOPRIGHT", overwritten, "BOTTOMRIGHT", 0, -8)
	alert:SetColor(unpack(db.color.alert))

	-------------------------------------------------------------------

	self.refresh = function()
		posx:SetValue(db.posx or 0)
		posx.value:SetText(db.posx or 0)
		posy:SetValue(db.posy or -150)
		posy.value:SetText(db.posy or 0)
		padh:SetValue(db.padh or 0)
		padh.value:SetText(db.padh or 0)
		padv:SetValue(db.padv or 0)
		padv.value:SetText(db.padv or 0)

		font.value:SetText(db.font.face or "Friz Quadrata TT")
		UIDropDownMenu_SetSelectedValue(font.dropdown, db.font.face or "Friz Quadrata TT")
		outline.value:SetText(db.font.outline or L["None"])
		UIDropDownMenu_SetSelectedValue(outline.dropdown, db.font.outline or L["None"])
		shadow:SetChecked(db.font.shadow)

		earth:SetColor(unpack(db.color.earth))
		lightning:SetColor(unpack(db.color.lightning))
		water:SetColor(unpack(db.color.water))
		normal:SetColor(unpack(db.color.normal))
		overwritten:SetColor(unpack(db.color.overwritten))
		alert:SetColor(unpack(db.color.alert))
	end

	self:SetScript("OnShow", nil)
end)

InterfaceOptions_AddCategory(panel)

------------------------------------------------------------------------

local panel2 = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
panel2.name = ShieldsUp.L["Alerts"]
panel2.parent = panel.name
panel2:Hide()
panel2:SetScript("OnShow", function(self)
	local L = ShieldsUp.L
	local db = ShieldsUpDB
	local sinkOptions = ShieldsUp:GetSinkAce2OptionsDataTable().output

	-------------------------------------------------------------------

	local title = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	title:SetPoint("TOPLEFT", 16, -16)
	title:SetText(self.name)

	local notes = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	notes:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
	notes:SetPoint("RIGHT", self, -32, 0)
	notes:SetHeight(32)
	notes:SetJustifyH("LEFT")
	notes:SetJustifyV("TOP")
	notes:SetNonSpaceWrap(true)
	notes:SetText(L["Use these settings to configure how ShieldsUp alerts you when a shield expires or is removed."])

	-------------------------------------------------------------------

	local textlabel = self:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	textlabel:SetPoint("TOPLEFT", notes, "BOTTOMLEFT", 0, -16)
	textlabel:SetPoint("TOPRIGHT", notes, "BOTTOMRIGHT", 0, -16)
	textlabel:SetJustifyH("LEFT")
	textlabel:SetText(L["Text Alerts"])

	local textpanel = CreatePanel(self)
	textpanel:SetPoint("TOPLEFT", textlabel, "BOTTOMLEFT", -4, 0)
	textpanel:SetPoint("TOPRIGHT", textlabel, "BOTTOMRIGHT", 4, 0)

	-------------------------------------------------------------------

	local earthtext = CreateCheckbox(self, L["Earth Shield"])
	earthtext.tiptext = L["Show a text message when %s expires."]:format(L["Earth Shield"])
	earthtext:SetPoint("TOPLEFT", textpanel, 8, -8)
	earthtext:SetChecked(db.alert.earth.text)
	earthtext:SetScript("OnClick", function()
		local checked = self:GetChecked()
		PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")
		db.alert.earth.text = checked and true or false
	end)

	-------------------------------------------------------------------

	local watertext = CreateCheckbox(self, L["Water Shield"])
	watertext.tiptext = L["Show a text message when %s expires."]:format(L["Water Shield"])
	watertext:SetPoint("TOPLEFT", textpanel, "TOP", 8, -8)
	watertext:SetChecked(db.alert.water.text)
	watertext:SetScript("OnClick", function()
		local checked = self:GetChecked()
		PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")
		db.alert.water.text = checked and true or false
	end)

	-------------------------------------------------------------------

	textpanel:SetHeight(8 + earthtext:GetHeight() + 8)

	-------------------------------------------------------------------

	local output, scrollarea, sticky
	if ShieldsUp.Pour then
		output = CreateDropdown(self, sinkOptions.name)
		output.tiptext = sinkOptions.desc
		output:SetPoint("TOPLEFT", earthtext, "BOTTOMLEFT", 0, -8)
		output:SetPoint("TOPRIGHT", watertext, "BOTTOMLEFT", -16, -8)
		output.value:SetText(db.alert.output.sink20OutputSink or L["Raid Warning"])
		do
			local function OnClick(self)
				sinkOptions.set(self.value, true)

				sinkOptions = ShieldsUp:GetSinkAce2OptionsDataTable().output
				if sinkOptions.args.ScrollArea.disabled then
					scrollarea:Hide()
				else
					scrollarea:Show()
				end
				if sinkOptions.args.Sticky.disabled then
					sticky:Hide()
					textpanel:SetHeight(8 + earthtext:GetHeight() + 8 + output:GetHeight() + 8)
				else
					sticky:Show()
					textpanel:SetHeight(8 + earthtext:GetHeight() + 8 + output:GetHeight() + 8 + sticky:GetHeight() + 8)
				end

				output.value:SetText(self.text)
				UIDropDownMenu_SetSelectedValue(output.dropdown, self.value)
			end

			UIDropDownMenu_Initialize(output.dropdown, function()
				local selected = db.alert.output.sink20OutputSink or output.value:GetText()
				local info = UIDropDownMenu_CreateInfo()

				for k, v in pairs(sinkOptions.args) do
					if k ~= "Default" and v.isRadio and not (v.hidden and v.hidden()) then
						info.text = v.name
						info.value = k
						info.func = OnClick
						info.checked = v.name == selected
						UIDropDownMenu_AddButton(info)
					end
				end
			end)

			UIDropDownMenu_SetSelectedValue(output.dropdown, db.alert.output.sink20OutputSink or "RaidWarning")
		end

		--------------------------------------------------------------

		scrollarea = CreateDropdown(self, sinkOptions.args.ScrollArea.name)
		scrollarea.tiptext = sinkOptions.args.ScrollArea.desc
		scrollarea:SetPoint("TOPLEFT", watertext, "BOTTOMLEFT", 0, -8)
		scrollarea:SetPoint("TOPRIGHT", textpanel, -8, -8 - watertext:GetHeight() - 8)
		scrollarea.value:SetText(db.alert.output.sink20ScrollArea)
		do
			local function OnClick(self)
				sinkOptions.set(self.value, true)

				sinkOptions = ShieldsUp:GetSinkAce2OptionsDataTable().output

				scrollarea.value:SetText(self.text)
				UIDropDownMenu_SetSelectedValue(scrollarea.dropdown, self.value)
			end

			UIDropDownMenu_Initialize(scrollarea.dropdown, function()
				local selected = db.alert.output.sink20ScrollArea or scrollarea.value:GetText()
				local info = UIDropDownMenu_CreateInfo()

				for i, v in ipairs(sinkOptions.args.ScrollArea.validate) do
					info.text = v
					info.value = v
					info.func = OnClick
					info.checked = v == selected
					UIDropDownMenu_AddButton(info)
				end
			end)

			UIDropDownMenu_SetSelectedValue(scrollarea.dropdown, db.alert.output.sink20ScrollArea)
		end

		--------------------------------------------------------------

		sticky = CreateCheckbox(self, sinkOptions.args.Sticky.name)
		sticky.tiptext = sinkOptions.args.Sticky.desc
		sticky:SetPoint("TOPLEFT", scrollarea, "BOTTOMLEFT", 0, -8)
		sticky:SetChecked(db.alert.output.sink20Sticky)
		sticky:SetScript("OnClick", function(self)
			local checked = self:GetChecked()
			PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")
			db.alert.output.sink20Sticky = checked and true or false
		end)

		--------------------------------------------------------------
--[[
		if sinkOptions.args.ScrollArea.disabled then
			scrollarea:Hide()
		end
		if sinkOptions.args.Sticky.disabled then
			sticky:Hide()
		end
]]
		textpanel:SetHeight(8 + earthtext:GetHeight() + 8 + output:GetHeight() + 8 + (sticky:IsShown() and (sticky:GetHeight() + 8) or 0))
	end

	-------------------------------------------------------------------

	local soundlabel = self:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	soundlabel:SetPoint("TOPLEFT", textpanel, "BOTTOMLEFT", 0, -32)
	soundlabel:SetPoint("TOPRIGHT", textpanel, "BOTTOMRIGHT", 0, -32)
	soundlabel:SetJustifyH("LEFT")
	soundlabel:SetText(L["Sound Alerts"])

	local soundpanel = CreatePanel(self)
	soundpanel:SetPoint("TOPLEFT", soundlabel, "BOTTOMLEFT", -4, 0)
	soundpanel:SetPoint("TOPRIGHT", soundlabel, "BOTTOMRIGHT", 4, 0)

	-------------------------------------------------------------------

	local earthsound = CreateCheckbox(self, L["Earth Shield"])
	earthsound.tiptext = L["Play a sound when %s expires."]:format(L["Earth Shield"])
	earthsound:SetPoint("TOPLEFT", soundpanel, 8, -8)
	earthsound:SetChecked(db.alert.earth.sound)
	earthsound:SetScript("OnClick", function()
		local checked = self:GetChecked()
		PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")
		db.alert.earth.sound = checked and true or false
	end)

	-------------------------------------------------------------------

	local watersound = CreateCheckbox(self, L["Water Shield"])
	watersound.tiptext = L["Play a sound when when %s expires."]:format(L["Water Shield"])
	watersound:SetPoint("TOPLEFT", soundpanel, "TOP", 8, -8)
	watersound:SetChecked(db.alert.water.sound)
	watersound:SetScript("OnClick", function()
		local checked = self:GetChecked()
		PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")
		db.alert.water.sound = checked and true or false
	end)

	-------------------------------------------------------------------

	local esoundfile = CreateDropdown(self, L["Sound File"])
	esoundfile.tiptext = L["Select the sound file to play when %s expires."]:format(L["Earth Shield"])
	esoundfile:SetPoint("TOPLEFT", earthsound, "BOTTOMLEFT", 0, -8)
	esoundfile:SetPoint("TOPRIGHT", watersound, "BOTTOMLEFT", -16, -8)
	esoundfile.value:SetText(db.alert.earth.soundFile)
	do
		local function OnClick(self)
			db.alert.earth.soundFile = self.value
			esoundfile.value:SetText(self.text)
			UIDropDownMenu_SetSelectedValue(esoundfile.dropdown, self.value)
		end

		UIDropDownMenu_Initialize(esoundfile.dropdown, function()
			local selected = UIDropDownMenu_GetSelectedValue(font.dropdown) or esoundfile.value:GetText()
			local info = UIDropDownMenu_CreateInfo()

			for i, sound in ipairs(ShieldsUp.sounds) do
				info.text = sound
				info.value = sound
				info.func = OnClick
				info.checked = sound == selected
				UIDropDownMenu_AddButton(info)
			end
		end)

		UIDropDownMenu_SetSelectedValue(esoundfile.dropdown, db.alert.earth.soundFile)
	end

	-------------------------------------------------------------------

	local wsoundfile = CreateDropdown(self, L["Sound File"])
	wsoundfile.tiptext = L["Select the sound file to play when %s expires."]:format(L["Water Shield"])
	wsoundfile.tiptext = L["Select
	wsoundfile:SetPoint("TOPLEFT", earthsound, "BOTTOMLEFT", 0, -8)
	wsoundfile:SetPoint("TOPRIGHT", watersound, "BOTTOMLEFT", -16, -8)
	wsoundfile.value:SetText(db.alert.water.soundFile)
	do
		local function OnClick(self)
			db.alert.water.soundFile = self.value
			wsoundfile.value:SetText(self.text)
			UIDropDownMenu_SetSelectedValue(wsoundfile.dropdown, self.value)
		end

		UIDropDownMenu_Initialize(wsoundfile.dropdown, function()
			local selected = UIDropDownMenu_GetSelectedValue(font.dropdown) or wsoundfile.value:GetText()
			local info = UIDropDownMenu_CreateInfo()

			for i, sound in ipairs(ShieldsUp.sounds) do
				info.text = sound
				info.value = sound
				info.func = OnClick
				info.checked = sound == selected
				UIDropDownMenu_AddButton(info)
			end
		end)

		UIDropDownMenu_SetSelectedValue(wsoundfile.dropdown, db.alert.water.soundFile)
	end

	-------------------------------------------------------------------

	soundpanel:SetHeight(8 + earthsound:GetHeight() + 8)

	-------------------------------------------------------------------

	self.refresh = function()
	end

	self:SetScript("OnShow", nil)
end)

InterfaceOptions_AddCategory(panel2)

------------------------------------------------------------------------

if LibStub:GetLibrary("tekKonfig-AboutPanel", true) then
	-- this will be embedded in release version, but for now I don't want to deal with it
	LibStub:GetLibrary("tekKonfig-AboutPanel").new(panel.name, "ShieldsUp")
end

------------------------------------------------------------------------

SLASH_SHIELDSUP1 = "/sup"
SLASH_SHIELDSUP2 = "/shieldsup"
SlashCmdList.SHIELDSUP = function() InterfaceOptionsFrame_OpenToCategory(panel) end