local ADDON_NAME, ns = ...

ns.mediapath = "Interface\\AddOns\\oUF_Freebgrid\\media\\"

ns.defaults = {
    scale = 1.0,
    scale25 = 1.0,
    scale40 = 1.0,
    scaleYes = false,
    width = 64,
    height = 28,
    texture = "gradient",
    texturePath = ns.mediapath.."gradient",
    font = "calibri",
    fontPath = "Fonts\\Frizqt__.ttf",
    fontsize = 8,
    fontsizeEdge = 8,
    outline = "NONE",
    solo = true,
    player = true,
    party = true,
    numCol = 8,
    numUnits = 5,
    petUnits = 5,
    MTUnits = 5,
    spacing = 5,
    orientation = "HORIZONTAL",
    porientation = "HORIZONTAL",
    horizontal = false,
    pethorizontal = false,
    MThorizontal = false,
    growth = "RIGHT",
    petgrowth = "RIGHT",
    MTgrowth = "RIGHT",
    omfChar = false,
    reversecolors = true,
    definecolors = false,
    powerbar = false,
    powerbarsize = .08,
    outsideRange = .40,
    arrow = true,
    arrowmouseover = true,
    arrowmouseoveralways = false,
    arrowscale = 1.0,
    healtext = false,
    healbar = true,
    healoverflow = true,
    healothersonly = false,
    healalpha = .40,
    roleicon = false,
    pets = false,
    MT = false,
    indicatorsize = 6,
    symbolsize = 11,
    leadersize = 12,
    aurasize = 12,
    multi = false,
    deficit = false,
    perc = false,
    actual = false,
    myhealcolor = { r = 0.0, g = 1.0, b = 0.5, a = 0.4 },
    otherhealcolor = { r = 0.0, g = 1.0, b = 0.0, a = 0.4 },
    hpcolor = { r = 0.1, g = 0.1, b = 0.1, a = 1 },
    hpbgcolor = { r = 0.33, g = 0.33, b = 0.33, a = 1 },
    powercolor = { r = 1, g = 1, b = 1, a = 1 },
    powerbgcolor = { r = 0.33, g = 0.33, b = 0.33, a = 1 },
    powerdefinecolors = false,
    colorSmooth = false,
    gradient = { r = 1, g = 0, b = 0, a = 1 },
    tborder = true,
    fborder = true,
    afk = true,
    highlight = true,
    dispel = true,
    powerclass = false,
    tooltip = true,
    smooth = false,
    altpower = false,
    sortName = false,
    sortClass = false,
    classOrder = "DEATHKNIGHT,DRUID,HUNTER,MAGE,PALADIN,PRIEST,ROGUE,SHAMAN,WARLOCK,WARRIOR",
    hidemenu = false,
    autorez = false,
    cluster = {
        enabled = false,
        range = 30,
        freq = 250,
        perc = 90,
        textcolor = { r = 0, g = .9, b = .6, a = 1 },
    },
    hpinverted = false,
    hpreversed = false,
    ppinverted = false,
    ppreversed = false,
	ClickCastset = {
	["type1"]			= "NONE",
	["shiftztype1"]		= "NONE",
	["ctrlztype1"]		= "NONE",
	["altztype1"]		= "NONE",
	["altzctrlztype1"]	= "NONE",
	["type2"]			= "NONE",
	["shiftztype2"]		= "NONE",
	["ctrlztype2"]		= "NONE",
	["altztype2"]		= "NONE",
	["altzctrlztype2"]	= "NONE",
	["type3"]			= "NONE",
	["shiftztype3"]		= "NONE",
	["ctrlztype3"]		= "NONE",
	["altztype3"]		= "NONE",
	["altzctrlztype3"]	= "NONE",	
	["shiftztype4"]		= "NONE",
	["ctrlztype4"]		= "NONE",
	["altztype4"]		= "NONE",
	["altzctrlztype4"]	= "NONE",
	["type4"]			= "NONE",
	["shiftztype5"]		= "NONE",
	["ctrlztype5"]		= "NONE",
	["altztype5"]		= "NONE",
	["altzctrlztype5"]	= "NONE",
	["type5"]			= "NONE",
	["enable"]			= true,
	["change"]			= false,
	},
}

ns.ClickSets_Sets = {
	PRIEST = { 
			["type2"]				= 17,--"�����g:��",
	},

	DRUID = { 
			["type2"]			= 18562,--"Ѹ������",
	},
	SHAMAN = { 
			["ctrl-type1"]			= 2008,		--"����֮��",
			["type2"]				= 51886,	--"�������",
			["ctrl-type2"]			= 546,		--ˮ������
			["alt-type2"]			= 131,		--ˮ�º���

	},

	PALADIN = { 
			["shift-type1"]			= 635,--"�}���g",
			["alt-type1"]			= 20925,--"�̶�",
			["ctrl-type1"]			= 53563,--"ʥ���ű�",
			["alt-ctrl-type1"]		= 7328,--"���H",
		    ["type2"]				= 20473,--"���}���",
			["shift-type2"]			= 82326,--"��ʥ֮��",
			["ctrl-type2"]			= 4987,--"�Q���g",
			["alt-type2"]			= 85673,--"Word of Glory",
			["alt-ctrl-type2"]		= 633,--"�}���g",
		    ["type3"]				= 31789,--���x���o
			["alt-type3"]			= 20217,--����
			["shift-type3"]			= 20911,--���o
			["ctrl-type3"]			= 19740,--����
			["alt-ctrl-type3"]		= 31789, -- �������
	},

	WARRIOR = { 
			["ctrl-type1"]			= 50720,--"������o",
			["type2"]				= 3411,--"��_",
	},

	MAGE = { 
			["alt-type1"]			= 1459,--"�ط�����",
			["ctrl-type1"]			= 54646,--"רע",
			["type2"]				= 475,--"����{��",
			["alt-type2"]			= 130,--"����",
	},

	WARLOCK = { 
			["type2"]			= 80398,--"�ڰ���ͼ",
	},

	HUNTER = { 
			["type2"]				= 34477,--"�`��",
			["alt-type2"]			= 53271,--Master's Call
	},

	ROGUE = { 
			["type2"]				= 57933,--"͵��Q��",
	},

	DEATHKNIGHT = {
	},
	MONK = {
	},
}


function ClickSetDefault ()
--[[	if ns.db.ClickCastset.change then return end

	for k, _ in pairs(ns.db.ClickCastset) do
	--DEFAULT_CHAT_FRAME:AddMessage(tostring(v));
		if k ~= "enable" then
		    ns.db.ClickCastset[k] = "NONE"
		end
	end
]]
	local class = select(2, UnitClass("player"))
	for k, v in pairs(ns.ClickSets_Sets[class]) do
		if GetSpellInfo(v) then 
			ns.db.ClickCastset[string.gsub(k,"-","z")] = GetSpellInfo(v)
		end
	end
	--ns.db.ClickCastset.change = true

end
function ns.InitDB()
    _G[ADDON_NAME.."DB"] = _G[ADDON_NAME.."DB"] or {}
    ns.db = _G[ADDON_NAME.."DB"]

    for k, v in pairs(ns.defaults) do
        if(type(ns.db[k]) == 'nil') then
            ns.db[k] = v
        elseif(type(ns.db[k]) == 'table') then
            for i, x in pairs(ns.defaults[k]) do
                if(ns.db[k][i] == nil) then
                    ns.db[k][i] = x
                end
            end
        end
    end
	ClickSetDefault ()
end

function ns.FlushDB()
    for k,v in pairs(ns.defaults) do 
        if ns.db[k] == v and type(ns.db[k]) ~= "table" then 
            ns.db[k] = nil 
        end 
    end
end

