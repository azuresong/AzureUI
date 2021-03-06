﻿-- Engines
local _, _, _, DB = unpack(select(2, ...))
local Media = "InterFace\\AddOns\\Sora's Bags\\Media\\"

DB.MyClass = select(2, UnitClass("player"))
DB.MyClassColor = RAID_CLASS_COLORS[DB.MyClass]
DB.IsInCombat = UnitAffectingCombat("player")
DB.Font = GetLocale() == "zhCN" and "Fonts\\ARKai_T.ttf" or "Fonts\\bLEI00D.ttf"
DB.bgFile = "Interface\\Tooltips\\UI-Tooltip-Background"
DB.Icon = "Interface\\Addons\\Sora's\\Modules\\Chat\\Icon\\"
DB.GlowTex = Media.."GlowTex"
DB.Statusbar = Media.."Statusbar"
DB.ThreatBar = Media.."ThreatBar"
DB.Solid = Media.."Solid"
DB.Button = Media.."Button"
DB.ArrowT = Media.."ArrowT"
DB.Arrow = Media.."Arrow"
DB.Warning = Media.."Warning.mp3"
DB.RaidBuffPos = {"TOPLEFT", Minimap, "BOTTOMLEFT", -5, -25}
DB.ClassBuffPos = {"CENTER", UIParent, -100, 150}
DB.TooltipPos = {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -50, 201}