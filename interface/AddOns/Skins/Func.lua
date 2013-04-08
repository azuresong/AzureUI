-----------------
-- Backdrop/Shadow/Glow/Border
-----------------
function CreatePanel(f, w, h, a1, p, a2, x, y)
	local _, class = UnitClass("player")
	local r, g, b = RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b
	sh = scale(h)
	sw = scale(w)
	f:SetFrameLevel(1)
	f:SetHeight(sh)
	f:SetWidth(sw)
	f:SetFrameStrata("BACKGROUND")
	f:SetPoint(a1, p, a2, x, y)
	f:SetBackdrop({
	  bgFile =  [=[Interface\ChatFrame\ChatFrameBackground]=],
      edgeFile = "Interface\\Buttons\\WHITE8x8", 
	  tile = false, tileSize = 0, edgeSize = 1, 
	  insets = { left = -1, right = -1, top = -1, bottom = -1}
	})
	f:SetBackdropColor(.05,.05,.05,0)
	f:SetBackdropBorderColor(.15,.15,.15,0)
end
function SimpleBackground(f, w, h, a1, p, a2, x, y)
	local _, class = UnitClass("player")
	local r, g, b = RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b
	sh = scale(h)
	sw = scale(w)
	f:SetFrameLevel(1)
	f:SetHeight(sh)
	f:SetWidth(sw)
	f:SetFrameStrata("BACKGROUND")
	f:SetPoint(a1, p, a2, x, y)
	f:SetBackdrop({
	  bgFile = "Interface\\AddOns\\Skins\\statusbar4",
      edgeFile = "Interface\\AddOns\\Skins\\statusbar4", 
	  tile = false, tileSize = 0, edgeSize = 1, 
	  insets = { left = 1, right = 1, top = 1, bottom = 1}
	})
	f:SetBackdropColor(.07,.07,.07, 1)
	f:SetBackdropBorderColor(0, 0, 0, 1)
end
local forInfoPanel = {
	bgFile =  "Interface\\AddOns\\Skins\\statusbar4",
	edgeFile = "Interface\\AddOns\\Skins\\glowTex", 
	edgeSize = 4,
	insets = { left = 2, right = 2, top = 2, bottom = 2 }
}
function CreateShadowforInfoPanel(f) 
	if f.shadow then return end
	local shadow = CreateFrame("Frame", nil, f)
	shadow:SetFrameLevel(0)
	shadow:SetFrameStrata(f:GetFrameStrata())
	shadow:SetPoint("TOPLEFT", -2, 2)
	shadow:SetPoint("BOTTOMRIGHT", 2, -2)
	shadow:SetBackdrop(forInfoPanel)
	shadow:SetBackdropColor(.05,.05,.05, .9)
	shadow:SetBackdropBorderColor(0, 0, 0, 1)
	f.shadow = shadow
	return shadow
end
local shadows = {
	bgFile =  "Interface\\AddOns\\Skins\\statusbar4",
	edgeFile = "Interface\\AddOns\\Skins\\glowTex", 
	edgeSize = 4,
	insets = { left = 3, right = 3, top = 3, bottom = 3 }
}
function CreateShadow(f) --
	if f.shadow then return end
	local shadow = CreateFrame("Frame", nil, f)
	shadow:SetFrameLevel(0)
	shadow:SetFrameStrata(f:GetFrameStrata())
	shadow:SetPoint("TOPLEFT", -2, 2)
	shadow:SetPoint("BOTTOMRIGHT", 2, -2)
	shadow:SetBackdrop(shadows)
	shadow:SetBackdropColor(.05,.05,.05, .9)
	shadow:SetBackdropBorderColor(0, 0, 0, 1)
	f.shadow = shadow
	return shadow
end
local shadows12345 = {
	bgFile =  "Interface\\AddOns\\Skins\\statusbar4",
	edgeFile = "Interface\\AddOns\\Skins\\glowTex", 
	edgeSize = 4,
	insets = { left = 3, right = 3, top = 3, bottom = 3 }
}
function CreateShadow12345(f) --
	if f.shadow then return end
	local shadow = CreateFrame("Frame", nil, f)
	shadow:SetFrameLevel(0)
	shadow:SetFrameStrata(f:GetFrameStrata())
	shadow:SetPoint("TOPLEFT", -0, 0)
	shadow:SetPoint("BOTTOMRIGHT", 0, -0)
	shadow:SetBackdrop(shadows12345)
	shadow:SetBackdropColor(.05,.05,.05, .9)
	shadow:SetBackdropBorderColor(0, 0, 0, 0.5)
	f.shadow = shadow
	return shadow
end
function CreateShadowclassbar(f) --
	if f.shadow then return end
	local shadow = CreateFrame("Frame", nil, f)
	shadow:SetFrameLevel(5)
	shadow:SetFrameStrata(f:GetFrameStrata())
	shadow:SetPoint("TOPLEFT", -2, 2)
	shadow:SetPoint("BOTTOMRIGHT", 2, -2)
	shadow:SetBackdrop(shadows)
	shadow:SetBackdropColor(.05,.05,.05, .9)
	shadow:SetBackdropBorderColor(0, 0, 0, 0.6)
	f.shadow = shadow
	return shadow
end
function SimpleShadow(f) --
	if f.shadow then return end
	local shadow = CreateFrame("Frame", nil, f)
	shadow:SetFrameLevel(0)
	shadow:SetFrameStrata(f:GetFrameStrata())
	shadow:SetPoint("TOPLEFT", -2, 2)
	shadow:SetPoint("BOTTOMRIGHT", 2, -2)
	shadow:SetBackdrop(shadows)
	shadow:SetBackdropColor(.05,.05,.05, 1)
	shadow:SetBackdropBorderColor(0, 0, 0, 0)
	f.shadow = shadow
	return shadow
end
function frame1px(f)
	f:SetBackdrop({
		bgFile =  [=[Interface\ChatFrame\ChatFrameBackground]=],
        edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = 1, 
		insets = {left = -1, right = -1, top = -1, bottom = -1} 
	})
	f:SetBackdropColor(.05,.05,.05,0)
	f:SetBackdropBorderColor(.15,.15,.15,0)	
end
function CreateShadowconfig(f)--
	if f.shadow then return end
	local shadow = CreateFrame("Frame", nil, f)
	shadow:SetFrameLevel(0)
	shadow:SetFrameStrata(f:GetFrameStrata())
	shadow:SetPoint("TOPLEFT", -2, 2)
	shadow:SetPoint("BOTTOMRIGHT", 2, -2)
	shadow:SetBackdrop(shadows)
	shadow:SetBackdropColor( .05,.05,.05, 0)
	shadow:SetBackdropBorderColor(0, 0, 0, 1)
	f.shadow = shadow
	return shadow
end
function CreateShadowback(f)
	if f.shadow then return end
	local shadow = CreateFrame("Frame", nil, f)
	shadow:SetFrameLevel(0)
	shadow:SetFrameStrata(f:GetFrameStrata())
	shadow:SetPoint("TOPLEFT", -2, 2)
	shadow:SetPoint("BOTTOMRIGHT", 2, -2)
	shadow:SetBackdrop(shadows)
	shadow:SetBackdropColor( .05,.05,.05, .9)
	shadow:SetBackdropBorderColor(0, 0, 0, 1)
	f.shadow = shadow
	return shadow
end
function CreateShadow3(f)--
	if f.shadow then return end
	local shadow = CreateFrame("Frame", nil, f)
	shadow:SetFrameLevel(0)
	shadow:SetFrameStrata(f:GetFrameStrata())
	shadow:SetPoint("TOPLEFT", -3, 3)
	shadow:SetPoint("BOTTOMRIGHT", 3, -3)
	shadow:SetBackdrop(shadows)
	shadow:SetBackdropColor( .05,.05,.05, 0)
	shadow:SetBackdropBorderColor(0, 0, 0, 1)
	f.shadow = shadow
	return shadow
end
function CreateShadowNameplates(f)
	if f.shadow then return end
	local shadow = CreateFrame("Frame", nil, f)
	shadow:SetFrameLevel(0)
	shadow:SetFrameStrata(f:GetFrameStrata())
	shadow:SetPoint("TOPLEFT", -4, 4)
	shadow:SetPoint("BOTTOMRIGHT", 4, -4)
	shadow:SetBackdrop(shadows)
	shadow:SetBackdropColor( .05,.05,.05, .9)
	shadow:SetBackdropBorderColor(0, 0, 0, 1)
	f.shadow = shadow
	return shadow
end
function CreateShadowNameplatesicon(f)--
	if f.shadow then return end
	local shadow = CreateFrame("Frame", nil, f)
	shadow:SetFrameLevel(0)
	shadow:SetFrameStrata(f:GetFrameStrata())
	shadow:SetPoint("TOPLEFT", -1, 1)
	shadow:SetPoint("BOTTOMRIGHT", 1, -1)
	shadow:SetBackdrop(shadows)
	shadow:SetBackdropColor( .05,.05,.05, .9)
	shadow:SetBackdropBorderColor(0, 0, 0, 1)
	f.shadow = shadow
	return shadow
end
function CreateShadow2(f)--
	if f.shadow then return end
	local shadow = CreateFrame("Frame", nil, f)
	shadow:SetFrameLevel(0)
	shadow:SetFrameStrata(f:GetFrameStrata())
	shadow:SetPoint("TOPLEFT", -5, 5)
	shadow:SetPoint("BOTTOMRIGHT", 5, -5)
	shadow:SetBackdrop(shadows)
	shadow:SetBackdropColor( .05,.05,.05, .9)
	shadow:SetBackdropBorderColor(0, 0, 0, 1)
	f.shadow = shadow
	return shadow
end
function CreateShadow0(f)--
	if f.shadow then return end
	local shadow = CreateFrame("Frame", nil, f)
	shadow:SetFrameLevel(0)
	shadow:SetFrameStrata(f:GetFrameStrata())
	shadow:SetPoint("TOPLEFT", 1, -1)
	shadow:SetPoint("BOTTOMRIGHT", -1, 1)
	shadow:SetBackdrop(shadows)
	shadow:SetBackdropColor( .05,.05,.05, .9)
	shadow:SetBackdropBorderColor(0, 0, 0, 1)
	f.shadow = shadow
	return shadow
end
function CreateShadow00(f)--
	if f.shadow then return end
	local shadow = CreateFrame("Frame", nil, f)
	shadow:SetFrameLevel(4)
	shadow:SetFrameStrata(f:GetFrameStrata())
	shadow:SetPoint("TOPLEFT", 1, -1)
	shadow:SetPoint("BOTTOMRIGHT", -1, 1)
	shadow:SetBackdrop(shadows)
	shadow:SetBackdropColor( .05,.05,.05, .9)
	shadow:SetBackdropBorderColor(0, 0, 0, 0.6)
	f.shadow = shadow
	return shadow
end
function CreateShadow1(f)
    if f.frameBD==nil then
      local frameBD = CreateFrame("Frame", nil, f)
      frameBD = CreateFrame("Frame", nil, f)
      frameBD:SetFrameLevel(5)
      frameBD:SetFrameStrata(f:GetFrameStrata())
     frameBD:SetPoint("TOPLEFT", 1, -1)
      frameBD:SetPoint("BOTTOMLEFT", 1, 1)
      frameBD:SetPoint("TOPRIGHT", -1, -1)
      frameBD:SetPoint("BOTTOMRIGHT", -1, 1)
      frameBD:SetBackdrop( { 
         edgeFile = "Interface\\AddOns\\Skins\\glowTex", edgeSize = 4,
         insets = {left = 3, right = 3, top = 3, bottom = 3},
         tile = false, tileSize = 0,
      })
      frameBD:SetBackdropColor( .05,.05,.05, .9)
	  frameBD:SetBackdropBorderColor(0, 0, 0, 0.6)
      f.frameBD = frameBD
    end
end