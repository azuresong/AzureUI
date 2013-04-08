--[[
	JewelTips 0.7.0
]]--
local _G = _G
--Create Jeweltips frame
JewelTips = {}
local JewelTips = JewelTips
JewelTips.Jewels = {
--		[] = "0",
	[15] = 2304, --Light Armor Kit
	[16] = 2313, --Medium Armor Kit
	[17] = 4265, --Heavy Armor Kit
	[18] = 8173, --Thick Armor Kit
	[30] = 4405, --Crude Scope
	[32] = 4406, --Standard Scope
	[33] = 4407, --Accurate Scope
	[34] = 6043, --Iron Counterweight
	[36] = 5421, --Fiery Blaze Enchantment
	[37] = 6041, --Steel Weapon Chain
	[41] = {GetSpellInfo(7418), 7418}, --+5 Health
	[43] = 6042, --Iron Shield Spike
	[65] = {GetSpellInfo(7454), 7454},
	[66] = { --+1 Stamina
		multi = true,
		INVTYPE_WRIST = {GetSpellInfo(7457), 7457},
		INVTYPE_FEET = {GetSpellInfo(7863), 7863},
	},
	[241] = {GetSpellInfo(7745), 7745},
	[247] = {GetSpellInfo(13419), 13419},
	[249] = {GetSpellInfo(7786), 7786},
	[255] = {GetSpellInfo(13380), 13380},
	[256] = {GetSpellInfo(7861), 7861},
	[366] = {GetSpellInfo(13700), 13700},
	[368] = {GetSpellInfo(34004), 34004},
	[369] = {GetSpellInfo(34001), 34001},
	[464] = 7969, --Mithril Spurs
	[663] = 10546, --Deadly Scope
	[664] = 10548, --Sniper Scope
	[684] = {GetSpellInfo(33995), 33995},
	[723] = {GetSpellInfo(7793), 7793}, --+3 Intellect
	[724] = {GetSpellInfo(13644), 13644}, --+3 Stamina
	[744] = {GetSpellInfo(13421), 13421},
	[783] = {GetSpellInfo(7771), 7771}, --+10 Armor
	[803] = {GetSpellInfo(13898), 13898},
	[804] = {GetSpellInfo(13522), 13522},
	[805] = {GetSpellInfo(13943), 13943}, --+4 Weapon Damage
	[844] = {GetSpellInfo(13612), 13612},
	[845] = {GetSpellInfo(13617), 13617},
	[846] = {GetSpellInfo(13620), 13620},
	[848] = {GetSpellInfo(13635), 13635},
	[849] = {GetSpellInfo(13882), 13882},
	[850] = {GetSpellInfo(13640), 13640},
	[851] = {GetSpellInfo(20024), 20024},
	[852] = {
		multi = true,
		INVTYPE_FEET = {GetSpellInfo(13836), 13836},
		INVTYPE_SHIELD = {GetSpellInfo(13817), 13817},
		INVTYPE_WRIST = {GetSpellInfo(13648), 13648},
	},
	[854] = {GetSpellInfo(13655), 13655},
	[856] = {GetSpellInfo(13887), 13887},
	[857] = {GetSpellInfo(13663), 13663},	--+50 Mana
	[863] = {GetSpellInfo(13689), 13689},
	[865] = {GetSpellInfo(13698), 13698},
	[884] = {GetSpellInfo(13746), 13746},
	[903] = {GetSpellInfo(13794), 13794},
	[904] = {GetSpellInfo(13815), 13815},
	[905] = {GetSpellInfo(13822), 13822},
	[906] = {GetSpellInfo(13841), 13841},
	[908] = {GetSpellInfo(13858), 13858},
	[909] = {GetSpellInfo(13868), 13868},
	[910] = {GetSpellInfo(25083), 25083},
	[911] = {GetSpellInfo(13890), 13890},
	[912] = {GetSpellInfo(13915), 13915},
	[913] = {GetSpellInfo(13917), 13917},
	[923] = {GetSpellInfo(13931), 13931}, --+5 Defense Rating
	[926] = {GetSpellInfo(13933), 13933},
	[928] = {GetSpellInfo(13941), 13941},
	[929] = {
		multi = true,
		INVTYPE_SHIELD = {GetSpellInfo(20017), 20017},
		INVTYPE_FEET = {GetSpellInfo(20020), 20020},
		INVTYPE_WRIST = {GetSpellInfo(13945), 13945},
	},
	[930] = {GetSpellInfo(13947), 13947},
	[931] = {GetSpellInfo(13948), 13948},
	[943] = {GetSpellInfo(13529), 13529},
	[963] = {GetSpellInfo(13937), 13937},
	[983] = {
		multi = true,
		INVTYPE_FEET = {GetSpellInfo(44589), 44589}, --Enchant Boots - Superior Agility
		INVTYPE_CLOAK = {GetSpellInfo(44500), 44500}, --Enchant Cloak - Superior Agility
	},
	[1071] = {GetSpellInfo(34009), 34009},
	[1075] = {
		multi = true,
		INVTYPE_FEET = {GetSpellInfo(44528), 44528}, --Enchant Boots - Greater Fortitude
		INVTYPE_SHIELD = {GetSpellInfo(44597), 44597}, --Enchant Shield - Exceptional Stamina
	},
	[1088] = {GetSpellInfo(44597), 44597}, --Enchant Shield - Mighty Stamina
	[1099] = {GetSpellInfo(60663), 60663}, --Enchant Cloak - Major Agility
	[1103] = {GetSpellInfo(44633), 44633}, --Enchant Weapon - Exceptional Agility
	[1119] = {GetSpellInfo(44555), 44555}, --Enchant Bracers - Exceptional Intellect
	[1128] = {GetSpellInfo(60653), 60653}, --Enchant Shield - Greater Intellect
	[1144] = {GetSpellInfo(33990), 33990}, -- +15 Spirit
	[1147] = {
		multi = true,
		INVTYPE_WRIST = {GetSpellInfo(44593), 44593}, --Enchant Bracers - Major Spirit
		INVTYPE_FEET = {GetSpellInfo(44508), 44508}, --Enchant Boots - Greater Spirit
	},
	[1225] = {GetSpellInfo(44497), 44497}, --Enchant Weapon - Exceptional Intellect
	[1231] = {GetSpellInfo(44510), 44510}, --Enchant Weapon - Exceptional Spirit
	[1257] = {GetSpellInfo(34005), 34005}, --+15 Arcane Resistance
	[1262] = {GetSpellInfo(44596), 44596}, --Enchant Cloak - Superior Arcane Resistance
	[1354] = {GetSpellInfo(44556), 44556}, --Enchant Cloak - Superior Fire Resistance
	[1400] = {GetSpellInfo(44494), 44494}, --Enchant Cloak - Superior Nature Resistance
	[1441] = {GetSpellInfo(34006), 34006},
	[1446] = {GetSpellInfo(44590), 44590}, --Enchant Cloak - Superior Shadow Resistance
	[1483] = 11622, --Lesser Arcanum of Rumination
	[1503] = 11642, --Lesser Arcanum of Constitution
	[1504] = 11643, --Lesser Arcanum of Tenacity
	[1505] = 11644, --Lesser Arcanum of Resilience
	[1506] = 11645, --Lesser Arcanum of Voracity
	[1507] = 11646, --Lesser Arcanum of Voracity
	[1508] = 11647, --Lesser Arcanum of Voracity
	[1509] = 11648, --Lesser Arcanum of Voracity
	[1510] = 11649, --Lesser Arcanum of Voracity
	[1593] = {GetSpellInfo(34002), 34002}, -- +24 Attack Power
	[1594] = {GetSpellInfo(33996), 33996}, -- +26 Attack Power
	[1597] = {
		multi = true,
		INVTYPE_HAND = {GetSpellInfo(44513), 44513}, --Enchant Gloves - Greater Assault
		INVTYPE_FEET = {GetSpellInfo(60763), 60763}, --Enchant Boots - Greater Assault
	},
	[1600] = {GetSpellInfo(60616), 60616}, --Enchant Bracers - Striking
	[1601] = {GetSpellInfo(44645), 44645}, --Enchant Ring - Assault
	[1603] = {GetSpellInfo(60668), 60668}, --Enchant Gloves - Crusher
	[1606] = {GetSpellInfo(60621), 60621}, --Enchant Weapon - Greater Potency
	[1626] = {GetSpellInfo(44630), 44630}, --Enchant Weapon - Greater Savagery
	[1704] = 12645, --Thorium Spike (20-30)
	[1843] = 15564, --Rugged Armor Kit
	[1883] = {GetSpellInfo(20008), 20008},
	[1884] = {GetSpellInfo(20009), 20009},
	[1886] = {GetSpellInfo(20011), 20011}, -- +9 Stamina
	[1887] = {GetSpellInfo(20012), 20012}, -- +7 Agility
	[1888] = {
		multi = true,
		INVTYPE_CLOAK = {GetSpellInfo(20014), 20014}, --+5 All Resistances
		INVTYPE_SHIELD = {GetSpellInfo(27947), 27947},
	},
	[1889] = {GetSpellInfo(20015), 20015},
	[1891] = {GetSpellInfo(27905), 27905}, --+4 All Stats
	[1892] = {GetSpellInfo(20026), 20026}, -- +100 Health
	[1893] = {GetSpellInfo(20028), 20028}, --+100 Mana
	[1894] = {GetSpellInfo(20029), 20029}, --Icy Weapon
	[1896] = {GetSpellInfo(20030), 20030},
	[1897] = {GetSpellInfo(13695), 13695}, --+5 Weapon Damage
	[1898] = {GetSpellInfo(20032), 20032}, --life stolen
	[1899] = {GetSpellInfo(20033), 20033}, --Unholy Weapon
	[1900] = {GetSpellInfo(20034), 20034}, -- Crusader
	[1903] = {GetSpellInfo(20035), 20035},
	[1904] = {GetSpellInfo(20036), 20036},
	[1950] = {GetSpellInfo(46594), 46594}, --+15 Defense Rating
	[1951] = {GetSpellInfo(44591), 44591}, --Enchant Cloak - Titanweave
	[1952] = {GetSpellInfo(44489), 44489}, --Enchant Shield - Defense
	[1953] = {GetSpellInfo(47766), 47766},--Enchant Chest - Greater Defense
	[2322] = {GetSpellInfo(33999), 33999},
	[2326] = {GetSpellInfo(44635), 44635}, --Enchant Bracers - Greater Spellpower
	[2327] = {GetSpellInfo(44634), 44634}, --Enchant Bracers - Major Healing
	[2332] = {GetSpellInfo(60767), 60767}, --Enchant Bracers - Superior Spellpower
	[2343] = {GetSpellInfo(34010), 34010},
	[2376] = {GetSpellInfo(33991), 33991}, -- changed?
	[2381] = {GetSpellInfo(44509), 44509}, --Enchant Chest - Greater Mana Restoration
	[2443] = {GetSpellInfo(21931), 21931},
	[2463] = {GetSpellInfo(13657), 13657},
	[2483] = 18169, --Flame Mantle of the Dawn
	[2484] = 18170, --Frost Mantle of the Dawn
	[2485] = 18171, --Arcane Mantle of the Dawn
	[2486] = 18172, --Nature Mantle of the Dawn
	[2487] = 18173, --Shadow Mantle of the Dawn
	[2488] = 18182, --Chromatic Mantle of the Dawn
	[2503] = 18251, --Core Armor Kit
	[2504] = {GetSpellInfo(22749), 22749},
	[2505] = {GetSpellInfo(22750), 22750}, -- +55 Healing
	[2523] = 18283, --Biznicks 247x128 Accurascope
	[2543] = 18329, --Arcanum of Rapidity
	[2544] = 18330, --Arcanum of Focus
	[2545] = 18331, --Arcanum of Protection
	[2563] = {GetSpellInfo(23799), 23799}, -- +15 Strength
	[2564] = {
		multi = true,
		INVTYPE_HAND = {GetSpellInfo(25080), 25080}, -- +15 Agility
		INVTYPE_WEAPON = {GetSpellInfo(23800), 23800},
		INVTYPE_WEAPONMAINHAND = {GetSpellInfo(23800), 23800},
		INVTYPE_WEAPONOFFHAND = {GetSpellInfo(23800), 23800},
		INVTYPE_2HWEAPON = {GetSpellInfo(23800), 23800},
	},
	[2565] = {GetSpellInfo(23801), 23801}, -- Mana Regen 4 per 5 sec.
	[2566] = {GetSpellInfo(23802), 23802}, -- +24 Healing
	[2567] = {GetSpellInfo(23803), 23803}, -- +20 Spirit
	[2568] = {GetSpellInfo(23804), 23804}, -- +22 Intellect
	[2583] = 19782, --Presence of Might
	[2584] = 19783, --Syncretist's Sigil
	[2585] = 19784, --Death's Embrace
	[2586] = 19785, --Falcon's Call
	[2587] = 19786, --Vodouisant's Vigilant Embrace
	[2588] = 19787, --Presence of Sight
	[2589] = 19788, --Hoodoo Hex
	[2590] = 19789, --Prophetic Aura
	[2591] = 19790, --Animist's Caress
	[2603] = 19971, --High Test Eternium Fishing Line
	[2604] = 20078,--Zandalar Signet of Serenity
	[2605] = 20076,--Zandalar Signet of Mojo
	[2606] = 20077,--Zandalar Signet of Might
	[2613] = {GetSpellInfo(25072), 25072}, --+2% Threat
	[2614] = {GetSpellInfo(25073), 25073},
	[2615] = {GetSpellInfo(25074), 25074},
	[2616] = {GetSpellInfo(25078), 25078},
	[2617] = {GetSpellInfo(27911), 27911},
	[2619] = {GetSpellInfo(25081), 25081},-- +15 Fire Resistance
	[2620] = {GetSpellInfo(25082), 25082}, -- +15 Nature Resistance
	[2621] = {GetSpellInfo(25084), 25084},
	[2622] = {GetSpellInfo(25086), 25086},
	[2646] = {GetSpellInfo(27837), 27837},
	[2647] = {GetSpellInfo(27899), 27899},
	[2648] = {GetSpellInfo(27906), 27906}, -- +12 Defense Rating
	[2649] = {
		multi = true,
		INVTYPE_FEET = {GetSpellInfo(27950), 27950}, -- +12 Stamina
		INVTYPE_WRIST = {GetSpellInfo(27914), 27914}, -- +12 Stamina
	},
	[2650] = {GetSpellInfo(27917), 27917},--+15 Spell Damage
	[2653] = {GetSpellInfo(27944), 27944}, --+18 Block Value
	[2654] = {GetSpellInfo(27945), 27945}, -- +12 Intellect
	[2655] = {GetSpellInfo(27946), 27946}, --+15 Shield Block Rating
	[2656] = {GetSpellInfo(27948), 27948},
	[2657] = {GetSpellInfo(27951), 27951},
	[2658] = {GetSpellInfo(27954), 27954},
	[2659] = {GetSpellInfo(27957), 27957}, -- +150 Health
	[2660] = {GetSpellInfo(27958), 27958}, -- +150 Mana
	[2661] = {
		multi = true,
		INVTYPE_CHEST = {GetSpellInfo(27960), 27960}, -- +6 All Stats
		INVTYPE_ROBE = {GetSpellInfo(27960), 27960}, -- +6 All Stats
		INVTYPE_WRIST = {GetSpellInfo(44616), 44616}, --Enchant Bracers - Greater Stats
	},
	[2662] = {GetSpellInfo(27961), 27961},
	[2664] = {GetSpellInfo(27962), 27962},
	[2665] = {GetSpellInfo(27964), 27964}, -- +35 Spirit (NYI)
	[2666] = {GetSpellInfo(27968), 27968},
	[2667] = {GetSpellInfo(27971), 27971},
	[2668] = {GetSpellInfo(27972), 27972},
	[2669] = {GetSpellInfo(27975), 27975},
	[2670] = {GetSpellInfo(27977), 27977},
	[2671] = {GetSpellInfo(27981), 27981},
	[2672] = {GetSpellInfo(27982), 27982},
	[2673] = {GetSpellInfo(27984), 27984}, -- Mongoose
	[2674] = {GetSpellInfo(28003), 28003},
	[2675] = {GetSpellInfo(28004), 28004},
	[2679] = {GetSpellInfo(27913), 27913},
	[2681] = 22635, --Savage Guard
	[2682] = 22636, --Ice Guard
	[2683] = 22638, --Shadow Guard
	[2684] = 23122, --Consecrated Sharpening Stone
	[2685] = 23123, --Blessed Wizard Oil
	[2712] = 23528,--Fel Sharpening Stone
	[2713] = 23529, --Adamantite Sharpening Stone
	[2714] = 23530, --Felsteel Shield Spike
	[2715] = 23547, --Resilience of the Scourge
	[2716] = 23549, --Fortitude of the Scourge
	[2717] = 23548, --Might of the Scourge
	[2718] = 23559, --Lesser Rune of Warding
	[2719] = 23575, --Lesser Rune of Shielding
	[2720] = 23576, --Greater Rune of Shielding
	[2721] = 23545, --Power of the Scourge
	[2722] = 23764, --Adamantite Scope
	[2723] = 23765, --Khorium Scope
	[2724] = 23766, --Stabilized Eternium Scope
	[2745] = 24275, --Silver Spellthread
	[2746] = 24276, --Golden Spellthread
	[2747] = 24273, --Mystic Spellthread
	[2748] = 24274, --Runic Spellthread
	[2791] = 25521, --Greater Rune of Warding
	[2792] = 25650, --Knothide Armor Kit
	[2793] = 25651, --Vindicator's Armor Kit
	[2794] = 25652, --Magister's Armor Kit
	[2795] = 25679, --Comfortable Insoles
	[2836] = 25652, --Magister's Armor Kit??
	[2841] = 34330, --+10 Stamina (Heavy Knothide Armor Kit)
	[2928] = {GetSpellInfo(27924), 27924},--+12 Spell Damage
	[2929] = {GetSpellInfo(27920), 27920},--+2 Weapon Damage
	[2930] = {GetSpellInfo(27926), 27926},--+20 Healing
	[2931] = {GetSpellInfo(27927), 27927},--+20 Healing
	[2933] = {GetSpellInfo(33992), 33992},
	[2934] = {GetSpellInfo(33993), 33993},
	[2935] = {GetSpellInfo(33994), 33994},
	[2937] = {
		multi = true,
		INVTYPE_HAND = {GetSpellInfo(33997), 33997}, --+20 Spell
		INVTYPE_WRIST = {GetSpellInfo(44635), 44635}, --Enchant Bracers - Greater Spellpower
	},
	[2938] = {GetSpellInfo(34003), 34003},
	[2939] = {GetSpellInfo(34007), 34007},
	[2940] = {GetSpellInfo(34008), 34008},
	[2954] = 28420, --Fel Weightstone
	[2955] = 28421, --Adamantite Weightstone
	[2977] = 28882, --Inscription of Warding (Aldor)
	[2978] = 28889, --Greater Inscription of Warding (Aldor)
	[2979] = 28878, --Inscription of Faith (Aldor)
	[2980] = 28887, --Greater Inscription of Faith (Aldor)
	[2981] = 28881, --Inscription of Discipline (Aldor)
	[2982] = 28886, --Greater Inscription of Discipline (Aldor)
	[2983] = 28885, --Inscription of Vengeance (Aldor)
	[2984] = 29483, --Shadow Armor Kit
	[2985] = 29485, --Flame Armor Kit
	[2986] = 28888, --Greater Inscription of Vengeance
	[2987] = 29486, --Frost Armor Kit
	[2988] = 29487, --Nature Armor Kit
	[2989] = 29488, --Arcane Armor Kit
	[2990] = 28908, --Inscription of the Knight
	[2991] = 28911, --Greater Inscription of the Knight
	[2992] = 28904, --Inscription of the Oracle
	[2993] = 28912, --Greater Inscription of the Oracle
	[2994] = 28903, --Inscription of the Orb
	[2995] = 28909, --Greater Inscription of the Orb
	[2996] = 28907, --Inscription of the Blade
	[2997] = 28910, --Greater Inscription of the Blade
	[2998] = 29187, --Inscription of Endurance
	[2999] = 29186, --Glyph of the Defender
	[3001] = 29189, --Glyph of Renewal
	[3002] = 29191, --Glyph of Power
	[3003] = 29192, --Glyph of Ferocity
	[3004] = 29193, --Glyph of the Gladiator
	[3005] = 29194, --Glyph of Nature Warding
	[3006] = 29195, --Glyph of Arcane Warding
	[3007] = 29196, --Glyph of Fire Warding
	[3008] = 29198, --Glyph of Frost Warding
	[3009] = 29199, --Glyph of Shadow Warding
	[3010] = 29533, --Cobrahide Leg Armor
	[3011] = 29534, --Clefthide Leg Armor
	[3012] = 29535, --Nethercobra Leg Armor
	[3013] = 29536, --Nethercleft Leg Armor
	[3096] = 30846, --Glyph of the Outcast
	[3150] = {GetSpellInfo(33991), 33991}, --New enchant id?
	[3222] = {
		multi = true,
		INVTYPE_WEAPON = {GetSpellInfo(42620), 42620}, --+20 Agility
		INVTYPE_WEAPONMAINHAND = {GetSpellInfo(42620), 42620}, --+20 Agility
		INVTYPE_WEAPONOFFHAND = {GetSpellInfo(42620), 42620}, --+20 Agility
		INVTYPE_2HWEAPON = {GetSpellInfo(42620), 42620}, --+20 Agility
		INVTYPE_HAND = {GetSpellInfo(44529), 44529}, --Enchant Gloves - Major Agility
	},
	[3223] = 33185, --Adamantite Weapon Chain
	[3225] = {GetSpellInfo(42974), 42974},	--Executioner
	[3229] = {GetSpellInfo(44383), 44383}, --+12 Resilience Rating
	[3230] = {GetSpellInfo(44483), 44483}, --Enchant Cloak - Superior Frost Resistance
	[3231] = {
		multi = true,
		INVTYPE_WRIST = {GetSpellInfo(44598), 44598}, --Enchant Bracer - Expertise
		INVTYPE_HAND = {GetSpellInfo(44529), 44529}, --Enchant Gloves - Expertise
	},
	[3232] = {GetSpellInfo(47901), 47901}, --Enchant Boots - Tuskarr's Vitality
	[3233] = {GetSpellInfo(27958), 27958}, --Enchant Chest - Exceptonal Mana
	[3234] = {GetSpellInfo(44488), 44488}, --Enchant Gloves - Precision
	[3236] = {GetSpellInfo(44492), 44492}, --Enchant Chest - Major Health
	[3237] = {GetSpellInfo(44496), 44496}, --Enchant Weapon - Exceptional Striking
	[3239] = {GetSpellInfo(44524), 44524}, --Enchant Weapon - Icebreaker
	[3240] = {
		multi = true,
		INVTYPE_FINGER = {GetSpellInfo(44638), 44638}, --Enchant Ring - Greater Healing Power
		INVTYPE_HAND = {GetSpellInfo(44484), 44484}, --Enchant Gloves - Exceptional Healing
	},
	[3241] = {GetSpellInfo(44576), 44576}, --Enchant Weapon - Lifeward
	[3243] = {GetSpellInfo(44582), 44582}, --Enchant Cloak - Spell Piercing
	[3244] = {GetSpellInfo(44584), 44584}, --Enchant Boots - Greater Vitality
	[3245] = {GetSpellInfo(44588), 44588}, --Enchant Chest - Exceptional Resilience
	[3246] = {GetSpellInfo(44592), 44592}, --Enchant Gloves - Exceptional Spellpower
	[3247] = {GetSpellInfo(44595), 44595}, --Enchant Weapon - Scourgebane
	[3249] = {GetSpellInfo(44612), 44612}, --Enchant Gloves - Greater Blasting
	[3250] = {GetSpellInfo(44613), 44613}, --Enchant Boots - Icewalker
	[3251] = {GetSpellInfo(44621), 44621}, --Enchant Weapon - Giant Slayer
	[3252] = {GetSpellInfo(44623), 44623}, --Enchant Chest - Super Stats
	[3253] = {GetSpellInfo(44625), 44625}, --Enchant Gloves - Armsman
	[3255] = {GetSpellInfo(44629), 44629}, --Enchant Weapon - Exceptional Spellpower
	[3256] = {GetSpellInfo(44631), 44631}, --Enchant Cloak - Shadow Armor
	[3257] = {GetSpellInfo(44632), 44632}, --Enchant Weapon - Exceptional Healing
	[3260] = 34207, --Glove Reinforcements
	[3269] = 34836, --Spun Truesilver Fishing Line
	[3273] = {GetSpellInfo(46578), 46578}, --Deathfrost
	[3294] = {GetSpellInfo(47672), 47672}, --Enchant Cloak - Mighty Armor
	[3295] = {
		INVTYPE_CLOAK = {GetSpellInfo(47898), 47898}, --Enchant Cloak - Haste
		INVTYPE_RING = {GetSpellInfo(44637), 44637}, --Enchant Ring - Haste
	},
	[3296] = {GetSpellInfo(47899), 47899}, --Enchant Cloak - Wisdom
	[3297] = {GetSpellInfo(47900), 47900}, --Enchant Chest - Super Health
	[3300] = {GetSpellInfo(44636), 44636}, --Enchant Ring - Greater Spellpower

	[3325] = 38371, --Jormungar Leg Armor
	[3326] = 38372, --Nerubian Leg Armor
	[3327] = {GetSpellInfo(60583), 60583}, --Jormungar Leg Reinforcements
	[3328] = {GetSpellInfo(60584), 60584}, --Nerubian Leg Reinforcements
	[3329] = 38375, --Borean Armor Kit
	[3330] = 38376, --Heavy Borean Armor Kit
	[3365] = {GetSpellInfo(53323), 53323}, --Rune of Swordshattering
	[3366] = {GetSpellInfo(53331), 53331}, --Rune of Lichbane
	[3367] = {GetSpellInfo(53342), 53342}, --Rune of Spellshattering
	[3368] = {GetSpellInfo(53344), 53344}, --Rune of the Fallen Crusader
	[3369] = {GetSpellInfo(53341), 53341}, --Rune of Cinderglacier
	[3370] = {GetSpellInfo(53343), 53343}, --Rune of Razorice
	[3594] = {GetSpellInfo(54446), 54446}, --Rune of Swordbreaking
	[3595] = {GetSpellInfo(54447), 54447}, --Rune of Spellbreaking
	[3599] = {GetSpellInfo(54736), 54736}, --Personal Electromagnetic Pulse Generator
	[3601] = {GetSpellInfo(54793), 54793}, --Belt-Clipped Spynoculars
	[3603] = {GetSpellInfo(54998), 54998}, --Hand-Mounted Pyro Rocket
	[3604] = {GetSpellInfo(54999), 54999}, --Hyperspeed Accelerators
	[3605] = {GetSpellInfo(55002), 55002}, --Flexweave Underlay
	[3606] = {GetSpellInfo(55016), 55016}, --Nitro Boosts
	[3607] = 41146, --Sun Scope
	[3608] = 41167, --Heartseeker Scope (spell 55135)
	
	[3718] = 41601, --Shining Spellthread
	[3719] = 41602, --Brilliant Spellthread
	[3720] = 41603, --Azure Spellthread
	[3721] = 41604, --Sapphire Spellthread
	[3722] = {GetSpellInfo(55642), 55642}, --Lightweave Embroidery
	[3728] = {GetSpellInfo(55769), 55769}, --Darkglow Embroidery
	[3729] = 41611, --Eternal Belt Buckle
	[3730] = {GetSpellInfo(55777), 55777}, --Swordguard Embroidery
	[3731] = 41976, --Titanium Weapon Chain
	
	[3748] = 42500, --Titanium Shield Spike
	
	[3756] = {GetSpellInfo(57683), 57683}, --Fur Lining - Attack Power
	[3757] = {GetSpellInfo(57690), 57690}, --Fur Lining - Stamina
	[3758] = {GetSpellInfo(57691), 57691}, --Fur Lining - Spell Power
	[3759] = {GetSpellInfo(57692), 57692}, --Fur Lining - Fire Resist
	[3760] = {GetSpellInfo(57694), 57694}, --Fur Lining - Frost Resist
	[3761] = {GetSpellInfo(57696), 57696}, --Fur Lining - Shadow Resist
	[3762] = {GetSpellInfo(57699), 57699}, --Fur Lining - Nature Resist
	[3788] = {GetSpellInfo(59619), 59619}, --Enchant Weapon - Accuracy
	[3789] = {GetSpellInfo(59621), 59621}, --Enchant Weapon - Berserking
	[3790] = {GetSpellInfo(59625), 59625}, --Enchant Weapon - Black Magic
	[3791] = {GetSpellInfo(59636), 59636}, --Enchant Ring - Stamina
	[3793] = 44067, --Inscription of Triumph
	[3794] = 44068, --Inscription of Dominance
	[3795] = 44069, --Arcanume of Triumph
	[3797] = 44075, --Arcanum of Dominance
	
	[3806] = 44129, --Inscription of the Storm
	[3807] = 44130, --Lesser Inscription of the Crag
	[3808] = 44133, --Greater Inscription of the Axe
	[3809] = 44134, --Greater Inscription of the Crag
	[3810] = 44135, --Greater Inscription of the Storm
	[3811] = 44136, --Greater Inscription of the Pinnacle
	[3812] = 44137, --Arcanum of the Frosty Soul
	[3813] = 44138, --Arcanum of Toxic Warding
	[3814] = 44139, --Arcanum of the Fleeing Shadow
	[3815] = 44140, --Arcanum of the Eclipsed Moon
	[3816] = 44141, --Arcanum of the Flame's Soul
	[3817] = 44149, --Arcanum of Torment
	[3818] = 44150, --Arcanum of the Stalwart Protector
	[3819] = 44152, --Arcanum of Blissful Mending
	[3820] = 44159, --Arcanum of Burning Mysteries
	[3822] = 38373, --Frosthide Leg Armor
	[3823] = 38374, --Icescale Leg Armor
	[3824] = {GetSpellInfo(60606), 60606}, --Enchant Boots - Assault
	[3825] = {GetSpellInfo(60609), 60609}, --Enchant Cloak - Speed
	[3826] = {GetSpellInfo(60623), 60623}, --Enchant Boots - Icewalker
	[3827] = {GetSpellInfo(60691), 60691}, --Enchant 2H Weapon - Massacre
	[3828] = {GetSpellInfo(44630), 44630}, --Enchant 2H Weapon - Greater Savagery
	[3829] = {GetSpellInfo(44513), 44513}, --Enchant Gloves - Greater Assault
	[3830] = {GetSpellInfo(44629), 44629}, --Enchant Weapon - Exceptional Spellpower
	[3831] = {GetSpellInfo(47898), 47898}, --Enchant Cloak - Greater Speed
	[3832] = {GetSpellInfo(60692), 60692}, --Enchant Chest - Powerful Stats
	[3833] = {GetSpellInfo(60707), 60707}, --Enchant Weapon - Superior Potency
	[3834] = {GetSpellInfo(60714), 60714}, --Enchant Weapon - Mighty Spellpower
	[3835] = {GetSpellInfo(61117), 61117}, --Master's Inscription of the Axe
	[3836] = {GetSpellInfo(61118), 61118}, --Master's Inscription of the Crag
	[3837] = {GetSpellInfo(61119), 61119}, --Master's Inscription of the Pinnacle
	[3838] = {GetSpellInfo(61120), 61120}, --Master's Inscription of the Storm
	[3839] = {GetSpellInfo(44645), 44645}, --Enchant Ring - Assault
	[3840] = {GetSpellInfo(44636), 44636}, --Enchant Ring - Greater Spellpower
	[3842] = 44701, --Arcanum of the Savage Gladiator (Alliance)
	[3843] = 44739, --Diamond-cut Refractor Scope
	[3844] = {GetSpellInfo(44510), 44510}, --Enchant Weapon - Exceptional Spirit
	[3845] = {GetSpellInfo(44575), 44575}, --Enchant Bracers - Greater Assault
	[3859] = {GetSpellInfo(63765), 63765}, --Springy Arachnoweave
	[3872] = {GetSpellInfo(56039), 56039}, --神圣魔线1
	[3873] = {GetSpellInfo(56034), 56034}, --大师魔线1
	[3875] = {GetSpellInfo(59929), 59929}, --利斧铭文
	[3876] = {GetSpellInfo(59932), 59932}, --巅峰铭文
	[3878] = {GetSpellInfo(67839), 67839}, --Mind Amplification Dish

	-- Cataclysm
	[4061] = 52687, --手套50精通
	[4062] = 52743, --土灵活力
	[4063] = 52744, --胸甲15属性
	[4064] = 52745, --披风70法穿
	[4065] = 52746, --护腕50速度
	[4067] = 52748, --雪崩
	[4068] = 52749, --手套50急速
	[4069] = 52750, --靴子50急速
	[4070] = 52751, --胸甲55耐力
	[4071] = 52752, --护腕50暴击
	[4072] = 52753, --披风30智力
	[4073] = 52754, --盾牌160护甲
	[4074] = 52755, --元素杀手
	[4075] = 52756, --手套35力量
	[4076] = 52757, --鞋子35敏捷
	[4077] = 52758, --胸甲40韧性
	[4078] = {GetSpellInfo(74215), 74215}, --戒指40力量
	[4079] = {GetSpellInfo(74216), 74216}, --戒指40敏捷
	[4080] = {GetSpellInfo(74217), 74217}, --戒指40智力
	[4081] = {GetSpellInfo(74218), 74218}, --戒指40耐力
	[4082] = 52759, --手套50精准
	[4083] = 52760, --飓风
	[4084] = 52761, --心灵之歌
	[4085] = 52762, --盾牌50精通
	[4086] = 52763, --护腕50躲闪
	[4087] = 52764, --披风50暴击
	[4088] = 52765, --胸甲40精神
	[4089] = 52766, --护腕50命中
	[4090] = 52767, --披风250护甲
	[4091] = 52768, --副手40智力
	[4092] = 52769, --鞋子50命中
	[4093] = 52770, --护腕50精神
	[4094] = 52771, --靴子50精通
	[4095] = 52772, --护腕50精准
	[4096] = 52773, --披风50智力
	[4097] = 52774, --能量洪流
	[4098] = 52775, --风行
	[4099] = 52776, --山崩
	[4100] = 52777, --披风65暴击
	[4101] = 52778, --护腕65暴击
	[4102] = 52779, --胸甲20属性
	[4103] = 52780, --胸甲75耐力
	[4104] = 52782, --熔岩行者
	[4105] = 52781, --刺客步伐
	[4106] = 52783, --手套50力量
	[4107] = 52784, --手套65精通
	[4108] = 52785, --护腕65速度
	[4110] = 54450, --强能幽灵魔线
	[4112] = 54449, --幽灵魔线
	[4113] = {GetSpellInfo(75154), 75154}, --大师魔线2
	[4114] = {GetSpellInfo(75155), 75155}, --神圣魔线2
	[4115] = {GetSpellInfo(75172), 75172}, --亮纹刺绣
	[4116] = {GetSpellInfo(75175), 75175}, --黑光刺绣2
	[4118] = {GetSpellInfo(75178), 75178}, --剑刃刺绣2
	[4122] = {GetSpellInfo(78169), 78169}, --焦毁腿甲
	[4124] = {GetSpellInfo(78170), 78170}, --暮光腿甲
	[4126] = 56550, --龙鳞腿甲片
	[4127] = 56551, --焦鳞腿甲
	[4175] = 59594, --侏儒X光瞄准镜
	[4176] = 59595, --+88 Hit Rating (R19 Threatfinder)
	[4177] = 59596, --+88 Ranged Haste Rating (Safety Catch Removal Kit)
	[4189] = {GetSpellInfo(85007), 85007}, --龙人雕饰 - 耐力
	[4190] = {GetSpellInfo(85008), 85008}, --龙人雕饰 - 敏捷
	[4191] = {GetSpellInfo(85009), 85009}, --龙人雕饰 - 力量
	[4192] = {GetSpellInfo(85010), 85010}, --龙人雕饰 - 智力
	[4193] = {GetSpellInfo(86375), 86375}, --迅钢铭文
	[4194] = {GetSpellInfo(86401), 86401}, --狮鬃铭文
	[4195] = {GetSpellInfo(86402), 86402}, --大地公主的铭文
	[4196] = {GetSpellInfo(86403), 86403}, --邪火铭文
	[4198] = 62333, --+75 Stamina and +25 Dodge Rating (Greater Inscription of Unbreakable Quartz)
	[4197] = 62341, --次级不碎石英铭文
	[4199] = 62342, --次级充能磁石铭文
	[4200] = 62343, --+50 Intellect and +25 Haste Rating (Greater Inscription of Charged Lodestone)
	[4201] = 62344, --次级锯缘石铭文
	[4202] = 62345, --+50 Strength and +25 Critical Strike Rating (Greater Inscription of Jagged Stone)
	[4204] = 62346, --+50 Agility and +25 Mastery Rating (Greater Inscription of Shattered Crystal)
	[4205] = 62347, --次级破裂水晶铭文
	[4206] = 62366, --+90 Stamina and 35 Dodge rating (Arcanum of the Earthen Ring)
	[4207] = 62367, --+60 Intellect and 35 Critical Strike rating (Arcanum of Hyjal)
	[4208] = 62422, --+60 Strength and 35 Mastery rating (Arcanum of the Wildhammer - Alliance)
	[4209] = 62369, --+60 Agility and 35 Haste rating (Arcanum of the Ramkahen)
	[4215] = 55055, --Elementium Spike (90-133) (Elementium Shield Spike)
	[4216] = 55056, --Pyrium Spike (210-350) (Pyrium Shield Spike)
	[4217] = 55057, -- (Pyrium Weapon Chain)
	[4227] = 68134, --双手武器130敏捷
	[4256] = 68785, --护腕50力量
	[4257] = 68786, --护腕50智力
	[4258] = 68784, --护腕50敏捷
	[4267] = 70139, --弗林特洛克的土拨鼠瞄准镜
	[4270] = 71720, --龙皮腿甲片
	[4439] = {GetSpellInfo(85068), 85068}, --焦鳞腿甲强化片
	[4440] = {GetSpellInfo(85067), 85067}, --龙骨腿甲强化片
	[5000] = 0
}

--Localize functions
local tonumber, GetItemInfo, GetItemGem, select = tonumber, GetItemInfo, GetItemGem, select
local RED_GEM, YELLOW_GEM, BLUE_GEM, META_GEM = RED_GEM, YELLOW_GEM, BLUE_GEM, META_GEM
--local INVTYPE_FEET INVTYPE_WRIST INVTYPE_CLOAK INVTYPE_SHIELD = INVTYPE_FEET INVTYPE_WRIST INVTYPE_CLOAK INVTYPE_SHIELD
local strgsub = string.gsub
local strmatch = string.match
--Localize tooltips
local ItemRefTooltip, GameTooltip = ItemRefTooltip, GameTooltip
local currentGemLinkTable = {}
local currentGemTextureTable = {}
local icon
local lastlink = "None"

JewelTips.BUTTON_SIZE = 30
--if IDCard then
	JewelTips.BUTTON_OFFSETY = -40
--end
JewelTips.QUESTIONMARK_ICON = "Interface\\Icons\\INV_Misc_QuestionMark"
JewelTips.ENCHANT_ICON = "Interface\\Icons\\Spell_Holy_GreaterHeal"

function JewelTips.enchantIDtoLink(JewelID, equipLoc)
	local index = tonumber(JewelID)
	if not index then return nil end

	local item = JewelTips.Jewels[index]
	if type(item) == "table" and item.multi == true then
		item = item[equipLoc]
	end

	if item and item ~= 0 then
		if type(item) == "number" then
			return select(2, GetItemInfo(item)) or item
		else
			return "|cffffd000|Henchant:"..item[2].."|h["..item[1].."]|h|r"
		end
	else
		return -1 * index --index is negated to show that the number is the original enchantID
	end
end

function JewelTips.JewelColor(itemLink)
	local subtype = select(7,GetItemInfo( itemLink ))
	local colorString

	if subtype == BLUE_GEM then
		colorString = "0000ff"
	elseif subtype == RED_GEM then
		colorString = "ff0000"
	elseif subtype == YELLOW_GEM then
		colorString = "ffff00"
	elseif subtype == "紫色" then
		colorString = "8000ff"
	elseif subtype == "橙色" then
		colorString = "ff8040"
	elseif subtype == "绿色" then
		colorString = "00ff00"
	elseif subtype == META_GEM then
		colorString = "aaaaaa"
	else
		colorString = "ffffff"
	end

	return " (|cff"..colorString..subtype.."|r)"
end

-- Shared Button Functions
local function gemButton_OnClick(self)
	if IsShiftKeyDown() then
		if WIM_EditBoxInFocus then
			WIM_EditBoxInFocus:Insert(self.link);
		elseif ChatFrame1EditBox:IsVisible() then
			ChatFrame1EditBox:Insert(self.link);
		end
	end
end

--This function is only used for gemButtons not used for the enchantButton
local function gemButton_OnEnter(self)
	if self.link then
		local linknum = tonumber(self.link)
		if (not linknum) then
			--self.link is an itemLink
			GameTooltip:SetOwner(self, JewelTips.TOOLTIP_ANCHOR, JewelTips.TOOLTIP_ANCHOR_OFFSETX, JewelTips.TOOLTIP_ANCHOR_OFFSETY)
			GameTooltip:SetHyperlink(self.link)
			GameTooltip:Show()
		elseif (linknum > 0) then
			--self.link is an itemID
			GameTooltip:SetOwner(self, JewelTips.TOOLTIP_ANCHOR, JewelTips.TOOLTIP_ANCHOR_OFFSETX, JewelTips.TOOLTIP_ANCHOR_OFFSETY)
			GameTooltip:SetHyperlink("item:"..self.link)
			GameTooltip:Show()
		end
	end
end
--/script JewelTips.MoveButtons("top")
local enchantButton = CreateFrame("Button",nil,ItemRefTooltip)
local gem1Button = CreateFrame("Button",nil,ItemRefTooltip)
local gem2Button = CreateFrame("Button",nil,ItemRefTooltip)
local gem3Button = CreateFrame("Button",nil,ItemRefTooltip)

local gemButtonTable = {enchantButton, gem1Button, gem2Button, gem3Button}

for index, gemButton in pairs(gemButtonTable) do
	gemButton:SetWidth(JewelTips.BUTTON_SIZE)
	gemButton:SetHeight(JewelTips.BUTTON_SIZE)
	gemButton:SetScript("OnClick", gemButton_OnClick)
	gemButton:SetScript("OnEnter", gemButton_OnEnter)
	gemButton:SetScript("OnLeave", function() GameTooltip:Hide() end)
	gemButton.gemIndex = index - 1
	gemButton:Hide()
end

local function ClearButtons()
	for _, gemButton in pairs(gemButtonTable) do
		gemButton:Hide()
	end
end

function JewelTips:MoveButtons(side)
	if side == "top" then
		self.TOOLTIP_ANCHOR = "ANCHOR_TOPLEFT"
		self.TOOLTIP_ANCHOR_OFFSETX = 0
		self.TOOLTIP_ANCHOR_OFFSETY = 0
		for index, gemButton in pairs(gemButtonTable) do
			gemButton:ClearAllPoints()
			gemButton:SetPoint("BOTTOMLEFT", ItemRefTooltip, "TOPLEFT", 2+(self.BUTTON_SIZE * (index-1)), 0 )
		end
	elseif side == "bottom" then
		self.TOOLTIP_ANCHOR = "ANCHOR_BOTTOMRIGHT"
		self.TOOLTIP_ANCHOR_OFFSETX = -1*(self.BUTTON_SIZE+2)
		self.TOOLTIP_ANCHOR_OFFSETY = 0
		for index, gemButton in pairs(gemButtonTable) do
			gemButton:ClearAllPoints()
			gemButton:SetPoint("TOPLEFT", ItemRefTooltip, "BOTTOMLEFT", 2+(self.BUTTON_SIZE * (index-1)), 0 )
		end
	elseif side == "left" then
		self.TOOLTIP_ANCHOR = "ANCHOR_BOTTOMLEFT"
		self.TOOLTIP_ANCHOR_OFFSETX = 0
		self.TOOLTIP_ANCHOR_OFFSETY = self.BUTTON_SIZE+2
		for index, gemButton in pairs(gemButtonTable) do
			gemButton:ClearAllPoints()
			gemButton:SetPoint("TOPRIGHT", ItemRefTooltip, "TOPLEFT", 0, self.BUTTON_OFFSETY - (self.BUTTON_SIZE * (index-1)) )
		end
	elseif side == "right" then
		self.TOOLTIP_ANCHOR = "ANCHOR_BOTTOMRIGHT"
		self.TOOLTIP_ANCHOR_OFFSETX = 0
		self.TOOLTIP_ANCHOR_OFFSETY = self.BUTTON_SIZE+2
		for index, gemButton in pairs(gemButtonTable) do
			gemButton:ClearAllPoints()
			gemButton:SetPoint("TOPLEFT", ItemRefTooltip, "TOPRIGHT", 0, self.BUTTON_OFFSETY - (self.BUTTON_SIZE *(index-1)) )
		end
	end
end

JewelTips:MoveButtons("left")

--Main Routine------------------------------------------
local function addEnchantLines(tooltip, link)
	--For some tooltips, this Main function will be called continuously. This code keeps us from doing unnecessary work after the first time.
	if link ~= lastlink then--Reuse data from the last call since the tooltip link is the same
		currentGemLinkTable[1], currentGemLinkTable[2], currentGemLinkTable[3], currentGemLinkTable[4] = string.match(link, "item:%d+:(%d+):(%d+):(%d+):(%d+):")

		for index, gemLink in pairs(currentGemLinkTable) do
			if gemLink == "0" then
				currentGemLinkTable[index] = nil
			else
				--Check for an item corresponding to the enchantID
				if index == 1 then
					currentGemLinkTable[1] = JewelTips.enchantIDtoLink(gemLink, select(9, GetItemInfo(link)))
				else
					local newGemLink = select(2,GetItemGem(link, gemButtonTable[index].gemIndex))
					if newGemLink then
						currentGemLinkTable[index] = newGemLink
						currentGemTextureTable[index] = GetItemIcon( currentGemLinkTable[index] )
					else
						currentGemLinkTable[index] = gemLink
						currentGemTextureTable[index] = JewelTips.QUESTIONMARK_ICON
					end
				end
			end
		end
		lastlink = link
	end

	--Add tooltip lines
	for index, gemLink in pairs(currentGemLinkTable) do
		if index == 1 then
			if type(gemLink) == "number" then
				if gemLink < 0 then
					tooltip:AddLine( string.format("[未知附魔: %d]".." (|cffffffff".."附魔".."|r)", -1 * gemLink) )
				else
					tooltip:AddLine( string.format("[不安全链接: %d]".." (|cffffffff".."附魔".."|r)", gemLink) )
					lastlink = "None"
				end
				tooltip:AddTexture(JewelTips.QUESTIONMARK_ICON)
			else
				tooltip:AddLine( gemLink .. " (|cffffffff".."附魔".."|r)")
				if strmatch( gemLink, "Henchant:" ) then
					tooltip:AddTexture(JewelTips.ENCHANT_ICON)
				else
					tooltip:AddTexture(GetItemIcon(gemLink) or JewelTips.QUESTIONMARK_ICON)
				end
			end
		else
			if tonumber(gemLink) then
				lastlink = "None"
			else
				tooltip:AddLine(gemLink .. JewelTips.JewelColor(gemLink))
				tooltip:AddTexture(currentGemTextureTable[index])
			end
		end
	end

	tooltip:Show()
end

local function updateItemRefButtons(link)
	--Show/Hide the Buttons for each Gem
	for index, gemButton in pairs(gemButtonTable) do
		gemButton.link = currentGemLinkTable[index]
		if gemButton.link then
			if type(gemButton.link) == "number" then
				gemButton:SetNormalTexture(JewelTips.QUESTIONMARK_ICON)
			else
				icon = select( 10, GetItemInfo( gemButton.link ) )
				gemButton:SetNormalTexture(icon or JewelTips.ENCHANT_ICON)
			end
			gemButton:Show()
		else
			gemButton:Hide()
		end
	end
end

--Thanks to Tekkub for his beautifully simple tekKompare code from which some of this is borrowed
local Orig_GameTooltip_OnTooltipSetItem = GameTooltip:GetScript("OnTooltipSetItem")
GameTooltip:SetScript("OnTooltipSetItem", function(tooltip, ...)
	assert(tooltip, "arg 1 is nil, someone isn't hooking correctly")

	local _, link = tooltip:GetItem()

	--Check if the tooltip is one of our Jewel tooltips
	for _, gemButton in pairs(gemButtonTable) do
		if tooltip:IsOwned(gemButton) then
			-- If we're setting the link for our enchantbutton, check that the icon is good
			local linknum = tonumber(gemButton.link)
			if (linknum and linknum > 0) then
				local _, itemRefItem = ItemRefTooltip:GetItem()
				ItemRefTooltip:ClearLines()
				SetItemRef(itemRefItem)
				addEnchantLines(ItemRefTooltip, link)
				ItemRefTooltip:Show()
				_, gemButton.link, _, _, _, _, _, _, _, icon = GetItemInfo( linknum )
				gemButton:SetNormalTexture(icon)
			end
			return Orig_GameTooltip_OnTooltipSetItem(tooltip, ...)
		end
	end

--	if not ShoppingTooltip1:IsVisible() then SetTips(link, frame, ShoppingTooltip1, ShoppingTooltip2) end
	if link then
		addEnchantLines(tooltip, link)
	end
	if Orig_GameTooltip_OnTooltipSetItem then return Orig_GameTooltip_OnTooltipSetItem(tooltip, ...) end
end)

local Orig_ItemRefTooltip_OnTooltipSetItem = ItemRefTooltip:GetScript("OnTooltipSetItem")
ItemRefTooltip:SetScript("OnTooltipSetItem", function(tooltip, ...)
	assert(tooltip, "arg 1 is nil, someone isn't hooking correctly")

	local _, link = tooltip:GetItem()
	if link then
		addEnchantLines(tooltip, link)
		updateItemRefButtons(link)
--	else
--		ClearButtons()
	end
	if Orig_ItemRefTooltip_OnTooltipSetItem then return Orig_ItemRefTooltip_OnTooltipSetItem(tooltip, ...) end
end)

local Orig_ItemRefTooltip_OnTooltipCleared = ItemRefTooltip:GetScript("OnTooltipCleared")
ItemRefTooltip:SetScript("OnTooltipCleared", function(...)
	ClearButtons()

	if Orig_ItemRefTooltip_OnTooltipCleared then return Orig_ItemRefTooltip_OnTooltipCleared(...) end
end)
