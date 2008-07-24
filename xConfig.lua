--[[
	xConfig: configuration widget creation helper
	Code mostly adapted from tekKonfig, OmniCC, and Ace3
--]]

xConfig = {}
local lib = xConfig

local editbox = CreateFrame("EditBox", nil, UIParent)
editbox:Hide()
editbox:SetAutoFocus(true)
editbox:SetHeight(32)
editbox:SetFontObject("GameFontHighlightSmall")
lib.editbox = editbox

local left = editbox:CreateTexture(nil, "BACKGROUND")
left:SetWidth(8) left:SetHeight(20)
left:SetPoint("LEFT", -5, 0)
left:SetTexture("Interface\\Common\\Common-Input-Border")
left:SetTexCoord(0, 0.0625, 0, 0.625)

local right = editbox:CreateTexture(nil, "BACKGROUND")
right:SetWidth(8) right:SetHeight(20)
right:SetPoint("RIGHT", 0, 0)
right:SetTexture("Interface\\Common\\Common-Input-Border")
right:SetTexCoord(0.9375, 1, 0, 0.625)

local center = editbox:CreateTexture(nil, "BACKGROUND")
center:SetHeight(20)
center:SetPoint("RIGHT", right, "LEFT", 0, 0)
center:SetPoint("LEFT", left, "RIGHT", 0, 0)
center:SetTexture("Interface\\Common\\Common-Input-Border")
center:SetTexCoord(0.0625, 0.9375, 0, 0.625)

editbox:SetScript("OnEditFocusGained", editbox.HighlightText)
editbox:SetScript("OnEditFocusLost", editbox.Hide)
editbox:SetScript("OnEscapePressed", editbox.ClearFocus)
editbox:SetScript("OnEnterPressed", function(self)
	local parent = self:GetParent()
	local old = parent.slider:GetValue()
	local low, high = parent.slider:GetMinMaxValues()
	local step = parent.slider:GetValueStep()
	if parent.slider.isPercent then
		parent.current:SetText((self:GetValue() * 100).."%")
	else
		parent.current:SetText(self:GetValue())
	end
	if self:GetValue() - old > 0 then
		parent.slider:SetValue(min(value + step, high))
	else
		parent.slider:SetValue(max(value + step, low))
	end
	if parent.func then parent.func() end
	self:Hide()
end)

local function OpenEditbox(self)
	editbox:SetText(self.val)
	editbox:SetParent(self)
	editbox:SetPoint("LEFT", self)
	editbox:SetPoint("RIGHT", self)
	editbox:Show()
end

local function ShowTooltip(self)
	if self.tip then
		GameTooltip:SetOwner(self)
		GameTooltip:SetText(tiptext)
	end
end

local function HideTooltip()
	GameTooltip:Hide()
end

local function Slider_OnValueChanged(self)
	if editbox:IsVisible() then
		editbox:Hide()
	end
	if self.isPercent then
		self:GetParent().current:SetText((self:GetValue() * 100).."%")
	else
		self:GetParent().current:SetText(self:GetValue())
	end
end

local function Slider_OnMouseWheel(self, delta)
	local step = self:GetValueStep() * delta
	local value = self:GetValue()
	local low, high = self:GetMinMaxValues()
	if step > 0 then
		self:SetValue(min(value + step, high))
	else
		self:SetValue(max(value + step, low))
	end
end

local bg = {
	bgFile = "Interface\\Buttons\\UI-SliderBar-Background",
	edgeFile = "Interface\\Buttons\\UI-SliderBar-Border",
	edgeSize = 8, tile = true, tileSize = 8,
	insets = {left = 3, right = 3, top = 6, bottom = 6}
}

function lib.CreateSlider(parent, label, lowvalue, highvalue, step, ...)
	local container = CreateFrame("Frame", nil, parent)
	container:SetWidth(144)
	container:SetHeight(17 + 10 + 12)
	if select(1, ...) then container:SetPoint(...) end

	local slider = CreateFrame("Slider", nil, container)
	slider:SetPoint("LEFT")
	slider:SetPoint("RIGHT")
	slider:SetHeight(17)
	slider:SetHitRectInsets(0, 0, 0, -10)
	slider:SetOrientation("HORIZONTAL")
	slider:SetBackdrop(bg)
	slider:SetThumbTexture("Interface\\Buttons\\UI-SliderBar-Button-Horizontal")
	container.slider = slider

	local label = slider:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	label:SetPoint("BOTTOMLEFT", slider, "TOPLEFT", -4, -3)

	local low = slider:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	low:SetPoint("TOPLEFT", slider, "BOTTOMLEFT", -4, 3)
	low:SetText(lowvalue)
	container.low = low

	local high = slider:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	high:SetPoint("TOPRIGHT", slider, "BOTTOMRIGHT", 4, 3)
	high:SetText(highvalue)
	container.high = high

	local current = slider:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	current:SetPoint("TOP", slider, "BOTTOM", 0, 3)
	current:SetWidth(slider:GetWidth() - low:GetWidth() - high:GetWidth() - 8)
	current:SetHeight(low:GetHeight())
	container.current = current

	local button = CreateFrame("Button", nil, container)
	button:SetAllPoints(current)
	button:SetScript("OnClick", OpenEditbox) -- this.val
	button:SetScript("OnEnter", ShowTooltip) -- this.tip
	button:SetScript("OnLeave", HideTooltip)
	current.button = button

	if type(lowvalue) == "string" then
		slider:SetMinMaxValues(tonumber(lowvalue:gsub("%%", "")) / 100, tonumber(highvalue:gsub("%%", "")) / 100)
		slider:SetValueStep(tonumber(step:gsub("%%", "")) / 100)
	else
		slider:SetMinMaxValues(lowvalue, highvalue)
		slider:SetStepValue(step)
	end

	slider:EnableMouseWheel(true)
	slider:SetScript("OnMouseWheel", Slider_OnMouseWheel)
	slider:SetScript("OnValueChanged", Slider_OnValueChanged)
	slider:SetScript("OnEnter", ShowTooltip) -- this.tip
	slider:SetScript("OnLeave", HideTooltip)

	return container
end

local function OnClick(self)
	PlaySound(self:GetChecked() and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")
end

function lib.CreateCheckbox(parent, label, ...)
	local check = CreateFrame("CheckButton", nil, parent)
	check:SetWidth(26)
	check:SetHeight(26)
	if select(1, ...) then check:SetPoint(...) end

	check:SetHitRectInsets(0, -100, 0, 0)

	check:SetNormalTexture("Interface\\Buttons\\UI-CheckBox-Up")
	check:SetPushedTexture("Interface\\Buttons\\UI-CheckBox-Down")
	check:SetHighlightTexture("Interface\\Buttons\\UI-CheckBox-Highlight")
	check:SetDisabledCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled")
	check:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")

	check:SetScript("OnEnter", ShowTooltip) -- self.tip
	check:SetScript("OnLeave", HideTooltip)
	check:SetScript("OnClick", OnClick) -- play sound

	-- Label
	local fs = check:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	fs:SetPoint("LEFT", check, "RIGHT", 0, 1)
	fs:SetText(label)
	check.label = fs

	return check
end

function lib.CreateHeading(parent, text, subtext)
	local title = parent:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	title:SetPoint("TOPLEFT", 16, -16)
	title:SetText(text)

	local subtitle = parent:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	subtitle:SetHeight(32)
	subtitle:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
	subtitle:SetPoint("RIGHT", parent, -32, 0)
	subtitle:SetNonSpaceWrap(true)
	subtitle:SetJustifyH("LEFT")
	subtitle:SetJustifyV("TOP")
	subtitle:SetText(subtext)

	return title, subtitle
end