--[[--------------------------------------------------------------------
	PhanxConfig-Panel
	Simple background panel widget generator. Requires LibStub.
----------------------------------------------------------------------]]

local lib, oldminor = LibStub:NewLibrary("PhanxConfig-Panel", 1)
if not lib then return end

local panelBackdrop = GameTooltip:GetBackdrop()

function lib.CreatePanel(parent, width, height)
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