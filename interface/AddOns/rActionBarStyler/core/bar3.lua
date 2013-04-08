
  -----------------------------
  -- INIT
  -----------------------------

  --get the addon namespace
  local addon, ns = ...
  local gcfg = ns.cfg
  --get some values from the namespace
  local cfg = gcfg.bars.bar3
  local dragFrameList = ns.dragFrameList

  -----------------------------
  -- FUNCTIONS
  -----------------------------

  if not cfg.enable then return end

  local num = NUM_ACTIONBAR_BUTTONS
  local buttonList = {}

  --create the frame to hold the buttons
  local frame = CreateFrame("Frame", "rABS_MultiBarBottomRight", UIParent, "SecureHandlerStateTemplate")
 
    frame:SetWidth(cfg.buttons.size*18 + 17*cfg.buttons.margin + 2*cfg.padding)
    frame:SetHeight(cfg.buttons.size*2 + 1*cfg.buttons.margin + 2*cfg.padding)
    frame:SetPoint("BOTTOM",rABS_MainMenuBar,"BOTTOM",0,0)
	
	frame:SetScale(cfg.scale)

  --move the buttons into position and reparent them
  MultiBarBottomRight:SetParent(frame)
  MultiBarBottomRight:EnableMouse(false)

  for i=1, num do
    local button = _G["MultiBarBottomRightButton"..i]
    table.insert(buttonList, button) --add the button object to the list
    button:SetSize(cfg.buttons.size, cfg.buttons.size)
    button:ClearAllPoints()
    if i == 1 then
		button:SetPoint("BOTTOMLEFT", frame, cfg.padding, cfg.padding)
    elseif i == 4 then
		button:SetPoint("TOPLEFT", frame,"TOPLEFT",cfg.padding,-cfg.padding)
	elseif i == 7 then
		button:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -cfg.padding-cfg.buttons.size*2-cfg.buttons.margin*2, cfg.padding)
	elseif i == 10 then
		button:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -cfg.padding-cfg.buttons.size*2-cfg.buttons.margin*2,-cfg.padding)
	else
		local previous = _G["MultiBarBottomRightButton"..i-1]
		button:SetPoint("LEFT", previous, "RIGHT", cfg.buttons.margin, 0)
      
    end
  end

  --show/hide the frame on a given state driver
  RegisterStateDriver(frame, "visibility", "[petbattle][overridebar][vehicleui][possessbar,@vehicle,exists] hide; show")

  --create drag frame and drag functionality
  if cfg.userplaced.enable then
    rCreateDragFrame(frame, dragFrameList, -2 , true) --frame, dragFrameList, inset, clamp
  end

  --create the mouseover functionality
  if cfg.mouseover.enable then
    rButtonBarFader(frame, buttonList, cfg.mouseover.fadeIn, cfg.mouseover.fadeOut) --frame, buttonList, fadeIn, fadeOut
    frame.mouseover = cfg.mouseover
  end

  --create the combat fader
  if cfg.combat.enable then
    rCombatFrameFader(frame, cfg.combat.fadeIn, cfg.combat.fadeOut) --frame, buttonList, fadeIn, fadeOut
  end