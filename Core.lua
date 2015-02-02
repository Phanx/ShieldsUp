--[[--------------------------------------------------------------------
	ShieldsUp
	Text-based shaman shield monitor.
	Copyright (c) 2008-2015 Phanx <addons@phanx.net>. All rights reserved.
	http://www.wowinterface.com/downloads/info9165-ShieldsUp.html
	http://www.curse.com/addons/wow/shieldsup
----------------------------------------------------------------------]]

local SHIELDSUP, ShieldsUp = ...
if select(2, UnitClass("player")) ~= "SHAMAN" then return DisableAddOn(SHIELDSUP) end

local L = ShieldsUp.L
local LibSharedMedia = LibStub("LibSharedMedia-3.0")
local LibSink = LibStub("LibSink-2.0")

local f, db, playerGUID
local earthCount, waterCount = 0, -1
local earthKnown, earthGUID, earthName, earthColor
local waterSpell, waterStacks = LIGHTNING_SHIELD

local EARTH_SHIELD     = GetSpellInfo(974)
local WATER_SHIELD     = GetSpellInfo(52127)
local LIGHTNING_SHIELD = GetSpellInfo(324)
L.EarthShield, L.WaterShield, L.LightningShield = EARTH_SHIELD, WATER_SHIELD, LIGHTNING_SHIELD

local spellToKey = {
	[EARTH_SHIELD] = "earth",
	[WATER_SHIELD] = "water",
	[LIGHTNING_SHIELD] = "lightning",
}
local icons = {
	earth     = format("|T%s:0:0:0:0:64:64:5:59:5:59|t", select(3, GetSpellInfo(974))),
	water     = format("|T%s:0:0:0:0:64:64:5:59:5:59|t", select(3, GetSpellInfo(52127))),
	lightning = format("|T%s:0:0:0:0:64:64:5:59:5:59|t", select(3, GetSpellInfo(324))),
}
local opposite = {
	[""] = "",
	["BOTTOM"] = "TOP",
	["TOP"] = "BOTTOM",
}

local units = { player = true, pet = true }
for i = 1,  4 do units["party"..i], units["partypet"..i] = true, true end
for i = 1, 40 do units["raid" ..i], units["raidpet" ..i] = true, true end

-- TODO: switch UNIT_AURA to a unit event, skip ES check, when ES is unknown

function ShieldsUp:OnLogin()
	playerGUID = UnitGUID("player")
	db = self:InitializeDB("ShieldsUpDB", {
		--offsetX = 0,
		--offsetY = 0,
		spacingX = 10,
		spacingY = 10,
		alpha = 1,
		hideInfinite = true, -- NYI
		nameFont = "Friz Quadrata TT",
		nameSize = 20,
		numberFont = "Arial Narrow",
		numberSize = 20,
		outline = "OUTLINE",
		shadow = false,
		namePosition = "TOP",
		nameUsesClassColor = true,
		colors = {
			earth     = { r = 0.63, g = 0.87, b = 0.33 },
			water     = { r = 0.3,  g = 0.85, b = 1 },
			lightning = { r = 0.72, g = 0.5,  b = 1 },
			missing   = { r = 1,    g = 0.1,  b = 0.1 },
			active    = { r = 1,    g = 1,    b = 1 },
		},
		alerts = {
			sink20OutputSink = "UIErrorsFrame",
			whileHidden = false,
			earth = {
				text = true,
				sound = "None",
			},
			water = {
				text = true,
				sound = "None",
			},
		},
		show = { -- NYI
			solo = true,
			party = true,
			raid = true,
			arena = true,
			battleground = true,
			nocombat = true,
			resting = false,
		},
	})

	LibSink:Embed(self)
	self:SetSinkStorage(db.alerts)

	self:RegisterEvent("GROUP_ROSTER_UPDATE")
	self:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
	self:RegisterEvent("UNIT_AURA")

	self:PLAYER_SPECIALIZATION_CHANGED()
	self:PLAYER_ENTERING_WORLD()
end

function ShieldsUp:PLAYER_SPECIALIZATION_CHANGED()
	local spec = GetSpecialization()
	-- Earth Shield?
	earthKnown = IsSpellKnown(974)
	-- Water Shield if resto, Lightning Shield otherwise
	waterSpell = spec == 3 and WATER_SHIELD or LIGHTNING_SHIELD
	-- can stack if Elemental with Fulmination
	waterStacks = spec == 1 and IsSpellKnown(88766)
	print("Spec changed", waterSpell, waterStacks)
end

function ShieldsUp:PLAYER_ENTERING_WORLD()
	local raid = IsInRaid()
	units.player, units.pet = not raid, not raid
	self:UNIT_AURA("player")
	if earthKnown and earthGUID ~= playerGUID and IsInGroup() then
		local i, n, u = 1, GetNumGroupMembers(), "raid"
		if not IsInRaid() then
			n, u = n - 1, "party"
		end
		while i <= n and not earthGUID do
			self:UNIT_AURA(u..i)
			self:UNIT_AURA(u.."pet"..i)
			i = i + 1
		end
	end
end

function ShieldsUp:GROUP_ROSTER_UPDATE()
	local raid = IsInRaid()
	units.player, units.pet = not raid, not raid
	if earthGUID and earthGUID ~= playerGUID then
		if IsInGroup() then
			local u = raid and "raid" or "party"
			for i = 1, GetNumGroupMembers() do
				if UnitGUID(u..i) == earthGUID or UnitGUID(u.."pet"..i) then
					print("Earth Shield target still in group")
					return
				end
			end
		end
		print("Earth Shield target left group")
		earthCount, earthGUID, earthName, earthColor = 0, nil, nil, nil
		self:UpdateDisplay()
	end
end

function ShieldsUp:UNIT_AURA(unit)
	if not units[unit] then
		return
	end
	-- Check for Water/Lightning Shield on player
	if UnitIsUnit(unit, "player") then
		--print("Checking player buffs")
		local buff, _, _, count = UnitBuff(unit, waterSpell)
		if not buff then
			count = 0
		elseif count == 0 then
			count = 1 -- non-stacking buffs report a count of 0
		end
		if not buff and waterCount > 0 then
			--print("Water Shield lost")
			waterCount = 0
			self:UpdateDisplay()
			self:Alert(waterSpell)
			-- TODO: delay to avoid alerting when casting ES over WS on self?
		elseif count ~= waterCount then
			if earthGUID == playerGUID then
				print("Water Shield overwrote Earth Shield")
				earthCount, earthGUID, earthName, earthColor = 0, nil, nil, nil
			end
			--print("Water Shield charges now", count)
			waterCount = count
			self:UpdateDisplay()
		end
		if waterCount > 0 then
			return
		end
	end
	-- Check for Earth Shield cast by player
	local guid = UnitGUID(unit)
	local buff, _, _, count, _, _, _, caster = UnitBuff(unit, EARTH_SHIELD, nil, "PLAYER")
	if not buff then
		if guid ~= earthGUID or earthCount == 0 then
			return
		elseif UnitBuff(unit, EARTH_SHIELD) and not UnitInRange(unit) then
			print("Earth Shield target out of range")
			earthCount = -1
		else
			print("Earth Shield faded")
			earthCount = 0
			self:Alert(EARTH_SHIELD)
			-- TODO: delay to avoid alerting when casting ES on new target?
		end
		return self:UpdateDisplay()
	elseif guid ~= earthGUID then
		print("Earth Shield on new target")
		earthCount = count or 1
		earthGUID  = guid
		earthName  = UnitName(unit)
		if UnitIsPlayer(unit) then
			local _, class = UnitClass(unit)
			earthColor = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]
		else
			earthColor = GREEN_FONT_COLOR
		end
		return self:UpdateDisplay()
	elseif count ~= earthCount then
		print("Earth Shield charges changed from", earthCount, "to", count)
		earthCount = count
		return self:UpdateDisplay()
	end
end

function ShieldsUp:Alert(spell)
	local spellKey = spellToKey[spell]
	local color = db.colors[spellKey]
	--print("Alert", spell, "=>", spellKey)
	if spellKey == "lightning" then spellKey = "water" end

	if db.alerts[spellKey].text then
		if spell == EARTH_SHIELD then
			local name = earthGUID == playerGUID and L[">> YOU <<"] or earthName
			self:Pour(format("%s faded from |c%s%s!", spell, earthColor.colorStr or strsub(GREEN_FONT_COLOR_CODE, 3), name), color.r, color.g, color.b)
		else
			self:Pour(format("%s faded!", spell), color.r, color.g, color.b)
		end
	end

	local sound = db.alerts[spellKey].sound
	if sound ~= "None" then
		PlaySoundFile(LibSharedMedia:Fetch("sound", sound), "Master")
	end
end

function ShieldsUp:UpdateDisplay()
	--print("UpdateDisplay")
	if not f then
		return self:SetupDisplay()
	end
	local mode = earthKnown and earthGUID ~= playerGUID and IsInGroup() and 2 or 1
	if mode ~= f.mode then
		--print("Mode", mode)
		f.earthText:ClearAllPoints()
		f.waterText:ClearAllPoints()
		if mode == 1 then
			if db.namePosition == "NONE" then
				f.earthText:SetPoint("CENTER")
				f.waterText:SetPoint("CENTER")
			else
				f.earthText:SetPoint("TOP", f, "BOTTOM")
				f.waterText:SetPoint("TOP", f, "BOTTOM")
			end
		else
			local point = db.namePosition == "NONE" and "" or db.namePosition == "BOTTOM" and "TOP" or "BOTTOM"
			f.earthText:SetPoint(opposite[point].."LEFT",  f, point.."RIGHT")
			f.waterText:SetPoint(opposite[point].."RIGHT", f, point.."LEFT")
		end
		f.mode = mode
	end
	-- Earth Shield target name
	if earthGUID and mode == 2 and db.namePosition ~= "NONE" then
		-- not using "if count > 0 then a else b" logic because count can be -1 if target is out of range
		local color = earthCount == 0 and db.colors.missing or db.nameUsesClassColor and earthColor or db.colors.earth
		f.earthText:SetTextColor(color.r, color.g, color.b)
		f.nameText:SetText(earthName)
	else
		f.nameText:SetText("")
	end
	-- Earth Shield stack count
	if earthCount > 0 or mode == 2 then
		local color = earthCount == 0 and db.colors.missing or db.colors.earth
		f.earthText:SetTextColor(color.r, color.g, color.b)
		f.earthText:SetText(earthCount < 0 and "??" or earthCount)
	else
		f.earthText:SetText("")
	end
	-- Water/Lightning Shield stack count
	if earthCount == 0 or mode == 2 then
		local color = waterCount > 0 and db.colors[spellToKey[waterSpell]] or db.colors.missing
		f.waterText:SetTextColor(color.r, color.g, color.b)
		f.waterText:SetText(waterStacks and waterCount > 0 and waterCount or strsub(waterSpell, 1, 1))
	else
		f.waterText:SetText("")
	end
end

function ShieldsUp:SetupDisplay()
	--print("SetupDisplay")
	f = CreateFrame("Frame", SHIELDSUP.."Frame", UIParent)
	f:SetPoint("CENTER")

	local b = f:CreateTexture(nil, "BACKGROUND")
	b:SetPoint("TOP", f, 0, 25)
	b:SetPoint("BOTTOMLEFT", f, -40, -25)
	b:SetPoint("BOTTOMRIGHT", f, 40, -25)
	b:SetTexture(0.5, 0.5, 0.5, 0.5)
	f.bg = b

	f:SetMovable(true)
	f:SetClampedToScreen(true)
	f:SetClampRectInsets(-40, 40, -25, 25) -- Nice lack of consistent
	f:SetHitRectInsets(-40, -40, -25, -25) -- syntax here, Blizzard!
	f:RegisterForDrag("LeftButton")
	f:SetScript("OnDragStart", f.StartMoving)
	f:SetScript("OnHide", f.StopMovingOrSizing)
	f:SetScript("OnDragStop", function(f) f:StopMovingOrSizing() ShieldsUp:SavePosition() end)

	f.nameText  = f:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
	f.earthText = f:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
	f.waterText = f:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")

	self.SetupDisplay = nil
	self:ApplySettings()

	if db.offsetX and db.offsetY then
		self:RestorePosition()
		self:LockDisplay(true)
	else
		self:LockDisplay(false)
	end
end

function ShieldsUp:ApplySettings()
	f:SetSize(db.spacingX, db.spacingY)
	f:SetAlpha(db.alpha)

	f.nameText:SetFont(LibSharedMedia:Fetch("font", db.nameFont), db.nameSize, db.outline)
	f.nameText:SetShadowOffset(db.shadow and 1 or 0, db.shadow and -1 or 0)
	f.nameText:ClearAllPoints()
	if db.namePosition == "TOP" then
		f.nameText:SetPoint("BOTTOM", f, "TOP")
	else
		f.nameText:SetPoint("TOP", f, "BOTTOM")
	end

	f.earthText:SetFont(LibSharedMedia:Fetch("font", db.numberFont), db.numberSize, db.outline)
	f.earthText:SetShadowOffset(db.shadow and 1 or 0, db.shadow and -1 or 0)

	f.waterText:SetFont(LibSharedMedia:Fetch("font", db.numberFont), db.numberSize, db.outline)
	f.waterText:SetShadowOffset(db.shadow and 1 or 0, db.shadow and -1 or 0)

	self:UpdateDisplay()
end

function ShieldsUp:SavePosition()
	if not f then return end
	local x, y = f:GetCenter()	
	local w, h = UIParent:GetWidth(), UIParent:GetHeight()
	db.offsetX = x / w
	db.offsetY = y / h
	--print(format("SavePosition: %.2f, %.2f", db.offsetX * 100, db.offsetY * 100))
	self:RestorePosition()
end

function ShieldsUp:RestorePosition()
	if not f then return end
	--print("RestorePosition")
	f:ClearAllPoints()
	local x, y = db.offsetX, db.offsetY
	if not x or not y then
		f:SetPoint("CENTER")
	else
		local w, h = UIParent:GetWidth(), UIParent:GetHeight()
		f:SetPoint("CENTER", UIParent, "BOTTOMLEFT", floor(x * w + 0.5), floor(y * h + 0.5))
	end
end

function ShieldsUp:LockDisplay(lock)
	if not f then return end
	--print("LockDisplay", lock, f.locked)
	if lock == nil then
		lock = not f.locked
	end
	f:EnableMouse(not lock)
	f.bg:SetShown(not lock)
	f.locked = lock
end
