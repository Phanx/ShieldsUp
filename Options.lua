--[[--------------------------------------------------------------------
	ShieldsUp
	Simple shaman shield monitor.
	by Phanx < addons@phanx.net >
	http://www.wowinterface.com/downloads/info9165-ShieldsUp.html
	http://wow.curse.com/downloads/wow-addons/details/shieldsup.aspx
	Copyright © 2008–2010 Alyssa "Phanx" Kinley
	See README for license terms and additional information.
----------------------------------------------------------------------]]

if select(2, UnitClass("player")) ~= "SHAMAN" then return end

local ADDON_NAME, namespace = ...
local ShieldsUp = namespace.ShieldsUp
local L = namespace.L

------------------------------------------------------------------------

local panel = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
panel.name = GetAddOnMetadata(ADDON_NAME, "Title")
panel:Hide()
panel:SetScript("OnShow", function(self)
	local db = ShieldsUpDB
	local SharedMedia = LibStub("LibSharedMedia-3.0", true)

	local screenwidth = UIParent:GetWidth()
	local screenheight = UIParent:GetHeight()

	self.CreatePanel = LibStub("PhanxConfig-Panel").CreatePanel
	self.CreateCheckbox = LibStub("PhanxConfig-Checkbox").CreateCheckbox
	self.CreateColorPicker = LibStub("PhanxConfig-ColorPicker").CreateColorPicker
	self.CreateDropdown = LibStub("PhanxConfig-Dropdown").CreateDropdown
	self.CreateScrollingDropdown = LibStub("PhanxConfig-ScrollingDropdown").CreateScrollingDropdown
	self.CreateSlider = LibStub("PhanxConfig-Slider").CreateSlider

	--------------------------------------------------------------------

	local title = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	title:SetPoint("TOPLEFT", 16, -16)
	title:SetPoint("TOPRIGHT", -16, -16)
	title:SetJustifyH("LEFT")
	title:SetText(self.name)

	local notes = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	notes:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
	notes:SetPoint("TOPRIGHT", title, 0, -8)
	notes:SetHeight(32)
	notes:SetJustifyH("LEFT")
	notes:SetJustifyV("TOP")
	notes:SetNonSpaceWrap(true)
	notes:SetText(L["ShieldsUp is a monitor for your shaman shields. Use these settings to configure the addon's appearance and behavior."])

	--------------------------------------------------------------------

	local posx = self:CreateSlider(L["Horizontal Position"], math.floor(screenwidth / 10) / 2 * -10, math.floor(screenwidth / 10) / 2 * 10, 5)
	posx.desc = L["Set the horizontal distance from the center of the screen to place the display."]
	posx.container:SetPoint("TOPLEFT", notes, "BOTTOMLEFT", -4, -8)
	posx.container:SetPoint("TOPRIGHT", notes, "BOTTOM", -8, 8)
	posx:SetValue(db.posx or 0)
	posx.valueText:SetText(db.posx or 0)
	posx.OnValueChanged = function(self, value)
		value = math.floor(value)
		db.posx = value
		ShieldsUp:ApplySettings()
		return value
	end

	--------------------------------------------------------------------

	local posy = self:CreateSlider(L["Vertical Position"], floor(screenheight / 10) / 2 * -10, floor(screenheight / 10) / 2 * 10, 5)
	posy.desc = L["Set the vertical distance from the center of the screen to place the display."]
	posy.container:SetPoint("TOPLEFT", posx.container, "BOTTOMLEFT", 0, -8)
	posy.container:SetPoint("TOPRIGHT", posx.container, "BOTTOMRIGHT", 0, -8)
	posy:SetValue(db.posy or -150)
	posy.valueText:SetText(db.posy or 0)
	posy.OnValueChanged = function(self, value)
		value = math.floor(value)
		db.posy = value
		ShieldsUp:ApplySettings()
		return value
	end

	--------------------------------------------------------------------

	local padh = self:CreateSlider(L["Horizontal Padding"], 0, floor(screenwidth / 10) / 2 * 10, 1)
	padh.desc = L["Set the horizontal space between the charge counts."]
	padh.container:SetPoint("TOPLEFT", posy.container, "BOTTOMLEFT", 0, -8)
	padh.container:SetPoint("TOPRIGHT", posy.container, "BOTTOMRIGHT", 0, -8)
	padh:SetValue(db.padh or 0)
	padh.valueText:SetText(db.padh or 0)
	padh.OnValueChanged = function(self, value)
		value = math.floor(value)
		db.padh = value
		ShieldsUp:ApplySettings()
		return value
	end

	--------------------------------------------------------------------

	local padv = self:CreateSlider(L["Vertical Padding"], 0, floor(screenwidth / 10) / 2 * 10, 1)
	padv.desc = L["Set the vertical space between the target name and charge counters."]
	padv.container:SetPoint("TOPLEFT", padh.container, "BOTTOMLEFT", 0, -8)
	padv.container:SetPoint("TOPRIGHT", padh.container, "BOTTOMRIGHT", 0, -8)
	padv:SetValue(db.padv or 0)
	padv.valueText:SetText(db.padv or 0)
	padv.OnValueChanged = function(self, value)
		value = math.floor(value)
		db.padv = value
		ShieldsUp:ApplySettings()
		return value
	end

	--------------------------------------------------------------------

	local face = self:CreateScrollingDropdown(L["Font Face"], ShieldsUp.fonts)
	face.container.desc = L["Set the font face to use for the display text."]
	face.container:SetPoint("TOPLEFT", notes, "BOTTOM", 8, -8)
	face.container:SetPoint("TOPRIGHT", notes, "BOTTOMRIGHT", 0, -8)
	face.valueText:SetText(db.font.face or "Friz Quadrata TT")
	do
		local _, height, flags = face.valueText:GetFont()
		face.valueText:SetFont(SharedMedia:Fetch("font", db.font.face or "Friz Quadrata TT"), height, flags)

		function face:OnValueChanged(value)
			local _, height, flags = self.valueText:GetFont()
			self.valueText:SetFont(SharedMedia:Fetch("font", value), height, flags)
			db.font.face = value
			ShieldsUp:ApplySettings()
		end

		local button_OnClick = face.button:GetScript("OnClick")
		face.button:SetScript("OnClick", function(self)
			button_OnClick(self)
			face.list:Hide()

			local function SetButtonFonts(self)
				local buttons = face.list.buttons
				for i = 1, #buttons do
					local button = buttons[i]
					if button.value and button:IsShown() then
						button.label:SetFont(SharedMedia:Fetch("font", button.value), UIDROPDOWNMENU_DEFAULT_TEXT_HEIGHT)
					end
				end
			end

			local OnShow = face.list:GetScript("OnShow")
			face.list:SetScript("OnShow", function(self)
				OnShow(self)
				SetButtonFonts(self)
			end)

			local OnVerticalScroll = face.list.scrollFrame:GetScript("OnVerticalScroll")
			face.list.scrollFrame:SetScript("OnVerticalScroll", function(self, delta)
				OnVerticalScroll(self, delta)
				SetButtonFonts(self)
			end)

			local SetText = face.list.text.SetText
			face.list.text.SetText = function(self, text)
				self:SetFont(SharedMedia:Fetch("font", text), UIDROPDOWNMENU_DEFAULT_TEXT_HEIGHT + 1)
				SetText(self, text)
			end

			button_OnClick(self)
			self:SetScript("OnClick", button_OnClick)
		end)
	end

	--------------------------------------------------------------------

	local outline = self:CreateDropdown(L["Outline"])
	outline.container.desc = L["Select an outline width for the display text."]
	outline.container:SetPoint("TOPLEFT", face.container, "BOTTOMLEFT", 0, -8)
	outline.container:SetPoint("TOPRIGHT", face.container, "BOTTOMRIGHT", 0, -8)
	do
		local outlines = { ["NONE"] = L["None"], ["OUTLINE"] = L["Thin"], ["THICKOUTLINE"] = L["Thick"] }

		local function OnClick(self)
			db.font.outline = self.value
			ShieldsUp:ApplySettings()
			outline.valueText:SetText(self.text)
			UIDropDownMenu_SetSelectedValue(outline, self.value)
		end

		local info = { } -- UIDropDownMenu_CreateInfo()
		UIDropDownMenu_Initialize(outline, function(self)
			local selected = outlines[UIDropDownMenu_GetSelectedValue(outline)] or self.valueText:GetText()

			info.text = L["None"]
			info.value = "NONE"
			info.func = OnClick
			info.checked = L["None"] == selected
			UIDropDownMenu_AddButton(info)

			info.text = L["Thin"]
			info.value = "OUTLINE"
			info.func = OnClick
			info.checked = L["Thin"] == selected
			UIDropDownMenu_AddButton(info)

			info.text = L["Thick"]
			info.value = "THICKOUTLINE"
			info.func = OnClick
			info.checked = L["Thick"] == selected
			UIDropDownMenu_AddButton(info)
		end)

		outline.valueText:SetText(outlines[db.font.outline] or L["None"])
		UIDropDownMenu_SetSelectedValue(outline, db.font.outline or L["None"])
	end

	--------------------------------------------------------------------

	local large = self:CreateSlider(L["Counter Size"], 6, 32, 1)
	large.desc = L["Set the text size for the charge counters."]
	large.container:SetPoint("TOPLEFT", outline.container, "BOTTOMLEFT", 0, -8)
	large.container:SetPoint("TOPRIGHT", outline.container, "BOTTOMRIGHT", 0, -8)
	large:SetValue(db.font.large or 0)
	large.valueText:SetText(db.font.large or 0)
	large.OnValueChanged = function(self, value)
		value = math.floor(value)
		db.font.large = value
		ShieldsUp:ApplySettings()
		return value
	end

	--------------------------------------------------------------------

	local small = self:CreateSlider(L["Name Size"], 6, 32, 1)
	small.desc = L["Set the text size for the target name."]
	small.container:SetPoint("TOPLEFT", large.container, "BOTTOMLEFT", 0, -8)
	small.container:SetPoint("TOPRIGHT", large.container, "BOTTOMRIGHT", 0, -8)
	small:SetValue(db.font.small or 0)
	small.valueText:SetText(db.font.small or 0)
	small.OnValueChanged = function(self, value)
		value = math.floor(value)
		db.font.small = value
		ShieldsUp:ApplySettings()
		return value
	end

	--------------------------------------------------------------------

	local shadow = self:CreateCheckbox(L["Shadow"])
	shadow.desc = L["Add a drop shadow effect to the display text."]
	shadow:SetPoint("TOPLEFT", small.container, "BOTTOMLEFT", 0, -8)
	shadow:SetChecked(db.font.shadow)
	shadow.OnClick = function(self, checked)
		db.font.shadow = checked
		ShieldsUp:ApplySettings()
	end

	--------------------------------------------------------------------

	local cblind = self:CreateCheckbox(L["Colorblind Mode"])
	cblind.desc = L["Add asterisks around the target name when your %s has been overwritten, in addition to changing the color."]:format(L["Earth Shield"])
	cblind:SetPoint("TOPLEFT", padv.container, "BOTTOMLEFT", 0, -8)
	cblind:SetChecked(db.colorblind)
	cblind.OnClick = function(self, checked)
		db.colorblind = checked
		ShieldsUp:Update()
	end

	--------------------------------------------------------------------

	local vdist = -8 - face.container:GetHeight() - 8 - outline.container:GetHeight() - 8 - large.container:GetHeight() - 8 - small.container:GetHeight() - 8 - shadow:GetHeight() - 4

	local colors = self:CreatePanel()
	colors.label = self:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	colors.label:SetPoint("BOTTOMLEFT", colors, "TOPLEFT", 4, 0)
	colors.label:SetText(L["Colors"])
	colors:SetPoint("TOPLEFT", notes, "BOTTOMLEFT", 0, vdist - colors.label:GetHeight())
	colors:SetPoint("TOPRIGHT", notes, "BOTTOMRIGHT", 0, vdist - colors.label:GetHeight())

	--------------------------------------------------------------------

	local earth = self:CreateColorPicker(L["Earth Shield"])
	earth.desc = string.format(L["Set the color for the %s charge counter."], L["Earth Shield"])
	earth:SetPoint("TOPLEFT", colors, 8, -8)
	earth:SetColor(unpack(db.color.earth))
	earth.GetColor = function() return unpack(db.color.earth) end
	earth.OnColorChanged = function(self, r, g, b)
		db.color.earth[1] = r
		db.color.earth[2] = g
		db.color.earth[3] = b
		ShieldsUp:Update()
	end

	--------------------------------------------------------------------

	local lightning = self:CreateColorPicker(L["Lightning Shield"])
	lightning.desc = string.format(L["Set the color for the %s charge counter."], L["Lightning Shield"])
	lightning:SetPoint("TOPLEFT", earth, "BOTTOMLEFT", 0, -8)
	lightning:SetColor(unpack(db.color.lightning))
	lightning.GetColor = function() return unpack(db.color.lightning) end
	lightning.OnColorChanged = function(self, r, g, b)
		db.color.lightning[1] = r
		db.color.lightning[2] = g
		db.color.lightning[3] = b
		ShieldsUp:Update()
	end

	--------------------------------------------------------------------

	local water = self:CreateColorPicker(L["Water Shield"])
	water.desc = string.format(L["Set the color for the %s charge counter."], L["Water Shield"])
	water:SetPoint("TOPLEFT", lightning, "BOTTOMLEFT", 0, -8)
	water:SetColor(unpack(db.color.water))
	water.GetColor = function() return unpack(db.color.water) end
	water.OnColorChanged = function(self, r, g, b)
		db.color.water[1] = r
		db.color.water[2] = g
		db.color.water[3] = b
		ShieldsUp:Update()
	end

	--------------------------------------------------------------------

	local normal = self:CreateColorPicker(L["Active"])
	normal.desc = string.format(L["Set the color for the target name while your %s is active."], L["Earth Shield"])
	normal:SetPoint("TOPLEFT", colors, "TOP", 8, -8)
	normal:SetColor(unpack(db.color.normal))
	normal.GetColor = function() return unpack(db.color.normal) end
	normal.OnColorChanged = function(self, r, g, b)
		db.color.normal[1] = r
		db.color.normal[2] = g
		db.color.normal[3] = b
		ShieldsUp:Update()
	end

	--------------------------------------------------------------------

	local overwritten = self:CreateColorPicker(L["Overwritten"])
	overwritten.desc = string.format(L["Set the color for the target name when your %s has been overwritten."], L["Earth Shield"])
	overwritten:SetPoint("TOPLEFT", normal, "BOTTOMLEFT", 0, -8)
	overwritten:SetColor(unpack(db.color.overwritten))
	overwritten.GetColor = function() return unpack(db.color.overwritten) end
	overwritten.OnColorChanged = function(self, r, g, b)
		db.color.overwritten[1] = r
		db.color.overwritten[2] = g
		db.color.overwritten[3] = b
		ShieldsUp:Update()
	end

	--------------------------------------------------------------------

	local alert = self:CreateColorPicker(L["Inactive"])
	alert.desc = L["Set the color for expired, dispelled, or otherwise inactive shields."]
	alert:SetPoint("TOPLEFT", overwritten, "BOTTOMLEFT", 0, -8)
	alert:SetColor(unpack(db.color.alert))
	alert.GetColor = function() return unpack(db.color.alert) end
	alert.OnColorChanged = function(self, r, g, b)
		db.color.alert[1] = r
		db.color.alert[2] = g
		db.color.alert[3] = b
		ShieldsUp:Update()
	end

	--------------------------------------------------------------------

	colors:SetHeight(earth:GetHeight() * 3 + 32)

	--------------------------------------------------------------------

	self.refresh = function()
		posx:SetValue(db.posx or 0)
		posx.valueText:SetText(db.posx or 0)
		posy:SetValue(db.posy or -150)
		posy.valueText:SetText(db.posy or 0)
		padh:SetValue(db.padh or 0)
		padh.valueText:SetText(db.padh or 0)
		padv:SetValue(db.padv or 0)
		padv.valueText:SetText(db.padv or 0)
		font.valueText:SetText(db.font.face or "Friz Quadrata TT")
		UIDropDownMenu_SetSelectedValue(font, db.font.face or "Friz Quadrata TT")
		outline.valueText:SetText(db.font.outline or L["None"])
		UIDropDownMenu_SetSelectedValue(outline, db.font.outline or L["None"])
		shadow:SetChecked(db.font.shadow)
		large:SetValue(db.font.large or 24)
		large.valueText:SetText(db.font.large or 24)
		small:SetValue(db.font.small or 16)
		small.valueText:SetText(db.font.small or 16)
		earth:SetColor(unpack(db.color.earth))
		lightning:SetColor(unpack(db.color.lightning))
		water:SetColor(unpack(db.color.water))
		normal:SetColor(unpack(db.color.normal))
		overwritten:SetColor(unpack(db.color.overwritten))
		alert:SetColor(unpack(db.color.alert))
		cblind:SetChecked(db.colorblind)
	end

	self:SetScript("OnShow", nil)
end)

InterfaceOptions_AddCategory(panel)

------------------------------------------------------------------------

local panel2 = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
panel2.name = L["Alerts"]
panel2.parent = panel.name
panel2:Hide()
panel2:SetScript("OnShow", function(self)
	local db = ShieldsUpDB

	local SharedMedia = LibStub("LibSharedMedia-3.0", true)

	self.CreatePanel = LibStub("PhanxConfig-Panel").CreatePanel
	self.CreateCheckbox = LibStub("PhanxConfig-Checkbox").CreateCheckbox
	self.CreateDropdown = LibStub("PhanxConfig-Dropdown").CreateDropdown

	--------------------------------------------------------------------

	local title = self:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	title:SetPoint("TOPLEFT", 16, -16)
	title:SetPoint("TOPRIGHT", -16, -16)
	title:SetJustifyH("LEFT")
	title:SetText(self.name)

	local notes = self:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	notes:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
	notes:SetPoint("TOPRIGHT", title, 0, -8)
	notes:SetHeight(32)
	notes:SetJustifyH("LEFT")
	notes:SetJustifyV("TOP")
	notes:SetNonSpaceWrap(true)
	notes:SetText(L["Use these settings to configure how ShieldsUp alerts you when a shield expires or is removed."])

	--------------------------------------------------------------------

	local elabel = self:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	elabel:SetPoint("TOPLEFT", notes, "BOTTOMLEFT", 0, -16)
	elabel:SetPoint("TOPRIGHT", notes, "BOTTOMRIGHT", 0, -16)
	elabel:SetJustifyH("LEFT")
	elabel:SetText(L["Earth Shield"])

	local epanel = self:CreatePanel()
	epanel:SetPoint("TOPLEFT", elabel, "BOTTOMLEFT", -4, 0)
	epanel:SetPoint("TOPRIGHT", elabel, "BOTTOMRIGHT", 4, 0)

	--------------------------------------------------------------------

	local etext = self:CreateCheckbox(L["Text Alert"])
	etext.desc = L["Show a text message when %s expires."]:format(L["Earth Shield"])
	etext:SetPoint("TOPLEFT", epanel, 8, -8)
	etext:SetChecked(db.alert.earth.text)
	etext.OnClick = function(self, checked)
		db.alert.earth.text = checked
	end

	--------------------------------------------------------------------

	local esound = self:CreateCheckbox(L["Sound Alert"])
	esound.desc = L["Play a sound when %s expires."]:format(L["Earth Shield"])
	esound:SetPoint("TOPLEFT", etext, "BOTTOMLEFT", 0, -8)
	esound:SetChecked(db.alert.earth.sound)
	esound.OnClick = function(self, checked)
		db.alert.earth.sound = checked
	end

	local esoundfile = self:CreateDropdown(L["Sound File"])
	esoundfile.container.desc = L["Select the sound to play when %s expires."]:format(L["Earth Shield"])
	esoundfile.container:SetPoint("BOTTOMLEFT", epanel, "BOTTOM", 8, 8)
	esoundfile.container:SetPoint("BOTTOMRIGHT", epanel, -8, 8)
	do
		local function OnClick(self)
			PlaySoundFile(SharedMedia:Fetch("sound", self.value))
			db.alert.earth.soundFile = self.value
			esoundfile.valueText:SetText(self.text)
			UIDropDownMenu_SetSelectedValue(esoundfile, self.value)
		end

		local info = { } -- UIDropDownMenu_CreateInfo()
		UIDropDownMenu_Initialize(esoundfile, function(self)
			local selected = UIDropDownMenu_GetSelectedValue(self) or self.valueText:GetText()

			for i, sound in ipairs(ShieldsUp.sounds) do
				info.text = sound
				info.value = sound
				info.func = OnClick
				info.checked = sound == selected
				UIDropDownMenu_AddButton(info)
			end
		end)

		esoundfile:SetValue(db.alert.earth.soundFile)
	end

	--------------------------------------------------------------------

	epanel:SetHeight(8 + etext:GetHeight() + 8 + esound:GetHeight() + 8)

	--------------------------------------------------------------------

	local wlabel = self:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	wlabel:SetPoint("TOPLEFT", epanel, "BOTTOMLEFT", 4, -8)
	wlabel:SetPoint("TOPRIGHT", epanel, "BOTTOMRIGHT", -4, -8)
	wlabel:SetJustifyH("LEFT")
	wlabel:SetText(L["Water Shield"])

	local wpanel = self:CreatePanel()
	wpanel:SetPoint("TOPLEFT", wlabel, "BOTTOMLEFT", -4, 0)
	wpanel:SetPoint("TOPRIGHT", wlabel, "BOTTOMRIGHT", 4, 0)

	--------------------------------------------------------------------

	local wtext = self:CreateCheckbox(L["Text Alert"])
	wtext.desc = L["Show a text message when %s expires."]:format(L["Water Shield"])
	wtext:SetPoint("TOPLEFT", wpanel, 8, -8)
	wtext:SetChecked(db.alert.water.text)
	wtext.OnClick = function(self, checked)
		db.alert.water.text = checked
	end

	--------------------------------------------------------------------

	local wsound = self:CreateCheckbox(L["Sound Alert"])
	wsound.desc = L["Play a sound when %s expires."]:format(L["Water Shield"])
	wsound:SetPoint("TOPLEFT", wtext, "BOTTOMLEFT", 0, -8)
	wsound:SetChecked(db.alert.water.sound)
	wsound.OnClick = function(self, checked)
		db.alert.water.sound = checked
	end

	--------------------------------------------------------------------

	local wsoundfile = self:CreateDropdown(L["Sound File"])
	wsoundfile.container.desc = L["Select the sound to play when %s expires."]:format(L["Water Shield"])
	wsoundfile.container:SetPoint("BOTTOMLEFT", wpanel, "BOTTOM", 8, 8)
	wsoundfile.container:SetPoint("BOTTOMRIGHT", wpanel, -8, 8)
	do
		local function OnClick(self)
			PlaySoundFile(SharedMedia:Fetch("sound", self.value))
			db.alert.water.soundFile = self.value
			wsoundfile.valueText:SetText(self.text)
			UIDropDownMenu_SetSelectedValue(wsoundfile, self.value)
		end

		local info = { }
		UIDropDownMenu_Initialize(wsoundfile, function()
			local selected = UIDropDownMenu_GetSelectedValue(wsoundfile) or wsoundfile.valueText:GetText()

			for i, sound in ipairs(ShieldsUp.sounds) do
				info.text = sound
				info.value = sound
				info.func = OnClick
				info.checked = sound == selected
				UIDropDownMenu_AddButton(info)
			end
		end)

		wsoundfile:SetValue(db.alert.water.soundFile)
	end

	--------------------------------------------------------------------

	wpanel:SetHeight(8 + wtext:GetHeight() + 8 + wsound:GetHeight() + 8)

	--------------------------------------------------------------------

	local olabel, opanel, output, scrollarea, sticky, UpdateOutputPanel
	if ShieldsUp.Pour then
		local sinkOptions = ShieldsUp:GetSinkAce2OptionsDataTable().output

		local outputNames = { }
		for k, v in pairs(sinkOptions.args) do
			if k ~= "Default" and k ~= "Sticky" and k ~= "Channel" and v.type == "toggle" then
				outputNames[k] = v.name
			end
		end

		function UpdateOutputPanel()
			if sinkOptions.args.ScrollArea.disabled then
				scrollarea.container:Hide()
			else
				scrollarea.container:Show()

				local valid
				local current = db.alert.output.sink20ScrollArea
				for i, scrollArea in ipairs(sinkOptions.args.ScrollArea.validate) do
					if scrollArea == current then
						valid = true
						break
					end
				end
				if not valid then
					scrollarea.valueText:SetText()
				end
			end

			if sinkOptions.args.Sticky.disabled then
				sticky:Hide()
				opanel:SetHeight(8 + output:GetHeight() + 8 + 8) -- Why the extra 8? I don't know!
			else
				sticky:Show()
				opanel:SetHeight(8 + output:GetHeight() + 8 + sticky:GetHeight() + 8 + 8)
			end
		end

		olabel = self:CreateFontString(nil, "OVERLAY", "GameFontNormal")
		olabel:SetPoint("TOPLEFT", wpanel, "BOTTOMLEFT", 4, -8)
		olabel:SetPoint("TOPRIGHT", wpanel, "BOTTOMRIGHT", -4, -8)
		olabel:SetJustifyH("LEFT")
		olabel:SetText(L["Text Output"])

		opanel = self:CreatePanel()
		opanel:SetPoint("TOPLEFT", olabel, "BOTTOMLEFT", -4, 0)
		opanel:SetPoint("TOPRIGHT", olabel, "BOTTOMRIGHT", 4, 0)

		output = self:CreateDropdown(sinkOptions.name, init)
		output.container.desc = sinkOptions.desc
		output.container:SetPoint("TOPLEFT", opanel, 8, -8)
		output.container:SetPoint("TOPRIGHT", opanel, "TOP", -4, -8)
		do
			local function OnClick(self)
				sinkOptions.set(self.value, true)
				sinkOptions = ShieldsUp:GetSinkAce2OptionsDataTable().output

				UpdateOutputPanel()

				output:SetValue(self.value, self.text)
			end

			local info = { }
			UIDropDownMenu_Initialize(output, function(self)
				local selected = db.alert.output.sink20OutputSink or self.value:GetText()
				for k, v in pairs(sinkOptions.args) do
					if k ~= "Default" and k ~= "Sticky" and k ~= "Channel" and v.type == "toggle" and not (v.hidden and v:hidden()) then
						info.text = v.name
						info.value = k
						info.func = OnClick
						info.checked = v.name == selected
						UIDropDownMenu_AddButton(info)
					end
				end
			end)

			output:SetValue(db.alert.output.sink20OutputSink, outputNames[db.alert.output.sink20OutputSink])
		end

		--------------------------------------------------------------

		scrollarea = self:CreateDropdown(sinkOptions.args.ScrollArea.name)
		scrollarea.container.desc = sinkOptions.args.ScrollArea.desc
		scrollarea.container:SetPoint("TOPLEFT", opanel, "TOP", 4, -8)
		scrollarea.container:SetPoint("TOPRIGHT", opanel, -8, -8)
		do
			local function OnClick(self)
				sinkOptions.set("ScrollArea", self.value)
				sinkOptions = ShieldsUp:GetSinkAce2OptionsDataTable().output

				scrollarea:SetValue(self.value, self.text)
			end

			local info = { }
			UIDropDownMenu_Initialize(scrollarea, function(self)
				local selected = db.alert.output.sink20ScrollArea or self.valueText:GetText()

				for i, v in ipairs(sinkOptions.args.ScrollArea.validate) do
					info.text = v
					info.value = v
					info.func = OnClick
					info.checked = v == selected
					UIDropDownMenu_AddButton(info)
				end
			end)

			sinkOptions.set(db.alert.output.sink20OutputSink, true) -- hax!
			for i, v in ipairs(sinkOptions.args.ScrollArea.validate) do
				if v == db.alert.output.sink20ScrollArea then
					scrollarea:SetValue(db.alert.output.sink20ScrollArea)
				end
			end
		end

		--------------------------------------------------------------

		sticky = self:CreateCheckbox(sinkOptions.args.Sticky.name)
		sticky.desc = sinkOptions.args.Sticky.desc
		sticky:SetPoint("TOPLEFT", scrollarea.container, "BOTTOMLEFT", 0, -8)
		sticky:SetChecked(db.alert.output.sink20Sticky)
		sticky.OnClick = function(self, checked)
			sinkOptions.set("Sticky", checked)
			sinkOptions = ShieldsUp:GetSinkAce2OptionsDataTable().output
		end

		--------------------------------------------------------------

		UpdateOutputPanel()
	end

	--------------------------------------------------------------------

	self.refresh = function()
		etext:SetChecked(db.alert.earth.text)
		esound:SetChecked(db.alert.earth.sound)
		esoundfile:SetValue(db.alert.earth.soundFile)
		wtext:SetChecked(db.alert.water.text)
		wsound:SetChecked(db.alert.water.sound)
		wsoundfile:SetValue(db.alert.water.soundFile)
		if ShieldsUp.Pour then
			output:SetValue(db.alert.output.sink20OutputSink, outputNames[db.alert.output.sink20OutputSink])
			sinkOptions.set(db.alert.output.sink20OutputSink, true) -- hax!
			for i, v in ipairs(sinkOptions.args.ScrollArea.validate) do
				if v == db.alert.output.sink20ScrollArea then
					scrollarea:SetValue(db.alert.output.sink20ScrollArea)
				end
			end
			sticky:SetChecked(db.alert.output.sink20Sticky)
			UpdateOutputPanel()
		end
	end

	self:SetScript("OnShow", nil)
end)

InterfaceOptions_AddCategory(panel2)

------------------------------------------------------------------------

local panel3 = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
panel3.name = L["Visibility"]
panel3.parent = panel.name
panel3:Hide()
panel3:SetScript("OnShow", function(self)
	local db = ShieldsUpDB.show

	self.CreatePanel = LibStub("PhanxConfig-Panel").CreatePanel
	self.CreateCheckbox = LibStub("PhanxConfig-Checkbox").CreateCheckbox

	--------------------------------------------------------------------

	local title = self:CreateFontString("ShieldsUpAlertTitle", "ARTWORK", "GameFontNormalLarge")
	title:SetPoint("TOPLEFT", 16, -16)
	title:SetPoint("TOPRIGHT", -16, -16)
	title:SetJustifyH("LEFT")
	title:SetText(self.name)

	local notes = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	notes:SetPoint("TOPLEFT", title, "BOTTOMLEFT")
	notes:SetPoint("TOPRIGHT", title, "BOTTOMRIGHT")
	notes:SetHeight(32)
	notes:SetJustifyH("LEFT")
	notes:SetJustifyV("TOP")
	notes:SetNonSpaceWrap(true)
	notes:SetText(L["Use these settings to control when the ShieldsUp display should be shown or hidden."])

	--------------------------------------------------------------------

	local glabel = self:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	glabel:SetPoint("TOPLEFT", notes, "BOTTOMLEFT", 0, -8)
	glabel:SetPoint("TOPRIGHT", notes, "BOTTOMRIGHT", 0, -8)
	glabel:SetJustifyH("LEFT")
	glabel:SetText(L["Group Size"])

	local gpanel = self:CreatePanel()
	gpanel:SetPoint("TOPLEFT", glabel, "BOTTOMLEFT", -4, 0)
	gpanel:SetPoint("TOPRIGHT", glabel, "BOTTOMRIGHT", 4, 0)

	local gsolo = self:CreateCheckbox(L["Solo"])
	gsolo.desc = L["Show the display while you are not in a group"]
	gsolo:SetPoint("TOPLEFT", gpanel, 8, -8)
	gsolo:SetChecked(db.group.solo)
	gsolo.OnClick = function(self, checked)
		db.group.solo = checked
		ShieldsUp:UpdateVisibility()
	end

	local gparty = self:CreateCheckbox(L["Party"])
	gparty.desc = L["Show the display while you are in a party group"]
	gparty:SetPoint("TOPLEFT", gsolo, "BOTTOMLEFT", 0, -8)
	gparty:SetChecked(db.group.party)
	gparty.OnClick = function(self, checked)
		db.group.party = checked
		ShieldsUp:UpdateVisibility()
	end

	local graid = self:CreateCheckbox(L["Raid"])
	graid.desc = L["Show the display while you are in a raid group"]
	graid:SetPoint("TOPLEFT", gpanel, "TOP", 8, -16 - gsolo:GetHeight())
	graid:SetChecked(db.group.raid)
	graid.OnClick = function(self, checked)
		db.group.raid = checked
		ShieldsUp:UpdateVisibility()
	end

	gpanel:SetHeight(gsolo:GetHeight() * 2 + 24)

	--------------------------------------------------------------------

	local zlabel = self:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	zlabel:SetPoint("TOPLEFT", gpanel, "BOTTOMLEFT", 4, -8)
	zlabel:SetPoint("TOPRIGHT", gpanel, "BOTTOMRIGHT", -4, -8)
	zlabel:SetJustifyH("LEFT")
	zlabel:SetText(L["Zone Type"])

	local zpanel = self:CreatePanel()
	zpanel:SetPoint("TOPLEFT", zlabel, "BOTTOMLEFT", -4, 0)
	zpanel:SetPoint("TOPRIGHT", zlabel, "BOTTOMRIGHT", 4, 0)

	local zworld = self:CreateCheckbox(L["World"])
	zworld.desc = L["Show the display while you are in the outdoor world"]
	zworld:SetPoint("TOPLEFT", zpanel, 8, -8)
	zworld:SetChecked(db.zone.none)
	zworld.OnClick = function(self, checked)
		db.zone.solo = checked
		ShieldsUp:UpdateVisibility()
	end

	local zparty = self:CreateCheckbox(L["Party Dungeon"])
	zparty.desc = L["Show the display while you are in a party dungeon"]
	zparty:SetPoint("TOPLEFT", zworld, "BOTTOMLEFT", 0, -8)
	zparty:SetChecked(db.zone.party)
	zparty.OnClick = function(self, checked)
		db.zone.party = checked
		ShieldsUp:UpdateVisibility()
	end

	local zraid = self:CreateCheckbox(L["Raid Dungeon"])
	zraid.desc = L["Show the display while you are in a raid dungeon"]
	zraid:SetPoint("TOPLEFT", zpanel, "TOP", 8, -16 - zworld:GetHeight())
	zraid:SetChecked(db.zone.raid)
	zraid.OnClick = function(self, checked)
		db.group.raid = checked
		ShieldsUp:UpdateVisibility()
	end

	local zarena = self:CreateCheckbox(L["Arena"])
	zarena.desc = L["Show the display while you are in a PvP arena"]
	zarena:SetPoint("TOPLEFT", zparty, "BOTTOMLEFT", 0, -8)
	zarena:SetChecked(db.zone.arena)
	zarena.OnClick = function(self, checked)
		db.zone.arena = checked
		ShieldsUp:UpdateVisibility()
	end

	local zpvp = self:CreateCheckbox(L["Battleground"])
	zpvp.desc = L["Show the display while you are in a PvP battleground"]
	zpvp:SetPoint("TOPLEFT", zraid, "BOTTOMLEFT", 0, -8)
	zpvp:SetChecked(db.zone.pvp)
	zpvp.OnClick = function(self, checked)
		db.zone.pvp = checked
		ShieldsUp:UpdateVisibility()
	end

	zpanel:SetHeight(zworld:GetHeight() * 3 + 32)

	--------------------------------------------------------------------

	local xlabel = self:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	xlabel:SetPoint("TOPLEFT", zpanel, "BOTTOMLEFT", 4, -8)
	xlabel:SetPoint("TOPRIGHT", zpanel, "BOTTOMRIGHT", -4, -8)
	xlabel:SetJustifyH("LEFT")
	xlabel:SetText(L["Exceptions"])

	local xpanel = self:CreatePanel()
	xpanel:SetPoint("TOPLEFT", xlabel, "BOTTOMLEFT", -4, 0)
	xpanel:SetPoint("TOPRIGHT", xlabel, "BOTTOMRIGHT", 4, 0)

	local xdead = self:CreateCheckbox(L["Dead"])
	xdead.desc = L["Hide the display while you are dead"]
	xdead:SetPoint("TOPLEFT", xpanel, 8, -8)
	xdead:SetChecked(db.except.dead)
	xdead.OnClick = function(self, checked)
		db.except.dead = checked
		ShieldsUp:UpdateVisibility()
	end

	local xnocombat = self:CreateCheckbox(L["Out Of Combat"])
	xnocombat.desc = L["Hide the display while you are out of combat"]
	xnocombat:SetPoint("TOPLEFT", xpanel, "TOP", 8, -8)
	xnocombat:SetChecked(db.except.nocombat)
	xnocombat.OnClick = function(self, checked)
		db.except.nocombat = checked
		ShieldsUp:UpdateVisibility()
	end

	local xresting = self:CreateCheckbox(L["Resting"])
	xresting.desc = L["Hide the display while you are in an inn or major city"]
	xresting:SetPoint("TOPLEFT", xdead, "BOTTOMLEFT", 0, -8)
	xresting:SetChecked(db.except.resting)
	xresting.OnClick = function(self, checked)
		db.except.resting = checked
		ShieldsUp:UpdateVisibility()
	end

	local xvehicle = self:CreateCheckbox(L["Vehicle"])
	xvehicle.desc = L["Hide the display while you are controlling a vehicle"]
	xvehicle:SetPoint("TOPLEFT", xnocombat, "BOTTOMLEFT", 0, -8)
	xvehicle:SetChecked(db.except.vehicle)
	xvehicle.OnClick = function(self, checked)
		db.except.vehicle = checked
		ShieldsUp:UpdateVisibility()
	end

	xpanel:SetHeight(xdead:GetHeight() * 2 + 24)

	--------------------------------------------------------------------

	self.refresh = function()
		gsolo:SetChecked(db.group.solo)
		gparty:SetChecked(db.group.party)
		graid:SetChecked(db.group.raid)
		zworld:SetChecked(db.zone.none)
		zparty:SetChecked(db.zone.party)
		zraid:SetChecked(db.zone.raid)
		zarena:SetChecked(db.zone.arena)
		zpvp:SetChecked(db.zone.pvp)
		xdead:SetChecked(db.except.dead)
		xresting:SetChecked(db.except.resting)
		xvehicle:SetChecked(db.except.vehicle)
	end

	self:SetScript("OnShow", nil)
end)

InterfaceOptions_AddCategory(panel3)

------------------------------------------------------------------------

LibStub("LibAboutPanel").new(panel.name, ADDON_NAME)

------------------------------------------------------------------------

ShieldsUp.optionsPanel = panel

------------------------------------------------------------------------

SLASH_SHIELDSUP1 = "/sup"
SLASH_SHIELDSUP2 = "/shieldsup"
SlashCmdList.SHIELDSUP = function() InterfaceOptionsFrame_OpenToCategory(panel) end

------------------------------------------------------------------------