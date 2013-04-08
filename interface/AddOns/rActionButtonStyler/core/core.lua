
  ---------------------------------------
  -- VARIABLES
  ---------------------------------------

  --get the addon namespace
  local addon, ns = ...

  --get the config values
  local cfg = ns.cfg

  local classcolor = RAID_CLASS_COLORS[select(2, UnitClass("player"))]
  local dominos = IsAddOnLoaded("Dominos")
  local bartender4 = IsAddOnLoaded("Bartender4")

  if cfg.color.classcolored then
    cfg.color.normal = classcolor
  end

  --backdrop settings
  local bgfile, edgefile = "", ""
  if cfg.background.showshadow then edgefile = cfg.textures.outer_shadow end
  if cfg.background.useflatbackground and cfg.background.showbg then bgfile = cfg.textures.buttonbackflat end

  --backdrop
  local backdrop = {
    bgFile = bgfile,
    edgeFile = edgefile,
    tile = false,
    tileSize = 32,
    edgeSize = cfg.background.inset,
    insets = {
      left = cfg.background.inset,
      right = cfg.background.inset,
      top = cfg.background.inset,
      bottom = cfg.background.inset,
    },
  }

  ---------------------------------------
  -- FUNCTIONS
  ---------------------------------------

  local function applyBackground(bu)
    if not bu or (bu and bu.bg) then return end
    --shadows+background
    if bu:GetFrameLevel() < 1 then bu:SetFrameLevel(1) end
    if cfg.background.showbg or cfg.background.showshadow then
      bu.bg = CreateFrame("Frame", nil, bu)
      bu.bg:SetAllPoints(bu)
      bu.bg:SetPoint("TOPLEFT", bu, "TOPLEFT", -4, 4)
      bu.bg:SetPoint("BOTTOMRIGHT", bu, "BOTTOMRIGHT", 4, -4)
      bu.bg:SetFrameLevel(bu:GetFrameLevel()-1)
      if cfg.background.classcolored then
        cfg.background.backgroundcolor = classcolor
        cfg.background.shadowcolor = classcolor
      end
      if cfg.background.showbg and not cfg.background.useflatbackground then
        local t = bu.bg:CreateTexture(nil,"BACKGROUND",-8)
        t:SetTexture(cfg.textures.buttonback)
        t:SetAllPoints(bu)
        t:SetVertexColor(cfg.background.backgroundcolor.r,cfg.background.backgroundcolor.g,cfg.background.backgroundcolor.b,cfg.background.backgroundcolor.a)
      end
      bu.bg:SetBackdrop(backdrop)
      if cfg.background.useflatbackground then
        bu.bg:SetBackdropColor(cfg.background.backgroundcolor.r,cfg.background.backgroundcolor.g,cfg.background.backgroundcolor.b,cfg.background.backgroundcolor.a)
      end
      if cfg.background.showshadow then
        bu.bg:SetBackdropBorderColor(cfg.background.shadowcolor.r,cfg.background.shadowcolor.g,cfg.background.shadowcolor.b,cfg.background.shadowcolor.a)
      end
    end
  end

  --style extraactionbutton
  local function styleExtraActionButton(bu)
    if not bu or (bu and bu.rabs_styled) then return end
    local name = bu:GetName()
    local ho = _G[name.."HotKey"]
    --remove the style background theme
    bu.style:SetTexture(nil)
    hooksecurefunc(bu.style, "SetTexture", function(self, texture)
      if texture then
        --print("reseting texture: "..texture)
        self:SetTexture(nil)
      end
    end)
    --icon
    bu.icon:SetTexCoord(0.1,0.9,0.1,0.9)
    bu.icon:SetAllPoints(bu)
    --cooldown
    bu.cooldown:SetAllPoints(bu.icon)
    --hotkey
    ho:Hide()
    --add button normaltexture
    bu:SetNormalTexture(cfg.textures.normal)
    local nt = bu:GetNormalTexture()
    nt:SetVertexColor(cfg.color.normal.r,cfg.color.normal.g,cfg.color.normal.b,1)
    nt:SetAllPoints(bu)
    --apply background
    if not bu.bg then applyBackground(bu) end
    bu.rabs_styled = true
  end

  --initial style func
local function styleActionButton(bu)
	if not bu or (bu and bu.rabs_styled) then
      return
    end
	local name = bu:GetName()
	local action = bu.action

	if name:match("MultiCast") then return end

	if not bu.equipped then
		local equipped = bu:CreateTexture(nil, "OVERLAY")
		equipped:SetTexture(0, 1, 0, .3)
		equipped:SetAllPoints()
		equipped:Hide()
		bu.equipped = equipped
	end

	if action and IsEquippedAction(action) then
		if not bu.equipped:IsShown() then
			bu.equipped:Show()
		end
	else
		if bu.equipped:IsShown() then
			bu.equipped:Hide()
		end
	end
 
    local ic  = _G[name.."Icon"]
    local co  = _G[name.."Count"]
    local bo  = _G[name.."Border"]
    local ho  = _G[name.."HotKey"]
    local cd  = _G[name.."Cooldown"]
    local na  = _G[name.."Name"]
    local fl  = _G[name.."Flash"]
    local nt  = _G[name.."NormalTexture"]
	local Normal2 = bu:GetNormalTexture()
    local fbg  = _G[name.."FloatingBG"]

	--cooldown
	if cd then
		cd:ClearAllPoints()
		cd:SetAllPoints(bu)
	end

	if fl then fl:SetTexture(nil) end
	if nt then nt:SetTexture(nil) nt:Hide() nt:SetAlpha(0) end
	if Normal2 then Normal2:SetTexture(nil) Normal2:Hide() Normal2:SetAlpha(0) end
	if bo then bo:SetTexture(nil) end 	
	
	--item stack count
    co:SetFont(cfg.font, cfg.itemcount.fontsize, "OUTLINE")
    co:ClearAllPoints()
    co:SetPoint(cfg.itemcount.pos1.a1,bu,cfg.itemcount.pos1.x,cfg.itemcount.pos1.y)
    if not dominos and not bartender4 and not cfg.itemcount.show then
      co:Hide()
    end
	
	--floatingBG
    if fbg then
		fbg:Kill()
	end
	
	--macro name
    na:SetFont(cfg.font, cfg.macroname.fontsize, "OUTLINE")
    na:ClearAllPoints()
    na:SetPoint(cfg.macroname.pos1.a1,bu,cfg.macroname.pos1.x,cfg.macroname.pos1.y)
    na:SetPoint(cfg.macroname.pos2.a1,bu,cfg.macroname.pos2.x,cfg.macroname.pos2.y)
    if not dominos and not bartender4 and not cfg.macroname.show then
      na:Hide()
    end
	--shadows+background
   if not bu.bg then
		bu:CreateShadow("Background")
	end

	if ic then
		ic:SetTexCoord(.08, .92, .08, .92)
		ic:SetAllPoints()
	end
	
	--hotkey
    ho:SetFont(cfg.font, cfg.hotkeys.fontsize, "OUTLINE")
    ho:ClearAllPoints()
    ho:SetPoint(cfg.hotkeys.pos1.a1,bu,cfg.hotkeys.pos1.x,cfg.hotkeys.pos1.y)
    ho:SetPoint(cfg.hotkeys.pos2.a1,bu,cfg.hotkeys.pos2.x,cfg.hotkeys.pos2.y)
    if not dominos and not bartender4 and not cfg.hotkeys.show then
      ho:Hide()
    end

	bu:StyleButton(true)
    bu.rabs_styled = true
end

local function styleLeaveButton(bu)
    if not bu or (bu and bu.rabs_styled) then return end
    --shadows+background
    if not bu.bg then bu:CreateShadow("Background") end
    bu.rabs_styled = true
end

  --style pet buttons
  local function stylePetButton(bu)
    if not bu or (bu and bu.rabs_styled) then return end
    local name = bu:GetName()
    local ic  = _G[name.."Icon"]
    local fl  = _G[name.."Flash"]
    local nt  = _G[name.."NormalTexture2"]
	local shine = _G[name.."Shine"]
	local autocast = _G[name.."AutoCastable"]
    if cd then
		cd:ClearAllPoints()
		cd:SetAllPoints(bu)
	end

	if fl then fl:SetTexture(nil) end
	if nt then nt:SetTexture(nil) nt:Hide() nt:SetAlpha(0) end
	if Normal2 then Normal2:SetTexture(nil) Normal2:Hide() Normal2:SetAlpha(0) end
	if bo then bo:SetTexture(nil) end 	

	autocast:SetAlpha(0)
	--shadows+background
   if not bu.bg then
	bu:CreateShadow("Background")
	end

	if ic then
		ic:SetTexCoord(.08, .92, .08, .92)
		ic:SetAllPoints()
	end
	
	if shine then
	shine:Size(bu:GetSize())
	shine:ClearAllPoints()
	shine:SetPoint("CENTER", bu, 0, 0)
	end
	bu:StyleButton(true)
    bu.rabs_styled = true
  end

  --style stance buttons
local function styleStanceButton(bu)
    if not bu or (bu and bu.rabs_styled) then return end
    local name = bu:GetName()
    local ic  = _G[name.."Icon"]
    local fl  = _G[name.."Flash"]
    local nt  = _G[name.."NormalTexture2"]


	if fl then fl:SetTexture(nil) end
	if nt then nt:SetTexture(nil) nt:Hide() nt:SetAlpha(0) end
	if Normal2 then Normal2:SetTexture(nil) Normal2:Hide() Normal2:SetAlpha(0) end
	if bo then bo:SetTexture(nil) end 	


	--shadows+background
   
	bu:CreateShadow("Background")
	

	if ic then
		ic:SetTexCoord(.08, .92, .08, .92)
		ic:SetAllPoints()
	end
	bu:StyleButton(true)
    bu.rabs_styled = true
end

  --update hotkey func
local function updateHotkey(self, actionButtonType)
    local ho = _G[self:GetName().."HotKey"]
    if ho and not cfg.hotkeys.show and ho:IsShown() then
      ho:Hide()
    end
end

  ---------------------------------------
  -- INIT
  ---------------------------------------

  local function init()
    --style the actionbar buttons
    for i = 1, NUM_ACTIONBAR_BUTTONS do
      styleActionButton(_G["ActionButton"..i])
      styleActionButton(_G["MultiBarBottomLeftButton"..i])
      styleActionButton(_G["MultiBarBottomRightButton"..i])
      styleActionButton(_G["MultiBarRightButton"..i])
      styleActionButton(_G["MultiBarLeftButton"..i])
    end
    for i = 1, 6 do
      styleActionButton(_G["OverrideActionBarButton"..i])
    end
    --style leave button
    styleLeaveButton(OverrideActionBarLeaveFrameLeaveButton)
    styleLeaveButton(rABS_LeaveVehicleButton)
    --petbar buttons
    for i=1, NUM_PET_ACTION_SLOTS do
      stylePetButton(_G["PetActionButton"..i])
    end
    --stancebar buttons
    for i=1, NUM_STANCE_SLOTS do
      styleStanceButton(_G["StanceButton"..i])
    end
    --possess buttons
    for i=1, NUM_POSSESS_SLOTS do
      styleStanceButton(_G["PossessButton"..i])
    end
    --extraactionbutton1
    styleExtraActionButton(ExtraActionButton1)
    --spell flyout
    SpellFlyoutBackgroundEnd:SetTexture(nil)
    SpellFlyoutHorizontalBackground:SetTexture(nil)
    SpellFlyoutVerticalBackground:SetTexture(nil)
    local function checkForFlyoutButtons(self)
      local NUM_FLYOUT_BUTTONS = 10
      for i = 1, NUM_FLYOUT_BUTTONS do
        styleActionButton(_G["SpellFlyoutButton"..i])
      end
    end
    SpellFlyout:HookScript("OnShow",checkForFlyoutButtons)

    --dominos styling
    if dominos then
      --print("Dominos found")
      for i = 1, 60 do
        styleActionButton(_G["DominosActionButton"..i])
      end
    end
    --bartender4 styling
    if bartender4 then
      --print("Bartender4 found")
      for i = 1, 120 do
        styleActionButton(_G["BT4Button"..i])
      end
    end

    --hide the hotkeys if needed
    if not dominos and not bartender4 and not cfg.hotkeys.show then
      hooksecurefunc("ActionButton_UpdateHotkeys",  updateHotkey)
    end

  end

  ---------------------------------------
  -- CALL
  ---------------------------------------

  local a = CreateFrame("Frame")
  a:RegisterEvent("PLAYER_LOGIN")
  a:SetScript("OnEvent", init)