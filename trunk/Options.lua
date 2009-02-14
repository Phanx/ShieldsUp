--[[--------------------------------------------------------------------
	ShieldsUp
	Simple shaman shield monitor.
	by Phanx < addons@phanx.net >
	http://www.wowinterface.com/downloads/info9165-ShieldsUp.html
	Copyright © 2008 Alyssa S. Kinley, a.k.a Phanx
	See included README for license terms and additional information.

	This file adds GUI configuration for ShieldsUp
	via the Blizzard Interface Options frame.
----------------------------------------------------------------------]]

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
		if self.hint then
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:SetText(self.hint, nil, nil, nil, nil, true)
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

		if self.hint then
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:SetText(self.hint, nil, nil, nil, nil, true)
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
		if self.hint then
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:SetText(self.hint, nil, nil, nil, nil, true)
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

	local i = 0
	function CreateDropdown(parent, name)
		i = i + 1

		local frame = CreateFrame("Frame", nil, parent)
		frame:SetHeight(42)
		frame:SetWidth(162)
		frame:EnableMouse(true)
		frame:SetScript("OnEnter", OnEnter)
		frame:SetScript("OnLeave", OnLeave)
		frame:SetScript("OnHide", OnHide)

		local dropdown = CreateFrame("Frame", "ShieldsUpDropdown" .. i, frame)
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
		frame.button = button
		frame.label = label
		frame.value = value

		return frame
	end
end

------------------------------------------------------------------------

local CreateScrollingDropdown
do
	local MAX_LIST_SIZE = 15

	local function ListButton_OnClick(self)
		local frame = self:GetParent():GetParent()
		frame.list.selected = self.value
		frame.list:Hide()
		frame.value:SetText(self.value)

		if frame.OnValueChanged then
			frame:OnValueChanged(self.value)
		end

		PlaySound("UChatScrollButton")
	end

	local function CreateListButton(parent)
		local button = CreateFrame("Button", nil, parent)
		button:SetHeight(UIDROPDOWNMENU_BUTTON_HEIGHT)

		button.label = button:CreateFontString()
		button.label:SetFont("Fonts\\FRIZQT__.ttf", UIDROPDOWNMENU_DEFAULT_TEXT_HEIGHT)
		button.label:SetJustifyH("LEFT")
		button.label:SetPoint("LEFT", 27, 0)

		button.check = button:CreateTexture(nil, "ARTWORK")
		button.check:SetWidth(24)
		button.check:SetHeight(24)
		button.check:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")
		button.check:SetPoint("LEFT")

		local highlight = button:CreateTexture(nil, "BACKGROUND")
		highlight:SetAllPoints(button)
		highlight:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
		highlight:SetAlpha(0.4)
		highlight:SetBlendMode("ADD")
		highlight:Hide()
		button:SetHighlightTexture(highlight)

		button:SetScript("OnClick", ListButton_OnClick)

		return button
	end

	local function UpdateListWidth(self)
		self.width = 0
		for i, item in pairs(self:GetParent().items) do
			self.text:SetText(item)
			self.width = max(self.text:GetWidth() + 60, self.width)
		end
	end

	local function UpdateList(self)
		local buttons = self.buttons
		local items = self:GetParent().items
		local listSize = min(#items, MAX_LIST_SIZE)

		local scrollFrame = self.scrollFrame
		local offset = scrollFrame.offset
		FauxScrollFrame_Update(scrollFrame, #items, listSize, UIDROPDOWNMENU_BUTTON_HEIGHT)

		for i = 1, listSize do
			local index = i + offset
			local button = self.buttons[i]

			local item = items[index]
			if item then
				button.value = item
				button.label:SetText(item)

				if item == self.selected then
					button.check:Show()
				else
					button.check:Hide()
				end

				button:SetWidth(self.width)
				button:Show()
			else
				button.value = nil
				button.label:SetText()
				button.check:Hide()
				button:Hide()
			end
		end

		for i = listSize + 1, #buttons do
			buttons[i]:Hide()
		end

		if self.scrollFrame:IsShown() then
			self:SetWidth(self.width + 50)
		else
			self:SetWidth(self.width + 30)
		end
		self:SetHeight((listSize * UIDROPDOWNMENU_BUTTON_HEIGHT) + (UIDROPDOWNMENU_BORDER_HEIGHT * 2))
	end

	local function CreateList(parent)
		local list = CreateFrame("Button", parent:GetName() .. "List", parent)
		list:SetToplevel(true)
		list:Raise()

		list.text = list:CreateFontString()
		list.text:SetFont("Fonts\\FRIZQT__.ttf", UIDROPDOWNMENU_DEFAULT_TEXT_HEIGHT + 2)

		list.buttons = setmetatable({}, { __index = function(t, i)
			local button = CreateListButton(list)
			if i > 1 then
				button:SetPoint("TOPLEFT", t[i-1], "BOTTOMLEFT")
			else
				button:SetPoint("TOPLEFT", 15, -15)
			end
			t[i] = button

			return button
		end })

		list.scrollFrame = CreateFrame("ScrollFrame", list:GetName() .. "ScrollFrame", list, "FauxScrollFrameTemplate")
		list.scrollFrame:SetPoint("TOPLEFT", 12, -14)
		list.scrollFrame:SetPoint("BOTTOMRIGHT", -36, 13)
		list.scrollFrame:SetScript("OnVerticalScroll", function(self, delta)
			FauxScrollFrame_OnVerticalScroll(self, delta, UIDROPDOWNMENU_BUTTON_HEIGHT, function() UpdateList(list) end)
		end)

		list:SetBackdrop({
			bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
			edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
			insets = { left = 11, right = 12, top = 12, bottom = 11 },
			tile = true, tileSize = 32, edgeSize = 32,
		})

		list:SetScript("OnShow", function(self)
			UpdateListWidth(self)
			UpdateList(self)
		end)
		list:SetScript("OnHide", list.Hide)
		list:SetScript("OnClick", list.Hide)
		list:SetPoint("TOPLEFT", parent, "BOTTOMLEFT", 6, 8)
		list:Hide()

		return list
	end

	local function DropdownButton_OnClick(self)
		local list = self:GetParent().list
		if list then
			if list:IsShown() then
				list:Hide()
			else
				list:Show()
			end
		else
			self:GetParent().list = CreateList(self:GetParent())
			self:GetParent().list:Show()
		end
	end

	function CreateScrollingDropdown(parent, name, items)
		local frame = CreateDropdown(parent, name)
		frame.button:SetScript("OnClick", DropdownButton_OnClick)
		frame.dropdown.items = items

		return frame
	end
end

------------------------------------------------------------------------

local CreateSlider
do
	local function OnEnter(self)
		if self.hint then
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:SetText(self.hint, nil, nil, nil, nil, true)
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

local panel = CreateFrame("Frame", "ShieldsUpOptionsFrame", InterfaceOptionsFramePanelContainer)
panel.name = GetAddOnMetadata("ShieldsUp", "Title")
panel:Hide()
panel:SetScript("OnShow", function(self)
	local L = ShieldsUp.L
	local db = ShieldsUpDB
	local LSM = LibStub("LibSharedMedia-3.0", true)

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
	posx.hint = L["Set the horizontal distance from the center of the screen."]
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
	posy.hint = L["Set the vertical distance from the center of the screen."]
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
	padh.hint = L["Set the horizontal space between display elements."]
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
	padv.hint = L["Set the vertical space between display elements."]
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

	local face = CreateScrollingDropdown(self, L["Typeface"], ShieldsUp.fonts)
	face.hint = L["Select the typeface."]
	face:SetPoint("TOPLEFT", notes, "BOTTOM", 8, -16)
	face:SetPoint("TOPRIGHT", notes, "BOTTOMRIGHT", 2, -16)
	face.value:SetText(db.font.face or "Friz Quadrata TT")
	do
		local _, height, flags = face.value:GetFont()
		face.value:SetFont(LSM:Fetch("font", db.font.face or "Friz Quadrata TT"), height, flags)

		function face:OnValueChanged(value)
			local _, height, flags = self.value:GetFont()
			self.value:SetFont(LSM:Fetch("font", value), height, flags)
			db.font.face = value
			ShieldsUp:ApplySettings()
		end

		local OnClick = face.button:GetScript("OnClick")
		face.button:SetScript("OnClick", function(self)
			OnClick(self)
			face.dropdown.list:Hide()

			local function SetButtonFonts(self)
				for i = 1, #self.buttons do
					local button = self.buttons[i]
					if button.value and button:IsShown() then
						button.label:SetFont(LSM:Fetch("font", button.value), UIDROPDOWNMENU_DEFAULT_TEXT_HEIGHT)
					end
				end
			end

			local OnShow = face.dropdown.list:GetScript("OnShow")
			face:SetScript("OnShow", function(self)
				OnShow(self)
				SetButtonFonts(self)
			end)

			local OnVerticalScroll = face.dropdown.list.scrollFrame:GetScript("OnVerticalScroll")
			face.dropdown.list.scrollFrame:SetScript("OnVerticalScroll", function(self, delta)
				OnVerticalScroll(self, delta)
				SetButtonFonts(self)
			end)

			local SetText = face.dropdown.list.text.SetText
			face.dropdown.list.text.SetText = function(self, text)
				self.list.text:SetFont(LSM:Fetch("font", text), UIDROPDOWNMENU_DEFAULT_TEXT_HEIGHT + 1)
				SetText(self, text)
			end

			OnClick(self)

			self:SetScript("OnClick", OnClick)
		end)
	end

	-------------------------------------------------------------------

	local outline = CreateDropdown(self, L["Outline"])
	outline.hint = L["Select an outline width."]
	outline:SetPoint("TOPLEFT", face, "BOTTOMLEFT", 0, -8)
	outline:SetPoint("TOPRIGHT", face, "BOTTOMRIGHT", 0, -8)
	do
		local outlines = { ["NONE"] = L["None"], ["OUTLINE"] = L["Thin"], ["THICKOUTLINE"] = L["Thick"] }

		outline.value:SetText(outlines[db.font.outline] or L["None"])

		local function OnClick(self)
			db.font.outline = self.value
			ShieldsUp:ApplySettings()
			outline.value:SetText(self.text)
			UIDropDownMenu_SetSelectedValue(outline.dropdown, self.value)
		end

		UIDropDownMenu_Initialize(outline.dropdown, function()
			local selected = outlines[UIDropDownMenu_GetSelectedValue(outline.dropdown)] or outline.value:GetText()
			local info = UIDropDownMenu_CreateInfo()

			for value, name in pairs(outlines) do
				print("text = " .. name .. ", value = " .. value)
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
	shadow.hint = L["Toggle the drop shadow effect."]
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
	earth.hint = string.format(L["Set the color for the %s charge counter"], L["Earth Shield"])
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
	lightning.hint = string.format(L["Set the color for the %s charge counter"], L["Lightning Shield"])
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
	earth.hint = string.format(L["Set the color for the %s charge counter"], L["Water Shield"])
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
	normal.hint = string.format(L["Set the color for the target name while your %s is active."], L["Earth Shield"])
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
	overwritten.hint = string.format(L["Set the color for the target name when your %s has been overwritten."], L["Earth Shield"])
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
	alert.hint = string.format(L["Set the color for expired or otherwise inactive shields."])
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
	local sinkOptions

	-------------------------------------------------------------------

	local title = self:CreateFontString("ShieldsUpAlertTitle", "ARTWORK", "GameFontNormalLarge")
	title:SetPoint("TOPLEFT", 16, -16)
	title:SetText(self.name)

	local notes = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	notes:SetPoint("TOPLEFT", 16, -16 - 20 - 8)
	notes:SetPoint("TOPRIGHT", -16, -16 - 20 - 8)
	notes:SetJustifyH("LEFT")
	notes:SetJustifyV("TOP")
	notes:SetNonSpaceWrap(true)
	notes:SetText(L["Use these settings to configure how ShieldsUp alerts you when a shield expires or is removed."])

	-------------------------------------------------------------------

	local elabel = self:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	elabel:SetPoint("TOPLEFT", notes, "BOTTOMLEFT", 0, -16)
	elabel:SetPoint("TOPRIGHT", notes, "BOTTOMRIGHT", 0, -16)
	elabel:SetJustifyH("LEFT")
	elabel:SetText(L["Earth Shield"])

	local epanel = CreatePanel(self)
	epanel:SetPoint("TOPLEFT", elabel, "BOTTOMLEFT", -4, 0)
	epanel:SetPoint("TOPRIGHT", elabel, "BOTTOMRIGHT", 4, 0)

	-------------------------------------------------------------------

	local etext = CreateCheckbox(self, L["Text alert"])
	etext.hint = L["Show a text message when %s expires."]:format(L["Earth Shield"])
	etext:SetPoint("TOPLEFT", epanel, 8, -8)
	etext:SetChecked(db.alert.earth.text)
	etext:SetScript("OnClick", function()
		local checked = self:GetChecked()
		PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")
		db.alert.earth.text = checked and true or false
	end)

	-------------------------------------------------------------------

	local esound = CreateCheckbox(self, L["Sound alert"])
	esound.hint = L["Play a sound when %s expires."]:format(L["Earth Shield"])
	esound:SetPoint("TOPLEFT", etext, "BOTTOMLEFT", 0, -8)
	esound:SetChecked(db.alert.earth.sound)
	esound:SetScript("OnClick", function()
		local checked = self:GetChecked()
		PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")
		db.alert.earth.sound = checked and true or false
	end)

	local esoundfile = CreateDropdown(self, L["Sound file"])
	esoundfile.hint = L["Select the sound to play when %s expires."]:format(L["Earth Shield"])
	esoundfile:SetPoint("BOTTOMLEFT", epanel, "BOTTOM", 8, 8)
	esoundfile:SetPoint("BOTTOMRIGHT", epanel, -8, 8)
	esoundfile.value:SetText(db.alert.earth.soundFile)
	do
		local function OnClick(self)
			PlaySoundFile(LSM:Fetch("sound", self.value))
			db.alert.earth.soundFile = self.value
			esoundfile.value:SetText(self.text)
			UIDropDownMenu_SetSelectedValue(esoundfile.dropdown, self.value)
		end

		UIDropDownMenu_Initialize(esoundfile.dropdown, function()
			local selected = UIDropDownMenu_GetSelectedValue(esoundfile.dropdown) or esoundfile.value:GetText()
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

	epanel:SetHeight(8 + etext:GetHeight() + 8 + esound:GetHeight() + 8)

	-------------------------------------------------------------------

	local wlabel = self:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	wlabel:SetPoint("TOPLEFT", epanel, "BOTTOMLEFT", 4, -8)
	wlabel:SetPoint("TOPRIGHT", epanel, "BOTTOMRIGHT", -4, -8)
	wlabel:SetJustifyH("LEFT")
	wlabel:SetText(L["Water Shield"])

	local wpanel = CreatePanel(self)
	wpanel:SetPoint("TOPLEFT", wlabel, "BOTTOMLEFT", -4, 0)
	wpanel:SetPoint("TOPRIGHT", wlabel, "BOTTOMRIGHT", 4, 0)

	-------------------------------------------------------------------

	local wtext = CreateCheckbox(self, L["Text alert"])
	wtext.hint = L["Show a text message when %s expires."]:format(L["Water Shield"])
	wtext:SetPoint("TOPLEFT", wpanel, 8, -8)
	wtext:SetChecked(db.alert.water.text)
	wtext:SetScript("OnClick", function()
		local checked = self:GetChecked()
		PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")
		db.alert.water.text = checked and true or false
	end)

	-------------------------------------------------------------------

	local wsound = CreateCheckbox(self, L["Sound alert"])
	wsound.hint = L["Play a sound when when %s expires."]:format(L["Water Shield"])
	wsound:SetPoint("TOPLEFT", wtext, "BOTTOMLEFT", 0, -8)
	wsound:SetChecked(db.alert.water.sound)
	wsound:SetScript("OnClick", function()
		local checked = self:GetChecked()
		PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")
		db.alert.water.sound = checked and true or false
	end)

	-------------------------------------------------------------------

	local wsoundfile = CreateDropdown(self, L["Sound file"])
	wsoundfile.hint = L["Select the sound file to play when %s expires."]:format(L["Water Shield"])
	wsoundfile:SetPoint("BOTTOMLEFT", wpanel, "BOTTOM", 8, 8)
	wsoundfile:SetPoint("BOTTOMRIGHT", wpanel, -8, 8)
	wsoundfile.value:SetText(db.alert.water.soundFile)
	do
		local function OnClick(self)
			PlaySoundFile(LSM:Fetch("sound", self.value))
			db.alert.water.soundFile = self.value
			wsoundfile.value:SetText(self.text)
			UIDropDownMenu_SetSelectedValue(wsoundfile.dropdown, self.value)
		end

		UIDropDownMenu_Initialize(wsoundfile.dropdown, function()
			local selected = UIDropDownMenu_GetSelectedValue(wsoundfile.dropdown) or wsoundfile.value:GetText()
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

	wpanel:SetHeight(8 + wtext:GetHeight() + 8 + wsound:GetHeight() + 8)

	-------------------------------------------------------------------

	local olabel, opanel, output, scrollarea, sticky
	if ShieldsUp.Pour then
		sinkOptions = ShieldsUp:GetSinkAce2OptionsDataTable().output

		olabel = self:CreateFontString(nil, "OVERLAY", "GameFontNormal")
		olabel:SetPoint("TOPLEFT", wpanel, "BOTTOMLEFT", 4, -8)
		olabel:SetPoint("TOPRIGHT", wpanel, "BOTTOMRIGHT", -4, -8)
		olabel:SetJustifyH("LEFT")
		olabel:SetText(L["Text Output"])

		opanel = CreatePanel(self)
		opanel:SetPoint("TOPLEFT", olabel, "BOTTOMLEFT", -4, 0)
		opanel:SetPoint("TOPRIGHT", olabel, "BOTTOMRIGHT", 4, 0)

		output = CreateDropdown(self, sinkOptions.name)
		output.hint = sinkOptions.desc
		output:SetPoint("TOPLEFT", opanel, 8, -8)
		output:SetPoint("TOPRIGHT", opanel, "TOP", -4, -8)
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
					opanel:SetHeight(8 + output:GetHeight() + 8)
				else
					sticky:Show()
					opanel:SetHeight(8 + output:GetHeight() + 8 + sticky:GetHeight() + 8)
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
		scrollarea.hint = sinkOptions.args.ScrollArea.desc
		scrollarea:SetPoint("TOPLEFT", opanel, "TOP", 4, -8)
		scrollarea:SetPoint("TOPRIGHT", opanel, -8, -8)
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
		sticky.hint = sinkOptions.args.Sticky.desc
		sticky:SetPoint("TOPLEFT", scrollarea, "BOTTOMLEFT", 0, -8)
		sticky:SetChecked(db.alert.output.sink20Sticky)
		sticky:SetScript("OnClick", function(self)
			local checked = self:GetChecked()
			PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")
			db.alert.output.sink20Sticky = checked and true or false
		end)

		--------------------------------------------------------------

		opanel:SetHeight(8 + output:GetHeight() + 8 + (sticky:IsShown() and (sticky:GetHeight() + 8) or 0))
	end

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