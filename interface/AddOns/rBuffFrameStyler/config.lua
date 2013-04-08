
  -- // rBuffFrameStyler
  -- // zork - 2012

  -----------------------------
  -- INIT
  -----------------------------

  --get the addon namespace
  local addon, ns = ...
  local cfg = CreateFrame("Frame")
  ns.cfg = cfg

  -----------------------------
  -- CONFIG
  -----------------------------

  --adjust the oneletter abbrev?
  cfg.adjustOneletterAbbrev = true
  
  --scale of the consolidated tooltip
  cfg.consolidatedTooltipScale = 1.2
  
  --combine buff and debuff frame - should buffs and debuffs be displayed in one single frame?
  --if you disable this it is intended that you unlock the buff and debuffs and move them apart!
  cfg.combineBuffsAndDebuffs = true

  --buff frame settings
  cfg.buffFrame = {
    pos             = { a1 = "TOPRIGHT", af = "Minimap", a2 = "TOPLEFT", x = -35, y = 0 },
    gap             = 10, --gap between buff and debuff rows
    userplaced      = true, --want to place the bar somewhere else?
    rowSpacing      = 10,
    colSpacing      = 7,
    buttonsPerRow   = 10,
    button = {
      size              = 28,
    },
    icon = {
      padding           = -1,
    },
    border = {
      texture           = "Interface\\ChatFrame\\ChatFrameBackground",
      color             = { r = 0.4, g = 0.35, b = 0.35, },
      classcolored      = false,
    },
    background = {
      show              = true,   --show backdrop
      edgeFile          = "Interface\\AddOns\\aurora\\media\\glow",
      color             = { r = 0, g = 0, b = 0, a = 1},
      classcolored      = false,
      inset             = 5,
      padding           = 3,
    },
    duration = {
      font              = STANDARD_TEXT_FONT,
      size              = 10,
      pos               = { a1 = "BOTTOM", x = 0, y = -5 },
    },
    count = {
      font              = STANDARD_TEXT_FONT,
      size              = 11,
      pos               = { a1 = "TOPRIGHT", x = 0, y = 0 },
    },
  }

  --debuff frame settings
  cfg.debuffFrame = {
    pos             = { a1 = "TOPRIGHT", af = "rBFS_BuffDragFrame", a2 = "BOTTOMRIGHT", x = 0, y = -10 },
    userplaced      = true, --want to place the bar somewhere else?
    rowSpacing      = 10,
    colSpacing      = 7,
    buttonsPerRow   = 6,
    button = {
      size              = 32,
    },
    icon = {
      padding           = -1,
    },
    border = {
      texture           = "",
    },
    background = {
      show              = true,   --show backdrop
      edgeFile          = "Interface\\AddOns\\aurora\\media\\glow",
      color             = { r = 0, g = 0, b = 0, a = 1},
      classcolored      = false,
      inset             = 5,
      padding           = 3,
    },
    duration = {
      font              = STANDARD_TEXT_FONT,
      size              = 13,
      pos               = { a1 = "BOTTOM", x = 0, y = -3 },
    },
    count = {
      font              = STANDARD_TEXT_FONT,
      size              = 12,
      pos               = { a1 = "TOPRIGHT", x = 0, y = 0 },
    },
  }

