--[[--------------------------------------------------------------------
	ShieldsUp
	Basic shaman shield monitor.
	by Phanx < addons@phanx.net >
	http://www.wowinterface.com/downloads/info9165-ShieldsUp.html
	Copyright ©2008–2009 Alyssa "Phanx" Kinley
	See included README for license terms and additional information.
----------------------------------------------------------------------]]

-- TO DO:
-- Add automatic visibility states.

if select(2, UnitClass("player")) ~= "SHAMAN" then return DisableAddOn("ShieldsUp") end

local SharedMedia
local Sink

local db, hasEarthShield, isInGroup

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
local waterSpell = ""

local EARTH_SHIELD = GetSpellInfo(32594)
local LIGHTNING_SHIELD = GetSpellInfo(324)
local WATER_SHIELD = GetSpellInfo(33736)

local L = setmetatable(ShieldsUpStrings or {}, { __index = function(t, k)
	t[k] = k
	return k
end })
L["Earth Shield"] = EARTH_SHIELD
L["Lightning Shield"] = LIGHTNING_SHIELD
L["Water Shield"] = WATER_SHIELD

------------------------------------------------------------------------

local defaults = {
	posx = 0,
	posy = -150,
	padh = 5,
	padv = 0,
	alpha = 1,
	colorblind = false,
	color = {
		earth = { 0.65, 1, 0.25 },
		lightning = { 0.25, 0.65, 1 },
		water = { 0.25, 0.65, 1 },
		alert = { 1, 0, 0 },
		normal = { 1, 1, 1 },
		overwritten = { 1, 1, 0 },
	},
	font = {
		face = "Friz Quadrata TT",
		large = 24,
		small = 16,
		outline = "NONE",
		shadow = true,
	},
	alert = {
		earth = {
			text = true,
			sound = true,
			soundFile = "Tribal Bell",
		},
		water = {
			text = true,
			sound = true,
			soundFile = "Tribal Bell",
		},
		output = {
			sink20OutputSink = "RaidWarning",
		},
	},
}

------------------------------------------------------------------------

local DEBUG_LEVEL = 0

local function Print(str, ...)
	if select(1, ...) then str = str:format(...) end
	print("|cff00ddbaShieldsUp:|r "..str)
end

local function Debug(lvl, str, ...)
	if lvl > DEBUG_LEVEL then return end
	if select(1, ...) then str = str:format(...) end
	print("|cffff6666ShieldsUp:|r "..str)
end

local function GetAuraCharges(unit, aura)
	local name, _, _, charges, _, _, _, caster = UnitAura(unit, aura)
--	Debug(3, "GetAuraCharges(%s, %s) -> %s, %s", unit, aura, tostring(charges), tostring(caster == "player"))
	if not name then
		return 0, nil
	elseif charges > 0 then
		return charges, caster == "player"
	else
		return 1, caster == "player"
	end
end

------------------------------------------------------------------------

local ShieldsUp = CreateFrame("Frame", "ShieldsUp", UIParent)

ShieldsUp.L = L
ShieldsUp.debug = 0
ShieldsUp.defaults = defaults
ShieldsUp:SetScript("OnEvent", function(self, event, ...) return self[event] and self[event](self, ...) end)
ShieldsUp:RegisterEvent("ADDON_LOADED")

function ShieldsUp:ADDON_LOADED(addon)
	if addon ~= "ShieldsUp" then return end

	if ShieldsUpStrings then
		ShieldsUpStrings = nil
	end

	if not ShieldsUpDB then
		ShieldsUpDB = { }
	end
	local function safecopy(src, dst)
		if type(src) ~= "table" then return { } end
		if type(dst) ~= "table" then dst = { } end

		for k, v in pairs(src) do
			if type(v) == "table" then
				dst[k] = safecopy(v, dst[k])
			elseif type(dst[k]) ~= type(v) then
				dst[k] = v
			end
		end
		return dst
	end
	db = safecopy(defaults, ShieldsUpDB)

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
	SharedMedia = LibStub("LibSharedMedia-3.0", true)
	if SharedMedia then
		SharedMedia:Register("sound", "Alliance Bell", "Sound\\Doodad\\BellTollAlliance.wav")
		SharedMedia:Register("sound", "Horde Bell", "Sound\\Doodad\\BellTollHorde.wav")
		SharedMedia:Register("sound", "Tribal Bell", "Sound\\Doodad\\BellTollTribal.wav")
		SharedMedia:Register("sound", "Cannon Blast", "Sound\\Doodad\\Cannon01_BlastA.wav")
		SharedMedia:Register("sound", "Dynamite", "Sound\\Spells\\DynamiteExplode.wav")
		SharedMedia:Register("sound", "Gong", "Sound\\Doodad\\G_GongTroll01.wav")
		SharedMedia:Register("sound", "Serpent", "Sound\\Creature\\TotemAll\\SerpentTotemAttackA.wav")

		self.fonts = {}
		for i, v in pairs(SharedMedia:List("font")) do
			tinsert(self.fonts, v)
		end
		table.sort(self.fonts)

		self.sounds = {}
		for i, v in pairs(SharedMedia:List("sound")) do
			tinsert(self.sounds, v)
		end
		table.sort(self.sounds)

		function ShieldsUp:SharedMedia_Registered(mediatype)
			if mediatype == "font" then
				wipe(self.fonts)
				for i, v in pairs(SharedMedia:List("font")) do
					tinsert(self.fonts, v)
				end
				table.sort(self.fonts)
			elseif mediatype == "sound" then
				wipe(self.sounds)
				for i, v in pairs(SharedMedia:List("sound")) do
					tinsert(self.sounds, v)
				end
				table.sort(self.sounds)
			end
		end

		function ShieldsUp:SharedMedia_SetGlobal(callback, mediatype)
			if mediatype == "font" then
				self:ApplySettings()
			end
		end

		SharedMedia.RegisterCallback(self, "LibSharedMedia_Registered", "SharedMedia_Registered")
		SharedMedia.RegisterCallback(self, "LibSharedMedia_SetGlobal",  "SharedMedia_SetGlobal")
	end

	Sink = LibStub("LibSink-2.0", true)
	if Sink then
		Sink:Embed(self)
		self:SetSinkStorage(db.alert.output)
	end

	playerGUID = UnitGUID("player")

	self:CHARACTER_POINTS_CHANGED()

	if GetNumRaidMembers() > 0 then
		Debug(2, "isInGroup = true")
		isInGroup = true
		local name, charges, duration, expires, caster, _
		for i = 1, GetNumRaidMembers() do
			name, _, _, charges, _, duration, expires, caster = UnitAura("raid"..i, EARTH_SHIELD)
			if name and caster == "player" then
				earthCount = charges
				earthGUID = UnitGUID("raid"..i)
				earthName = UnitName("raid"..i)
				earthUnit = "raid"..i
				earthTime = expires - duration
				break
			end
			name, _, _, charges, _, duration, expires, caster = UnitAura("raid"..i.."pet", EARTH_SHIELD)
			if name and caster == "player" then
				earthCount = charges
				earthGUID = UnitGUID("raid"..i.."pet")
				earthName = UnitName("raid"..i.."pet")
				earthUnit = "raid"..i.."pet"
				earthTime = expires - duration
				break
			end
		end
	elseif GetNumPartyMembers() > 0 then
		Debug(2, "isInGroup = true")
		isInGroup = true
		local name, charges, duration, expires, caster, _
		for i = 1, GetNumPartyMembers() do
			name, _, _, charges, _, duration, expires, caster = UnitAura("party"..i, EARTH_SHIELD)
			if name and caster == "player" then
				earthCount = charges
				earthGUID = UnitGUID("party"..i)
				earthName = UnitName("party"..i)
				earthUnit = "party"..i
				earthTime = expires - duration
				break
			end
			name, _, _, charges, _, duration, expires, caster = UnitAura("party"..i.."pet", EARTH_SHIELD)
			if name and caster == "player" then
				earthCount = charges
				earthGUID = UnitGUID("party"..i.."pet")
				earthName = UnitName("party"..i.."pet")
				earthUnit = "party"..i.."pet"
				earthTime = expires - duration
				break
			end
		end
	else
		Debug(2, "isInGroup = false")
		isInGroup = false
	end

	if earthName ~= playerName then
		local name, charges, _
		
		name, _, _, charges = UnitAura("player", WATER_SHIELD)
		if name then
			waterCount = charges
			waterSpell = WATER_SHIELD
		end
		
		name, _, _, charges = UnitAura("player", LIGHTNING_SHIELD)
		if name then
			waterCount = charges
			waterSpell = LIGHTNING_SHIELD
		end
	end

	self:ApplySettings()

	self:RegisterEvent("CHARACTER_POINTS_CHANGED")
	self:RegisterEvent("PLAYER_TALENT_UPDATE")
	self:RegisterEvent("PARTY_LEADER_CHANGED")
	self:RegisterEvent("PARTY_MEMBERS_CHANGED")
	self:RegisterEvent("RAID_ROSTER_UPDATE")
	self:RegisterEvent("UNIT_AURA")
	self:RegisterEvent("UNIT_SPELLCAST_SENT")
--	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")

	self:RegisterEvent("PLAYER_LOGOUT")

	self:UnregisterEvent("PLAYER_LOGIN")
	self.PLAYER_LOGIN = nil
end

------------------------------------------------------------------------

function ShieldsUp:PLAYER_LOGOUT()
	self:UnregisterAllEvents()
end

------------------------------------------------------------------------

function ShieldsUp:CHARACTER_POINTS_CHANGED()
--	Debug(1, "CHARACTER_POINTS_CHANGED")
	
	if GetSpellInfo(EARTH_SHIELD) then
	--	Debug(2, "I have the Earth Shield spell.")
		hasEarthShield = true
	else
	--	Debug(2, "I don't have the Earth Shield spell.")
		hasEarthShield = false
	end
end

ShieldsUp.PLAYER_TALENT_UPDATE = ShieldsUp.CHARACTER_POINTS_CHANGED

------------------------------------------------------------------------

do
	local earthCast = 0
	function ShieldsUp:UNIT_SPELLCAST_SENT(unit, spell, rank, target)
		if unit ~= "player" then return end
	--	Debug(3, "UNIT_SPELLCAST_SENT, "..spell..", "..target)

		if earthPending and GetTime() - earthCast > 2 then
			earthPending = nil
		end

		if spell == WATER_SHIELD or spell == LIGHTNING_SHIELD then
			if spell ~= waterSpell then
				waterSpell = spell
				self:Update()
			else
				waterSpell = spell
			end
		elseif spell == EARTH_SHIELD then
			earthTime = GetTime()
			if target ~= earthName then
				earthPending = target
			end
		end
	end
end

------------------------------------------------------------------------

function ShieldsUp:UNIT_SPELLCAST_SUCCEEDED(unit, spell, rank)
	if unit ~= "player" then return end
--	Debug(3, "UNIT_SPELLCAST_SUCCEEDED, "..spell)

	if earthPending and spell == EARTH_SHIELD then
		earthName = earthPending
	end
end

do
	local charges
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
	--	Debug(4, "UNIT_AURA, "..unit)

		local update = false
		if unit == earthUnit then
			local charges, mine = GetAuraCharges(unit, EARTH_SHIELD)
			Debug(4, "UNIT_AURA, charges = %d, earthCount = %d, mine = %s, earthOverwritten = %s, UnitIsVisible = %s", charges, earthCount, tostring(mine), tostring(earthOverwritten), tostring(UnitIsVisible(unit)))
			if charges == 1 and not mine and not UnitIsVisible(unit) then
				-- Do nothing!
			elseif charges < earthCount then
				if charges == 0 then
					Debug(2, "Earth Shield faded from %s.", earthName)
					self:Alert(EARTH_SHIELD)
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
					Debug(2, "Someone overwrote my Earth Shield on %s.", earthName)
					earthCount = charges
					earthOverwritten = true
				elseif not mine and earthOverwritten then
					-- This buff is not mine, and it was not mine before
					Debug(2, "Someone refreshed their Earth Shield on %s.", earthName)
					earthCount = charges
				end
				update = true
			elseif charges > 0 then
				Debug(3, "Earth Shield charges did not change.")
				if mine and earthOverwritten then
					Debug(2, "I overwrote someone's Earth Shield on %s.", earthName)
					earthOverwritten = false
					update = true
				elseif not mine and not earthOverwritten then
					Debug(2, "Someone overwrote my Earth Shield on %s.", earthName)
					earthOverwritten = true
					update = true
				end
			else
				Debug(4, "Earth Shield charges did not change from zero.")
			end
		end

		if earthPending and UnitName(unit) == earthPending then
			charges = GetAuraCharges(unit, EARTH_SHIELD)
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

		if unit == "player" then
			charges = GetAuraCharges(unit, waterSpell)
			if charges ~= waterCount then
				Debug(2, waterSpell.." charges changed.")
				if charges == 0 then
					self:Alert(waterSpell)
				end
				waterCount = charges
				update = true
			end
		end

		if update then
			self:Update()
		end
	end
end

------------------------------------------------------------------------

do
	local n
	local function GetUnitFromGUID(guid)
		if playerGUID == guid then
			return "player"
		end
		if HasPetUI() and UnitGUID("pet") == guid then
			return "pet"
		end
		n = GetNumRaidMembers()
		if n > 0 then
			for i = 1, n do
				if UnitGUID("raid"..i) == guid then
					return "raid"..i
				end
				if UnitGUID("raid"..i.."pet") == guid then
					return "raid"..i.."pet"
				end
			end
		return end
		n = GetNumPartyMembers()
		if n > 0 then
			for i = 1, n do
				if UnitGUID("party"..i) == guid then
					return "party"..i
				end
				if UnitGUID("party"..i.."pet") == guid then
					return "party"..i.."pet"
				end
			end
		end
	end

	local function OnGroupChange(self)
		Debug(3, "OnGroupChange")
		if GetTime() - earthTime > 900 then
		--	Debug(2, "Earth Shield hasn't been cast recently, clearing name")
			earthName = ""
			self:Update()
		end
		if earthName ~= "" then
			earthUnit = GetUnitFromGUID(earthGUID)
			if not earthUnit then
			--	Debug(2, "Earth Shield target no longer in group, clearing name")
				earthCount = 0
				earthName = ""
				self:Update()
			end
		end
		if GetNumRaidMembers() > 0 or GetNumPartyMembers() > 0 then
			Debug(3, "In a group")
			if not isInGroup then
				Debug(1, "Joined a group")
				isInGroup = true
				self:ApplySettings()
			end
		else
			Debug(3, "Not in a group")
			if isInGroup then
				Debug(1, "Left a group")
				isInGroup = false
				self:ApplySettings()
			end
		end
	end
	
	ShieldsUp.PARTY_LEADER_CHANGED = OnGroupChange
	ShieldsUp.PARTY_MEMBERS_CHANGED = OnGroupChange
	ShieldsUp.RAID_ROSTER_UPDATE = OnGroupChange
end

------------------------------------------------------------------------

function ShieldsUp:Update()
--	Debug(3, "Update")
	if GetTime() - earthTime > 900 then
		earthCount = 0
		earthName = ""
	end

	if earthCount == 0 then
		self.nameText:SetTextColor(unpack(db.color.alert))
	elseif earthOverwritten then
		self.nameText:SetTextColor(unpack(db.color.overwritten))
	else
		self.nameText:SetTextColor(unpack(db.color.normal))
	end
	if earthOverwritten and db.colorblind then
		self.nameText:SetText("* "..earthName.." *")
	else
		self.nameText:SetText(earthName)
	end

	if earthCount > 0 then
		self.earthText:SetTextColor(unpack(db.color.earth))
	else
		self.earthText:SetTextColor(unpack(db.color.alert))
	end
	self.earthText:SetText(earthCount)

	if not isInGroup and earthName == playerName and earthCount > 0 then
		self.waterText:SetTextColor(unpack(db.color.earth))
		self.waterText:SetText(earthCount)
	else
		if waterCount > 0 then
			if waterSpell == LIGHTNING_SHIELD then
				self.waterText:SetTextColor(unpack(db.color.lightning))
			else
				self.waterText:SetTextColor(unpack(db.color.water))
			end
		else
			self.waterText:SetTextColor(unpack(db.color.alert))
		end
		self.waterText:SetText(waterCount)
	end
end

------------------------------------------------------------------------

function ShieldsUp:Alert(spell)
	local r, g, b, text, sound
	if spell == EARTH_SHIELD then
		if db.alert.earth.text then
			r, g, b = unpack(db.color.earth)
			text = string.format(L["%s faded from %s!"], spell, earthName == playerName and L["YOU"] or earthName)
		end
		if db.alert.earth.sound then
			sound = SharedMedia and SharedMedia:Fetch("sound", db.alert.earth.soundFile) or "Sound\\Doodad\\BellTollHorde.wav"
		end
	else
		if db.alert.water.text then
			r, g, b = unpack(spell == LIGHTNING_SHIELD and db.color.lightning or db.color.water)
			text = string.format(L["%s faded!"], spell)
		end
		if db.alert.water.sound then
			sound = SharedMedia and SharedMedia:Fetch("sound", db.alert.water.soundFile) or "Sound\\Doodad\\BellTollHorde.wav"
		end
	end
	if r and g and b and text then
		if self.Pour then
			self:Pour(text, r, g, b)
		else
			RaidNotice_AddMessage(RaidWarningFrame, msg, { r = r, g = b, b = b })
		end
	end
	if sound then
		PlaySoundFile(sound)
	end
--	Debug(1, "Alert, "..spell..", "..text..", "..sound)
end

------------------------------------------------------------------------

function ShieldsUp:ApplySettings()
	Debug(1, "ApplySettings")
	
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
	if hasEarthShield and isInGroup then
		self.waterText:SetPoint("TOPRIGHT", self, "TOPLEFT", -db.padh / 2, 0)
	else
		self.waterText:SetPoint("TOP", self, "TOP", 0, 0)
	end

	if not self.earthText then
		self.earthText = self:CreateFontString(nil, "OVERLAY")
	end
	self.earthText:SetFont(face, db.font.large, outline)
	self.earthText:SetShadowOffset(0, 0)
	self.earthText:SetShadowOffset(shadow, -shadow)
	self.earthText:SetPoint("TOPLEFT", self, "TOPRIGHT", db.padh / 2, 0)
	if hasEarthShield and isInGroup then
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
	self.nameText:SetPoint("BOTTOM", self, "TOP", 0, db.padv)
	if hasEarthShield and isInGroup then
		self.nameText:Show()
	else
		self.nameText:Hide()
	end

	self:Update()
end

------------------------------------------------------------------------