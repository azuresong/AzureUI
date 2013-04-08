--[[
	Kui Nameplates
	Kesava-Auchindoun EU
]]
local addon = LibStub('AceAddon-3.0'):NewAddon('KuiNameplates', 'AceEvent-3.0', 'AceTimer-3.0')
local kui = LibStub('Kui-1.0')
local LSM = LibStub('LibSharedMedia-3.0')

-- add yanone kaffesatz and accidental presidency to LSM (only supports latin)
LSM:Register(LSM.MediaType.FONT, 'Yanone Kaffesatz', kui.m.f.yanone)
LSM:Register(LSM.MediaType.FONT, 'Accidental Presidency', kui.m.f.accid)
-- TODO should probably move LSM stuff into Kui, and replace the table there

local locale = GetLocale()
local latin  = (locale ~= 'zhCN' and locale ~= 'zhTW' and locale ~= 'koKR' and locale ~= 'ruRU')

-------------------------------------------------------------- Default config --
local defaults = {
	profile = {
		general = {
			combat      = false, -- automatically show hostile plates upon entering combat
			highlight   = true, -- highlight plates on mouse-over
			fixaa       = true, -- attempt to make plates appear sharper (with some drawbacks)
		},
		fade = {
			smooth      = true, -- smoothy fade plates (fading is instant if disabled)
			fadespeed   = .5, -- fade animation speed modifier
			fademouse   = false, -- fade in plates on mouse-over
			fadeall     = false, -- fade all plates by default
			fadedalpha  = .3, -- the alpha value to fade plates out to
		},
		tank = {
			enabled    = false, -- recolour a plate's bar and glow colour when you have threat
			barcolour  = { .2, .9, .1, 1 }, -- the bar colour to use when you have threat
			glowcolour = { 1, 0, 0, 1, 1 } -- the glow colour to use when you have threat
		},
		text = {
			level        = true, -- display levels
			friendlyname = { 1, 1, 1 }, -- friendly name text colour
			enemyname    = { 1, 1, 1 }  -- enemy name text colour
		},
		hp = {
			friendly  = '=:m;<:d;', -- health display pattern for friendly units
			hostile   = '<:p;', -- health display pattern for hostile/neutral units
			showalt   = false, -- show alternate (contextual) health values as well as main values
			mouseover = false, -- hide health values until you mouse over or target the plate
			smooth    = true -- smoothly animate health bar changes
		},
		fonts = {
			options = {
				font       = (latin and 'Yanone Kaffesatz' or LSM:GetDefault(LSM.MediaType.FONT)),
				fontscale  = 1.0,
				outline    = true,
				monochrome = false,
			},
			sizes = {
				combopoints = 13,
				large       = 10,
				spellname   = 9,
				name        = 9,
				small       = 8
			},
		}
	}
}

------------------------------------------------------------------------ init --
function addon:OnInitialize()
	if not _G['KuiNameplatesFilesLoaded-150'] then
		print('|cffff3333KuiNameplates was not loaded correctly. If you installed this update while WoW was running, you must fully restart WoW for it to recognise new files (reloading the UI or logging out and back in will not work). Otherwise, please try redownloading the addon.')
	end

	self.db = LibStub('AceDB-3.0'):New('KuiNameplatesGDB', defaults)

	-- enable ace3 profiles
	LibStub('AceConfig-3.0'):RegisterOptionsTable('kuinameplates-profiles', LibStub('AceDBOptions-3.0'):GetOptionsTable(self.db))
	LibStub('AceConfigDialog-3.0'):AddToBlizOptions('kuinameplates-profiles', 'Profiles', 'Kui Nameplates')
	
	self.db.RegisterCallback(self, 'OnProfileChanged', 'ProfileChanged')
end