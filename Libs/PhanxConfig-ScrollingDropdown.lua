--[[--------------------------------------------------------------------
	PhanxConfig-ScrollingDropdown
	Simple scrolling dropdown widget generator. Requires LibStub.
	Based on tekKonfig-Dropdown by Tekkub and OmniCC_Options by Tuller.
	Requires PhanxConfig-Dropdown.
----------------------------------------------------------------------]]

local PhanxConfigDropdown = LibStub:GetLibrary("PhanxConfig-Dropdown", true)
assert(PhanxConfigDropdown, "PhanxConfig-ScrollingDropdown requires PhanxConfig-Dropdown!")

local lib, oldminor = LibStub:NewLibrary("PhanxConfig-ScrollingDropdown", 1)
if not lib then return end

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

function lib.CreateScrollingDropdown(parent, name, items)
	assert(items and type(items) == "table", "Bad argument #3 to CreateScrollingDropdown (table expected, got " .. type(items) .. ")")

	local dropdown = PhanxConfigDropdown.CreateDropdown(parent, name)
	dropdown.button:SetScript("OnClick", DropdownButton_OnClick)
	dropdown.items = items

	return dropdown
end