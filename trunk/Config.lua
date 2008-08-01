if not ShieldsUp then return end

local config = LibStub("AceConfigRegistry-3.0", true)
local dialog = LibStub("AceConfigDialog-3.0", true)

if not (config and dialog) then return end

local media = LibStub("LibSharedMedia-3.0", true)
local sink = LibStub("LibSink-2.0", true)

local registered = false
local options

local function getOptions()
	local self = ShieldsUp
	local db = self.db.profile

	local maxHeight = floor(UIParent:GetHeight() / 3)
	local maxWidth = floor(UIParent:GetWidth() / 3)

	local frameOptions = {
		name = "Frame",
		type = "group",
		args = {
			x = {
				order = 10,
				name = "Horizontal Position",
				desc = "Set the horizontal placement relative to the center of the screen",
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
				name = "Vertical Position",
				desc = "Set the vertical placement relative to the center of the screen",
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
				name = "Horizontal Spacing",
				desc = "Set the horizontal spacing between text elements",
				type = "range", min = -10, max = maxWidth * 2, step = 1, bigStep = 20,
				get = function() return db.y end,
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
				name = "Vertical Spacing",
				desc = "Set the vertical spacing between text elements",
				type = "range", min = -10, max = maxHeight * 2, step = 1, bigStep = 20,
				get = function() return db.y end,
				set = function(t, v)
					db.v = v
					self.earthName:ClearAllPoints()
					self.earthName:SetPoint("BOTTOM", self, "TOP", 0, v)
				end
			},
			alpha = {
				order = 50,
				name = "Alpha",
				desc = "Set the opacity level",
				type = "range", min = 0.1, max = 1, step = 0.05, bigStep = 0.1, isPercent = true,
				get = function() return db.alpha end,
				set = function(t, v)
					db.alpha = v
					self:SetAlpha(v)
				end
			}
		}
	}

	local fontOptions = {
		name = "Font",
		type = "group",
		args = {
			outline = {
				order = 20,
				name = "Outline",
				type = "select", values = { ["NONE"] = "None", ["OUTLINE"] = "Thin", ["THICKOUTLINE"] = "Thick" },
				get = function() return db.font.outline end,
				set = function(t, v)
					db.font.outline = v
					local face = media and media:Fetch("font", db.font.face) or "Fonts\\FRIZQT__.ttf"
					self.earthName:SetFont(face, db.font.small, v)
					self.earthText:SetFont(face, db.font.large, v)
					self.waterText:SetFont(face, db.font.large, v)
				end
			},
			large = {
				order = 30,
				name = "Count Size",
				desc = "Set the font size for the counters",
				type = "range", min = 4, max = 32, step = 1, bigStep = 4,
				get = function() return db.font.large end,
				set = function(t, v)
					db.font.large = v
					local face = media and media:Fetch("font", db.font.face) or "Fonts\\FRIZQT__.ttf"
					self.earthName:SetFont(face, db.font.small, db.font.outline)
					self.earthText:SetFont(face, v, db.font.outline)
					self.waterText:SetFont(face, v, db.font.outline)
				end
			},
			small = {
				order = 40,
				name = "Name Size",
				desc = "Set the font size for the name",
				type = "range", min = 4, max = 32, step = 1, bigStep = 4,
				get = function() return db.font.small end,
				set = function(t, v)
					db.font.small = v
					local face = media and media:Fetch("font", db.font.face) or "Fonts\\FRIZQT__.ttf"
					self.earthName:SetFont(face, v, db.font.outline)
					self.earthText:SetFont(face, db.font.large, db.font.outline)
					self.waterText:SetFont(face, db.font.large, db.font.outline)
				end
			},
			shadow = {
				order = 50,
				arg = "fontShadow",
				name = "Shadow Offset",
				type = "range", min = 0, max = 2, step = 1,
				get = function() return db.font.shadow end,
				set = function(t, v)
					db.font.shadow = v
					self.earthName:SetShadowOffset(0, 0)
					self.earthName:SetShadowOffset(v, -v)
					self.earthText:SetShadowOffset(0, 0)
					self.earthText:SetShadowOffset(v, -v)
					self.waterText:SetShadowOffset(0, 0)
					self.waterText:SetShadowOffset(v, -v)
				end
			}
		}
	}

	local colorOptions = {
		name = "Colors",
		type = "group",
		args = {
			normal = {
				order = 10,
				arg = "colorNormal",
				name = "Normal",
				type = "color",
			},
			alert = {
				order = 20,
				arg = "colorAlert",
				name = "Alert",
				type = "color",
			},
			earth = {
				order = 30,
				arg = "colorEarth",
				name = "Earth Shield",
				type = "color",
			},
			water = {
				order = 40,
				arg = "colorWater",
				name = "Water Shield",
				type = "color",
			}
		}
	}

	options.alert = {
		name = "Alerts",
		type = "group",
		get = function(k)
			return db[k.arg]
		end,
		set = function(k, v)
			db[k.arg] = v
		end,
		args = {
			earth = {
				order = 10,
				name = "Earth Shield",
				type = "group", inline = true,
				args = {
					text = {
						arg = "alertEarthText",
						name = "Text",
						type = "toggle",
					},
					sound = {
						arg = "alertEarthSound",
						name = "Sound",
						type = "toggle",
					}
				}
			},
			water = {
				order = 20,
				name = "Water Shield",
				type = "group", inline = true,
				args = {
					text = {
						arg = "alertWaterText",
						name = "Text",
						type = "toggle",
					},
					sound = {
						arg = "alertWaterSound",
						name = "Sound",
						type = "toggle",
					}
				}
			}
		}
	}

	if media then
		options.font.args.face = {
			order = 10,
			arg = "fontFace",
			name = "Face",
			type = "select", values = self.fonts, dialogControl = "LSM30_Font",
			get = function(k)
				return db.fontFace
			end,
			set = function(k, v)
				db.fontFace = v
				self:ApplySettings()
			end,
		}
		options.alert.args.earth.args.soundFile = {
			arg = "alertEarthSoundFile",
			name = "Sound File",
			type = "select", values = self.sounds, dialogControl = "LSM30_Sound",
			get = function(k)
				return db.alertEarthSoundFile
			end,
			set = function(k, v)
				db.alertEarthSoundFile = v
				PlaySoundFile(media:Fetch("sound", self.sounds[v]))
			end,
		}
		options.alert.args.water.args.soundFile = {
			arg = "alertWaterSoundFile",
			name = "Sound File",
			type = "select", values = self.sounds, dialogControl = "LSM30_Sound",
			get = function(k)
				return db.alertWaterSoundFile
			end,
			set = function(k, v)
				db.alertWaterSoundFile = v
				PlaySoundFile(media:Fetch("sound", self.sounds[v]))
			end,
		}
	end

	if sink then
		options.alert.args.output = self:GetSinkAce3OptionsDataTable()
		options.alert.args.output.inline = true
		options.alert.args.output.order = 30
	end
--[[
	options.show = {
		order = 500,
		name = "Visibility",
		type = "group",
		get = function(k)
			return db[k.arg]
		end,
		set = function(k, v)
			db[k.arg] = v
		end,
		args = {
			auto = {
			},
			group = {
				name = "Group Size",
				type = "group", inline = true,
				args = {
					solo = {
					},
					party = {
					},
					raid = {
					}
				}
			},
			zone = {
				name = "Zone Type",
				type = "group", inline = true,
				args = {
					world = {
					},
					dungeon = {
					},
					raid = {
					},
					arena = {
					},
					battleground = {
					}
				}
			}
		}
	}
]]
	options.profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
	options.profile.order = 600

	return options
end

local function initOptions()
	if registered then return end

	options = options or getOptions()

	config:RegisterOptionsTable("ShieldsUp", {
		name = GetAddOnMetadata("ShieldsUp", "Title"),
		type = "group",
		args = {
			intro = {
				order = 1,
				type = "description", name = [[
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

	config:RegisterOptionsTable("ShieldsUp-Profile", options.profile)
	dialog:AddToBlizOptions("ShieldsUp-Profile", "Profile", "ShieldsUp")

--	config:RegisterOptionsTable("ShieldsUp-ShowHide", options.show)
--	dialog:AddToBlizOptions("ShieldsUp-ShowHide", "Visibility", "ShieldsUp")

	config:RegisterOptionsTable("ShieldsUp-Alert", options.alert)
	dialog:AddToBlizOptions("ShieldsUp-Alert", "Alert", "ShieldsUp")

	config:RegisterOptionsTable("ShieldsUp-Color", options.color)
	dialog:AddToBlizOptions("ShieldsUp-Color", "Color", "ShieldsUp")

	config:RegisterOptionsTable("ShieldsUp-Font", options.font)
	dialog:AddToBlizOptions("ShieldsUp-Font", "Font", "ShieldsUp")

	config:RegisterOptionsTable("ShieldsUp-Frame", options.frame)
	dialog:AddToBlizOptions("ShieldsUp-Frame", "Frame", "ShieldsUp")
	
	registered = true
end

SLASH_SHIELDSUP1 = "/shieldsup"
SLASH_SHIELDSUP2 = "/sup"
SlashCmdList.SHIELDSUP = function(input)
	if not registered then
		initOptions()
	end
	InterfaceOptionsFrame_OpenToFrame(dialog.BlizOptions["ShieldsUp"].frame)
end

local hax = CreateFrame("Frame", nil, InterfaceOptionsFrame)
hax:SetScript("OnShow", function()
	if not registered then
		initOptions()
		hax:Hide()
	end
end)