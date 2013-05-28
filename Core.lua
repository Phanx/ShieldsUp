--[[--------------------------------------------------------------------
	ShieldsUp
	Text-based shaman shield monitor.
	Copyright (c) 2008-2013 Phanx <addons@phanx.net>. All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info9165-ShieldsUp.html
	http://www.curse.com/addons/wow/shieldsup
----------------------------------------------------------------------]]

local ADDON_NAME, private = ...
if select(2, UnitClass("player")) ~= "SHAMAN" then return DisableAddOn(ADDON_NAME) end

local format, strfind, strjoin = format, strfind, strjoin
local tostring, unpack = tostring, unpack
local UnitAura = UnitAura

local EARTH_SHIELD = GetSpellInfo(974)
local LIGHTNING_SHIELD = GetSpellInfo(324)
local WATER_SHIELD = GetSpellInfo(52127)

local DISPLAY_MULTIPLE, DISPLAY_SINGLE = 2, 1

local L = private.L
L.EarthShield = EARTH_SHIELD
L.LightningShield = LIGHTNING_SHIELD
L.WaterShield = WATER_SHIELD

------------------------------------------------------------------------

local SharedMedia, Sink
local db, hasEarthShield, hasLightningCharges, isInGroup

local playerGUID = ""
local playerName = UnitName("player")

local earthCount = 0
local earthTime = 0
local earthGUID = ""
local earthName = ""
local earthUnit = ""
local earthOverwritten = false
local earthPending = nil

local waterCount = 0
local waterSpell = LIGHTNING_SHIELD

------------------------------------------------------------------------

local defaults = {
	posx = 0,
	posy = -150,
	padh = 5,
	padv = 0,
	alpha = 1,

	namePosition = "TOP",
	hideInfinite = false,

	showSolo = true,
	showInParty = true,
	showInRaid = true,
	showInArena = true,
	showInBG = true,
	hideOOC = true,
	hideResting = true,

	font = {
		face = "Friz Quadrata TT",
		large = 24,
		small = 16,
		outline = "NONE",
		shadow = true,
	},
	color = {
		earth = { 0.65, 1, 0.25 },
		lightning = { 0.25, 0.65, 1 },
		water = { 0.25, 0.65, 1 },
		normal = { 1, 1, 1 },
		overwritten = { 1, 1, 0 },
		alert = { 1, 0, 0 },
		useClassColor = false,
	},
	alert = {
		alertWhenHidden = false,
		earth = {
			text = true,
			sound = "Tribal Bell",
			overwritten = false,
		},
		water = {
			text = true,
			sound = "Tribal Bell",
		},
		output = {
			sink20OutputSink = "RaidWarning",
		},
	},
}

------------------------------------------------------------------------

local function Print(str, ...)
	if select("#", ...) > 0 then
		if strfind(str, "%%[dfqsx%.%d]") then
			return print("|cff00ddbaShieldsUp:|r", format(str, ...))
		else
			return print("|cff00ddbaShieldsUp:|r", str, ...)
		end
	end
	print("|cff00ddbaShieldsUp:|r", str)
end

local function Debug(lvl, str, ...)
	if lvl > 0 then return end
	if select("#", ...) > 0 then
		if strfind(str, "%%[dfqsx%.%d]") then
			return print("|cffff7f7fShieldsUp:|r", format(str, ...))
		else
			return print("|cffff7f7fShieldsUp:|r", str, ...)
		end
	end
	print("|cffff7f7fShieldsUp:|r", str)
end

------------------------------------------------------------------------

local function GetAuraCharges(unit, aura)
	local name, _, _, charges, _, _, _, caster = UnitAura(unit, aura)
	Debug(3, "GetAuraCharges(%s, %s) -> %s, %s", unit, aura, tostring(charges), tostring(caster == "player"))
	if not name then
		return 0
	elseif charges > 1 then
		return charges, caster == "player", caster
	else
		return 1, caster == "player", caster
	end
end

local function UnitHasEarthShield(unit)
	local name, _, _, charges, _, duration, expires, caster = UnitAura(unit, EARTH_SHIELD)
	if name and caster == "player" then
		earthCount = charges
		earthGUID  = unit == "player" and playerGUID or UnitGUID(unit)
		earthName  = unit == "player" and playerName or UnitName(unit)
		earthUnit  = unit
		earthTime  = expires - duration
		Debug(2, "Earth Shield found on", unit)
	end
	return charges
end

------------------------------------------------------------------------

local ShieldsUp = CreateFrame("Frame", "ShieldsUp", UIParent)
ShieldsUp:SetScript("OnEvent", function(self, event, ...) return self[event] and self[event](self, ...) end)
ShieldsUp:RegisterEvent("ADDON_LOADED")

------------------------------------------------------------------------

function ShieldsUp:ADDON_LOADED(addon)
	if addon ~= "ShieldsUp" then return end
	Debug(1, "ADDON_LOADED", addon)

	if not ShieldsUpDB then
		ShieldsUpDB = {}
	end
	local function CopyDefaults(src, dst)
		if type(src) ~= "table" then return {} end
		if type(dst) ~= "table" then dst = {} end

		for k, v in pairs(src) do
			if type(v) == "table" then
				dst[k] = CopyDefaults(v, dst[k])
			elseif type(dst[k]) ~= type(v) then
				dst[k] = v
			end
		end
		return dst
	end
	db = CopyDefaults(defaults, ShieldsUpDB)

	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil

	if IsLoggedIn() then
		self:PLAYER_LOGIN()
	else
		self:RegisterEvent("PLAYER_LOGIN")
	end
end

------------------------------------------------------------------------

function ShieldsUp:PLAYER_LOGIN()
	Debug(1, "PLAYER_LOGIN")

	SharedMedia = LibStub("LibSharedMedia-3.0", true)
	if SharedMedia then
		Debug(2, "LibSharedMedia-3.0 found.")

		SharedMedia:Register("sound", "Alliance Bell", "Sound\\Doodad\\BellTollAlliance.ogg")
		SharedMedia:Register("sound", "Cannon Blast", "Sound\\Doodad\\Cannon01_BlastA.ogg")
		SharedMedia:Register("sound", "Dynamite", "Sound\\Spells\\DynamiteExplode.ogg")
		SharedMedia:Register("sound", "Gong", "Sound\\Doodad\\G_GongTroll01.ogg")
		SharedMedia:Register("sound", "Horde Bell", "Sound\\Doodad\\BellTollHorde.ogg")
		SharedMedia:Register("sound", "Serpent", "Sound\\Creature\\TotemAll\\SerpentTotemAttackA.ogg")
		SharedMedia:Register("sound", "Tribal Bell", "Sound\\Doodad\\BellTollTribal.ogg")

		self.fonts = {}
		for i, v in pairs(SharedMedia:List("font")) do
			self.fonts[i] = v
		end
		sort(self.fonts)

		self.sounds = {}
		for i, v in pairs(SharedMedia:List("sound")) do
			self.sounds[i] = v
		end
		sort(self.sounds)

		function ShieldsUp:SharedMedia_Registered(mediatype)
			if mediatype == "font" then
				wipe(self.fonts)
				for i, v in pairs(SharedMedia:List("font")) do
					self.fonts[i] = v
				end
				sort(self.fonts)
				self:UpdateLayout()
			elseif mediatype == "sound" then
				wipe(self.sounds)
				for i, v in pairs(SharedMedia:List("sound")) do
					self.sounds[i] = v
				end
				sort(self.sounds)
			end
		end

		function ShieldsUp:SharedMedia_SetGlobal(callback, mediatype)
			if mediatype == "font" then
				self:UpdateLayout()
			end
		end

		SharedMedia.RegisterCallback(self, "LibSharedMedia_Registered", "SharedMedia_Registered")
		SharedMedia.RegisterCallback(self, "LibSharedMedia_SetGlobal",  "SharedMedia_SetGlobal")
	end

	Sink = LibStub("LibSink-2.0", true)
	if Sink then
		Debug(2, "LibSink-2.0 found.")

		Sink:Embed(self)
		self:SetSinkStorage(db.alert.output)

		-- temporary upgrade code to remove unwanted sinks
		if db.alert.output.sink20OutputSink == "Channel" then
			db.alert.output.sink20OutputSink = "RaidWarning"
			db.alert.output.sink20ScrollArea = nil
			db.alert.output.sink20Sticky = nil
		end
	end

	playerGUID = UnitGUID("player")

	self:RegisterEvent("PLAYER_REGEN_DISABLED")
	self:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
	self:RegisterEvent("GROUP_ROSTER_UPDATE")
	self:RegisterEvent("UNIT_AURA")
	self:RegisterEvent("UNIT_SPELLCAST_SENT")

	-- TODO: Only register these events if they are needed?
	local visEvents = {
		"PET_BATTLE_OPENING_START",
		"PET_BATTLE_CLOSE",
		"PLAYER_DEAD",
		"PLAYER_ALIVE",
		"PLAYER_UNGHOST",
		"PLAYER_REGEN_ENABLED",
		"PLAYER_UPDATE_RESTING",
		"UNIT_ENTERED_VEHICLE",
		"UNIT_EXITED_VEHICLE",
		"ZONE_CHANGED_NEW_AREA",
	}
	for i = 1, #visEvents do
		local event = visEvents[i]
		self[event] = self.UpdateVisibility
		self:RegisterEvent(event)
	end

	self:RegisterEvent("PLAYER_LOGOUT")

	self:UnregisterEvent("PLAYER_LOGIN")
	self.PLAYER_LOGIN = nil

	self:PLAYER_SPECIALIZATION_CHANGED()
	self:GROUP_ROSTER_UPDATE()
	self:UpdateVisibility()
end

------------------------------------------------------------------------

function ShieldsUp:PLAYER_LOGOUT()
	self:UnregisterAllEvents()
end

------------------------------------------------------------------------

function ShieldsUp:PLAYER_SPECIALIZATION_CHANGED()
	Debug(1, "PLAYER_SPECIALIZATION_CHANGED")

	local spec = GetSpecialization()
	hasEarthShield = spec == 3 -- Restoration
	hasLightningCharges = spec == 1 -- Elemental
	Debug(2, "Earth Shield?", hasEarthShield and "YES" or "NO")
	Debug(2, "Lightning Shield charges?", hasLightningCharges and "YES" or "NO")

	if waterCount == 0 then
		waterSpell = hasEarthShield and WATER_SHIELD or LIGHTNING_SHIELD
	end

	self:UpdateDisplayMode()
end

------------------------------------------------------------------------

function ShieldsUp:UNIT_SPELLCAST_SENT(unit, spell, rank, target)
	if unit ~= "player" then return end
	Debug(3, "UNIT_SPELLCAST_SENT, "..spell..", "..target)

	if earthPending and GetTime() - earthTime > 2 then
		earthPending = nil
	end

	if spell == WATER_SHIELD or spell == LIGHTNING_SHIELD then
		if spell ~= waterSpell then
			waterSpell = spell
			self:UpdateDisplay()
		else
			waterSpell = spell
		end
	elseif spell == EARTH_SHIELD then
		earthTime = GetTime()
		target = target:match("^([^-]+)")
		Debug(3, "Earth Shield cast on %s.", target)
		if target ~= earthName or (target == playerName and waterCount > 0) then
			earthPending = target
		end
	end
end

------------------------------------------------------------------------

do
	local ignore = setmetatable({}, { __index = function(t, k)
		if k == "player" or k == "pet" or ((k:match("^party") or k:match("^raid")) and not k:match("target$")) then
			t[k] = false
			return false
		else
			t[k] = true
			return true
		end
	end })

	function ShieldsUp:UNIT_AURA(unit)
		if ignore[unit] then return end
		Debug(4, "UNIT_AURA, "..unit)

		local alert, update

		if unit == "player" then
			local charges = GetAuraCharges(unit, waterSpell)
			if charges ~= waterCount then
				Debug(2, waterSpell.." charges changed.")
				if charges == 0 and earthPending ~= playerName then
					alert = waterSpell
				end
				waterCount = charges
				update = true
			end
		end

		if unit == earthUnit then
			local charges, mine, caster = GetAuraCharges(unit, EARTH_SHIELD)
			Debug(4, "UNIT_AURA, charges = %d, earthCount = %d, mine = %s, earthOverwritten = %s, UnitIsVisible = %s", charges, earthCount, tostring(mine), tostring(earthOverwritten), tostring(UnitIsVisible(unit)))
			if charges == 1 and not mine and not UnitIsVisible(unit) then
				-- Do nothing!
			elseif charges < earthCount then
				if charges == 0 then
					if not earthPending and not (unit == "player" and waterCount > 0) then
						Debug(2, "Earth Shield faded from %s.", earthName)
						alert = EARTH_SHIELD
					end
				else
					Debug(2, "Earth Shield healed %s.", earthName)
				end
				earthCount = charges
				update = true
			elseif charges > earthCount then
				Debug(3, "Earth Shield charges increased.")
				if mine and not earthOverwritten then
					-- This buff is mine, and it was mine before
					Debug(2, "I refreshed Earth Shield on %s.", earthName)
					earthCount = charges
				elseif mine and earthOverwritten then
					-- The buff is mine, and it was not mine before
					Debug(2, "I overwrote someone's Earth Shield on %s.", earthName)
					earthCount = charges
					earthOverwritten = false
				elseif not mine and not earthOverwritten then
					-- This buff is not mine, and it was mine before
					Debug(2, "%s overwrote my Earth Shield on %s.", UnitName(caster), earthName)
					earthCount = charges
					earthOverwritten = true
					if db.alert.earth.overwritten then
						ChatFrame1:AddMessage(format("%s overwrote my Earth Shield on %s!", UnitName(caster), earthName))
					end
				elseif not mine and earthOverwritten then
					-- This buff is not mine, and it was not mine before
					Debug(2, "Someone refreshed their Earth Shield on %s.", earthName)
					earthCount = charges
				end
				update = true
			elseif charges > 0 then
				Debug(4, "Earth Shield charges did not change.")
				if mine and earthOverwritten then
					Debug(2, "I overwrote someone's Earth Shield on %s.", earthName)
					earthOverwritten = false
					update = true
				elseif not mine and not earthOverwritten then
					Debug(2, "Someone overwrote my Earth Shield on %s.", earthName)
					earthOverwritten = true
					update = true
					if db.alert.earth.overwritten then
						ChatFrame1:AddMessage(format("%s overwrote my Earth Shield!", UnitName(caster)))
					end
				end
			else
				Debug(4, "Earth Shield charges did not change from zero.")
			end
		end

		if earthPending and UnitName(unit) == earthPending then
			local charges = GetAuraCharges(unit, EARTH_SHIELD)
			if charges > 0 then
				Debug(2, "I cast Earth Shield on a new target.")

				earthCount = charges
				earthGUID = UnitGUID(unit)
				earthName = earthPending
				earthUnit = unit
				earthOverwritten = false

				earthPending = nil

				update = true
			end
		end

		if update then
			self:UpdateDisplay()
		end
		if alert then
			self:Alert(alert)
		end
	end
end

------------------------------------------------------------------------

function ShieldsUp:GROUP_ROSTER_UPDATE()
	Debug(4, "GROUP_ROSTER_UPDATE")
	local newGroup = IsInRaid() and "raid" or IsInGroup() and "party" or false

	if newGroup then
		Debug(3, "In a group")
		if newGroup ~= isInGroup then
			isInGroup = newGroup
			Debug(1, "Joined a", newGroup, "group")
			self:UpdateLayout()
			self:UpdateVisibility()
		end
	else
		Debug(3, "Not in a group")
		if isInGroup then
			Debug(1, "Left a group")
			isInGroup = false
			self:UpdateLayout()
			self:UpdateVisibility()
		end
	end

	self:ScanForShields()
	self:UpdateDisplay()
end

------------------------------------------------------------------------

function ShieldsUp:PLAYER_REGEN_DISABLED()
	self:UpdateVisibility()
	-- TODO: Add missing shield alert on entering combat.
end

------------------------------------------------------------------------

function ShieldsUp:ScanForShields()
	Debug(3, "ScanForShields")
	earthCount, earthGUID, earthName, earthUnit, earthTime = 0, nil, nil, nil, 0
	waterCount = 0

	if UnitHasEarthShield("player") then
		Debug(2, "Earth Shield found on player")
	else
		waterCount = GetAuraCharges("player", WATER_SHIELD)
		if waterCount > 0 then
			waterSpell = WATER_SHIELD
			Debug(2, "Water Shield found on player")
		else
			waterCount = GetAuraCharges("player", LIGHTNING_SHIELD)
			if waterCount > 0 then
				waterSpell = LIGHTNING_SHIELD
				Debug(2, "Lightning Shield found on player")
			end
		end

		if IsInGroup() then
			local groupMembers, unit
			if IsInRaid() then
				isInGroup, groupMembers = "raid", GetNumGroupMembers()
			else
				isInGroup, groupMembers = "party", GetNumGroupMembers() - 1
			end

			Debug(2, "isInGroup =", isInGroup)
			for i = 1, groupMembers do
				unit = isInGroup..i
				if UnitHasEarthShield(unit) then
					Debug(2, "Earth Shield found on %s: %s", unit, UnitName(unit))
					break
				end
				unit = isInGroup.."pet"..i
				if UnitHasEarthShield(unit) then
					Debug(2, "Earth Shield found on %s: %s (%s)", unit, UnitName(unit), UnitName(isInGroup..i))
					break
				end
			end
		else
			Debug(2, "isInGroup = false, SOLO")
			isInGroup = false
		end
	end

	if earthCount == 0 then
		Debug(2, "Earth Shield not found")
	end
end

------------------------------------------------------------------------

function ShieldsUp:UpdateDisplayMode()
	local displayMode = DISPLAY_SINGLE
	if hasEarthShield and isInGroup and not db.hideInfinite then
		displayMode = DISPLAY_MULTIPLE
	end
	Debug(3, "UpdateDisplayMode", displayMode == DISPLAY_MULTIPLE and "MULTIPLE" or "SINGLE")
	self.displayMode = displayMode
	self:UpdateLayout()
end

function ShieldsUp:UpdateDisplay()
	Debug(3, "UpdateDisplay")
	if GetTime() - earthTime > 300 then
		earthCount = 0
		earthName = ""
	end

	local color, text

	if hasEarthShield then
		if earthCount == 0 then
			color = db.color.alert
		elseif earthOverwritten then
			color = db.color.overwritten
		elseif db.color.useClassColor then
			local _, class = UnitClass(earthUnit)
			color = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]
		else
			color = db.color.earth
		end
		self.nameText:SetTextColor(color.r or color[1], color.g or color[2], color.b or color[3])
		if earthOverwritten and tonumber(ENABLE_COLORBLIND_MODE) > 0 then
			self.nameText:SetFormattedText("* %s *", earthName)
		else
			self.nameText:SetText(earthName)
		end

		color = earthCount > 0 and db.color.earth or db.color.alert
		if self.displayMode == DISPLAY_SINGLE and waterCount > 0 then
			Debug(4, "SINGLE Earth Shield")
			self.waterText:SetTextColor(color[1], color[2], color[3])
			self.waterText:SetText(earthCount)
			return
		end

		Debug(4, "MULTIPLE Earth Shield")
		self.earthText:SetTextColor(color[1], color[2], color[3])
		self.earthText:SetText(earthCount)
	end

	if waterCount == 0 then
		Debug(4, "MISSING", waterSpell)
		color = db.color.alert
		text  = waterSpell == WATER_SHIELD and L.WaterAbbrev or L.LightningAbbrev
	elseif db.hideInfinite and not hasLightningCharges then
		Debug(4, "INFINITE", waterSpell)
		color = waterSpell == LIGHTNING_SHIELD and db.color.lightning or db.color.water
		text  = ""
	elseif waterSpell == LIGHTNING_SHIELD then
		Debug(4, "ACTIVE", waterSpell, hasLightningCharges)
		color = db.color.lightning
		text  = hasLightningCharges and waterCount or L.LightningAbbrev
	else
		Debug(4, "ACTIVE", waterSpell)
		color = db.color.water
		text  = L.WaterAbbrev
	end
	self.waterText:SetTextColor(color[1], color[2], color[3])
	self.waterText:SetText(text)
end

------------------------------------------------------------------------

function ShieldsUp:Alert(text, r, g, b, sound)
	if not db.alert.alertWhenHidden and not self:IsShown() then return end

	local spell = text
	if spell == EARTH_SHIELD then
		if db.alert.earth.text then
			r, g, b = unpack(db.color.earth)
			text = format(L.ShieldFadedFrom, spell, earthName == playerName and L.YOU or earthName)
		end
		if db.alert.earth.sound ~= "None" then
			sound = (SharedMedia and SharedMedia:Fetch("sound", db.alert.earth.soundFile)) or "Sound\\Doodad\\BellTollHorde.ogg"
		end
	elseif spell == LIGHTNING_SHIELD or spell == WATER_SHIELD then
		if db.alert.water.text then
			r, g, b = unpack(spell == LIGHTNING_SHIELD and db.color.lightning or db.color.water)
			text = format(L.ShieldFaded, spell)
		end
		if db.alert.water.sound ~= "None" then
			sound = (SharedMedia and SharedMedia:Fetch("sound", db.alert.water.soundFile)) or "Sound\\Doodad\\BellTollHorde.ogg"
		end
	end

	if r and g and b and text then
		if self.Pour then
			self:Pour(text, r, g, b)
		else
			RaidNotice_AddMessage(RaidWarningFrame, text, { r = r, g = b, b = b })
		end
	end

	if sound then
		PlaySoundFile(sound, "Master")
	end

	Debug(1, "Alert, spell: %s, text: %s, sound: %s", tostring(spell), tostring(text), tostring(sound))
end

------------------------------------------------------------------------
-- TODO: Split this out into the relevant event handlers?

function ShieldsUp:UpdateVisibility()
	Debug(2, "UpdateVisibility")

	if C_PetBattles.IsInBattle()
	or UnitIsDeadOrGhost("player")
	or UnitInVehicle("player")
	or ( db.hideOOC and not UnitAffectingCombat("player") )
	or ( db.hideResting  and IsResting() ) then
		return self:Hide()
	end

	local _, zoneType = IsInInstance()
	if zoneType == "none" and GetZonePVPInfo() == "combat" then zoneType = "pvp" end

	if ( zoneType  == "arena" and not db.showInArena )
	or ( zoneType  == "pvp"   and not db.showInBG    )
	or ( isInGroup == "raid"  and not db.showInRaid  )
	or ( isInGroup == "party" and not db.showInParty )
	or ( not isIngroup        and not db.showSolo    ) then
		return self:Hide()
	end

	self:Show()
	self:UpdateLayout()
end

------------------------------------------------------------------------

function ShieldsUp:UpdateLayout()
	Debug(1, "UpdateLayout")

	self:SetPoint("CENTER", UIParent, "CENTER", db.posx, db.posy)
	self:SetAlpha(db.alpha)
	self:SetHeight(1)
	self:SetWidth(1)

	local face = SharedMedia and SharedMedia:Fetch("font", db.font.face) or "Fonts\\FRIZQT__.ttf"

	local outline = db.font.outline
	local shadow = db.font.shadow and 1 or 0

	if not self.waterText then
		self.waterText = self:CreateFontString(nil, "OVERLAY")
	end
	self.waterText:SetFont(face, db.font.large, outline)
	self.waterText:SetShadowOffset(0, 0)
	self.waterText:SetShadowOffset(shadow, -shadow)
	self.waterText:ClearAllPoints()
	if self.displayMode == DISPLAY_MULTIPLE then
		if db.namePosition == "TOP" then
			self.waterText:SetPoint("TOPRIGHT", self, "TOPLEFT", -floor(db.padh / 2 + 0.5), 0)
		else
			self.waterText:SetPoint("BOTTOMRIGHT", self, "BOTTOMLEFT", -floor(db.padh / 2 + 0.5), 0)
		end
	else
		if db.namePosition == "TOP" then
			self.waterText:SetPoint("TOP", self, "TOP", 0, 0)
		else
			self.waterText:SetPoint("BOTTOM", self, "BOTTOM", 0, 0)
		end
	end

	if not self.earthText then
		self.earthText = self:CreateFontString(nil, "OVERLAY")
	end
	self.earthText:SetFont(face, db.font.large, outline)
	self.earthText:SetShadowOffset(0, 0)
	self.earthText:SetShadowOffset(shadow, -shadow)
	self.earthText:ClearAllPoints()
	if db.namePosition == "TOP" then
		self.earthText:SetPoint("TOPLEFT", self, "TOPRIGHT", floor(db.padh / 2 + 0.5), 0)
	else
		self.earthText:SetPoint("BOTTOMLEFT", self, "BOTTOMRIGHT", floor(db.padh / 2 + 0.5), 0)
	end
	if hasEarthShield and isInGroup and not db.hideInfinite then
		self.earthText:Show()
	else
		self.earthText:Hide()
	end

	if not self.nameText then
		self.nameText = self:CreateFontString(nil, "OVERLAY")
	end
	self.nameText:SetFont(face, db.font.small, outline)
	self.nameText:SetShadowOffset(0, 0)
	self.nameText:SetShadowOffset(shadow, -shadow)
	if hasEarthShield and isInGroup and db.namePosition ~= "NONE" then
		self.nameText:Show()
		self.nameText:ClearAllPoints()
		if db.namePosition == "TOP" then
			self.nameText:SetPoint("BOTTOM", self, "TOP", 0, db.padv)
		else
			self.nameText:SetPoint("TOP", self, "BOTTOM", 0, -db.padv)
		end
	else
		self.nameText:Hide()
	end

	self:UpdateDisplay()
end