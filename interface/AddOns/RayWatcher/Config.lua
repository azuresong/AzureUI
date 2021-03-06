﻿       -----------------------------------------------------------------------------------------------------
-- name = "目标debuff",
-- setpoint = { "BOTTOMRIGHT", UI_Parent, "CENTER", 300, -152 },
-- direction = "UP",
-- iconSide = "LEFT",
-- mode = "BAR", 
-- size = 24,
-- barWidth = 170,				
--	{spellID = 8050, unitId = "target", caster = "target", filter = "DEBUFF"},
--	{ spellID = 18499, filter = "CD" },
--	{ itemID = 56285, filter = "itemCD" },
---------------------------------------------------------------------------------------------------
--local R, C = unpack(RayUI)
local _, ns = ...

ns.font = "FONTS\\FRIZQT__.ttf"
ns.fontsize = 12
ns.fontflag = "OUTLINE"

ns.watchers ={
	["DRUID"] = {
            {
                name = "玩家buff",
                direction = "LEFT",
                setpoint = { "BOTTOMRIGHT", "oUF_FreebPlayer", "TOPRIGHT",-50, 80 },
                size = 28,

                --生命之花
                { spellID = 33763, unitId = "player", caster = "player", filter = "BUFF" },
                --回春術
                { spellID = 774, unitId = "player", caster = "player", filter = "BUFF" },
                --癒合
                { spellID = 8936, unitId = "player", caster = "player", filter = "BUFF" },
            },
            {
                name = "目标buff",
                direction = "RIGHT",
                setpoint = { "BOTTOMLEFT", "oUF_FreebTarget", "TOPLEFT", 50, 80 },
                size = 28,

                --生命之花
                { spellID = 33763, unitId = "target", caster = "player", filter = "BUFF" },
                --回春術
                { spellID = 774, unitId = "target", caster = "player", filter = "BUFF" },
                --癒合
                { spellID = 8936, unitId = "target", caster = "player", filter = "BUFF" },

            },
            {
                name = "玩家重要buff",
                direction = "LEFT",
                setpoint = { "BOTTOMRIGHT", "oUF_FreebPlayer", "TOPRIGHT", 0, 33 },
                size = 38,

                --蝕星蔽月(月蝕)
                { spellID = 48518, unitId = "player", caster = "player", filter = "BUFF" },
                --蝕星蔽月(日蝕)
                { spellID = 48517, unitId = "player", caster = "player", filter = "BUFF" },
                --流星
                { spellID = 93400, unitId = "player", caster = "player", filter = "BUFF" },
                --兇蠻咆哮
                { spellID = 52610, unitId = "player", caster = "player", filter = "BUFF" },
                { spellID = 127538, unitId = "player", caster = "player", filter = "BUFF" },
                --求生本能
                { spellID = 61336, unitId = "player", caster = "player", filter = "BUFF" },
                --生命之樹
                { spellID = 33891, unitId = "player", caster = "player", filter = "BUFF" },
                --節能施法
                { spellID = 16870, unitId = "player", caster = "player", filter = "BUFF" },
                --啟動
                { spellID = 29166, unitId = "player", caster = "all", filter = "BUFF" },
                --樹皮術
                { spellID = 22812, unitId = "player", caster = "player", filter = "BUFF" },
                --狂暴
                { spellID = 50334, unitId = "player", caster = "player", filter = "BUFF" },
                --狂暴恢復
                { spellID = 22842, unitId = "player", caster = "player", filter = "BUFF" },
                --共生
                { spellID = 100977, unitId = "player", caster = "player", filter = "BUFF" },

            },
            {
                name = "目标debuff",
                direction = "RIGHT",
                setpoint = { "BOTTOMLEFT", "oUF_FreebTarget", "TOPLEFT", 0, 33 },
                size = 38,

                --休眠
                { spellID = 2637, unitId = "target", caster = "all", filter = "DEBUFF" },
                --糾纏根鬚
                { spellID = 339, unitId = "target", caster = "all", filter = "DEBUFF" },
                --颶風術
                { spellID = 33786, unitId = "target", caster = "all", filter = "DEBUFF" },
                --月火術
                { spellID = 8921, unitId = "target", caster = "player", filter = "DEBUFF" },
                --日炎術
                { spellID = 93402, unitId = "target", caster = "player", filter = "DEBUFF" },
                --蟲群
                { spellID = 5570, unitId = "target", caster = "player", filter = "DEBUFF" },
                --掃擊
                { spellID = 1822, unitId = "target", caster = "player", filter = "DEBUFF" },
                --撕扯
                { spellID = 1079, unitId = "target", caster = "player", filter = "DEBUFF" },
                --割裂
                { spellID = 33745, unitId = "target", caster = "player", filter = "DEBUFF" },
                --血襲
                { spellID = 9007, unitId = "target", caster = "player", filter = "DEBUFF" },
                --割碎
                { spellID = 33876, unitId = "target", caster = "player", filter = "DEBUFF" },
                { spellID = 33878, unitId = "target", caster = "player", filter = "DEBUFF" },
                --精靈之火
                { spellID = 770, unitId = "target", caster = "all", filter = "DEBUFF" },
            },
            {
                name = "焦点debuff",
                direction = "UP",
                setpoint = { "BOTTOMLEFT", "oUF_FreebFocus", "TOPLEFT", 0, 10 },
                size = 24,
                mode = "BAR",
                iconSide = "LEFT",
                barWidth = 170,

                --休眠
                { spellID = 2637, unitId = "focus", caster = "all", filter = "DEBUFF" },
                --糾纏根鬚
                { spellID = 339, unitId = "focus", caster = "all", filter = "DEBUFF" },
                --颶風術
                { spellID = 33786, unitId = "focus", caster = "all", filter = "DEBUFF" },
            },
           
        },
        ["HUNTER"] = {
            {
                name = "玩家buff",
                direction = "LEFT",
                setpoint = { "BOTTOMRIGHT", "oUF_FreebPlayer", "TOPRIGHT",-50, 80 },
                size = 28,

                --狙擊訓練
                { spellID = 64420, unitId = "player", caster = "player", filter = "BUFF" },
                --射擊!
                { spellID = 82926, unitId = "player", caster = "player", filter = "BUFF" },
            },
            {
                name = "目标buff",
                direction = "RIGHT",
                setpoint = { "BOTTOMLEFT", "oUF_FreebTarget", "TOPLEFT", 50, 80 },
                size = 28,

                --獵人印記
                { spellID = 1130, unitId = "target", caster = "all", filter = "DEBUFF" },

            },
            {
                name = "玩家重要buff",
                direction = "LEFT",
                setpoint = { "BOTTOMRIGHT", "oUF_FreebPlayer", "TOPRIGHT", 0, 33 },
                size = 38,

                --誤導
                { spellID = 34477, unitId = "player", caster = "player", filter = "BUFF" },
                { spellID = 35079, unitId = "player", caster = "player", filter = "BUFF" },
                --蓄勢待發
                { spellID = 56453, unitId = "player", caster = "player", filter = "BUFF" },
                --快速射擊
                { spellID = 6150, unitId = "player", caster = "player", filter = "BUFF" },
                --戰術大師
                { spellID = 34837, unitId = "player", caster = "player", filter = "BUFF" },
                --強化穩固射擊
                { spellID = 53224, unitId = "player", caster = "player", filter = "BUFF" },
                --急速射擊
                { spellID = 3045, unitId = "player", caster = "player", filter = "BUFF" },
                --治療寵物
                { spellID = 136, unitId = "pet", caster = "player", filter = "BUFF" },
                --強化穩固射擊
                { spellID = 53220, unitId = "player", caster = "player", filter = "BUFF" },
                --連環火網
                { spellID = 82921, unitId = "player", caster = "player", filter = "BUFF" },
                --準備、就緒、瞄準……
                { spellID = 82925, unitId = "player", caster = "player", filter = "BUFF" },
                --狂亂效果
                { spellID = 19615, unitId = "pet", caster = "pet", filter = "BUFF" },
                --獸心
                { spellID = 34471, unitId = "player", caster = "player", filter = "BUFF" },
                --4T13
                { spellID = 105919, unitId = "player", caster = "player", filter = "BUFF" },
 

            },
            {
                name = "目标debuff",
                direction = "RIGHT",
                setpoint = { "BOTTOMLEFT", "oUF_FreebTarget", "TOPLEFT", 0, 33 },
                size = 38,

                --翼龍釘刺
                { spellID = 19386, unitId = "target", caster = "all", filter = "DEBUFF" },
                --沉默射擊
                { spellID = 34490, unitId = "target", caster = "all", filter = "DEBUFF" },
                --毒蛇釘刺
                { spellID = 118253, unitId = "target", caster = "player", filter = "DEBUFF" },
                --寡婦毒液
                { spellID = 82654, unitId = "target", caster = "all", filter = "DEBUFF" },
                --黑蝕箭
                { spellID = 3674, unitId = "target", caster = "player", filter = "DEBUFF" },
                --爆裂射擊
                { spellID = 53301, unitId = "target", caster = "player", filter = "DEBUFF" },
            },
            {
                name = "焦点debuff",
                direction = "UP",
                setpoint = { "BOTTOMLEFT", "oUF_FreebFocus", "TOPLEFT", 0, 10 },
                size = 24,
                mode = "BAR",
                iconSide = "LEFT",
                barWidth = 170,

                --翼龍釘刺
                { spellID = 19386, unitId = "focus", caster = "all", filter = "DEBUFF" },
                --沉默射擊
                { spellID = 34490, unitId = "focus", caster = "all", filter = "DEBUFF" },
            },
        
        },
        ["MAGE"] = {
            {
                name = "玩家重要buff&debuff",
                direction = "LEFT",
                setpoint = { "BOTTOMRIGHT", "oUF_FreebPlayer", "TOPRIGHT", 0, 33 },
                size = 38,

                --冰霜之指
                { spellID = 44544, unitId = "player", caster = "player", filter = "BUFF" },
                --焦炎之痕
                { spellID = 48108, unitId = "player", caster = "player", filter = "BUFF" },
                --飛彈彈幕
                { spellID = 79683, unitId = "player", caster = "player", filter = "BUFF" },
                --秘法強化
                { spellID = 12042, unitId = "player", caster = "player", filter = "BUFF" },
                --秘法衝擊
                { spellID = 36032, unitId = "player", caster = "player", filter = "DEBUFF" },
                --寒冰護體
                { spellID = 11426, unitId = "player", caster = "player", filter = "BUFF" },
                --2T13效果
                { spellID = 105785, unitId = "player", caster = "player", filter = "BUFF" },
            },
            {
                name = "目标debuff",
                direction = "RIGHT",
                setpoint = { "BOTTOMLEFT", "oUF_FreebTarget", "TOPLEFT", 0, 33 },
                size = 38,

                --變形術
                { spellID = 118, unitId = "target", caster = "all", filter = "DEBUFF" },
                --龍之吐息
                { spellID = 31661, unitId = "target", caster = "all", filter = "DEBUFF" },
                --衝擊波
                { spellID = 11113, unitId = "target", caster = "all", filter = "DEBUFF" },
                --減速術
                { spellID = 31589, unitId = "target", caster = "player", filter = "DEBUFF" },
                --燃火
                { spellID = 83853, unitId = "target", caster = "player", filter = "DEBUFF" },
                --點燃
                { spellID = 12654, unitId = "target", caster = "player", filter = "DEBUFF" },
                --活體爆彈
                { spellID = 44457, unitId = "target", caster = "player", filter = "DEBUFF" },
				--奥术炸弹
				{ spellID = 114923, unitId = "target", caster = "player", filter = "DEBUFF" },
                --炎爆術
                { spellID = 11366, unitId = "target", caster = "player", filter = "DEBUFF" },
                --極度冰凍
                { spellID = 44572, unitId = "target", caster = "player", filter = "DEBUFF"},
            },
            {
                name = "焦点debuff",
                direction = "UP",
                setpoint = { "BOTTOMLEFT", "oUF_FreebFocus", "TOPLEFT", 0, 10 },
                size = 24,
                mode = "BAR",
                iconSide = "LEFT",
                barWidth = 170,

                --變形術
                { spellID = 118, unitId = "focus", caster = "all", filter = "DEBUFF" },
                --活體爆彈
                { spellID = 44457, unitId = "focus", caster = "player", filter = "DEBUFF" },
            },

        },
        ["WARRIOR"] = {
            {
                name = "玩家重要buff",
                direction = "LEFT",
                setpoint = { "BOTTOMRIGHT", "oUF_FreebPlayer", "TOPRIGHT", 0, 33 },
                size = 38,

                --驟亡
                { spellID = 52437, unitId = "player", caster = "player", filter = "BUFF" },
                --沉著殺機
                { spellID = 85730, unitId = "player", caster = "player", filter = "BUFF" },
                --狂暴之怒
                { spellID = 18499, unitId = "player", caster = "player", filter = "BUFF" },
                --魯莽
                { spellID = 1719, unitId = "player", caster = "player", filter = "BUFF" },
                --熱血沸騰
                { spellID = 46916, unitId = "player", caster = "player", filter = "BUFF" },
                --劍盾合璧
                { spellID = 50227, unitId = "player", caster = "player", filter = "BUFF" },
                --蓄血
                { spellID = 64568, unitId = "player", caster = "player", filter = "BUFF" },
                --法術反射
                { spellID = 23920, unitId = "player", caster = "player", filter = "BUFF" },
                --勝利衝擊
                { spellID = 34428, unitId = "player", caster = "player", filter = "BUFF" },
                --盾牌格擋
                { spellID = 2565, unitId = "player", caster = "player", filter = "BUFF" },
                --盾墻
                { spellID = 871, unitId = "player", caster = "player", filter = "BUFF" },
                --狂怒恢復
                { spellID = 55694, unitId = "player", caster = "player", filter = "BUFF" },
                --橫掃攻擊
                { spellID = 12328, unitId = "player", caster = "player", filter = "BUFF" },
            },
            {
                name = "目标debuff",
                direction = "RIGHT",
                setpoint = { "BOTTOMLEFT", "oUF_FreebTarget", "TOPLEFT", 0, 33 },
                size = 38,

                --震盪波
                { spellID = 46968, unitId = "target", caster = "all", filter = "DEBUFF" },
                -- 斷筋
                { spellID = 1715, unitId = "target", caster = "all", filter = "DEBUFF" },
                --雷霆一擊
                { spellID = 6343, unitId = "target", caster = "player", filter = "DEBUFF" },
                --挫志怒吼
                { spellID = 1160, unitId = "target", caster = "player", filter = "DEBUFF" },
                --破膽怒吼
                { spellID = 5246, unitId = "target", caster = "player", filter = "DEBUFF" },
                --破甲（盜賊）
                { spellID = 8647, unitId = "target", caster = "player", filter = "DEBUFF" },
                --感染之傷（德魯伊）
                { spellID = 48484, unitId = "target", caster = "all", filter = "DEBUFF" },
                --挫志咆哮（德魯伊）
                { spellID = 99, unitId = "target", caster = "all", filter = "DEBUFF" },
            },
        },
        ["SHAMAN"] = {
            {
                name = "玩家buff",
                direction = "LEFT",
                setpoint = { "BOTTOMRIGHT", "oUF_FreebPlayer", "TOPRIGHT",-50, 80 },
                size = 28,

                --Earth Shield / Erdschild
                { spellID = 974, unitId = "player", caster = "player", filter = "BUFF" },
                --Riptide / Springflut
                { spellID = 61295, unitId = "player", caster = "player", filter = "BUFF" },
                --Lightning Shield / Blitzschlagschild
                { spellID = 324, unitId = "player", caster = "player", filter = "BUFF" },
                --Water Shield / Wasserschild
                { spellID = 52127, unitId = "player", caster = "player", filter = "BUFF" },

            },
            {
                name = "目标buff",
                direction = "RIGHT",
                setpoint = { "BOTTOMLEFT", "oUF_FreebTarget", "TOPLEFT", 50, 80 },
                size = 28,

                --Earth Shield / Erdschild
                { spellID = 974, unitId = "target", caster = "player", filter = "BUFF" },
                --Riptide / Springflut
                { spellID = 61295, unitId = "target", caster = "player", filter = "BUFF" },

            },
            {
                name = "玩家重要buff",
                direction = "LEFT",
                setpoint = { "BOTTOMRIGHT", "oUF_FreebPlayer", "TOPRIGHT", 0, 33 },
                size = 38,

                --Maelstorm Weapon / Waffe des Mahlstroms
                { spellID = 53817, unitId = "player", caster = "player", filter = "BUFF" },
                --Shamanistic Rage / Schamanistische Wut
                { spellID = 30823, unitId = "player", caster = "player", filter = "BUFF" },
                --Clearcasting / Freizaubern
                { spellID = 16246, unitId = "player", caster = "player", filter = "BUFF" },

            },
            {
                name = "目标debuff",
                direction = "RIGHT",
                setpoint = { "BOTTOMLEFT", "oUF_FreebTarget", "TOPLEFT", 0, 33 },
                size = 38,

                --Hex / Verhexen
                { spellID = 51514, unitId = "target", caster = "all", filter = "DEBUFF" },
                --Bind Elemental / Elementar binden
                { spellID = 76780, unitId = "target", caster = "all", filter = "DEBUFF" },
                --Storm Strike / Sturmschlag
                { spellID = 17364, unitId = "target", caster = "player", filter = "DEBUFF" },
                --Earth Shock / Erdschock
                { spellID = 8042, unitId = "target", caster = "player", filter = "DEBUFF" },
                --Frost Shock / Frostschock
                { spellID = 8056, unitId = "target", caster = "player", filter = "DEBUFF" },
                --Flame Shock / Flammenschock
                { spellID = 8050, unitId = "target", caster = "player", filter = "DEBUFF" },

            },
            {
                name = "焦点debuff",
                direction = "UP",
                setpoint = { "BOTTOMLEFT", "oUF_FreebFocus", "TOPLEFT", 0, 10 },
                size = 24,
                mode = "BAR",
                iconSide = "LEFT",
                barWidth = 170,

                --Hex / Verhexen
                { spellID = 51514, unitId = "focus", caster = "all", filter = "DEBUFF" },
                --Bind Elemental / Elementar binden
                { spellID = 76780, unitId = "focus", caster = "all", filter = "DEBUFF" },

            },
        },
        ["PALADIN"] = {
            {
                name = "玩家buff",
                direction = "LEFT",
				tooltip = false,
                setpoint = { "BOTTOMRIGHT", "oUF_FreebPlayer", "TOPRIGHT",-50, 80 },
                size = 28,

                --聖光信標
                { spellID = 53563, unitId = "player", caster = "player", filter = "BUFF" },
                --回蓝饰品
				{ spellID = 138856, unitId = "player", caster = "player", filter = "BUFF" },
            },
            {
                name = "目标buff",
                direction = "RIGHT",
				tooltip = false,
                setpoint = { "BOTTOMLEFT", "oUF_FreebTarget", "TOPLEFT", 50, 80 },
                size = 28,

                --聖光信標
                { spellID = 53563, unitId = "target", caster = "player", filter = "BUFF" },
            },
            {
                name = "玩家重要buff",
                direction = "LEFT",
				tooltip = true,
                setpoint = { "BOTTOMRIGHT", "oUF_FreebPlayer", "TOPRIGHT", 0, 33 },
                size = 38,

                --神聖之盾
                { spellID = 20925, unitId = "player", caster = "player", filter = "BUFF" },
                --神性祈求
                { spellID = 54428, unitId = "player", caster = "player", filter = "BUFF" },
                --神恩術
                { spellID = 31842, unitId = "player", caster = "player", filter = "BUFF" },
                --異端審問
                { spellID = 84963, unitId = "player", caster = "player", filter = "BUFF" },
                --破曉之光
                { spellID = 88819, unitId = "player", caster = "player", filter = "BUFF" },
                --聖光灌注
                { spellID = 54149, unitId = "player", caster = "player", filter = "BUFF" },
                --聖佑術
                { spellID = 498, unitId = "player", caster = "player", filter = "BUFF" },
                --戰爭藝術
                { spellID = 59578, unitId = "player", caster = "player", filter = "BUFF" },
                --復仇之怒
                { spellID = 31884, unitId = "player", caster = "player", filter = "BUFF" },
                --精通光環
                { spellID = 31821, unitId = "player", caster = "player", filter = "BUFF" },
				--Selfless Healer
				{ spellID = 114250, unitId = "player", caster = "player", filter = "BUFF" },
				--Holy Avenger
				{ spellID = 105809, unitId = "player", caster = "player", filter = "BUFF" },
            },
            {
                name = "目标debuff",
                direction = "RIGHT",
                setpoint = { "BOTTOMLEFT", "oUF_FreebTarget", "TOPLEFT", 0, 33 },
                size = 38,

                --制裁之錘
                { spellID = 853, unitId = "target", caster = "all", filter = "DEBUFF" },
				--eternal flame
				{ spellID = 114163, unitId = "target", caster = "all", filter = "BUFF" },
            },
            {
                name = "焦点debuff",
                direction = "UP",
                setpoint = { "BOTTOMLEFT", "oUF_FreebFocus", "TOPLEFT", 0, 10 },
                size = 24,
                mode = "BAR",
                iconSide = "LEFT",
                barWidth = 170,

                --制裁之錘
                { spellID = 853, unitId = "focus", caster = "all", filter = "DEBUFF" },

            },
           
        },
        ["PRIEST"] = {
            {
                name = "玩家buff&debuff",
                direction = "LEFT",
                setpoint = { "BOTTOMRIGHT", "oUF_FreebPlayer", "TOPRIGHT",-50, 80 },
                size = 28,

                --真言術：盾
                { spellID = 17, unitId = "player", caster = "all", filter = "BUFF" },
                --漸隱術
                { spellID = 586, unitId = "player", caster = "player", filter = "BUFF" },
                --防護恐懼結界
                { spellID = 6346, unitId = "player", caster = "all", filter = "BUFF" },
                --心靈意志
                { spellID = 73413, unitId = "player", caster = "player", filter = "BUFF" },
                --大天使
                { spellID = 81700, unitId = "player", caster = "player", filter = "BUFF" },
                --黑天使
                { spellID = 87153, unitId = "player", caster = "player", filter = "BUFF" },
                --虚弱靈魂
                { spellID = 6788, unitId = "player", caster = "all", filter = "DEBUFF" },
                --預支時間
                { spellID = 59889, unitId = "player", caster = "player", filter = "BUFF" },
            },
            {
                name = "目标buff",
                direction = "RIGHT",
                setpoint = { "BOTTOMLEFT", "oUF_FreebTarget", "TOPLEFT", 50, 80 },
                size = 28,

                --愈合祷言
                { spellID = 41635, unitId = "target", caster = "player", filter = "BUFF" },
                --守护之魂
                { spellID = 47788, unitId = "target", caster = "player", filter = "BUFF" },
                --痛苦镇压
                { spellID = 33206, unitId = "target", caster = "player", filter = "BUFF" },
                --真言术：盾
                { spellID = 17, unitId = "target", caster = "player", filter = "BUFF" },
                --恢复
                { spellID = 139, unitId = "target", caster = "player", filter = "BUFF" },
                --恩典
                { spellID = 77613, unitId = "target", caster = "player", filter = "BUFF" },
                --恩典
                { spellID = 6788, unitId = "target", caster = "all", filter = "DEBUFF" },
            },
            {
                name = "玩家重要buff",
                direction = "LEFT",
                setpoint = { "BOTTOMRIGHT", "oUF_FreebPlayer", "TOPRIGHT", 0, 33 },
                size = 38,

                --機緣回復
                { spellID = 63735, unitId = "player", caster = "player", filter = "BUFF" },
                --暗影寶珠
                { spellID = 77487, unitId = "player", caster = "player", filter = "BUFF" },
                --佈道
                { spellID = 81661, unitId = "player", caster = "player", filter = "BUFF" },
                --影散
                { spellID = 47585, unitId = "player", caster = "player", filter = "BUFF" },
                --真言術：壁
                { spellID = 81782 , unitId = "player", caster = "all", filter = "BUFF" },
                --2T12效果
                { spellID = 99132,  unitId = "player", caster = "player", filter = "BUFF" },
                --神聖洞察
                { spellID = 123266,  unitId = "player", caster = "player", filter = "BUFF" },
            },
            {
                name = "目标debuff",
                direction = "RIGHT",
                setpoint = { "BOTTOMLEFT", "oUF_FreebTarget", "TOPLEFT", 0, 33 },
                size = 38,

                --束縛不死生物
                { spellID = 9484, unitId = "target", caster = "all", filter = "DEBUFF" },
                --心靈尖嘯
                { spellID = 8122, unitId = "target", caster = "all", filter = "DEBUFF" },
                --暗言術:痛
                { spellID = 589, unitId = "target", caster = "player", filter = "DEBUFF" },
                --噬靈瘟疫
                { spellID = 2944, unitId = "target", caster = "player", filter = "DEBUFF" },
                --吸血之觸
                { spellID = 34914, unitId = "target", caster = "player", filter = "DEBUFF" },
                --心靈恐慌
                { spellID = 64044, unitId = "player", caster = "all", filter = "DEBUFF" },
                --心靈恐慌（繳械效果）
                { spellID = 64058, unitId = "player", caster = "all", filter = "DEBUFF" },
                --精神控制
                { spellID = 605, unitId = "player", caster = "all", filter = "DEBUFF" },
                --沉默
                { spellID = 15487, unitId = "player", caster = "all", filter = "DEBUFF" },
            },
            {
                name = "焦点debuff",
                direction = "UP",
                setpoint = { "BOTTOMLEFT", "oUF_FreebFocus", "TOPLEFT", 0, 10 },
                size = 24,
                mode = "BAR",
                iconSide = "LEFT",
                barWidth = 170,

                --束縛不死生物
                { spellID = 9484, unitId = "focus", caster = "all", filter = "DEBUFF" },
                --心靈尖嘯
                { spellID = 8122, unitId = "focus", caster = "all", filter = "DEBUFF" },
            },
         
        },
        ["WARLOCK"]={
            {
                name = "目标buff",
                direction = "RIGHT",
                setpoint = { "BOTTOMLEFT", "oUF_FreebTarget", "TOPLEFT", 50, 80 },
                size = 28,

                --元素詛咒
                { spellID = 1490, unitId = "target", caster = "player", filter = "DEBUFF" },
            },
            {
                name = "目标debuff",
                setpoint = { "BOTTOMLEFT", "oUF_FreebTarget", "TOPLEFT", 0, 33 },
                direction = "RIGHT",
                mode = "ICON",
                size = 38,

                --恐懼術
                { spellID = 5782, unitId = "target", caster = "player", filter = "DEBUFF" },
                --放逐術
                { spellID = 710, unitId = "target", caster = "player", filter = "DEBUFF" },
                --疲勞詛咒
                { spellID = 18223, unitId = "target", caster = "player", filter = "DEBUFF" },
                --腐蝕術
                { spellID = 172, unitId = "target", caster = "player", filter = "DEBUFF" },
                --獻祭
                { spellID = 348, unitId = "target", caster = "player", filter = "DEBUFF" },
                --痛苦災厄
                { spellID = 980, unitId = "target", caster = "player", filter = "DEBUFF" },
                --末日災厄
                { spellID = 603, unitId = "target", caster = "player", filter = "DEBUFF" },
                --痛苦動盪
                { spellID = 30108, unitId = "target", caster = "player", filter = "DEBUFF" },
                --蝕魂術
                { spellID = 48181, unitId = "target", caster = "player", filter = "DEBUFF" },
                --腐蝕種子
                { spellID = 27243, unitId = "target", caster = "player", filter = "DEBUFF" },
                --恐懼嚎叫
                { spellID = 5484, unitId = "target", caster = "player", filter = "DEBUFF" },
                --死亡纏繞
                { spellID = 6789, unitId = "target", caster = "player", filter = "DEBUFF" },
                --奴役惡魔
                { spellID = 1098, unitId = "pet", caster = "player", filter = "DEBUFF" },
                --惡魔跳躍
                { spellID = 54785, unitId = "target", caster = "player", filter = "DEBUFF" },
            },
            {
                name = "玩家重要buff",
                setpoint = { "BOTTOMRIGHT", "oUF_FreebPlayer", "TOPRIGHT", 0, 33 },
                direction = "LEFT",
                size = 38,

                --反衝
                { spellID = 34936, unitId = "player", caster = "player", filter = "BUFF" },
                --夜暮
                { spellID = 17941, unitId = "player", caster = "player", filter = "BUFF" },
                --靈魂炙燃
                { spellID = 74434, unitId = "player", caster = "player", filter = "BUFF" },
                --熔火之心
                { spellID = 122351, unitId = "player", caster = "player", filter = "BUFF" },
            },
        },
        ["ROGUE"] = {
            {
                name = "玩家buff",
                direction = "LEFT",
                setpoint = { "BOTTOMRIGHT", "oUF_FreebPlayer", "TOPRIGHT",-50, 80 },
                size = 28,

                --淺察
                { spellID = 84745, unitId = "player", caster = "player", filter = "BUFF" },
                --中度洞察
                { spellID = 84746, unitId = "player", caster = "player", filter = "BUFF" },
                --深度洞察
                { spellID = 84747, unitId = "player", caster = "player", filter = "BUFF" },
            },
            {
                name = "目标buff",
                direction = "RIGHT",
                setpoint = { "BOTTOMLEFT", "oUF_FreebTarget", "TOPLEFT", 50, 80 },
                size = 28,

                --致命毒藥
                { spellID = 2818, unitId = "target", caster = "player", filter = "DEBUFF" },
                --麻痺毒藥
                { spellID = 5760, unitId = "target", caster = "player", filter = "DEBUFF" },
                --致殘毒藥
                { spellID = 3409, unitId = "target", caster = "player", filter = "DEBUFF" },
                --吸血毒藥
                { spellID = 112961, unitId = "target", caster = "player", filter = "DEBUFF" },
                --致傷毒藥
                { spellID = 8680, unitId = "target", caster = "player", filter = "DEBUFF" },
            },
            {
                name = "玩家重要buff",
                direction = "LEFT",
                setpoint = { "BOTTOMRIGHT", "oUF_FreebPlayer", "TOPRIGHT", 0, 33 },
                size = 38,

                --疾跑
                { spellID = 2983, unitId = "player", caster = "player", filter = "BUFF" },
                --暗影披風
                { spellID = 31224, unitId = "player", caster = "player", filter = "BUFF" },
                --能量刺激
                { spellID = 13750, unitId = "player", caster = "player", filter = "BUFF" },
                --閃避
                { spellID = 5277, unitId = "player", caster = "player", filter = "BUFF" },
                --毒化
                { spellID = 32645, unitId = "player", caster = "player", filter = "BUFF" },
                --極限殺戮
                { spellID = 58426, unitId = "player", caster = "player", filter = "BUFF" },
                --切割
                { spellID = 5171, unitId = "player", caster = "player", filter = "BUFF" },
                --偷天換日
                { spellID = 57934, unitId = "player", caster = "player", filter = "BUFF" },
                --偷天換日(傷害之後)
                { spellID = 59628, unitId = "player", caster = "player", filter = "BUFF" },
                --养精蓄锐
                { spellID = 73651, unitId = "player", caster = "player", filter = "BUFF" },
                --剑刃乱舞
                { spellID = 13877, unitId = "player", caster = "player", filter = "BUFF" },
                --佯攻
                { spellID = 1966, unitId = "player", caster = "player", filter = "BUFF" },
                --暗影之舞
                { spellID = 51713, unitId = "player", caster = "player", filter = "BUFF" },
                --敏銳大師
                { spellID = 31665, unitId = "player", caster = "player", filter = "BUFF" },
                --毀滅者之怒
                { spellID = 109949, unitId = "player", caster = "player", filter = "BUFF" },
                --洞悉要害
                { spellID = 121153, unitId = "player", caster = "player", filter = "BUFF" },
            },
            {
                name = "目标debuff",
                direction = "RIGHT",
                setpoint = { "BOTTOMLEFT", "oUF_FreebTarget", "TOPLEFT", 0, 33 },
                size = 38,

                --偷襲
                { spellID = 1833, unitId = "target", caster = "all", filter = "DEBUFF" },
                --腎擊
                { spellID = 408, unitId = "target", caster = "all", filter = "DEBUFF" },
                --致盲
                { spellID = 2094, unitId = "target", caster = "all", filter = "DEBUFF" },
                --悶棍
                { spellID = 6770, unitId = "target", caster = "all", filter = "DEBUFF" },
                --割裂
                { spellID = 1943, unitId = "target", caster = "player", filter = "DEBUFF" },
                --絞喉
                { spellID = 703, unitId = "target", caster = "player", filter = "DEBUFF" },
                --絞喉沉默
                { spellID = 1330, unitId = "target", caster = "player", filter = "DEBUFF" },
                --鑿擊
                { spellID = 1776, unitId = "target", caster = "player", filter = "DEBUFF" },
                --破甲
                { spellID = 8647, unitId = "target", caster = "player", filter = "DEBUFF" },
                --卸除武裝
                { spellID = 51722, unitId = "target", caster = "player", filter = "DEBUFF" },
                --出血
                { spellID = 16511, unitId = "target", caster = "player", filter = "DEBUFF" },
                --揭底之擊
                { spellID = 84617, unitId = "target", caster = "player", filter = "DEBUFF" },
                --宿怨
                { spellID = 79140, unitId = "target", caster = "player", filter = "DEBUFF" },
                --破甲
                { spellID = 113746, unitId = "target", caster = "all", filter = "DEBUFF" },
            },
            {
                name = "焦点debuff",
                direction = "UP",
                setpoint = { "BOTTOMLEFT", "oUF_FreebFocus", "TOPLEFT", 0, 10 },
                size = 24,
                mode = "BAR",
                iconSide = "LEFT",
                barWidth = 170,

                --致盲
                { spellID = 2094, unitId = "focus", caster = "all", filter = "DEBUFF" },
                --悶棍
                { spellID = 6770, unitId = "focus", caster = "all", filter = "DEBUFF" },
            },
           
        },
        ["DEATHKNIGHT"] = {
            {
                name = "玩家重要buff",
                direction = "LEFT",
                setpoint = { "BOTTOMRIGHT", "oUF_FreebPlayer", "TOPRIGHT", 0, 33 },
                size = 38,

                --血魄護盾
                { spellID = 77535, unitId = "player", caster = "player", filter = "BUFF" },
                --血魄轉化
                { spellID = 45529, unitId = "player", caster = "player", filter = "BUFF" },
                --血族之裔
                { spellID = 55233, unitId = "player", caster = "player", filter = "BUFF" },
                --穢邪力量
                { spellID = 53365, unitId = "player", caster = "player", filter = "BUFF" },
                --穢邪之力
                { spellID = 67117, unitId = "player", caster = "player", filter = "BUFF" },
                --符文武器幻舞
                { spellID = 49028, unitId = "player", caster = "player", filter = "BUFF" },
                --冰錮堅韌
                { spellID = 48792, unitId = "player", caster = "player", filter = "BUFF" },
                --反魔法護罩
                { spellID = 48707, unitId = "player", caster = "player", filter = "BUFF" },
                --殺戮酷刑
                { spellID = 51124, unitId = "player", caster = "player", filter = "BUFF" },
                --冰封之霧
                { spellID = 59052, unitId = "player", caster = "player", filter = "BUFF" },
                --骸骨之盾
                { spellID = 49222, unitId = "player", caster = "player", filter = "BUFF" },
                --冰霜之柱
                { spellID = 51271, unitId = "player", caster = "player", filter = "BUFF" },
                --血魄充能			
                { spellID = 114851, unitId = "player", caster = "player", filter = "BUFF" },
                --寶寶能量
                { spellID = 91342, unitId = "pet", caster = "player", filter = "BUFF" },
                --黑暗變身
                { spellID = 63560, unitId = "pet", caster = "player", filter = "BUFF" },
            },
            {
                name = "目标debuff",
                direction = "RIGHT",
                setpoint = { "BOTTOMLEFT", "oUF_FreebTarget", "TOPLEFT", 0, 33 },
                size = 38,

                --絞殺
                { spellID = 47476, unitId = "target", caster = "player", filter = "DEBUFF" },
                --血魄瘟疫
                { spellID = 55078, unitId = "target", caster = "player", filter = "DEBUFF" },
                --冰霜熱疫
                { spellID = 55095, unitId = "target", caster = "player", filter = "DEBUFF" },
                --召喚石像鬼
                { spellID = 49206, unitId = "target", caster = "player", filter = "DEBUFF" },
                --死亡凋零

                { spellID = 43265, unitId = "target", caster = "player", filter = "DEBUFF" },
            },
        },
        ["MONK"] = {
            {
                name = "玩家buff",
                direction = "LEFT",
                setpoint = { "BOTTOMRIGHT", "oUF_FreebPlayer", "TOPRIGHT",-50, 80 },
                size = 28,

            },
            {
                name = "目标buff",
                direction = "RIGHT",
                setpoint = { "BOTTOMLEFT", "oUF_FreebTarget", "TOPLEFT", 50, 80 },
                size = 28,

            },
            {
                name = "玩家重要buff",
                direction = "LEFT",
                setpoint = { "BOTTOMRIGHT", "oUF_FreebPlayer", "TOPRIGHT", 0, 33 },
                size = 38,

                --虎掌
                { spellID = 125359, unitId = "player", caster = "player", filter = "BUFF" },

            },
            {
                name = "目标debuff",
                direction = "RIGHT",
                setpoint = { "BOTTOMLEFT", "oUF_FreebTarget", "TOPLEFT", 0, 33 },
                size = 38,

            },
            {
                name = "焦点debuff",
                direction = "UP",
                setpoint = { "BOTTOMLEFT", "oUF_FreebFocus", "TOPLEFT", 0, 10 },
                size = 24,
                mode = "BAR",
                iconSide = "LEFT",
                barWidth = 170,

            },
          
        },
        ["ALL"]={
      --[[      {
                name = "玩家特殊buff",
                direction = "LEFT",
                setpoint = { "TOPRIGHT", "oUF_FreebPlayer", "BOTTOMRIGHT", 0, -9 },
                size = 41,

                --飾品
                --伊格納修斯之心
                { spellID = 91027, unitId = "player", caster = "player", filter = "BUFF" },
                --伊格納修斯之心 (H)
                { spellID = 91041, unitId = "player", caster = "player", filter = "BUFF" },
                --暗月卡：火山
                { spellID = 89091, unitId = "player", caster = "player", filter = "BUFF" },
                --暗月卡：地震
                { spellID = 89181, unitId = "player", caster = "player", filter = "BUFF" },
                --狂怒共鸣之铃(H)
                { spellID = 91007, unitId = "player", caster = "player", filter = "BUFF" },
                --瑟拉里恩之鏡
                { spellID = 91024, unitId = "player", caster = "player", filter = "BUFF" },
                --绝境当头
                { spellID = 96907, unitId = "player", caster = "player", filter = "BUFF" },
                --恶魔领主之赐
                { spellID = 102662, unitId = "player", caster = "player", filter = "BUFF" },
                --腐败心灵徽记(普通模式)
                { spellID = 107982, unitId = "player", caster = "player", filter = "BUFF" },
                --腐敗心靈徽記(H)
                { spellID = 109789, unitId = "player", caster = "player", filter = "BUFF" },
                --死灵法术集核(H)
                { spellID = 97131, unitId = "player", caster = "player", filter = "BUFF" },
                --死灵法术集核
                { spellID = 96962, unitId = "player", caster = "player", filter = "BUFF" },
                --魂棺
                { spellID = 91019, unitId = "player", caster = "player", filter = "BUFF" },
                --秘银码表
                { spellID = 101291, unitId = "player", caster = "player", filter = "BUFF" },
                --瓦罗森的胸针
                { spellID = 102664, unitId = "player", caster = "player", filter = "BUFF" },
                --圣光念珠
                { spellID = 102660, unitId = "player", caster = "player", filter = "BUFF" },
                --時間之箭
                { spellID = 102659, unitId = "player", caster = "player", filter = "BUFF" },
                --七徵聖印
                { spellID = 109802, unitId = "player", caster = "player", filter = "BUFF" },
                --飢餓者
                { spellID = 96911, unitId = "player", caster = "player", filter = "BUFF" },
                --淨縛之意志(隨機團隊)
                { spellID = 109793, unitId = "player", caster = "player", filter = "BUFF" },
                --淨縛之意志(普通模式)
                { spellID = 107970, unitId = "player", caster = "player", filter = "BUFF" },
                --淨縛之意志(H模式)
                { spellID = 109795, unitId = "player", caster = "player", filter = "BUFF" },
                --加速之瓶(普通模式)
                { spellID = 96980, unitId = "player", caster = "player", filter = "BUFF" },
                --謊言面紗
                { spellID = 102667, unitId = "player", caster = "player", filter = "BUFF" },
                --永恆之火精華
                { spellID = 97010, unitId = "player", caster = "player", filter = "BUFF" },
                --擒星羅盤(隨機團隊)
                { spellID = 109709, unitId = "player", caster = "player", filter = "BUFF" },
                --壞滅之眼(普通模式)
                { spellID = 107966, unitId = "player", caster = "player", filter = "BUFF" },
                --矩陣(H)
                { spellID = 97140, unitId = "player", caster = "player", filter = "BUFF" },

                --工程
                --神經突觸彈簧(敏捷)
                { spellID = 96228, unitId = "player", caster = "player", filter = "BUFF" },
                --神經突觸彈簧(力量)
                { spellID = 96229, unitId = "player", caster = "player", filter = "BUFF" },
                --神經突觸彈簧(智力)
                { spellID = 96230, unitId = "player", caster = "player", filter = "BUFF" },
                --迅轉偏斜甲
                { spellID = 82176, unitId = "player", caster = "player", filter = "BUFF" },

                --武器附魔
                --心之歌
                { spellID = 74224, unitId = "player", caster = "player", filter = "BUFF" },
                --颶風
                { spellID = 74221, unitId = "player", caster = "player", filter = "BUFF" },
                --能量洪流
                { spellID = 74241, unitId = "player", caster = "player", filter = "BUFF" },
                --轻盈步伐
                { spellID = 74243, unitId = "player", caster = "player", filter = "BUFF" },
                --泰坦克，時之步履(隨機團隊)
                { spellID = 109842, unitId = "player", caster = "player", filter = "BUFF" },

                --藥水
                --土靈護甲
                { spellID = 79475, unitId = "player", caster = "player", filter = "BUFF" },
                --火山藥水
                { spellID = 79476, unitId = "player", caster = "player", filter = "BUFF" },

                --特殊buff
                --偷天換日
                { spellID = 57933, unitId = "player", caster = "all", filter = "BUFF" },
                --注入能量
                { spellID = 10060, unitId = "player", caster = "all", filter = "BUFF" },
                --嗜血術
                { spellID = 2825, unitId = "player", caster = "all", filter = "BUFF" },
                --英勇氣概
                { spellID = 32182, unitId = "player", caster = "all", filter = "BUFF" },
                --時間扭曲
                { spellID = 80353, unitId = "player", caster = "all", filter = "BUFF" },
                --上古狂亂
                { spellID = 90355, unitId = "player", caster = "all", filter = "BUFF" },
                --振奮咆哮
                { spellID = 97463, unitId = "player", caster = "all", filter = "BUFF" },
                --犧牲聖禦
                { spellID = 6940, unitId = "player", caster = "all", filter = "BUFF" },
                --保護聖禦
                { spellID = 1022, unitId = "player", caster = "all", filter = "BUFF" },
                --守护之魂
                { spellID = 47788, unitId = "player", caster = "all", filter = "BUFF" },
                --痛苦镇压
                { spellID = 33206, unitId = "player", caster = "all", filter = "BUFF" },
                --血族之裔
                { spellID = 105588, unitId = "player", caster = "all", filter = "BUFF" },

                --種族天賦
                --血之烈怒
                { spellID = 20572, unitId = "player", caster = "all", filter = "BUFF" },

                --套裝效果
                -- DK 4T13 (DPS)
                { spellID = 105647, unitId = "player", caster = "player", filter = "BUFF" },
            },]]
            {
                name = "PVE/PVP玩家debuff",
                direction = "UP",
                setpoint = { "CENTER", UIParent, "CENTER", -160, 50 },
                size = 40,

                --Death Knight
                --啃食
                { spellID = 47481, unitId = "player", caster = "all", filter = "DEBUFF" },
                --絞殺
                { spellID = 47476, unitId = "player", caster = "all", filter = "DEBUFF" },
                --冰鏈術
                { spellID = 45524, unitId = "player", caster = "all", filter = "DEBUFF" },

                --Druid
                --颶風術
                { spellID = 33786, unitId = "player", caster = "all", filter = "DEBUFF" },
                --休眠
                { spellID = 2637, unitId = "player", caster = "all", filter = "DEBUFF" },
                --重擊
                { spellID = 5211, unitId = "player", caster = "all", filter = "DEBUFF" },
                --傷殘術
                { spellID = 22570, unitId = "player", caster = "all", filter = "DEBUFF" },
                --突襲
                { spellID = 9005, unitId = "player", caster = "all", filter = "DEBUFF" },
                --糾纏根鬚
                { spellID = 339, unitId = "player", caster = "all", filter = "DEBUFF" },
                --野性衝鋒效果
                { spellID = 45334, unitId = "player", caster = "all", filter = "DEBUFF" },

                --Hunter
                --冰凍陷阱
                { spellID = 3355, unitId = "player", caster = "all", filter = "DEBUFF" },
                --恐嚇野獸
                { spellID = 1513, unitId = "player", caster = "all", filter = "DEBUFF" },
                --驅散射擊
                { spellID = 19503, unitId = "player", caster = "all", filter = "DEBUFF" },
                --奪械
                { spellID = 50541, unitId = "player", caster = "all", filter = "DEBUFF" },
                --沈默射擊
                { spellID = 34490, unitId = "player", caster = "all", filter = "DEBUFF" },
                --脅迫
                { spellID = 24394, unitId = "player", caster = "all", filter = "DEBUFF" },
                --音波沖擊
                { spellID = 50519, unitId = "player", caster = "all", filter = "DEBUFF" },
                --劫掠
                { spellID = 50518, unitId = "player", caster = "all", filter = "DEBUFF" },
                --震盪狙擊
                { spellID = 35101, unitId = "player", caster = "all", filter = "DEBUFF" },
                --震盪射擊
                { spellID = 5116, unitId = "player", caster = "all", filter = "DEBUFF" },
                --寒冰陷阱
                { spellID = 13810, unitId = "player", caster = "all", filter = "DEBUFF" },
                --凍痕
                { spellID = 61394, unitId = "player", caster = "all", filter = "DEBUFF" },
                --誘捕
                { spellID = 19185, unitId = "player", caster = "all", filter = "DEBUFF" },
                --釘刺
                { spellID = 50245, unitId = "player", caster = "all", filter = "DEBUFF" },
                --噴灑毒網
                { spellID = 54706, unitId = "player", caster = "all", filter = "DEBUFF" },
                --蛛網
                { spellID = 4167, unitId = "player", caster = "all", filter = "DEBUFF" },
                --霜暴之息
                { spellID = 92380, unitId = "player", caster = "all", filter = "DEBUFF" },
                --豹群
                { spellID = 13159, unitId = "player", caster = "player", filter = "BUFF" },

                --Mage
                --龍之吐息
                { spellID = 31661, unitId = "player", caster = "all", filter = "DEBUFF" },
                --衝擊波
                { spellID = 11113, unitId = "player", caster = "all", filter = "DEBUFF" },
                --活體爆彈
                { spellID = 44457, unitId = "player", caster = "all", filter = "DEBUFF" },
                --變形術
                { spellID = 118, unitId = "player", caster = "all", filter = "DEBUFF" },
                --極度冰凍
                { spellID = 44572, unitId = "player", caster = "all", filter = "DEBUFF" },
                --冰凍術
                { spellID = 33395, unitId = "player", caster = "all", filter = "DEBUFF" },
                --冰霜新星
                { spellID = 122, unitId = "player", caster = "all", filter = "DEBUFF" },
                --冰凍
                { spellID = 6136, unitId = "player", caster = "all", filter = "DEBUFF" },
                --冰錐術
                { spellID = 120, unitId = "player", caster = "all", filter = "DEBUFF" },
                --減速術
                { spellID = 31589, unitId = "player", caster = "all", filter = "DEBUFF" },

                --Paladin
                --懺悔
                { spellID = 20066, unitId = "player", caster = "all", filter = "DEBUFF" },
                --退邪術
                { spellID = 10326, unitId = "player", caster = "all", filter = "DEBUFF" },
                --暈眩 - 復仇之盾
                { spellID = 63529, unitId = "player", caster = "all", filter = "DEBUFF" },
                --制裁之錘
                { spellID = 853, unitId = "player", caster = "all", filter = "DEBUFF" },
                --神聖憤怒
                { spellID = 2812, unitId = "player", caster = "all", filter = "DEBUFF" },
                --公正聖印
                { spellID = 20170, unitId = "player", caster = "all", filter = "DEBUFF" },
                --復仇之盾
                { spellID = 31935, unitId = "player", caster = "all", filter = "DEBUFF" },

                --Priest
                --心靈恐慌（繳械效果）
                { spellID = 64058, unitId = "player", caster = "all", filter = "DEBUFF" },
                --精神控制
                { spellID = 605, unitId = "player", caster = "all", filter = "DEBUFF" },
                --心靈恐慌
                { spellID = 64044, unitId = "player", caster = "all", filter = "DEBUFF" },
                --心靈尖嘯
                { spellID = 8122, unitId = "player", caster = "all", filter = "DEBUFF" },
                --沉默
                { spellID = 15487, unitId = "player", caster = "all", filter = "DEBUFF" },
                --精神鞭笞
                { spellID = 15407, unitId = "player", caster = "all", filter = "DEBUFF" },
                --罪與罰
                { spellID = 87204, unitId = "player", caster = "all", filter = "DEBUFF" },

                --Rogue
                --卸除武裝
                { spellID = 51722, unitId = "player", caster = "all", filter = "DEBUFF" },
                --致盲
                { spellID = 2094, unitId = "player", caster = "all", filter = "DEBUFF" },
                --鑿擊
                { spellID = 1776, unitId = "player", caster = "all", filter = "DEBUFF" },
                --悶棍
                { spellID = 6770, unitId = "player", caster = "all", filter = "DEBUFF" },
                --絞喉 - 沉默
                { spellID = 1330, unitId = "player", caster = "all", filter = "DEBUFF" },
                --偷襲
                { spellID = 1833, unitId = "player", caster = "all", filter = "DEBUFF" },
                --腎擊
                { spellID = 408, unitId = "player", caster = "all", filter = "DEBUFF" },
                --致殘毒藥
                { spellID = 3409, unitId = "player", caster = "all", filter = "DEBUFF" },
                --擲殺
                { spellID = 26679, unitId = "player", caster = "all", filter = "DEBUFF" },

                --Shaman
                --妖術
                { spellID = 51514, unitId = "player", caster = "all", filter = "DEBUFF" },
                --陷地
                { spellID = 64695, unitId = "player", caster = "all", filter = "DEBUFF" },
                --凍結
                { spellID = 63685, unitId = "player", caster = "all", filter = "DEBUFF" },
                --地縛術
                { spellID = 3600, unitId = "player", caster = "all", filter = "DEBUFF" },
                --冰霜震擊
                { spellID = 8056, unitId = "player", caster = "all", filter = "DEBUFF" },

                --Warlock
                --放逐術
                { spellID = 710, unitId = "player", caster = "all", filter = "DEBUFF" },
                --死亡纏繞
                { spellID = 6789, unitId = "player", caster = "all", filter = "DEBUFF" },
                --恐懼術
                { spellID = 5782, unitId = "player", caster = "all", filter = "DEBUFF" },
                --恐懼嚎叫
                { spellID = 5484, unitId = "player", caster = "all", filter = "DEBUFF" },
                --誘惑
                { spellID = 6358, unitId = "player", caster = "all", filter = "DEBUFF" },
                --法術封鎖
                { spellID = 24259, unitId = "player", caster = "all", filter = "DEBUFF" },
                --暗影之怒
                { spellID = 30283, unitId = "player", caster = "all", filter = "DEBUFF" },
                --追獵
                { spellID = 30153, unitId = "player", caster = "all", filter = "DEBUFF" },
                --疲勞詛咒
                { spellID = 18223, unitId = "player", caster = "all", filter = "DEBUFF" },

                --Warrior
                --破膽怒吼
                { spellID = 20511, unitId = "player", caster = "all", filter = "DEBUFF" },
                --繳械
                { spellID = 676, unitId = "player", caster = "all", filter = "DEBUFF" },
                --沉默 - 窒息律令
                { spellID = 18498, unitId = "player", caster = "all", filter = "DEBUFF" },
                --衝鋒昏迷
                { spellID = 7922, unitId = "player", caster = "all", filter = "DEBUFF" },
                --震懾波
                { spellID = 46968, unitId = "player", caster = "all", filter = "DEBUFF" },
                --斷筋
                { spellID = 1715, unitId = "player", caster = "all", filter = "DEBUFF" },
                --刺耳怒吼
                { spellID = 12323, unitId = "player", caster = "all", filter = "DEBUFF" },

                --Racials
                --戰爭踐踏
                { spellID = 20549, unitId = "player", caster = "all", filter = "DEBUFF" },

                --副本
                --暮光堡壘
                --致死打擊 (哈福斯·破龍者)
                { spellID = 39171, unitId = "player", caster = "all", filter = "DEBUFF", fuzzy = true },
                --侵蝕魔法 (瑟拉里恩和瓦莉歐娜)
                { spellID = 86622, unitId = "player", caster = "all", filter = "DEBUFF", fuzzy = true },
                --暮光隕星 (瑟拉里恩和瓦莉歐娜)
                { spellID = 88518, unitId = "player", caster = "all", filter = "DEBUFF", fuzzy = true },
                --侵濕 (卓越者議會)
                { spellID = 82762, unitId = "player", caster = "all", filter = "DEBUFF", fuzzy = true }, 
                --聚雷針 (卓越者議會)
                { spellID = 83099, unitId = "player", caster = "all", filter = "DEBUFF", fuzzy = true }, 
                --旋風 (卓越者議會)
                { spellID = 83500, unitId = "player", caster = "all", filter = "DEBUFF", fuzzy = true },
                --磁力吸引 (卓越者議會)
                { spellID = 83587, unitId = "player", caster = "all", filter = "DEBUFF", fuzzy = true },
                --腐化:畸形 (丘加利)
                { spellID = 82125, unitId = "player", caster = "all", filter = "DEBUFF", fuzzy = true },
                --腐化:絕對 (丘加利)
                { spellID = 82170, unitId = "player", caster = "all", filter = "DEBUFF", fuzzy = true },

                --黑翼魔窟
                --闇能灌注 (全能魔像防禦系統)
                { spellID = 92048, unitId = "player", caster = "all", filter = "DEBUFF", fuzzy = true },
                --瞬間冷凍 (瑪洛里亞克)
                { spellID = 77699, unitId = "player", caster = "all", filter = "DEBUFF", fuzzy = true },
                --吞噬烈焰 (瑪洛里亞克)
                { spellID = 77786, unitId = "player", caster = "all", filter = "DEBUFF", fuzzy = true },
                --聚影體 (全能魔像防禦系統)
                { spellID = 92053, unitId = "player", caster = "all", filter = "DEBUFF", fuzzy = true },
                --爆裂灰燼（h奈法利安的末路）
                { spellID = 79339, unitId = "player", caster = "all", filter = "DEBUFF", fuzzy = true },

                --四風
                --靜電震擊 (奧拉基爾)
                { spellID = 87873, unitId = "player", caster = "all", filter = "DEBUFF", fuzzy = true },

                --火源
                --燃燒之球
                { spellID = 98451, unitId = "player", caster = "all", filter = "DEBUFF", fuzzy = true },
                --活力火花
                { spellID = 99262, unitId = "player", caster = "all", filter = "BUFF", fuzzy = true },
                --活力烈焰
                { spellID = 99263, unitId = "player", caster = "all", filter = "BUFF", fuzzy = true },
                --火焰易傷
                { spellID = 98492, unitId = "player", caster = "all", filter = "DEBUFF", fuzzy = true },
                --爆裂種子
                { spellID = 98450, unitId = "player", caster = "all", filter = "DEBUFF", fuzzy = true },
                --折磨
                { spellID = 99256, unitId = "player", caster = "all", filter = "DEBUFF", fuzzy = true },

                --龍魂
                --魔寇
                --安全
                { spellID = 103541, unitId = "player", caster = "all", filter = "DEBUFF", fuzzy = true },
                --警告
                { spellID = 103536, unitId = "player", caster = "all", filter = "DEBUFF", fuzzy = true },
                --危險
                { spellID = 103534, unitId = "player", caster = "all", filter = "DEBUFF", fuzzy = true },
                --督軍松奧茲
                --崩解之影
                { spellID = 103434, unitId = "player", caster = "all", filter = "DEBUFF", fuzzy = true },
                --未眠者尤沙吉
                --深度腐化
                { spellID = 103628, unitId = "player", caster = "all", filter = "DEBUFF", fuzzy = true },
                --哈甲拉
                --目標
                { spellID = 105285, unitId = "player", caster = "all", filter = "DEBUFF", fuzzy = true },
                --破碎寒冰
                { spellID = 105289, unitId = "player", caster = "all", filter = "DEBUFF", fuzzy = true },
                --奧特拉賽恩
                --黑暗逼近
                { spellID = 106498, unitId = "player", caster = "all", filter = "DEBUFF", fuzzy = true },
                --凋零之光
                { spellID = 109075, unitId = "player", caster = "all", filter = "DEBUFF", fuzzy = true },
                { spellID = 109075, unitId = "player", caster = "all", filter = "BUFF", fuzzy = true },
                --將領黑角
                --死亡之翼的脊椎
                --纏繞觸鬚
                { spellID = 105563, unitId = "player", caster = "all", filter = "DEBUFF", fuzzy = true },
                --血液腐化:大地
                { spellID = 106200, unitId = "player", caster = "all", filter = "DEBUFF", fuzzy = true },
                --血液腐化:死亡
                { spellID = 106199, unitId = "player", caster = "all", filter = "DEBUFF", fuzzy = true },
                --死亡之翼的狂亂
                --腐化寄生體
                { spellID = 108649, unitId = "player", caster = "all", filter = "DEBUFF", fuzzy = true },
				
				--Mogu'Shan Vaults
				--Elegon
				--Overcharged
				{ spellID = 117878, unitId = "player", caster = "player", filter = "DEBUFF", fuzzy = true },
				--Touch of the Titans
				{ spellID = 117870, unitId = "player", caster = "all", filter = "DEBUFF", fuzzy = true },
				--回蓝
				{ spellID = 117543, unitId = "player", caster = "all", filter = "BUFF", fuzzy = true },
				--ToES
				--cleansing waters
				{ spellID = 117283, unitId = "player", caster = "all", filter = "BUFF", fuzzy = true },
				--leishi spray
				{ spellID = 123121, unitId = "player", caster = "all", filter = "DEBUFF", fuzzy = true },
				--tsulong
				--光柱123716
				{ spellID = 123716, unitId = "player", caster = "all", filter = "BUFF"},
				--吐息
				{ spellID = 122858, unitId = "player", caster = "all", filter = "BUFF"},
                --其他
                --漏油
                { spellID = 94794, unitId = "player", caster = "all", filter = "DEBUFF" },
            },
            {
                name = "PVP目标buff",
                direction = "UP",
                setpoint = { "CENTER", UIParent, "CENTER", 160, 0 },
                size = 40,

                --啟動
                { spellID = 29166, unitId = "target", caster = "all", filter = "BUFF"},
                --法術反射
                { spellID = 23920, unitId = "target", caster = "all", filter = "BUFF" },
                --精通光環
                { spellID = 31821, unitId = "target", caster = "all", filter = "BUFF" },
                --寒冰屏障
                { spellID = 45438, unitId = "target", caster = "all", filter = "BUFF" },
                --暗影披風
                { spellID = 31224, unitId = "target", caster = "all", filter = "BUFF" },
                --聖盾術
                { spellID = 642, unitId = "target", caster = "all", filter = "BUFF" },
                --威懾
                { spellID = 19263, unitId = "target", caster = "all", filter = "BUFF" },
                --反魔法護罩
                { spellID = 48707, unitId = "target", caster = "all", filter = "BUFF" },
                --巫妖之軀
                { spellID = 49039, unitId = "target", caster = "all", filter = "BUFF" },
                --自由聖禦
                { spellID = 1044, unitId = "target", caster = "all", filter = "BUFF" },
                --犧牲聖禦
                { spellID = 6940, unitId = "target", caster = "all", filter = "BUFF" },
                --根基圖騰效果
                { spellID = 8178, unitId = "target", caster = "all", filter = "BUFF" },
                --保護聖禦
				{ spellID = 1022, unitId= "target", caster = "all", filter = "BUFF" },
				--副本
				--感染之爪
				{ spellID = 140092, unitId= "target", caster = "all", filter = "DEBUFF" },
				--talon rake
				{ spellID = 134366, unitId= "target", caster = "all", filter = "DEBUFF" },
		},
		{
                name = "boss1重要的buff/debuff",
                direction = "UP",
                setpoint = { "CENTER", UIParent, "CENTER", 200, 50 },
                size = 40,
				--Lei Shi - Scary Fog
				{ spellID = 123705, unitId= "Boss1", caster = "all", filter = "DEBUFF" },
				{ spellID = 123712, unitId= "Boss1", caster = "all", filter = "DEBUFF" },
				{ spellID = 123797, unitId= "Boss1", caster = "all", filter = "DEBUFF" },
				--Amber-Shaper Un'sok
				{ spellID = 123059, unitId= "Boss1", caster = "all", filter = "DEBUFF" },
		},
		{
                name = "boss2重要的buff/debuff",
                direction = "UP",
                setpoint = { "CENTER", UIParent, "CENTER", 200, 0 },
                size = 40,
				{ spellID = 123059, unitId= "Boss2", caster = "all", filter = "DEBUFF" },
		}
	}
}