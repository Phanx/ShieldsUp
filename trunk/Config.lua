if not ShieldsUp then return end

local config = LibStub("AceConfigRegistry-3.0")
local dialog = LibStub("AceConfigDialog-3.0")

local media = LibStub("LibSharedMedia-3.0", true)
local sink = LibStub("LibSink-2.0", true)

local registered = false

local function getOptions()
	local self = ShieldsUp
	local db = ShieldsUpDB
	local L = ShieldsUp.L

	local maxHeight = floor(UIParent:GetHeight() / 300) * 100
	local maxWidth = floor(UIParent:GetWidth() / 300) * 100

	local options = {}

	options.frame = {
		name = L["Frame"],
		type = "group",
		args = {
			x = {
				order = 10,
				name = L["Horizontal Position"],
				desc = L["Set the horizontal placement relative to the center of the screen"],
				type = "range", min = -maxWidth, max = maxWidth, step = 1, bigStep = 20,
				get = function() return db.x end,
				set = function(t, v)
					db.x = v
					self:ClearAllPoints()
					self:SetPoint("CENTER", v, db.y)
				end
			},
			y = {
				order = 20,
				name = L["Vertical Position"],
				desc = L["Set the vertical placement relative to the center of the screen"],
				type = "range", min = -maxHeight, max = maxHeight, step = 1, bigStep = 20,
				get = function() return db.y end,
				set = function(t, v)
					db.y = v
					self:ClearAllPoints()
					self:SetPoint("CENTER", db.x, v)
				end
			},
			hspace = {
				order = 30,
				name = L["Horizontal Spacing"],
				desc = L["Set the horizontal spacing between text elements"],
				type = "range", min = -10, max = maxWidth * 2, step = 1, bigStep = 20,
				get = function() return db.h end,
				set = function(t, v)
					db.h = v
					self.earthText:ClearAllPoints()
					self.earthText:SetPoint("TOPRIGHT", self, "TOPLEFT", -v / 2, 0)
					self.waterText:ClearAllPoints()
					self.waterText:SetPoint("TOPLEFT", self, "TOPRIGHT", v / 2, 0)
				end
			},
			vspace = {
				order = 40,
				arg = "v",
				name = L["Vertical Spacing"],
				desc = L["Set the vertical spacing between text elements"],
				type = "range", min = -10, max = maxHeight * 2, step = 1, bigStep = 20,
				get = function() return db.v end,
				set = function(t, v)
					db.v = v
					self.nameText:ClearAllPoints()
					self.nameText:SetPoint("BOTTOM", self, "TOP", 0, v)
				end
			},
			alpha = {
				order = 50,
				name = L["Alpha"],
				desc = L["Set the opacity level"],
				type = "range", min = 0.1, max = 1, step = 0.05, bigStep = 0.1, isPercent = true,
				get = function() return db.alpha end,
				set = function(t, v)
					db.alpha = v
					self:SetAlpha(v)
				end
			}
		}
	}

	options.font = {
		name = L["Font"],
		type = "group",
		args = {
			outline = {
				order = 20,
				name = L["Outline"],
				type = "select", values = { ["NONE"] = "None", ["OUTLINE"] = "Thin", ["THICKOUTLINE"] = "Thick" },
				get = function() return db.font.outline end,
				set = function(t, v)
					db.font.outline = v
					local face = media and media:Fetch("font", db.font.face) or "Fonts\\FRIZQT__.ttf"
					self.nameText:SetFont(face, db.font.small, v)
					self.earthText:SetFont(face, db.font.large, v)
					self.waterText:SetFont(face, db.font.large, v)
				end
			},
			large = {
				order = 30,
				name = L["Count Size"],
				desc = L["Set the font size for the counters"],
				type = "range", min = 4, max = 32, step = 1, bigStep = 2,
				get = function() return db.font.large end,
				set = function(t, v)
					db.font.large = v
					local face = media and media:Fetch("font", db.font.face) or "Fonts\\FRIZQT__.ttf"
					self.nameText:SetFont(face, db.font.small, db.font.outline)
					self.earthText:SetFont(face, v, db.font.outline)
					self.waterText:SetFont(face, v, db.font.outline)
				end
			},
			small = {
				order = 40,
				name = L["Name Size"],
				desc = L["Set the font size for the name"],
				type = "range", min = 4, max = 32, step = 1, bigStep = 2,
				get = function() return db.font.small end,
				set = function(t, v)
					db.font.small = v
					local face = media and media:Fetch("font", db.font.face) or "Fonts\\FRIZQT__.ttf"
					self.nameText:SetFont(face, v, db.font.outline)
					self.earthText:SetFont(face, db.font.large, db.font.outline)
					self.waterText:SetFont(face, db.font.large, db.font.outline)
				end
			},
			shadow = {
				order = 50,
				arg = "fontShadow",
				name = L["Shadow Offset"],
				type = "range", min = 0, max = 2, step = 1,
				get = function() return db.font.shadow end,
				set = function(t, v)
					db.font.shadow = v
					self.nameText:SetShadowOffset(0, 0)
					self.nameText:SetShadowOffset(v, -v)
					self.earthText:SetShadowOffset(0, 0)
					self.earthText:SetShadowOffset(v, -v)
					self.waterText:SetShadowOffset(0, 0)
					self.waterText:SetShadowOffset(v, -v)
				end
			}
		}
	}

	options.color = {
		name = L["Colors"],
		type = "group",
		get = function(t) return unpack(db.color[t.arg]) end,
		set = function(t, r, g, b)
			db.color[t.arg][1] = r
			db.color[t.arg][2] = g
			db.color[t.arg][3] = b
			self:Update()
		end,
		args = {
			normal = {
				order = 10,
				arg = "normal",
				name = L["Normal"], desc = L["Use this color for the Earth Shield target name"],
				type = "color",
			},
			over = {
				order = 20,
				arg = "overwritten",
				name = L["Overwritten"], desc = L["Use this color for the Earth Shield target name when someone overwrites your shield"],
				type = "color",
			},
			earth = {
				order = 30,
				arg = "earth",
				name = L["Earth Shield"], desc = L["Use this color for the Earth Shield charge counter"],
				type = "color",
			},
			water = {
				order = 40,
				arg = "water",
				name = L["Water Shield"], desc = L["Use this color for the Water Shield charge counter"],
				type = "color",
			},
			alert = {
				order = 50,
				arg = "alert",
				name = L["Alert"], desc = L["Use this color for the shield charge counters when at zero"],
				type = "color",
			}
		}
	}

	options.alert = {
		name = L["Alerts"],
		type = "group",
		args = {
			earth = {
				order = 10,
				name = L["Earth Shield"],
				type = "group", inline = true,
				args = {
					text = {
						order = 10,
						name = L["Text"], desc = L["Show a text alert when Earth Shield fades"],
						type = "toggle",
						get = function() return db.alert.earth.text end,
						set = function() db.alert.earth.text = not db.alert.earth.text end
					},
					sound = {
						order = 20,
						name = L["Sound"], desc = L["Play an alert sound when Earth Shield Fades"].
						type = "toggle",
						get = function() return db.alert.earth.sound end,
						set = function() db.alert.earth.sound = not db.alert.earth.sound end
					}
				}
			},
			water = {
				order = 20,
				name = L["Water Shield"],
				type = "group", inline = true,
				args = {
					text = {
						order = 10,
						name = L["Text"], desc = L["Show a text alert when Water Shield fades"],
						type = "toggle",
						get = function() return db.alert.water.text end,
						set = function(v) db.alert.water.text = v end
					},
					sound = {
						order = 20,
						name = L["Sound"], desc = L["Play an alert sound when Water Shield fades"],
						type = "toggle",
						get = function() return db.alert.water.sound end,
						set = function(v) db.alert.water.sound = v end
					}
				}
			}
		}
	}

	if media then
		options.font.args.face = {
			order = 10,
			name = L["Face"],
			type = "select", values = self.fonts, dialogControl = "LSM30_Font",
			get = function() return db.font.face end,
			set = function(t, v)
				db.font.face = v
				local font = media:Fetch("font", v)
				self.nameText:SetFont(font, db.font.small, db.font.outline)
				self.earthText:SetFont(font, db.font.large, db.font.outline)
				self.waterText:SetFont(font, db.font.large, db.font.outline)
			end,
		}
		options.alert.args.earth.args.soundFile = {
			name = L["Sound File"],
			type = "select", values = self.sounds, dialogControl = "LSM30_Sound",
			get = function() return db.alert.earth.soundFile end,
			set = function(t, v)
				db.alert.earth.soundFile = v
				PlaySoundFile(media:Fetch("sound", self.sounds[v]))
			end
		}
		options.alert.args.water.args.soundFile = {
			name = L["Sound File"],
			type = "select", values = self.sounds, dialogControl = "LSM30_Sound",
			get = function() return db.alert.water.soundFile end,
			set = function(t, v)
				db.alert.water.soundFile = v
				PlaySoundFile(media:Fetch("sound", self.sounds[v]))
			end
		}
	end

	if sink then
		options.alert.args.output = self:GetSinkAce3OptionsDataTable()
		options.alert.args.output.inline = true
		options.alert.args.output.order = 30
	end

	options.visibility = {
		order = 500,
		name = L["Visibility"],
		type = "group",
		args = {
			auto = {
				order = 10,
				name = L["Enable"], desc = L["Allow the display to hide or show itself based on the conditions below"]
				type = "toggle",
				get = function() return db.show.auto end,
				set = function(t, v) db.show.auto = v end
			},
			group = {
				order = 20,
				name = L["Group Size"],
				type = "group", inline = true,
				disabled = function() return not db.show.auto end,
				args = {
					solo = {
						order = 10,
						name = L["Solo"], desc = L["Show while not in a group"],
						type = "toggle",
						get = function() return db.show.solo end,
						set = function(t, v) db.show.solo = v end
					},
					party = {
						order = 20,
						name = L["Party"], desc = L["Show while in a 5-man party"],
						type = "toggle",
						get = function() return db.show.party end,
						set = function(t, v) db.show.party = v end
					},
					raid = {
						order = 30,
						name = L["Raid"], desc = L["Show while in a raid group"],
						type = "toggle",
						get = function() return db.show.raid end,
						set = function(t, v) db.show.raid = v end
					}
				}
			},
			zone = {
				order = 30,
				name = L["Zone Type"],
				type = "group", inline = true,
				disabled = function() return not db.show.auto end,
				args = {
					world = {
						order = 10,
						name = L["World"], desc = L["Show while in the world"],
						type = "toggle",
						get = function() return db.show.world end,
						set = function(t, v) db.show.world = v end
					},
					dungeon = {
						order = 20,
						name = L["Dungeon"], desc = L["Show while in a 5-man instanced dungeon"],
						type = "toggle",
						get = function() return db.show.dungeon end,
						set = function(t, v) db.show.dungeon = v end
					},
					raid = {
						order = 30,
						name = L["Raid Dungeon"], desc = L["Show while in an instanced raid dungeon"],
						type = "toggle",
						get = function() return db.show.raidDungeon end,
						set = function(t, v) db.show.raidDungeon = v end
					},
					arena = {
						order = 40,
						name = L["Arena"], desc = L["Show while in a PvP arena"],
						type = "toggle",
						get = function() return db.show.arena end,
						set = function(t, v) db.show.arena = v end
					},
					battleground = {
						order = 50,
						name = L["Battleground"], desc = L["Show while in a PvP battleground"],
						type = "toggle",
						get = function() return db.show.battleground end,
						set = function(t, v) db.show.battleground = v end
					}
				}
			}
		}
	}

	return options
end

local function initOptions()
	if registered then return end

	local options = options or getOptions()

	config:RegisterOptionsTable("ShieldsUp", {
		name = GetAddOnMetadata("ShieldsUp", "Title"),
		type = "group",
		args = {
			intro = {
				order = 1,
				type = "description", name = SHIELDSUP_ABOUTTEXT or [[
ShieldsUp is a shaman shield monitor that provides text displays of remaining charges on Water Shield and Earth Shield, as well as the name of the person your Earth Shield is currently active (or was last active) on.

The appearance, behavior, and placement are all configurable through the options presented here.

|cffffcc00Please note that ShieldsUp is currently in beta stages|r and may or may not be fully functional; it is certainly not yet complete!

|cffffcc00Credits|r
ShieldsUp is written by Bherasha @ US Sargeras Horde, and based on beSch by Infineon.
]]
			}
		}
	})

	optionsFrame = dialog:AddToBlizOptions("ShieldsUp")
	dialog:SetDefaultSize("ShieldsUp", 500, 400)

	config:RegisterOptionsTable("ShieldsUp-Frame", options.frame)
	dialog:AddToBlizOptions("ShieldsUp-Frame", L["Frame"], "ShieldsUp")

	config:RegisterOptionsTable("ShieldsUp-Color", options.color)
	dialog:AddToBlizOptions("ShieldsUp-Color", L["Colors"], "ShieldsUp")

	config:RegisterOptionsTable("ShieldsUp-Font", options.font)
	dialog:AddToBlizOptions("ShieldsUp-Font", L["Font"], "ShieldsUp")

--	config:RegisterOptionsTable("ShieldsUp-ShowHide", options.show)
--	dialog:AddToBlizOptions("ShieldsUp-ShowHide", L["Visibility"], "ShieldsUp")

	config:RegisterOptionsTable("ShieldsUp-Alert", options.alert)
	dialog:AddToBlizOptions("ShieldsUp-Alert", L["Alerts"], "ShieldsUp")
	
	registered = true
end

SLASH_SHIELDSUP1 = "/shieldsup"
SLASH_SHIELDSUP2 = "/sup"
SlashCmdList.SHIELDSUP = function()
	if not registered then
		initOptions()
	end
	InterfaceOptionsFrame_OpenToFrame(dialog.BlizOptions["ShieldsUp"].frame)
end

local hax = CreateFrame("Frame", nil, InterfaceOptionsFrame)
hax:SetScript("OnShow", function()
	if not registered then
		initOptions()
		hax:SetScript("OnShow", nil)
		hax:Hide()
	end
end)