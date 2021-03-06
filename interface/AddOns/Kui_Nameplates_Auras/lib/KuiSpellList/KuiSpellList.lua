local MAJOR, MINOR = 'KuiSpellList-1.0', 2
local KuiSpellList = LibStub:NewLibrary(MAJOR, MINOR)

if not KuiSpellList then
	-- already registered
	return
end

local whitelist = {
--[[ Important spells ----------------------------------------------------------
	Target buffs or debuffs which the player needs to keep track of.

	-- TODO? remove spells which have a clear visual effect (inc. movement speed
	decreases / effects which are passive or obvious) and which the player does
	not actively need to track. 
]]
	DRUID = { -- 5.2 COMPLETE
		[770] = true, -- faerie fire
		[1079] = true, -- rip
		[1822] = true, -- rake
		[8921] = true, -- moonfire
		[9007] = true, -- pounce bleed
		[93402] = true, -- sunfire
		[33745] = true, -- lacerate
		[102546] = true, -- pounce
		[106830] = true, -- thrash
		
		[339] = true, -- entangling roots
		[2637] = true, -- hibernate
		[6795] = true, -- growl
		[19975] = true, -- nature's grasp roots
		[22570] = true, -- maim
		[33786] = true, -- cyclone
		[58180] = true, -- infected wounds
		[102795] = true, -- bear hug

		[1126] = true, -- mark of the wild
		[29166] = true, -- innervate
		[110309] = true, -- symbiosis

		[774] = true, -- rejuvenation
		[8936] = true, -- regrowth
		[33763] = true, -- lifebloom
		[48438] = true, -- wild growth
		[102342] = true, -- ironbark

		-- talents
		[16979] = true, -- wild charge: bear
		[49376] = true, -- wild charge: cat
		[102351] = true, -- cenarion ward
		[102355] = true, -- faerie swarm
		[102359] = true, -- mass entanglement
		[61391] = true, -- typhoon daze
		[99] = true, -- disorienting roar
		[5211] = true, -- mighty bash
	},
	HUNTER = { -- 5.2 COMPLETE
	--	[1130] = true, -- hunter's mark
		[3674] = true, -- black arrow
		[53301] = true, -- explosive shot
		[63468] = true, -- piercing shots
		[118253] = true, -- serpent sting

		[5116] = true, -- concussive shot
		[19503] = true, -- scatter shot
		[24394] = true, -- intimidation
		[35101] = true, -- concussive barrage
		[64803] = true, -- entrapment
		[82654] = true, -- widow venom

		[3355] = true, -- freezing trap
		[13812] = true, -- explosive trap

		[34477] = true, -- misdirection

		-- talents
		[136634] = true, -- narrow escape
		[34490] = true, -- silencing shot
		[19386] = true, -- wyvern sting
		[117405] = true, -- binding shot
		[117526] = true, -- binding shot stun
		[120761] = true, -- glaive toss slow
		[121414] = true, -- glaive toss slow 2
	},
	MAGE = { -- 5.2 COMPLETE
		[116] = true, -- frostbolt debuff
		[11366] = true, -- pyroblast
		[12654] = true, -- ignite
		[31589] = true, -- slow
		[83853] = true, -- combustion
		[132210] = true, -- pyromaniac
		
		[118] = true, -- polymorph
		[28271] = true, -- polymorph: turtle
		[28272] = true, -- polymorph: pig
		[61305] = true, -- polymorph: cat
		[61721] = true, -- polymorph: rabbit
		[61780] = true, -- polymorph: turkey
	
		[1459] = true, -- arcane brilliance
		
		-- talents
		[111264] = true, -- ice ward
		[114923] = true, -- nether tempest
		[44457] = true, -- living bomb
		[112948] = true, -- frost bomb
	},
	DEATHKNIGHT = { -- 5.2 COMPLETE
		[55095] = true, -- frost fever
		[55078] = true, -- blood plague
		[114866] = true, -- soul reaper

		[45524] = true, -- chains of ice
		[49560] = true, -- death grip taunt
		[56222] = true, -- dark command		
		
		[3714] = true, -- path of frost
		[57330] = true, -- horn of winter
	},
	WARRIOR = { -- 5.2 COMPLETE
		[86346] = true,  -- colossus smash
		[113746] = true, -- weakened armour

		[355] = true,    -- taunt
		[676] = true,    -- disarm
		[1160] = true,   -- demoralizing shout
		[1715] = true,   -- hamstring
		[5246] = true,   -- intimidating shout
		[18498] = true,  -- gag order
		[64382] = true,  -- shattering throw
		[137637] = true, -- warbringer slow
		
		[469] = true,    -- commanding shout
		[3411] = true,   -- intervene
		[6673] = true,   -- battle shout
		
		                 -- talents
		[12323] = true,  -- piercing howl
		[107566] = true, -- staggering shout
		[132168] = true, -- shockwave debuff
		[114029] = true, -- safeguard
		[114030] = true, -- vigilance
		[113344] = true, -- bloodbath debuff
		[132169] = true, -- storm bolt debuff
	},
	PALADIN = { -- 5.2 COMPLETE
		[114163] = true, -- eternal flame
		[53563] = { colour = {1,.5,0} },  -- beacon of light
		[20925] = { colour = {1,1,.3} },  -- sacred shield
		
	--	[19740] = { colour = {.2,.2,1} }, -- blessing of might
	--	[20217] = { colour = {1,.3,.3} }, -- blessing of kings
		
	--	[114165] = true, -- holy prism
		[114916] = true, -- execution sentence dot
		[114917] = true, -- stay of execution hot
		
		                 -- hand of...
		[114039] = true, -- purity
		[6940] = true,   -- sacrifice
		[1044] = true,   -- freedom
		[1038] = true,   -- salvation
		[1022] = true,   -- protection
		
		[853] = true, -- fist of justice
		[2812] = true,   -- denounce
		[10326] = true,  -- turn evil
		[20066] = true,  -- repentance
		[62124] = true,  -- reckoning
		[105593] = true, -- fist of justice
	},
	WARLOCK = { -- 5.2 COMPLETE
		[5697]  = true,  -- unending breath
		[20707]  = true, -- soulstone
		[109773] = true, -- dark intent
	
		[172] = true,    -- corruption
		[348] = true,    -- immolate
		[980] = true,    -- agony
		[27243] = true,  -- seed of corruption
		[30108] = true,  -- unstable affliction
		[47960] = true,  -- shadowflame
		[48181] = true,  -- haunt
		[80240] = true,  -- havoc
		
		[1490] = true,   -- curse of the elements
		[18223] = true,  -- curse of exhaustion
		[109466] = true, -- curse of enfeeblement
		
		[710] = true,    -- banish
		[1098] = true,   -- enslave demon
		[5782] = true,   -- fear

		                 -- metamorphosis:
		[603] = true,    -- doom
		[124915] = true, -- chaos wave
		[116202] = true, -- aura of the elements
		[116198] = true, -- aura of enfeeblement
		
		                 -- talents:
		[5484] = true,   -- howl of terror
		[111397] = true, -- blood fear
	},
	SHAMAN = { -- 5.2 COMPLETE
		[8050] = true,   -- flame shock
		[17364] = true,  -- stormstrike
		[61882] = true,  -- earthquake
		
		[546] = true,    -- water walking
		[974] = true,    -- earth shield
		[61295] = true,  -- riptide
		
		[51514] = true,  -- hex
		[76780] = true,  -- bind elemental
	},
	PRIEST = { -- 5.2 COMPLETE
		[139] = true,    -- renew
		[6346] = true,   -- fear ward
		[33206] = true,  -- pain suppression
		[41635] = true,  -- prayer of mending buff
		[47788] = true,  -- guardian spirit
		[114908] = true, -- spirit shell shield
		
		[17] = true,     -- power word: shield
		[21562] = true,  -- power word: fortitude
	
		[2096] = true,   -- mind vision
		[8122] = true,   -- psychic scream
		[9484] = true,   -- shackle undead
		[64044] = true,  -- psychic horror
		[111759] = true, -- levitate
		
		[589] = true,    -- shadow word: pain
		[2944] = true,   -- devouring plague
		[14914] = true,  -- holy fire
		[34914] = true,  -- vampiric touch
		
		                 -- talents:
		[605] = true,    -- dominate mind
	},
	ROGUE = { -- 5.2 COMPLETE
		[703] = true,    -- garrote
		[1943] = true,   -- rupture
		[79140] = true,  -- vendetta
		[84617] = true,  -- revealing strike
		[89775] = true,  -- hemorrhage
		[113746] = true, -- weakened armour
		[122233] = true, -- crimson tempest

		[2818] = true,   -- deadly poison
		[3409] = true,   -- crippling poison
		[115196] = true, -- debilitating poison
		[5760] = true,   -- mind numbing poison
		[115194] = true, -- mind paralysis
		[8680] = true,   -- wound poison

		[408] = true,    -- kidney shot
		[1776] = true,   -- gouge
		[1833] = true,   -- cheap shot
		[2094] = true,   -- blind
		[6770] = true,   -- sap
		[26679] = true,  -- deadly throw
		[51722] = true,  -- dismantle

        [57934] = true,  -- tricks of the trade

                         -- talents:
        [112961] = true, -- leeching poison
        [113952] = true, -- paralytic poison
        [113953] = true, -- paralysis
        [115197] = true, -- partial paralysis
        [137619] = true, -- marked for death
	},
	MONK = { -- 5.2 COMPLETE
		[116189] = true, -- provoke taunt
		[116330] = true, -- dizzying haze debuff
		[123727] = true, -- keg smash - dizzying haze debuff
		[123725] = true, -- breath of fire
		[120086] = true, -- fists of fury stun
		[122470] = true, -- touch of karma
		[130320] = true, -- rising sun kick debuff
		
		[116781] = true, -- legacy of the white tiger
		[116844] = true, -- ring of peace
		[117666] = true, -- legacy of the emperor group
		[117667] = true, -- legacy of the emperor target (um.)
		
		[116849] = true, -- life cocoon
		[132120] = true, -- enveloping mist
		[119611] = true, -- renewing mist
		
		[117368] = true, -- grapple weapon
		[116095] = true, -- disable
		[115078] = true, -- paralysis
	
		                 -- talents:
		[116841] = true, -- tiger's lust
		[124081] = true, -- zen sphere
		[119392] = true, -- charging ox wave
		[119381] = true, -- leg sweep
		
	},
-- Important auras regardless of caster (cc, flags...) -------------------------
--[[
	Global = {
		-- PVP -----------------------------------------------------------------
		[34976] = true, -- Netherstorm Flag
		[23335] = true, -- Alliance Flag
		[23333] = true, -- Horde Flag
	},
]]
}

KuiSpellList.GetImportantSpells = function(class)
	return whitelist[class]
end
