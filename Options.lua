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

local L = ShieldsUp.L

local CreateCheckbox = LibStub("tekKonfig-Checkbox").new
	-- IN:  parent, size, label, ...
	-- OUT: checkbox

local CreateDropdown = LibStub("tekKonfig-Dropdown").new
	-- IN:  parent, label, ...
	-- OUT: dropdown, labeltext, container

local CreateSlider = LibStub("tekKonfig-Slider").new
	-- IN:  parent, label, lowvalue, highvalue, ...
	-- OUT: slider, labeltext, container, lowtext, hightext

local CreatePanel
do
	local panelBackdrop = GameTooltip:GetBackdrop()
	function CreatePanel(parent, width, height, ...)
		local f = CreateFrame("Frame", nil, parent)

		f:SetBackdrop(panelBackdrop)
		f:SetBackdropColor(0.2, 0.2, 0.2, 0.5)
		f:SetBackdropBorderColor(0.8, 0.8, 0.8, 0.5)

		f:SetWidth(width or 1)
		f:SetHeight(height or 1)
		if select(1, ...) then f:SetPoint(...) end

		return f
	end
end

local function Slider_OnMouseWheel(self, delta)
	local step = self:GetValueStep() * delta

	if step > 0 then
		self:SetValue(min(self:GetValue() + step, select(2, self:GetMinMaxValues())))
	else
		self:SetValue(max(self:GetValue() + step, select(1, self:GetMinMaxValues())))
	end
end

local CreateColorSelector
do
	local function SetColor(self, ...)
		self:GetNormalTexture():SetVertexColor(...)
		self.value = { ... }
	end

	local function OnClick(self)
		if ColorPickerFrame:IsShown() then
			ColorPickerFrame:Hide()
		else
			self.r, self.g, self.b = self.value[1], self.value[2], self.value[3]

			UIDropDownMenuButton_OpenColorPicker(self)
			ColorPickerFrame:SetFrameStrata("TOOLTIP")
			ColorPickerFrame:Raise()
		end
	end

	local function OnEnter(self)
		local color = NORMAL_FONT_COLOR
		self.bg:SetVertexColor(color.r, color.g, color.b)

		if self.tiptext then
			GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
			GameTooltip:SetText(self.tiptext)
			GameTooltip:Show()
		end
	end

	local function OnLeave(self)
		local color = HIGHLIGHT_FONT_COLOR
		self.bg:SetVertexColor(color.r, color.g, color.b)

		GameTooltip:Hide()
	end

	function CreateColorSelector(parent, label)
		local f = CreateFrame("Button", nil, parent)
		f:SetWidth(16)
		f:SetHeight(16)
		f:SetNormalTexture("Interface\\ChatFrame\\ChatFrameColorSwatch")

		f.bg = f:CreateTexture(nil, "BACKGROUND")
		f.bg:SetWidth(14)
		f.bg:SetHeight(14)
		f.bg:SetPoint("CENTER")

		f.SetColor = ColorSelector_SetColor
		f.swatchFunc = function() f:SetColor(ColorPickerFrame:GetColorRGB()) end
		f.cancelFunc = function() f:SetColor(f.r, f.g, f.b) end

		f:SetScript("OnClick", OnClick)
		f:SetScript("OnEnter", OnEnter)
		f:SetScript("OnLeave", OnLeave)

		return f
	end
end

--
--	General options
--

local generaloptions = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
generaloptions.name = "ShieldsUp"
generaloptions:Hide()
generaloptions:SetScript("OnShow", function(f)
	local db = ShieldsUpDB
	local checksound

	local screenwidth = UIParent:GetWidth()
	local screenheight = UIParent:GetHeight()

	local title, subtitle = LibStub("tekKonfig-Heading").new(f, f.name, L["ShieldsUp is a simple monitor for your shaman shields. Use these settings to the basic appearance of ShieldsUp."])

	--
	--	Basic settings
	--

	local x, xvalue, xcontainer = CreateSlider(f, L["Horizontal Position"], floor(screenwidth / 10) / 2 * -10, floor(screenwidth / 10) / 2 * 10)
	x.tiptext = L["Set the horizontal distance from the center of the screen."]
	xcontainer:SetPoint("TOPLEFT", subtitle, "BOTTOMLEFT", -2, -8)
	xcontainer:SetPoint("TOPRIGHT", subtitle, "BOTTOM", -8, -8)
	x:SetValueStep(1)
	x:SetValue(db.x or 0)
	x:EnableMouseWheel(true)
	x:SetScript("OnMouseWheel", Slider_OnMouseWheel)
	x:SetScript("OnValueChanged", function(self)
		db.x = floor(self:GetValue())
		xvalue:SetText(db.x)
		ShieldsUp:ApplySettings()
	end)

	local y, yvalue, ycontainer = CreateSlider(f, L["Vertical Position"], floor(screenheight / 10) / 2 * -10, floor(screenheight / 10) / 2 * 10)
	y.tiptext = L["Set the vertical distance from the center of the screen."]
	ycontainer:SetPoint("TOPLEFT", xcontainer, "BOTTOMLEFT", 0, -8)
	ycontainer:SetPoint("TOPRIGHT", xcontainer, "BOTTOMRIGHT", 0, -8)
	y:SetValueStep(1)
	y:SetValue(db.y or -150)
	y:EnableMouseWheel(true)
	y:SetScript("OnMouseWheel", Slider_OnMouseWheel)
	y:SetScript("OnValueChanged", function(self)
		db.y = floor(self:GetValue())
		yvalue:SetText(db.y)
		ShieldsUp:ApplySettings()
	end)

	local h, hvalue, hcontainer = CreateSlider(f, L["Horizontal Padding"], 0, floor(screenwidth / 10) / 2 * 10)
	h.tiptext = L["Set the horizontal space between display elements."]
	hcontainer:SetPoint("TOPLEFT", ycontainer, "BOTTOMLEFT", 0, -16)
	hcontainer:SetPoint("TOPRIGHT", ycontainer, "BOTTOMRIGHT", 0, -16)
	h:SetValueStep(1)
	h:SetValue(db.h or 0)
	h:EnableMouseWheel(true)
	h:SetScript("OnMouseWheel", Slider_OnMouseWheel)
	h:SetScript("OnValueChanged", function(self)
		db.h = floor(self:GetValue())
		hvalue:SetText(db.h)
		ShieldsUp:ApplySettings()
	end)

	local v, vvalue, vcontainer = CreateSlider(f, L["Vertical Padding"], 0, floor(screenwidth / 10) / 2 * 10)
	v.tiptext = L["Set the vertical space between display elements."]
	vcontainer:SetPoint("TOPLEFT", hcontainer, "BOTTOMLEFT", 0, -8)
	vcontainer:SetPoint("TOPRIGHT", hcontainer, "BOTTOMRIGHT", 0, -8)
	v:SetValueStep(1)
	v:SetValue(db.v or 0)
	v:EnableMouseWheel(true)
	v:SetScript("OnMouseWheel", Slider_OnMouseWheel)
	v:SetScript("OnValueChanged", function(self)
		db.v = floor(self:GetValue())
		vvalue:SetText(db.v)
		ShieldsUp:ApplySettings()
	end)

	--
	--	Font settings
	--

	local font, fontvalue, fontcontainer = CreateDropdown(f, L["Text Typeface"])
	font.tiptext = L["Select a font face."]
	fontcontainer:SetPoint("TOPLEFT", subtitle, "BOTTOM", 8, -8)
	fontcontainer:SetPoint("TOPRIGHT", subtitle, "BOTTOMRIGHT", 2, -8)
	fontvalue:SetText(db.font.face or "Friz Quadrata TT")
	do
		local function FontDropdown_OnClick(self)
			fontvalue:SetText(self.value)
			UIDropDownMenu_SetSelectedValue(font, self.value)
			ShieldsUp:ApplySettings()
		end
		local function FontDropdown_Initialize()
			local selected = UIDropDownMenu_GetSelectedValue(font) or fontvalue:GetText()
			local info = UIDropDownMenu_CreateInfo()

			for i, name in ipairs(ShieldsUp.fonts) do
				info.text = name
				info.value = name
				info.func = OnClick
				info.checked = name == selected
				UIDropDownMenu_AddButton(info)
			end
		end
		UIDropDownMenu_Initialize(font, FontDropdown_Initialize)
		UIDropDownMenu_SetSelectedValue(font, db.font.face or "Friz Quadrata TT")
	end

	local outline, outlinevalue, outlinecontainer = CreateDropdown(f, L["Text Outline"], "TOPLEFT", fontcontainer, "BOTTOMLEFT", 0, -8)
	outline.tiptext = L["Select a outline face."]
	outlinevalue:SetText(db.font.outline or L["None"])
	do
		local outlines = { ["NONE"] = L["None"], ["OUTLINE"] = L["Thin"], ["THICKOUTLINE"] = L["Thick"] }
		local function OnClick(self)
			UIDropDownMenu_SetSelectedValue(outline, self.value)
			outlinevalue:SetText(self.text)
			ShieldsUp:ApplySettings()
		end
		UIDropDownMenu_Initialize(outline, function()
			local selected = outlines[UIDropDownMenu_GetSelectedValue(outline)] or outlinevalue:GetText()
			local info = UIDropDownMenu_CreateInfo()

			for value, name in ipairs(outlines) do
				info.text = name
				info.value = value
				info.func = OnClick
				info.checked = name == selected
				UIDropDownMenu_AddButton(info)
			end
		end)
	end

	local shadow = CreateCheckbox(f, nil, L["Text Shadow"], "TOPLEFT", outlinecontainer, "BOTTOMLEFT", 0, -8)
	shadow.tiptext = L["Toggle the drop shadow effect."]
	shadow:SetChecked(db.font.shadow)
	shadow:SetScript("OnClick", function(self)
		checksound(self)
		db.font.shadow = not db.font.shadow
		ShieldsUp:ApplySettings()
	end)

	--
	--	Color settings
	--

	local earth = CreateColorSelector(f, L["Earth Shield"])
	earth.tiptext = L["Set the color for the Earth Shield charge counter"]
	earth:SetValue(unpack(db.color.earth))
	earth:SetPoint("TOPLEFT", vcontainer, 0, -24)

	local lightning

	local water

	local active

	local overwritten

	local inactive

	local zero

	--
	--	Cleanup
	--

	checksound = shadow:GetScript("OnClick")

	f:SetScript("OnShow", nil)
end)

InterfaceOptions_AddCategory(generaloptions)

local alertoptions = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
alertoptions.name = L["Alert Options"]
alertoptions.parent = generaloptions
alertoptions:Hide()
alertoptions:SetScript("OnShow", function(f)
	local db = ShieldsUpDB
	local checksound

	local title = f:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	f:SetPoint("TOPLEFT", 16, -16)
	f:SetText(L["Alert Options"])

	local subtitle = f:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	subtitle:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
	subtitle:SetPoint("TOPRIGHT", f, -32, 0)
	subtitle:SetHeight(32)
	subtitle:SetJustifyH("LEFT")
	subtitle:SetNonSpaceWrap(true)
	subtitle:SetText(L["Use these settings to configure how ShieldsUp alerts you when your shields are depleted or removed."])

	--
	--	Earth Shield alerts
	--

	local eslabel = f:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	eslabel:SetPoint("TOPLEFT", subtitle, "BOTTOMLEFT", 0, -8)
	eslabel:SetText(L["Earth Shield"])

	local escontainer = CreatePanel(f)
	escontainer:SetPoint("TOPLEFT", subtitle, "BOTTOMLEFT", -2, -8 - eslabel:GetHeight())
	escontainer:SetPoint("TOPRIGHT", subtitle, "BOTTOM", -2, -8 - eslabel:GetHeight())

	local estext = CreateCheckbox(f, L["Show Text"], "TOPLEFT", escontainer, "TOPLEFT", 2, -8)
	estext.tiptext = L["Show a text alert when %s fades."]:format(L["Earth Shield"])
	estext:SetChecked(db.alert.earth.text)
	estext:SetScript("OnClick", function(self)
		checksound(self)
		db.alert.earth.text = not db.alert.earth.text
	end)

	local essound = CreateCheckbox(f, L["Play Sound"], "TOPLEFT", estext, "BOTTOMLEFT", 0, -8)
	essound.tiptext = L["Play a sound when %s fades."]:format(L["Earth Shield"])
	essound:SetChecked(db.alert.earth.sound)
	essound:SetScript("OnClick", function(self)
		checksound(self)
		db.alert.earth.sound = not db.alert.earth.sound
	end)

	local esfile, esfilevalue, esfilecontainer = CreateDropdown(f, L["Sound"], "TOPLEFT", essound, "BOTTOMLEFT", 0, -8)
	esfile.tiptext = L["Select a sound to play when %s fades."]:format(L["Earth Shield"])
	esfilevalue:SetText(db.alert.earth.soundFile or "Tribal Bell")
	do
		local function OnClick(self)
			UIDropDownMenu_SetSelectedValue(esfile, self.value)
			outlinevalue:SetText(self.value)
		end
		UIDropDownMenu_Initialize(esfile, function()
			local selected = UIDropDownMenu_GetSelectedValue(esfile) or esfilevalue:GetText()
			local info = UIDropDownMenu_CreateInfo()

			for name in ipairs(ShieldsUp.sounds) do
				info.text = name
				info.value = name
				info.func = OnClick
				info.checked = name == selected
				UIDropDownMenu_AddButton(info)
			end
		end)
	end

	escontainer:SetHeight(8 + estext:GetHeight() + 8 + essound:GetHeight() + 8 + esfilecontainer:GetHeight() + 8)

	--
	--	Water Shield alerts
	--

	local wslabel = f:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	wslabel:SetPoint("TOPLEFT", subtitle, "BOTTOMLEFT", 0, -8)
	wslabel:SetText(L["Water Shield"])

	local wscontainer = CreatePanel(f)
	wscontainer:SetPoint("TOPLEFT", subtitle, "BOTTOM", 2, -8 - wslabel:GetHeight())
	wscontainer:SetPoint("TOPRIGHT", subtitle, "BOTTOMRIGHT", 2, -8 - wslabel:GetHeight())
	wscontainer:SetPoint("BOTTOMLEFT", escontainer, "BOTTOMRIGHT", 4, 0)

	local wstext = CreateCheckbox(f, L["Show Text"], "TOPLEFT", wscontainer, "TOPLEFT", 2, -8)
	wstext.tiptext = L["Show a text alert when %s fades."]:format(L["Water Shield"])
	wstext:SetChecked(db.alert.water.text)
	wstext:SetScript("OnClick", function(self)
		checksound(self)
		db.alert.water.text = not db.alert.water.text
	end)

	local wssound = CreateCheckbox(f, L["Play Sound"], "TOPLEFT", wstext, "BOTTOMLEFT", 0, -8)
	wssound.tiptext = L["Play a sound when %s fades."]:format(L["Water Shield"])
	wssound:SetChecked(db.alert.water.sound)
	wssound:SetScript("OnClick", function(self)
		checksound(self)
		db.alert.water.sound = not db.alert.water.sound
	end)

	local wsfile, wsfilevalue, wsfilecontainer = CreateDropdown(f, L["Sound"], "TOPLEFT", wssound, "BOTTOMLEFT", 0, -8)
	wsfile.tiptext = L["Select a sound to play when %s fades."]:format(L["Water Shield"])
	wsfilevalue:SetText(db.alert.water.soundFile or "Tribal Bell")
	do
		local function OnClick(self)
			UIDropDownMenu_SetSelectedValue(wsfile, self.value)
			outlinevalue:SetText(self.value)
		end
		UIDropDownMenu_Initialize(wsfile, function()
			local selected = UIDropDownMenu_GetSelectedValue(wsfile) or wsfilevalue:GetText()
			local info = UIDropDownMenu_CreateInfo()

			for name in ipairs(ShieldsUp.sounds) do
				info.text = name
				info.value = name
				info.func = OnClick
				info.checked = name == selected
				UIDropDownMenu_AddButton(info)
			end
		end)
	end

	--
	--	Output settings
	--

	local olabel = f:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	olabel:SetPoint("TOPLEFT", escontainer, "BOTTOMLEFT", 0, -8)
	wslabel:SetText(L["Text Output"])

	local ocontainer = CreatePanel(f)
	ocontainer:SetPoint("TOPLEFT", escontainer, "BOTTOMLEFT", -2, -8 - olabel:GetHeight())
	ocontainer:SetPoint("TOPRIGHT", wscontainer, "BOTTOM", -2, -8 - olabel:GetHeight())

	--
	--	Cleanup
	--

	checksound = earthtext:GetScript("OnClick")

	self:SetScript("OnShow", nil)
end)

InterfaceOptions_AddCategory(alertoptions)

--
--	Visibility options
--
--[[
local visibilityoptions = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
visibilityoptions.name = L["Visibility Options"]
visibilityoptions.parent = generaloptions
visibilityoptions:Hide()
visibilityoptions:SetScript("OnShow", function(f)

	checksound = earthtext:GetScript("OnClick")

	self:SetScript("OnShow", nil)
end)
]]
--
--	About panel
--

LibStub("tekKonfig-AboutPanel").new("ShieldsUp", generaloptions.name)

--
--	Slash command
--

ShieldsUp.optionsPanel = generaloptions
SLASH_SHIELDSUP1 = "/sup"
SLASH_SHIELDSUP2 = "/shieldsup"
SlashCmdList.SHIELDSUP = function(input)
	if input and string.len(input) > 0 then
		local cmd, arg = input:match("^([xyvh])%s?(%d+)$")
		if cmd and arg and db[cmd] and type(db[cmd]) == "number" then
			db[cmd] = tonumber(arg)
		else
			print("|cff00ddbaShieldsUp:|r "..ShieldsUp.L["Invalid command. Console configuration is quite limited, and is intended only for advanced users. Type |cffffcc00/shieldsup|r or |cffffcc00/sup|r without any arguments to open the main configuration panel."])
		end
	else
		InterfaceOptionsFrame_OpenToCategory(ShieldsUp.optionsPanel)
	end
end