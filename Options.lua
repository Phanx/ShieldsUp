--[[--------------------------------------------------------------------
	ShieldsUp
	Simple shaman shield monitor.
	by Phanx < addons@phanx.net >
	http://www.wowinterface.com/downloads/info9165-ShieldsUp.html
	Copyright © 2008 Alyssa S. Kinley, a.k.a Phanx
	See included README for license terms and additional information.

	This file adds a GUI configuration panel for ShieldsUp in the
	default Interface Options frame.
----------------------------------------------------------------------]]

if not ShieldsUp then return end
if not PhanxConfigWidgets then return end

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

	PhanxConfigWidgets:Embed(self)

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

	local posx = self:CreateSlider(L["Horizontal Position"], math.floor(screenwidth / 10) / 2 * -10, math.floor(screenwidth / 10) / 2 * 10, 5)
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

	local posy = self:CreateSlider(L["Vertical Position"], floor(screenheight / 10) / 2 * -10, floor(screenheight / 10) / 2 * 10, 5)
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

	local padh = self:CreateSlider(L["Horizontal Padding"], 0, floor(screenwidth / 10) / 2 * 10, 1)
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

	local padv = self:CreateSlider(L["Vertical Padding"], 0, floor(screenwidth / 10) / 2 * 10, 1)
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

	local typeface = self:CreateScrollingDropdown(L["Typeface"], ShieldsUp.fonts)
	typeface.container.hint = L["Select the typeface."]
	typeface.container:SetPoint("TOPLEFT", notes, "BOTTOM", 8, -16)
	typeface.container:SetPoint("TOPRIGHT", notes, "BOTTOMRIGHT", 2, -16)
	typeface.value:SetText(db.font.typeface or "Friz Quadrata TT")
	do
		local _, height, flags = typeface.value:GetFont()
		typeface.value:SetFont(LSM:Fetch("font", db.font.typeface or "Friz Quadrata TT"), height, flags)

		function typeface:OnValueChanged(value)
			local _, height, flags = self.value:GetFont()
			self.value:SetFont(LSM:Fetch("font", value), height, flags)
			db.font.face = value
			ShieldsUp:ApplySettings()
		end

		local OnClick = typeface.button:GetScript("OnClick")
		typeface.button:SetScript("OnClick", function(self)
			OnClick(self)
			typeface.list:Hide()

			local function SetButtonFonts(self)
				local buttons = typeface.list.buttons
				for i = 1, #buttons do
					local button = buttons[i]
					if button.value and button:IsShown() then
						button.label:SetFont(LSM:Fetch("font", button.value), UIDROPDOWNMENU_DEFAULT_TEXT_HEIGHT)
					end
				end
			end

			local OnShow = typeface.list:GetScript("OnShow")
			typeface.list:SetScript("OnShow", function(self)
				OnShow(self)
				SetButtonFonts(self)
			end)

			local OnVerticalScroll = typeface.list.scrollFrame:GetScript("OnVerticalScroll")
			typeface.list.scrollFrame:SetScript("OnVerticalScroll", function(self, delta)
				OnVerticalScroll(self, delta)
				SetButtonFonts(self)
			end)

			local SetText = typeface.list.text.SetText
			typeface.list.text.SetText = function(self, text)
				self:SetFont(LSM:Fetch("font", text), UIDROPDOWNMENU_DEFAULT_TEXT_HEIGHT + 1)
				SetText(self, text)
			end

			OnClick(self)

			self:SetScript("OnClick", OnClick)
		end)
	end

	-------------------------------------------------------------------

	local outline = self:CreateDropdown(L["Outline"])
	outline.container.hint = L["Select an outline width."]
	outline.container:SetPoint("TOPLEFT", typeface.container, "BOTTOMLEFT", 0, -8)
	outline.container:SetPoint("TOPRIGHT", typeface.container, "BOTTOMRIGHT", 0, -8)
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

			for value, name in pairs(outlines) do
				info.text = name
				info.value = value
				info.func = OnClick
				info.checked = name == selected
				UIDropDownMenu_AddButton(info)
			end
		end)

		UIDropDownMenu_SetSelectedValue(outline, db.font.outline or L["None"])
	end

	-------------------------------------------------------------------

	local shadow = self:CreateCheckbox(L["Shadow"])
	shadow.hint = L["Toggle the drop shadow effect."]
	shadow:SetPoint("TOPLEFT", outline.container, "BOTTOMLEFT", 0, -8)
	shadow:SetChecked(db.font.shadow)
	shadow:SetScript("OnClick", function(self)
		local checked = self:GetChecked()
		PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")
		db.font.shadow = checked and true or false
		ShieldsUp:ApplySettings()
	end)

	-------------------------------------------------------------------

	local colors = self:CreatePanel()
	colors:SetPoint("TOPLEFT", padv, "BOTTOMLEFT", -4, -32)
	colors:SetPoint("TOPRIGHT", notes, "BOTTOMRIGHT", 4, -16 - posx:GetHeight() - 24 - posy:GetHeight() - 24 - padh:GetHeight() - 24 - padv:GetHeight() - 24 - padv.label:GetHeight() - 32)
	colors:SetHeight(8 + 19 + 8 + 19 + 8 + 19 + 8)

	colors.label = self:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	colors.label:SetPoint("BOTTOMLEFT", colors, "TOPLEFT", 8, 0)
	colors.label:SetText(L["Colors"])

	-------------------------------------------------------------------

	local earth = self:CreateColorPicker(L["Earth Shield"])
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

	local lightning = self:CreateColorPicker(L["Lightning Shield"])
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

	local water = self:CreateColorPicker(L["Water Shield"])
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
	normal:SetPoint("TOPRIGHT", colors, -8, -8)
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
	overwritten:SetPoint("TOPRIGHT", normal, "BOTTOMRIGHT", 0, -8)
	overwritten:SetColor(unpack(db.color.overwritten))

	-------------------------------------------------------------------

	local alert = self:CreateColorPicker(L["Zero"])
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

		font.value:SetText(db.font.typeface or "Friz Quadrata TT")
		UIDropDownMenu_SetSelectedValue(font, db.font.typeface or "Friz Quadrata TT")
		outline.value:SetText(db.font.outline or L["None"])
		UIDropDownMenu_SetSelectedValue(outline, db.font.outline or L["None"])
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
	
	PhanxConfigWidgets:Embed(self)

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

	local epanel = self:CreatePanel()
	epanel:SetPoint("TOPLEFT", elabel, "BOTTOMLEFT", -4, 0)
	epanel:SetPoint("TOPRIGHT", elabel, "BOTTOMRIGHT", 4, 0)

	-------------------------------------------------------------------

	local etext = self:CreateCheckbox(L["Text alert"])
	etext.hint = L["Show a text message when %s expires."]:format(L["Earth Shield"])
	etext:SetPoint("TOPLEFT", epanel, 8, -8)
	etext:SetChecked(db.alert.earth.text)
	etext:SetScript("OnClick", function()
		local checked = self:GetChecked()
		PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")
		db.alert.earth.text = checked and true or false
	end)

	-------------------------------------------------------------------

	local esound = self:CreateCheckbox(L["Sound alert"])
	esound.hint = L["Play a sound when %s expires."]:format(L["Earth Shield"])
	esound:SetPoint("TOPLEFT", etext, "BOTTOMLEFT", 0, -8)
	esound:SetChecked(db.alert.earth.sound)
	esound:SetScript("OnClick", function()
		local checked = self:GetChecked()
		PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")
		db.alert.earth.sound = checked and true or false
	end)

	local esoundfile = self:CreateDropdown(L["Sound file"])
	esoundfile.container.hint = L["Select the sound to play when %s expires."]:format(L["Earth Shield"])
	esoundfile.container:SetPoint("BOTTOMLEFT", epanel, "BOTTOM", 8, 8)
	esoundfile.container:SetPoint("BOTTOMRIGHT", epanel, -8, 8)
	esoundfile.value:SetText(db.alert.earth.soundFile)
	do
		local function OnClick(self)
			PlaySoundFile(LSM:Fetch("sound", self.value))
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

	local wtext = self:CreateCheckbox(L["Text alert"])
	wtext.hint = L["Show a text message when %s expires."]:format(L["Water Shield"])
	wtext:SetPoint("TOPLEFT", wpanel, 8, -8)
	wtext:SetChecked(db.alert.water.text)
	wtext:SetScript("OnClick", function()
		local checked = self:GetChecked()
		PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")
		db.alert.water.text = checked and true or false
	end)

	-------------------------------------------------------------------

	local wsound = self:CreateCheckbox(L["Sound alert"])
	wsound.hint = L["Play a sound when when %s expires."]:format(L["Water Shield"])
	wsound:SetPoint("TOPLEFT", wtext, "BOTTOMLEFT", 0, -8)
	wsound:SetChecked(db.alert.water.sound)
	wsound:SetScript("OnClick", function()
		local checked = self:GetChecked()
		PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")
		db.alert.water.sound = checked and true or false
	end)

	-------------------------------------------------------------------

	local wsoundfile = self:CreateDropdown(L["Sound file"])
	wsoundfile.container.hint = L["Select the sound file to play when %s expires."]:format(L["Water Shield"])
	wsoundfile.container:SetPoint("BOTTOMLEFT", wpanel, "BOTTOM", 8, 8)
	wsoundfile.container:SetPoint("BOTTOMRIGHT", wpanel, -8, 8)
	wsoundfile.value:SetText(db.alert.water.soundFile)
	do
		local function OnClick(self)
			PlaySoundFile(LSM:Fetch("sound", self.value))
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
		sinkOptions = ShieldsUp:GetSinkAce2OptionsDataTable().output

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
				UIDropDownMenu_SetSelectedValue(output, self.value)
			end

			UIDropDownMenu_Initialize(output, function()
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
				sinkOptions.set(self.value, true)

				sinkOptions = ShieldsUp:GetSinkAce2OptionsDataTable().output

				scrollarea.value:SetText(self.text)
				UIDropDownMenu_SetSelectedValue(scrollarea, self.value)
			end

			UIDropDownMenu_Initialize(scrollarea, function()
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

			UIDropDownMenu_SetSelectedValue(scrollarea, db.alert.output.sink20ScrollArea)
		end

		--------------------------------------------------------------

		sticky = self:CreateCheckbox(sinkOptions.args.Sticky.name)
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