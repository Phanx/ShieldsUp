--[[
	ShieldsUp: a shaman shield monitor
	by Phanx < addons AT phanx net>
	http://www.wowinterface.com/downloads/info9165-ShieldsUp.html
	http://www.curse.com/downloads/details/13180/

	See the included README.TXT for license and additional information.
	
	TODO:
	- make bit operators more efficient
--]]

if select(2, UnitClass("player")) ~= "SHAMAN" then return end

ShieldsUp = CreateFrame("Frame")
ShieldsUp.version = tonumber(GetAddOnMetadata("ShieldsUp", "Version")) or 0
ShieldsUp:SetScript("OnEvent", function(self, event, ...) if self[event] then return self[event](self, ...) end end)
ShieldsUp:RegisterEvent("ADDON_LOADED")

local ShieldsUp = ShieldsUp
local SharedMedia = LibStub("LibSharedMedia-3.0", true)
local playerGUID
local db

local L = setmetatable(SHIELDSUP_LOCALE or {}, { __index = function(t, k) rawset(t, k, k) return k end })
L["ShieldsUp"] = GetAddOnMetadata("ShieldsUp", "Title")

local EARTH_SHIELD = GetSpellInfo(32594)
local WATER_SHIELD = GetSpellInfo(33736)

local FILTER_ME = bit.bor(COMBATLOG_OBJECT_CONTROL_PLAYER, COMBATLOG_OBJECT_AFFILIATION_MINE, COMBATLOG_OBJECT_TYPE_PLAYER)
local FILTER_PET = bit.bor(COMBATLOG_OBJECT_CONTROL_PLAYER, COMBATLOG_OBJECT_AFFILIATION_MINE, COMBATLOG_OBJECT_TYPE_PET)
local FILTER_GUARDIAN = bit.bor(COMBATLOG_OBJECT_CONTROL_PLAYER, COMBATLOG_OBJECT_AFFILIATION_MINE, COMBATLOG_OBJECT_TYPE_GUARDIAN)
local FILTER_PARTY = bit.bor(COMBATLOG_OBJECT_CONTROL_PLAYER, COMBATLOG_OBJECT_AFFILIATION_PARTY)
local FILTER_RAID = bit.bor(COMBATLOG_OBJECT_CONTROL_PLAYER, COMBATLOG_OBJECT_AFFILIATION_RAID)

local EARTH_FILTER = bit.bor(FILTER_ME, FILTER_PET, FILTER_GUARDIAN, FILTER_PARTY, FILTER_RAID)

local earthCount = 0
local earthGUID = ""
local earthName = ""
local earthOverwritten = false
local earthOverwrittenBy = ""
local earthTime = 0
local earthUnit = ""

local waterCount = 0
local waterTime = 0

local chatprefix = "|cff00ddba"..L["ShieldsUp"]..":|r "
local function Print(str, ...)
	if select("#", ...) > 0 then
		str = str:format(...)
	end
	DEFAULT_CHAT_FRAME:AddMessage(chatprefix..str)
end

local function Debug(lvl, str, ...)
	if lvl > 0 then return end
	if select("#", ...) > 0 then
		str = str:format(...)
	end
	DEFAULT_CHAT_FRAME:AddMessage("|cffff7f7fShieldsUp:|r "..str)
end

local function UnitFromGUID(guid)
	if playerGUID == guid then
		return "player"
	end
	if HasPetUI() and UnitGUID("pet") == guid then
		return "pet"
	end
	if GetNumRaidMembers() > 0 then
		local result
		for i = 1, 40 do
			result = UnitGUID("raid"..i)
			if result and result == guid then return "raid"..i end
			result = UnitGUID("raid"..i.."pet")
			if result and result == guid then return "raid"..i.."pet" end
		end
		return nil
	end
	if GetNumPartyMembers() > 0 then
		local result
		for i = 1, 4 do
			result = UnitGUID("party"..i)
			if result and result == guid then return "party"..i end
			result = UnitGUID("party"..i.."pet")
			if result and result == guid then return "party"..i.."pet" end
		end
		return nil
	end
	return nil
end

local function GroupChange()
	if GetTime() - earthTime > 900 then
		earthName = ""
	end
	if earthName ~= "" then
		earthUnit = UnitFromGUID(earthGUID)
		if not earthUnit then
			earthCount = 0
			earthName = ""
			self:Update()
		end
	end
end

function ShieldsUp:ADDON_LOADED(addon)
	if addon ~= "ShieldsUp" then return end
	Debug(1, "ADDON_LOADED")

	local defaults = {
		h = 5,
		v = 0,
		x = 0,
		y = -150,
		alpha = 1,
		color = {
			alert = { 1, 0, 0 },
			normal = { 1, 1, 1 },
			overwritten = { 1, 1, 0 },
			earth = { 0.65, 1, 0.25 },
			water = { 0.25, 0.65, 1 }
		},
		font = {
			face = "Friz Quadrata TT",
			large = 24,
			small = 16,
			outline = "NONE",
			shadow = true
		},
		alert = {
			earth = {
				text = true,
				sound = true,
				soundfile = "Tribal Bell"
			},
			water = {
				text = true,
				sound = true,
				soundfile = "Tribal Bell"
			},
			output = {
				sink20OutputSink = "RaidWarning"
			}
		},
		show = {
			auto = false,
			solo = false,
			party = true,
			raid = true,
			world = false,
			dungeon = true,
			raiddungeon = true,
			battleground = false,
			arena = false
		}
	}
	ShieldsUpDB = defaults
	if not ShieldsUpDB then
		ShieldsUpDB = defaults
	elseif ShieldsUpDB.version ~= self.version then
		local temp = defaults
		for k, v in pairs(ShieldsUpDB) do
			if defaults[k] then
				temp[k] = v
			end
		end
		temp.version = self.version
		ShieldsUpDB = temp
	end
	db = ShieldsUpDB

	self.L = L

	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil

	if IsLoggedIn() then
		self:PLAYER_LOGIN()
	else
		self:RegisterEvent("PLAYER_LOGIN")
	end	
end

function ShieldsUp:PLAYER_LOGIN()
	Debug(1, "PLAYER_LOGIN")

	playerGUID = UnitGUID("player")

	if SharedMedia then
		SharedMedia:Register("sound", "Alliance Bell", "Sound\\Doodad\\BellTollAlliance.wav")
		SharedMedia:Register("sound", "Horde Bell", "Sound\\Doodad\\BellTollHorde.wav")
		SharedMedia:Register("sound", "Tribal Bell", "Sound\\Doodad\\BellTollTribal.wav")
		SharedMedia:Register("sound", "Cannon Blast", "Sound\\Doodad\\Cannon01_BlastA.wav")
		SharedMedia:Register("sound", "Dynamite", "Sound\\Spells\\DynamiteExplode.wav")
		SharedMedia:Register("sound", "Gong", "Sound\\Doodad\\G_GongTroll01.wav")
		SharedMedia:Register("sound", "Serpent", "Sound\\Creature\\TotemAll\\SerpentTotemAttackA.wav")
		self.fonts = {}
		for k, v in pairs(SharedMedia:List("font")) do
		   self.fonts[v] = v
		end
		self.sounds = {}
		for k, v in pairs(SharedMedia:List("sound")) do
		   self.sounds[v] = v
		end
		self.SharedMedia_Registered = function(self, type)
			if type == "font" then
				for k, v in pairs(SharedMedia:List("font")) do
				   self.fonts[v] = v
				end
			elseif type == "sound" then
				for k, v in pairs(SharedMedia:List("sound")) do
				   self.sounds[v] = v
				end
			end
		end
		self.SharedMedia_SetGlobal = function(self, callback, type)
			if type == "font" then
				self:UpdateFrame()
			end
		end
		SharedMedia.RegisterCallback(self, "LibSharedMedia_Registered", "SharedMedia_Registered")
		SharedMedia.RegisterCallback(self, "LibSharedMedia_SetGlobal", "SharedMedia_SetGlobal")
	end

	if LibStub and LibStub("LibSink-2.0", true) then
		LibStub("LibSink-2.0"):Embed(self)
		self:SetSinkStorage(db.alert.output)
	end

	self:ApplySettings()
	self:Update()

	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	self:RegisterEvent("PARTY_MEMBERS_CHANGED")
	self:RegisterEvent("RAID_ROSTER_UPDATE")
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA")

	self:UnregisterEvent("PLAYER_LOGIN")
	self.PLAYER_LOGIN = nil
end

function ShieldsUp:COMBAT_LOG_EVENT_UNFILTERED(time, event, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, spellID, spellName)
	Debug(3, "COMBAT_LOG_EVENT_UNFILTERED, %s, %s, source = %s, %s, %s, dest = %s, %s, %s, spell = %s", tostring(time), tostring(event), tostring(sourceGUID), tostring(sourceName), tostring(sourceFlags), tostring(destGUID), tostring(destName), tostring(destFlags), tostring(spellName))

	if event == "SPELL_HEAL" then
		if earthCount > 0 and spellName == EARTH_SHIELD and destGUID == earthGUID then
			Debug(2, "Earth Shield healed %s.", destName)
			earthCount = earthCount - 1
			if earthCount < 0 then
				Debug(1, "Earth Shield count < 0, WTF?")
				earthCount = 0
			end
			self:Update()
		end
	reutrn end

	if event == "SPELL_ENERGIZE" and waterCount > 0 then
		if spellName == WATER_SHIELD then
			if destGUID == playerGUID then
				Debug(2, "Water Shield energized me.")
				waterCount = waterCount - 1
				if waterCount < 0 then
					Debug(1, "Water Shield count < 0, WTF?")
					waterCount = 0
				end
				self:Update()
			end
		end
	return end

	if event == "SPELL_CAST_SUCCESS" then
		if spellName == EARTH_SHIELD then
			if sourceGUID == playerGUID then
				if bit.band(destFlags, FILTER_ME) == FILTER_ME
				or bit.band(destFlags, FILTER_PET) == FILTER_PET
				or bit.band(destFlags, FILTER_GUARDIAN) == FILTER_GUARDIAN
				or bit.band(destFlags, FILTER_PARTY) == FILTER_PARTY
				or bit.band(destFlags, FILTER_RAID) == FILTER_RAID then
					Debug(1, "I cast Earth Shield on %s.", destName)
					earthCount = 6
					earthGUID = destGUID
					earthName = destName
					earthOverwritten = false
					earthOverwrittenBy = ""
					earthTime = time
				else
					Debug(1, "I cast Earth Shield on an outsider.")
					earthCount = 0
					earthGUID = ""
					earthName = ""
				end
				self:Update()
			elseif destGUID == earthGUID and earthCount > 0 then
				Debug(1, "%s cast Earth Shield on %s.", sourceName, destName)
				earthCount = 6
				earthOverwritten = true
				earthOverwrittenBy = sourceName
				earthTime = time
				self:Update()
			end
		elseif spellName == WATER_SHIELD then
			if sourceGUID == playerGUID then
				Debug(1, "I cast Water Shield.")
				waterCount = 3
				waterTime = time
				self:Update()
			end
		end
	return end

	if event == "SPELL_AURA_REMOVED" then
		if spellName == EARTH_SHIELD then
			if earthCount > 0 and destGUID == earthGUID then
				self:Scan(EARTH_SHIELD, earthGUID, earthName)
				if earthCount < 1 then
					Debug(1, "Earth Shield was removed from %s.", destName)
					self:Alert(EARTH_SHIELD)
				end
			end
		elseif spellName == WATER_SHIELD then
			if waterCount > 0 and destGUID == playerGUID then
				self:Scan(WATER_SHIELD)
				if waterCount < 1 then
					Debug(1, "Water Shield was removed from me.")
					self:Scan(WATER_SHIELD)
				end
			end
		end
	return end

	if event == "UNIT_DIED" then
		if destGUID == earthGUID and earthCount > 0 then
			Debug(1, "%s died with Earth Shield on.", destName)
			earthCount = 0
			self:Update()
		elseif destGUID == playerGUID and waterCount > 0 then
			Debug(1, "I died with Water Shield on.")
			waterCount = 0
			self:Update()
		end
	return end
end

function ShieldsUp:PARTY_LEADER_CHANGED()
	Debug(3, "PARTY_LEADER_CHANGED")
	GroupChange()
end

function ShieldsUp:PARTY_MEMBERS_CHANGED()
	Debug(3, "PARTY_MEMBERS_CHANGED")
	GroupChange()
end

function ShieldsUp:RAID_ROSTER_UPDATE()
	Debug(3, "RAID_ROSTER_UPDATE")
	GroupChange()
end

function ShieldsUp:ZONE_CHANGED_NEW_AREA()
	Debug(2, "ZONE_CHANGED_NEW_AREA")
	if GetTime() - earthTime > 900 then
		earthName = ""
		self:Update()
	end
end

function ShieldsUp:Scan(buff, guid)
	Debug(1, "Scanning for %s...", buff)
	local found
	local unit = UnitFromGUID(guid)
	if unit then
		local i, name = 1
		while true do
			name = UnitBuff(unit, i)
			if not name then
				break
			end
			if name == buff then
				Debug(1, "%s found.", buff)
				found = true
				break
			end
			i = i + 1
		end
	end
	if not found then
		Debug(1, "%s not found.", buff)
		if buff == EARTH_SHIELD then
			earthCount = 0
			earthTime = GetTime() - 600
			self:Update()
		elseif buff == WATER_SHIELD then
			waterCount = 0
			self:Update()
		end
	end
end

function ShieldsUp:Update()
	Debug(3, "Update")
	if GetTime() - earthTime > 900 then
		earthCount = 0
		earthName = ""
	end

	if earthOverwritten then
		self.nameText:SetTextColor(unpack(db.color.overwritten))
	else
		self.nameText:SetTextColor(unpack(db.color.normal))
	end
	self.nameText:SetText(earthName)

	if earthCount > 0 then
		self.earthText:SetTextColor(unpack(db.color.earth))
	else
		self.earthText:SetTextColor(unpack(db.color.alert))
	end
	self.earthText:SetText(earthCount)

	if waterCount > 0 then
		self.waterText:SetTextColor(unpack(db.color.water))
	else
		self.waterText:SetTextColor(unpack(db.color.alert))
	end
	self.waterText:SetText(waterCount)
end

function ShieldsUp:Alert(spell)
	local r, g, b, msg, sound
	if spell == EARTH_SHIELD then
		if db.alert.earth.text then
			r, g, b = unpack(db.color.earth)
			msg = string.format(L["%s faded from %s!"], spell, earthName == playerName and L["YOU"] or earthName)
		end
		if db.alert.earth.sound then
			sound = SharedMedia and SharedMedia:Fetch("sound", db.alert.earth.soundfile) or "Sound\\Doodad\\BellTollHorde.wav"
		end
	elseif spell == WATER_SHIELD then
		if db.alert.water.text then
			r, g, b = unpack(db.color.water)
			msg = string.format(L["%s faded!"], spell)
		end
		if db.alert.water.sound then
			sound = SharedMedia and SharedMedia:Fetch("sound", db.alert.water.soundfile) or "Sound\\Doodad\\SerpentTotemAttackA.wav"
		end
	end
	if r and g and b and msg then
		if self.Pour then
			self:Pour(msg, r, g, b)
		else
			RaidNotice_AddMessage(RaidWarningFrame, msg, { r = r, g = g, b = b })
		end
	end
	if sound then
		PlaySoundFile(sound)
	end
end

function ShieldsUp:ApplySettings()
	Debug(2, "ApplySettings")

	self:SetParent(UIParent)
	self:SetPoint("CENTER", UIParent, "CENTER", db.x, db.y)
	self:SetHeight(1)
	self:SetWidth(1)
	self:SetAlpha(db.alpha)

	local face = SharedMedia and SharedMedia:Fetch("font", db.font.face) or "Fonts\\FRIZQT__.ttf"
	local outline = db.font.outline
	local shadow = db.font.shadow and 1 or 0

	if not self.waterText then
		self.waterText = self:CreateFontString(nil, "OVERLAY")
	end
	self.waterText:SetPoint("TOPRIGHT", self, "TOPLEFT", -db.h / 2, 0)
	self.waterText:SetFont(face, db.font.large, outline)
	self.waterText:SetShadowOffset(0, 0)
	self.waterText:SetShadowOffset(shadow, -shadow)

	if not self.earthText then
		self.earthText = self:CreateFontString(nil, "OVERLAY")
	end
	self.earthText:SetPoint("TOPLEFT", self, "TOPRIGHT", db.h / 2, 0)
	self.earthText:SetFont(face, db.font.large, outline)
	self.earthText:SetShadowOffset(0, 0)
	self.earthText:SetShadowOffset(shadow, -shadow)

	if not self.nameText then
		self.nameText = self:CreateFontString(nil, "OVERLAY")
	end
	self.nameText:SetPoint("BOTTOM", self, "TOP", 0, db.v)
	self.nameText:SetFont(face, db.font.small, outline)
	self.nameText:SetShadowOffset(0, 0)
	self.nameText:SetShadowOffset(shadow, -shadow)
end

function ShieldsUp:UpdateVisibility()
	Debug(2, "UpdateVisiblity")

	if not db.show.auto then return end
	local instance = select(2, IsInInstance())
	if ( (GetNumRaidMembers() > 0 and db.show.raid)
		or (GetNumPartyMembers() > 0 and db.show.party)
		or db.show.solo )
	or ( (instance == "none" and db.show.world)
		or (instance == "party" and db.show.dungeon)
		or (instance == "raid" and db.show.raid)
		or (instance == "arena" and db.show.arena)
		or (instance == "pvp" and db.show.battleground) )
	then
		self:Show()
	else
		self:Hide()
	end
end