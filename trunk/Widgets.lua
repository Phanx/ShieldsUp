------------------------------------------------------------------------
--	PhanxConfigWidgets
--	Basic configuration widget creation
------------------------------------------------------------------------

if PhanxConfigWidgets then return end

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
	local function Frame_OnEnter(self)
		if self.hint then
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:SetText(self.hint, nil, nil, nil, nil, true)
		end
	end

	local function Button_OnEnter(self)
		if self:GetParent().hint then
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
		frame:SetScript("OnEnter", Frame_OnEnter)
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
		button:SetScript("OnEnter", Button_OnEnter)
		button:SetScript("OnLeave", OnLeave)
		button:SetScript("OnClick", OnClick)

		button:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up")
		button:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Down")
		button:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")
		button:SetDisabledTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Disabled")
		button:GetHighlightTexture():SetBlendMode("ADD")

		dropdown.container = frame
		dropdown.button = button
		dropdown.label = label
		dropdown.value = value

		return dropdown
	end
end

------------------------------------------------------------------------

local CreateScrollingDropdown
do
	local MAX_LIST_SIZE = 15

	local function ListButton_OnClick(self)
		local dropdown = self:GetParent():GetParent()
		dropdown.list.selected = self.value
		dropdown.list:Hide()
		dropdown.value:SetText(self.value)

		if dropdown.OnValueChanged then
			dropdown:OnValueChanged(self.value)
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
			self.width = 0
			for i, item in pairs(self:GetParent().items) do
				self.text:SetText(item)
				self.width = max(self.text:GetWidth() + 60, self.width)
			end
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
			local dropdown = self:GetParent()
			dropdown.list = CreateList(dropdown)
			dropdown.list:Show()
		end
	end

	function CreateScrollingDropdown(parent, name, items)
		assert(items and type(items) == "table", "Bad argument #3 to CreateScrollingDropdown (table expected, got " .. type(items) .. ")")

		local dropdown = CreateDropdown(parent, name)
		dropdown.button:SetScript("OnClick", DropdownButton_OnClick)
		dropdown.items = items

		return dropdown
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

PhanxConfigWidgets = {}

function PhanxConfigWidgets:Embed(target)
	target.CreatePanel = CreatePanel
	target.CreateCheckbox = CreateCheckbox
	target.CreateColorPicker = CreateColorPicker
	target.CreateDropdown = CreateDropdown
	target.CreateScrollingDropdown = CreateScrollingDropdown
	target.CreateSlider = CreateSlider
end

------------------------------------------------------------------------