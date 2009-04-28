--[[--------------------------------------------------------------------
	ShieldsUp
	Simple shaman shield monitor.
	by Phanx < addons@phanx.net >
	http://www.wowinterface.com/downloads/info9165-ShieldsUp.html
	Copyright © 2008–2009 Alyssa "Phanx" Kinley
	See README for license terms and additional information.
----------------------------------------------------------------------]]

if not ShieldsUp then return end

------------------------------------------------------------------------

local panel = CreateFrame("Frame", "ShieldsUpOptionsFrame", InterfaceOptionsFramePanelContainer)
panel.name = GetAddOnMetadata("ShieldsUp", "Title")
panel:Hide()
panel:SetScript("OnShow", function(self)
	local L = ShieldsUp.L
	local db = ShieldsUpDB
	local SharedMedia = LibStub:GetLibrary("LibSharedMedia-3.0", true)

	local screenwidth = UIParent:GetWidth()
	local screenheight = UIParent:GetHeight()

	self.CreatePanel = LibStub:GetLibrary("PhanxConfig-Panel").CreatePanel
	self.CreateCheckbox = LibStub:GetLibrary("PhanxConfig-Checkbox").CreateCheckbox
	self.CreateColorPicker = LibStub:GetLibrary("PhanxConfig-ColorPicker").CreateColorPicker
	self.CreateDropdown = LibStub:GetLibrary("PhanxConfig-Dropdown").CreateDropdown
	self.CreateScrollingDropdown = LibStub:GetLibrary("PhanxConfig-ScrollingDropdown").CreateScrollingDropdown
	self.CreateSlider = LibStub:GetLibrary("PhanxConfig-Slider").CreateSlider

	-------------------------------------------------------------------

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
	notes:SetText(L["ShieldsUp is a simple monitor for your shaman shields. Use these settings to configure the addon's appearance and behavior."])

	-------------------------------------------------------------------

	local posx = self:CreateSlider(L["Horizontal Position"], math.floor(screenwidth / 10) / 2 * -10, math.floor(screenwidth / 10) / 2 * 10, 5)
	posx.hint = L["Set the horizontal distance from the center of the screen to place the display."]
	posx.container:SetPoint("TOPLEFT", notes, "BOTTOMLEFT", 0, -8)
	posx.container:SetPoint("TOPRIGHT", notes, "BOTTOM", -8, 8)
	posx:SetValue(db.posx or 0)
	posx.value:SetText(db.posx or 0)
	posx:SetScript("OnValueChanged", function(self)
		db.posx = math.floor(self:GetValue())
		self.value:SetText(db.posx)
		ShieldsUp:ApplySettings()
	end)

	-------------------------------------------------------------------

	local posy = self:CreateSlider(L["Vertical Position"], floor(screenheight / 10) / 2 * -10, floor(screenheight / 10) / 2 * 10, 5)
	posy.hint = L["Set the vertical distance from the center of the screen to place the display."]
	posy.container:SetPoint("TOPLEFT", posx.container, "BOTTOMLEFT", 0, -8)
	posy.container:SetPoint("TOPRIGHT", posx.container, "BOTTOMRIGHT", 0, -8)
	posy:SetValue(db.posy or -150)
	posy.value:SetText(db.posy or 0)
	posy:SetScript("OnValueChanged", function(self)
		db.posy = floor(self:GetValue())
		self.value:SetText(db.posy)
		ShieldsUp:ApplySettings()
	end)

	-------------------------------------------------------------------

	local padh = self:CreateSlider(L["Horizontal Padding"], 0, floor(screenwidth / 10) / 2 * 10, 1)
	padh.hint = L["Set the horizontal space between the charge counts."]
	padh.container:SetPoint("TOPLEFT", posy.container, "BOTTOMLEFT", 0, -8)
	padh.container:SetPoint("TOPRIGHT", posy.container, "BOTTOMRIGHT", 0, -8)
	padh:SetValue(db.padh or 0)
	padh.value:SetText(db.padh or 0)
	padh:SetScript("OnValueChanged", function(self)
		db.padh = floor(self:GetValue())
		self.value:SetText(db.padh)
		ShieldsUp:ApplySettings()
	end)

	-------------------------------------------------------------------

	local padv = self:CreateSlider(L["Vertical Padding"], 0, floor(screenwidth / 10) / 2 * 10, 1)
	padv.hint = L["Set the vertical space between the target name and charge counters."]
	padv.container:SetPoint("TOPLEFT", padh.container, "BOTTOMLEFT", 0, -8)
	padv.container:SetPoint("TOPRIGHT", padh.container, "BOTTOMRIGHT", 0, -8)
	padv:SetValue(db.padv or 0)
	padv.value:SetText(db.padv or 0)
	padv:SetScript("OnValueChanged", function(self)
		db.padv = floor(self:GetValue())
		self.value:SetText(db.padv)
		ShieldsUp:ApplySettings()
	end)

	-------------------------------------------------------------------

	local face = self:CreateScrollingDropdown(L["Font Face"], ShieldsUp.fonts)
	face.container.hint = L["Set the font face to use for the display text."]
	face.container:SetPoint("TOPLEFT", notes, "BOTTOM", 8, -8)
	face.container:SetPoint("TOPRIGHT", notes, "BOTTOMRIGHT", 0, -8)
	face.value:SetText(db.font.face or "Friz Quadrata TT")
	do
		local _, height, flags = face.value:GetFont()
		face.value:SetFont(SharedMedia:Fetch("font", db.font.face or "Friz Quadrata TT"), height, flags)

		function face:OnValueChanged(value)
			local _, height, flags = self.value:GetFont()
			self.value:SetFont(SharedMedia:Fetch("font", value), height, flags)
			db.font.face = value
			ShieldsUp:ApplySettings()
		end

		local OnClick = face.button:GetScript("OnClick")
		face.button:SetScript("OnClick", function(self)
			OnClick(self)
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

			OnClick(self)

			self:SetScript("OnClick", OnClick)
		end)
	end

	-------------------------------------------------------------------

	local outline = self:CreateDropdown(L["Outline"])
	outline.container.hint = L["Select an outline width for the display text."]
	outline.container:SetPoint("TOPLEFT", face.container, "BOTTOMLEFT", 0, -8)
	outline.container:SetPoint("TOPRIGHT", face.container, "BOTTOMRIGHT", 0, -8)
	do
		local outlines = { ["NONE"] = L["None"], ["OUTLINE"] = L["Thin"], ["THICKOUTLINE"] = L["Thick"] }

		outline.value:SetText(outlines[db.font.outline] or L["None"])

		local function OnClick(self)
			db.font.outline = self.value
			ShieldsUp:ApplySettings()
			outline.value:SetText(self.text)
			UIDropDownMenu_SetSelectedValue(outline, self.value)
		end

		UIDropDownMenu_Initialize(outline, function()
			local selected = outlines[UIDropDownMenu_GetSelectedValue(outline)] or outline.value:GetText()
			local info = UIDropDownMenu_CreateInfo()

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

		UIDropDownMenu_SetSelectedValue(outline, db.font.outline or L["None"])
	end

	-------------------------------------------------------------------

	local shadow = self:CreateCheckbox(L["Shadow"])
	shadow.hint = L["Add a drop shadow effect to the display text."]
	shadow:SetPoint("TOPLEFT", outline.container, "BOTTOMLEFT", 0, -8)
	shadow:SetChecked(db.font.shadow)
	shadow:SetScript("OnClick", function(self)
		local checked = self:GetChecked()
		PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")
		db.font.shadow = checked and true or false
		ShieldsUp:ApplySettings()
	end)

	-------------------------------------------------------------------

	local large = self:CreateSlider(L["Counter Size"], 6, 32, 1)
	large.hint = L["Set the text size for the charge counters."]
	large.container:SetPoint("TOPLEFT", outline.container, "BOTTOMLEFT", 0, -8 - shadow:GetHeight() - 8)
	large.container:SetPoint("TOPRIGHT", outline.container, "BOTTOMRIGHT", 0, -8 - shadow:GetHeight() - 8)
	large:SetValue(db.font.large or 0)
	large.value:SetText(db.font.large or 0)
	large:SetScript("OnValueChanged", function(self)
		db.font.large = floor(self:GetValue())
		self.value:SetText(db.font.large)
		ShieldsUp:ApplySettings()
	end)

	-------------------------------------------------------------------

	local small = self:CreateSlider(L["Name Size"], 6, 32, 1)
	small.hint = L["Set the text size for the target name."]
	small.container:SetPoint("TOPLEFT", large.container, "BOTTOMLEFT", 0, -8)
	small.container:SetPoint("TOPRIGHT", large.container, "BOTTOMRIGHT", 0, -8)
	small:SetValue(db.font.small or 0)
	small.value:SetText(db.font.small or 0)
	small:SetScript("OnValueChanged", function(self)
		db.font.small = floor(self:GetValue())
		self.value:SetText(db.font.small)
		ShieldsUp:ApplySettings()
	end)

	-------------------------------------------------------------------

	local colors = self:CreatePanel()
	colors:SetPoint("TOPLEFT", padv, "BOTTOMLEFT", -4, -32)
	colors:SetPoint("TOPRIGHT", notes, "BOTTOMRIGHT", 4, -16 - posx:GetHeight() - 24 - posy:GetHeight() - 24 - padh:GetHeight() - 24 - padv:GetHeight() - 24 - padv.label:GetHeight() - 32)
	colors:SetHeight(shadow:GetHeight() * 3 + 32)

	colors.label = self:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	colors.label:SetPoint("BOTTOMLEFT", colors, "TOPLEFT", 8, 0)
	colors.label:SetText(L["Colors"])

	-------------------------------------------------------------------

	local earth = self:CreateColorPicker(L["Earth Shield"])
	earth.hint = string.format(L["Set the color for the %s charge counter."], L["Earth Shield"])
	earth.GetValue = function() return unpack(db.color.earth) end
	earth.SetValue = function(self, r, g, b)
		db.color.earth[1] = r
		db.color.earth[2] = g
		db.color.earth[3] = b
		ShieldsUp:Update()
	end
	earth:SetPoint("TOPLEFT", colors, 8, -8)
--	earth:SetPoint("TOPRIGHT", colors, "TOP", -8, -8)
	earth:SetColor(unpack(db.color.earth))

	-------------------------------------------------------------------

	local lightning = self:CreateColorPicker(L["Lightning Shield"])
	lightning.hint = string.format(L["Set the color for the %s charge counter."], L["Lightning Shield"])
	lightning.GetValue = function() return unpack(db.color.lightning) end
	lightning.SetValue = function(self, r, g, b)
		db.color.lightning[1] = r
		db.color.lightning[2] = g
		db.color.lightning[3] = b
		ShieldsUp:Update()
	end
	lightning:SetPoint("TOPLEFT", earth, "BOTTOMLEFT", 0, -8)
--	lightning:SetPoint("TOPRIGHT", earth, "BOTTOMRIGHT", 0, -8)
	lightning:SetColor(unpack(db.color.lightning))

	-------------------------------------------------------------------

	local water = self:CreateColorPicker(L["Water Shield"])
	earth.hint = string.format(L["Set the color for the %s charge counter."], L["Water Shield"])
	water.GetValue = function() return unpack(db.color.water) end
	water.SetValue = function(self, r, g, b)
		db.color.water[1] = r
		db.color.water[2] = g
		db.color.water[3] = b
		ShieldsUp:Update()
	end
	water:SetPoint("TOPLEFT", lightning, "BOTTOMLEFT", 0, -8)
--	water:SetPoint("TOPRIGHT", lightning, "BOTTOMRIGHT", 0, -8)
	water:SetColor(unpack(db.color.water))

	-------------------------------------------------------------------

	local normal = self:CreateColorPicker(L["Active"])
	normal.hint = string.format(L["Set the color for the target name while your %s is active."], L["Earth Shield"])
	normal.GetValue = function() return unpack(db.color.normal) end
	normal.SetValue = function(self, r, g, b)
		db.color.normal[1] = r
		db.color.normal[2] = g
		db.color.normal[3] = b
		ShieldsUp:Update()
	end
	normal:SetPoint("TOPLEFT", colors, "TOP", 8, -8)
--	normal:SetPoint("TOPRIGHT", colors, -8, -8)
	normal:SetColor(unpack(db.color.normal))

	-------------------------------------------------------------------

	local overwritten = self:CreateColorPicker(L["Overwritten"])
	overwritten.hint = string.format(L["Set the color for the target name when your %s has been overwritten."], L["Earth Shield"])
	overwritten.GetValue = function() return unpack(db.color.overwritten) end
	overwritten.SetValue = function(self, r, g, b)
		db.color.overwritten[1] = r
		db.color.overwritten[2] = g
		db.color.overwritten[3] = b
		ShieldsUp:Update()
	end
	overwritten:SetPoint("TOPLEFT", normal, "BOTTOMLEFT", 0, -8)
--	overwritten:SetPoint("TOPRIGHT", normal, "BOTTOMRIGHT", 0, -8)
	overwritten:SetColor(unpack(db.color.overwritten))

	-------------------------------------------------------------------

	local alert = self:CreateColorPicker(L["Inactive"])
	alert.hint = L["Set the color for expired, dispelled, or otherwise inactive shields."]
	alert.GetValue = function() return unpack(db.color.alert) end
	alert.SetValue = function(self, r, g, b)
		db.color.alert[1] = r
		db.color.alert[2] = g
		db.color.alert[3] = b
		ShieldsUp:Update()
	end
	alert:SetPoint("TOPLEFT", overwritten, "BOTTOMLEFT", 0, -8)
--	alert:SetPoint("TOPRIGHT", overwritten, "BOTTOMRIGHT", 0, -8)
	alert:SetColor(unpack(db.color.alert))

	-------------------------------------------------------------------

	local cblind = self:CreateCheckbox(L["Colorblind Mode"])
	cblind.hint = L["Add asterisks around the target name when your %s has been overwritten, in addition to changing the color."]:format(L["Earth Shield"])
	cblind:SetPoint("TOPLEFT", colors, "BOTTOMLEFT", 0, -8)
	cblind:SetChecked(db.colorblind)
	cblind:SetScript("OnClick", function(self)
		local checked = self:GetChecked()
		PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")
		db.colorblind = checked
		ShieldsUp:Update()
	end)

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
		UIDropDownMenu_SetSelectedValue(font, db.font.face or "Friz Quadrata TT")
		outline.value:SetText(db.font.outline or L["None"])
		UIDropDownMenu_SetSelectedValue(outline, db.font.outline or L["None"])
		shadow:SetChecked(db.font.shadow)
		large:SetValue(db.font.large or 24)
		large.value:SetText(db.font.large or 24)
		small:SetValue(db.font.small or 16)
		small.value:SetText(db.font.small or 16)

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
panel2.name = ShieldsUp.L["Alerts"]
panel2.parent = panel.name
panel2:Hide()
panel2:SetScript("OnShow", function(self)
	local L = ShieldsUp.L
	local db = ShieldsUpDB
	local sinkOptions

	local SharedMedia = LibStub:GetLibrary("LibSharedMedia-3.0", true)

	self.CreatePanel = LibStub:GetLibrary("PhanxConfig-Panel").CreatePanel
	self.CreateCheckbox = LibStub:GetLibrary("PhanxConfig-Checkbox").CreateCheckbox
	self.CreateDropdown = LibStub:GetLibrary("PhanxConfig-Dropdown").CreateDropdown

	-------------------------------------------------------------------

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
	notes:SetText(L["Use these settings to configure how ShieldsUp alerts you when a shield expires or is removed."])

	-------------------------------------------------------------------

	local elabel = self:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	elabel:SetPoint("TOPLEFT", notes, "BOTTOMLEFT", 0, -16)
	elabel:SetPoint("TOPRIGHT", notes, "BOTTOMRIGHT", 0, -16)
	elabel:SetJustifyH("LEFT")
	elabel:SetText(L["Earth Shield"])

	local epanel = self:CreatePanel()
	epanel:SetPoint("TOPLEFT", elabel, "BOTTOMLEFT", -4, 0)
	epanel:SetPoint("TOPRIGHT", elabel, "BOTTOMRIGHT", 4, 0)

	-------------------------------------------------------------------

	local etext = self:CreateCheckbox(L["Text Alert"])
	etext.hint = L["Show a text message when %s expires."]:format(L["Earth Shield"])
	etext:SetPoint("TOPLEFT", epanel, 8, -8)
	etext:SetChecked(db.alert.earth.text)
	etext:SetScript("OnClick", function(self)
		local checked = self:GetChecked()
		PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")
		db.alert.earth.text = checked and true or false
	end)

	-------------------------------------------------------------------

	local esound = self:CreateCheckbox(L["Sound Alert"])
	esound.hint = L["Play a sound when %s expires."]:format(L["Earth Shield"])
	esound:SetPoint("TOPLEFT", etext, "BOTTOMLEFT", 0, -8)
	esound:SetChecked(db.alert.earth.sound)
	esound:SetScript("OnClick", function(self)
		local checked = self:GetChecked()
		PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")
		db.alert.earth.sound = checked and true or false
	end)

	local esoundfile = self:CreateDropdown(L["Sound File"])
	esoundfile.container.hint = L["Select the sound to play when %s expires."]:format(L["Earth Shield"])
	esoundfile.container:SetPoint("BOTTOMLEFT", epanel, "BOTTOM", 8, 8)
	esoundfile.container:SetPoint("BOTTOMRIGHT", epanel, -8, 8)
	esoundfile.value:SetText(db.alert.earth.soundFile)
	do
		local function OnClick(self)
			PlaySoundFile(SharedMedia:Fetch("sound", self.value))
			db.alert.earth.soundFile = self.value
			esoundfile.value:SetText(self.text)
			UIDropDownMenu_SetSelectedValue(esoundfile, self.value)
		end

		UIDropDownMenu_Initialize(esoundfile, function()
			local selected = UIDropDownMenu_GetSelectedValue(esoundfile) or esoundfile.value:GetText()
			local info = UIDropDownMenu_CreateInfo()

			for i, sound in ipairs(ShieldsUp.sounds) do
				info.text = sound
				info.value = sound
				info.func = OnClick
				info.checked = sound == selected
				UIDropDownMenu_AddButton(info)
			end
		end)

		UIDropDownMenu_SetSelectedValue(esoundfile, db.alert.earth.soundFile)
	end

	-------------------------------------------------------------------

	epanel:SetHeight(8 + etext:GetHeight() + 8 + esound:GetHeight() + 8)

	-------------------------------------------------------------------

	local wlabel = self:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	wlabel:SetPoint("TOPLEFT", epanel, "BOTTOMLEFT", 4, -8)
	wlabel:SetPoint("TOPRIGHT", epanel, "BOTTOMRIGHT", -4, -8)
	wlabel:SetJustifyH("LEFT")
	wlabel:SetText(L["Water Shield"])

	local wpanel = self:CreatePanel()
	wpanel:SetPoint("TOPLEFT", wlabel, "BOTTOMLEFT", -4, 0)
	wpanel:SetPoint("TOPRIGHT", wlabel, "BOTTOMRIGHT", 4, 0)

	-------------------------------------------------------------------

	local wtext = self:CreateCheckbox(L["Text Alert"])
	wtext.hint = L["Show a text message when %s expires."]:format(L["Water Shield"])
	wtext:SetPoint("TOPLEFT", wpanel, 8, -8)
	wtext:SetChecked(db.alert.water.text)
	wtext:SetScript("OnClick", function(self)
		local checked = self:GetChecked()
		PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")
		db.alert.water.text = checked and true or false
	end)

	-------------------------------------------------------------------

	local wsound = self:CreateCheckbox(L["Sound Alert"])
	wsound.hint = L["Play a sound when when %s expires."]:format(L["Water Shield"])
	wsound:SetPoint("TOPLEFT", wtext, "BOTTOMLEFT", 0, -8)
	wsound:SetChecked(db.alert.water.sound)
	wsound:SetScript("OnClick", function(self)
		local checked = self:GetChecked()
		PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")
		db.alert.water.sound = checked and true or false
	end)

	-------------------------------------------------------------------

	local wsoundfile = self:CreateDropdown(L["Sound File"])
	wsoundfile.container.hint = L["Select the sound file to play when %s expires."]:format(L["Water Shield"])
	wsoundfile.container:SetPoint("BOTTOMLEFT", wpanel, "BOTTOM", 8, 8)
	wsoundfile.container:SetPoint("BOTTOMRIGHT", wpanel, -8, 8)
	wsoundfile.value:SetText(db.alert.water.soundFile)
	do
		local function OnClick(self)
			PlaySoundFile(SharedMedia:Fetch("sound", self.value))
			db.alert.water.soundFile = self.value
			wsoundfile.value:SetText(self.text)
			UIDropDownMenu_SetSelectedValue(wsoundfile, self.value)
		end

		UIDropDownMenu_Initialize(wsoundfile, function()
			local selected = UIDropDownMenu_GetSelectedValue(wsoundfile) or wsoundfile.value:GetText()
			local info = UIDropDownMenu_CreateInfo()

			for i, sound in ipairs(ShieldsUp.sounds) do
				info.text = sound
				info.value = sound
				info.func = OnClick
				info.checked = sound == selected
				UIDropDownMenu_AddButton(info)
			end
		end)

		UIDropDownMenu_SetSelectedValue(wsoundfile, db.alert.water.soundFile)
	end

	-------------------------------------------------------------------

	wpanel:SetHeight(8 + wtext:GetHeight() + 8 + wsound:GetHeight() + 8)

	-------------------------------------------------------------------

	local olabel, opanel, output, scrollarea, sticky
	if ShieldsUp.Pour then
		sinkOptions = ShieldsUp:GetSinkAce3OptionsDataTable()
		
		local info = { }

		local function UpdateOutputPanel()
			info[1] = "ScrollArea"
			if sinkOptions.disabled(info) then
				scrollarea.container:Hide()
			else
				scrollarea.container:Show()
			end

			info[1] = "Sticky"
			if sinkOptions.disabled(info) then
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

		output = self:CreateDropdown(sinkOptions.name)
		output.container.hint = sinkOptions.desc
		output.container:SetPoint("TOPLEFT", opanel, 8, -8)
		output.container:SetPoint("TOPRIGHT", opanel, "TOP", -4, -8)
		output.value:SetText(db.alert.output.sink20OutputSink or L["Raid Warning"])
		do
			local function OnClick(self)
				info[1] = self.value
				sinkOptions.set(info, true)
				sinkOptions = ShieldsUp:GetSinkAce3OptionsDataTable()

				local valid, current = false, db.alert.output.sink20ScrollArea
				for i, v in ipairs(sinkOptions.args.ScrollArea.values) do
					if v == current then
						valid = true
						break
					end
				end
				if not valid then
					db.alert.output.sink20ScrollArea = nil
					scrollarea.value:SetText(" ")
				end

				output.value:SetText(self.text)
				UIDropDownMenu_SetSelectedValue(output, self.value)
			end

			UIDropDownMenu_Initialize(output, function()
				local selected = db.alert.output.sink20OutputSink or output.value:GetText()
				local info = UIDropDownMenu_CreateInfo()

				for k, v in pairs(sinkOptions.args) do
					if k ~= "Default" and k ~= "Sticky" and v.type == "toggle" then
						info.text = v.name
						info.value = k
						info.func = OnClick
						info.checked = v.name == selected
						UIDropDownMenu_AddButton(info)
					end
				end
			end)

			UIDropDownMenu_SetSelectedValue(output, db.alert.output.sink20OutputSink or "RaidWarning")
		end

		--------------------------------------------------------------

		scrollarea = self:CreateDropdown(sinkOptions.args.ScrollArea.name)
		scrollarea.container.hint = sinkOptions.args.ScrollArea.desc
		scrollarea.container:SetPoint("TOPLEFT", opanel, "TOP", 4, -8)
		scrollarea.container:SetPoint("TOPRIGHT", opanel, -8, -8)
		scrollarea.value:SetText(db.alert.output.sink20ScrollArea)
		do
			local function OnClick(self)
				info[1] = "ScrollArea"
				sinkOptions.set(info, self.value)
				sinkOptions = ShieldsUp:GetSinkAce3OptionsDataTable()

				scrollarea.value:SetText(self.text)
				UIDropDownMenu_SetSelectedValue(scrollarea, self.value)
			end

			UIDropDownMenu_Initialize(scrollarea, function()
				local selected = db.alert.output.sink20ScrollArea or scrollarea.value:GetText()
				local info = UIDropDownMenu_CreateInfo()

				for i, v in ipairs(sinkOptions.args.ScrollArea.values) do
					info.text = v
					info.value = v
					info.func = OnClick
					info.checked = v == selected
					UIDropDownMenu_AddButton(info)
				end
			end)

			UIDropDownMenu_SetSelectedValue(scrollarea, db.alert.output.sink20ScrollArea)
		end

		--------------------------------------------------------------

		sticky = self:CreateCheckbox(sinkOptions.args.Sticky.name)
		sticky.hint = sinkOptions.args.Sticky.desc
		sticky:SetPoint("TOPLEFT", scrollarea.container, "BOTTOMLEFT", 0, -8)
		sticky:SetChecked(db.alert.output.sink20Sticky)
		sticky:SetScript("OnClick", function(self)
			local checked = self:GetChecked()
			PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")
			
			info[1] = "Sticky"
			sinkOptions.set(info, checked)
			sinkOptions = ShieldsUp:GetSinkAce3OptionsDataTable()
		end)

		--------------------------------------------------------------

		UpdateOutputPanel()
	end

	-------------------------------------------------------------------

	self.refresh = function()
	end

	self:SetScript("OnShow", nil)
end)

InterfaceOptions_AddCategory(panel2)

------------------------------------------------------------------------

local panel3 = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
panel3.name = ShieldsUp.L["Visibility"]
panel3.parent = panel.name
panel3:Hide()
panel3:SetScript("OnShow", function(self)
	local L = ShieldsUp.L
	local db = ShieldsUpDB.show

	self.CreatePanel = LibStub:GetLibrary("PhanxConfig-Panel").CreatePanel
	self.CreateCheckbox = LibStub:GetLibrary("PhanxConfig-Checkbox").CreateCheckbox

	-------------------------------------------------------------------

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

	-------------------------------------------------------------------

	local glabel = self:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	glabel:SetPoint("TOPLEFT", notes, "BOTTOMLEFT", 0, -8)
	glabel:SetPoint("TOPRIGHT", notes, "BOTTOMRIGHT", 0, -8)
	glabel:SetJustifyH("LEFT")
	glabel:SetText(L["Group Type"])

	local gpanel = self:CreatePanel()
	gpanel:SetPoint("TOPLEFT", glabel, "BOTTOMLEFT", -4, 0)
	gpanel:SetPoint("TOPRIGHT", glabel, "BOTTOMRIGHT", 4, 0)

	local gsolo = self:CreateCheckbox(L["Solo"])
	gsolo.hint = L["Show the display while you are not in a group"]
	gsolo:SetPoint("TOPLEFT", gpanel, 8, -8)
	gsolo:SetChecked(db.group.solo)
	gsolo:SetScript("OnClick", function(self)
		local checked = self:GetChecked() and true or false
		PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")
		db.group.solo = checked
		ShieldsUp:UpdateVisibility()
	end)

	local gparty = self:CreateCheckbox(L["Party"])
	gparty.hint = L["Show the display while you are in a party group"]
	gparty:SetPoint("TOPLEFT", gsolo, "BOTTOMLEFT", 0, -8)
	gparty:SetChecked(db.group.party)
	gparty:SetScript("OnClick", function(self)
		local checked = self:GetChecked() and true or false
		PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")
		db.group.party = checked
		ShieldsUp:UpdateVisibility()
	end)

	local graid = self:CreateCheckbox(L["Raid"])
	graid.hint = L["Show the display while you are in a raid group"]
	graid:SetPoint("TOPLEFT", gpanel, "TOP", 8, -16 - gsolo:GetHeight())
	graid:SetChecked(db.group.raid)
	graid:SetScript("OnClick", function(self)
		local checked = self:GetChecked() and true or false
		PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")
		db.group.raid = checked
		ShieldsUp:UpdateVisibility()
	end)
	
	gpanel:SetHeight(gsolo:GetHeight() * 2 + 24)

	-------------------------------------------------------------------

	local zlabel = self:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	zlabel:SetPoint("TOPLEFT", gpanel, "BOTTOMLEFT", 4, -8)
	zlabel:SetPoint("TOPRIGHT", gpanel, "BOTTOMRIGHT", -4, -8)
	zlabel:SetJustifyH("LEFT")
	zlabel:SetText(L["Zone Type"])

	local zpanel = self:CreatePanel()
	zpanel:SetPoint("TOPLEFT", zlabel, "BOTTOMLEFT", -4, 0)
	zpanel:SetPoint("TOPRIGHT", zlabel, "BOTTOMRIGHT", 4, 0)

	local zworld = self:CreateCheckbox(L["World"])
	zworld.hint = L["Show the display while you are in the outdoor world"]
	zworld:SetPoint("TOPLEFT", zpanel, 8, -8)
	zworld:SetChecked(db.zone.none)
	zworld:SetScript("OnClick", function(self)
		local checked = self:GetChecked() and true or false
		PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")
		db.zone.solo = checked
		ShieldsUp:UpdateVisibility()
	end)

	local zparty = self:CreateCheckbox(L["Party Dungeon"])
	zparty.hint = L["Show the display while you are in a party dungeon"]
	zparty:SetPoint("TOPLEFT", zworld, "BOTTOMLEFT", 0, -8)
	zparty:SetChecked(db.zone.party)
	zparty:SetScript("OnClick", function(self)
		local checked = self:GetChecked() and true or false
		PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")
		db.zone.party = checked
		ShieldsUp:UpdateVisibility()
	end)

	local zraid = self:CreateCheckbox(L["Raid Dungeon"])
	zraid.hint = L["Show the display while you are in a raid dungeon"]
	zraid:SetPoint("TOPLEFT", zpanel, "TOP", 8, -16 - zworld:GetHeight())
	zraid:SetChecked(db.zone.raid)
	zraid:SetScript("OnClick", function(self)
		local checked = self:GetChecked() and true or false
		PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")
		db.group.raid = checked
		ShieldsUp:UpdateVisibility()
	end)

	local zarena = self:CreateCheckbox(L["Arena"])
	zarena.hint = L["Show the display while you are in a PvP arena"]
	zarena:SetPoint("TOPLEFT", zparty, "BOTTOMLEFT", 0, -8)
	zarena:SetChecked(db.zone.arena)
	zarena:SetScript("OnClick", function(self)
		local checked = self:GetChecked() and true or false
		PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")
		db.zone.arena = checked
		ShieldsUp:UpdateVisibility()
	end)

	local zpvp = self:CreateCheckbox(L["Battleground"])
	zpvp.hint = L["Show the display while you are in a PvP battleground"]
	zpvp:SetPoint("TOPLEFT", zraid, "BOTTOMLEFT", 0, -8)
	zpvp:SetChecked(db.zone.pvp)
	zpvp:SetScript("OnClick", function(self)
		local checked = self:GetChecked() and true or false
		PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")
		db.zone.pvp = checked
		ShieldsUp:UpdateVisibility()
	end)
	
	zpanel:SetHeight(zworld:GetHeight() * 3 + 32)

	-------------------------------------------------------------------

	local xlabel = self:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	xlabel:SetPoint("TOPLEFT", zpanel, "BOTTOMLEFT", 4, -8)
	xlabel:SetPoint("TOPRIGHT", zpanel, "BOTTOMRIGHT", -4, -8)
	xlabel:SetJustifyH("LEFT")
	xlabel:SetText(L["Exceptions"])

	local xpanel = self:CreatePanel()
	xpanel:SetPoint("TOPLEFT", xlabel, "BOTTOMLEFT", -4, 0)
	xpanel:SetPoint("TOPRIGHT", xlabel, "BOTTOMRIGHT", 4, 0)

	local xdead = self:CreateCheckbox(L["Dead"])
	xdead.hint = L["Hide the display while you are dead"]
	xdead:SetPoint("TOPLEFT", xpanel, 8, -8)
	xdead:SetChecked(db.except.dead)
	xdead:SetScript("OnClick", function(self)
		local checked = self:GetChecked() and true or false
		PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")
		db.except.dead = checked
		ShieldsUp:UpdateVisibility()
	end)

	local xnocombat = self:CreateCheckbox(L["Out Of Combat"])
	xnocombat.hint = L["Hide the display while you are out of combat"]
	xnocombat:SetPoint("TOPLEFT", xpanel, "TOP", 8, -8)
	xnocombat:SetChecked(db.except.nocombat)
	xnocombat:SetScript("OnClick", function(self)
		local checked = self:GetChecked() and true or false
		PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")
		db.except.nocombat = checked
		ShieldsUp:UpdateVisibility()
	end)

	local xresting = self:CreateCheckbox(L["Resting"])
	xresting.hint = L["Hide the display while you are in an inn or major city"]
	xresting:SetPoint("TOPLEFT", xdead, "BOTTOMLEFT", 0, -8)
	xresting:SetChecked(db.except.resting)
	xresting:SetScript("OnClick", function(self)
		local checked = self:GetChecked() and true or false
		PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")
		db.except.resting = checked
		ShieldsUp:UpdateVisibility()
	end)

	local xvehicle = self:CreateCheckbox(L["Vehicle"])
	xvehicle.hint = L["Hide the display while you are controlling a vehicle"]
	xvehicle:SetPoint("TOPLEFT", xnocombat, "BOTTOMLEFT", 0, -8)
	xvehicle:SetChecked(db.except.vehicle)
	xvehicle:SetScript("OnClick", function(self)
		local checked = self:GetChecked() and true or false
		PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")
		db.except.vehicle = checked
		ShieldsUp:UpdateVisibility()
	end)
	
	xpanel:SetHeight(xdead:GetHeight() * 2 + 24)

	-------------------------------------------------------------------

	self:SetScript("OnShow", nil)
end)

InterfaceOptions_AddCategory(panel3)

------------------------------------------------------------------------

LibStub:GetLibrary("LibAboutPanel").new(panel.name, "ShieldsUp")

------------------------------------------------------------------------

SLASH_SHIELDSUP1 = "/sup"
SLASH_SHIELDSUP2 = "/shieldsup"
SlashCmdList.SHIELDSUP = function() InterfaceOptionsFrame_OpenToCategory(panel) end

------------------------------------------------------------------------