local F,C=unpack(Aurora)
local MyClass = select(2, UnitClass("player"))
local statusbar="Interface\\addons\\powerbar\\statusbar"

function MakeFontString(parent, fontHeight, fontStyle)
	local fs = parent:CreateFontString(nil, "OVERLAY")
	fs:SetFont("fonts\\frizqt__.ttf", fontHeight, fontStyle or "OUTLINE")
	fs:SetShadowColor(0, 0, 0)
	fs:SetShadowOffset(1.25, -1.25)
	return fs
end

local function CreateShadow(f, t, offset, thickness, texture)
	if f.shadow then return end
	
	local borderr, borderg, borderb, bordera = 0, 0, 0, 1
	local backdropr, backdropg, backdropb, backdropa =  .05, .05, .05, .9
	local frameLevel = f:GetFrameLevel() > 1 and f:GetFrameLevel() or 1

	local border = CreateFrame("Frame", nil, f)
	border:SetFrameLevel(frameLevel)
	border:Point("TOPLEFT", -1, 1)
	border:Point("TOPRIGHT", 1, 1)
	border:Point("BOTTOMRIGHT", 1, -1)
	border:Point("BOTTOMLEFT", -1, -1)
	border:CreateBorder()
	f.border = border
	
	local shadow = CreateFrame("Frame", nil, border)
	shadow:SetFrameLevel(frameLevel - 1)
	shadow:Point("TOPLEFT", -3, 3)
	shadow:Point("TOPRIGHT", 3, 3)
	shadow:Point("BOTTOMRIGHT", 3, -3)
	shadow:Point("BOTTOMLEFT", -3, -3)
	shadow:SetBackdrop( { 
		edgeFile = "Interface\\addons\\actionbar\\glowTex",
		bgFile ="Interface\\addons\\actionbar\\solid",
		edgeSize = 4,
		insets = {left = 4, right = 4, top = 4, bottom = 4},
	})
	shadow:SetBackdropColor( backdropr, backdropg, backdropb, backdropa )
	shadow:SetBackdropBorderColor( borderr, borderg, borderb, bordera )
	f.shadow = shadow
end

--ShadowOrbs
if MyClass == "PRIEST" then 
	local ShadowOrbs = CreateFrame("Frame", nil, UIParent)
	ShadowOrbs:SetSize(98, 10)
	ShadowOrbs:SetPoint("CENTER",UIParent,"CENTER",0,30)
	local maxShadowOrbs = 3
	
	for i = 1,3 do
		ShadowOrbs[i] = CreateFrame("StatusBar", nil, ShadowOrbs)
		ShadowOrbs[i]:SetSize(30, 10)
		ShadowOrbs[i]:SetStatusBarTexture(statusbar)
		ShadowOrbs[i]:SetStatusBarColor(.86,.22,1)
		ShadowOrbs[i]:CreateShadow()
		ShadowOrbs[i]:Hide()
		if (i == 1) then
			ShadowOrbs[i]:SetPoint("LEFT", ShadowOrbs, "LEFT")
		else
			ShadowOrbs[i]:SetPoint("LEFT", ShadowOrbs[i-1], "RIGHT", 4, 0)
		end
	end
	ShadowOrbs:RegisterEvent("PLAYER_ENTERING_WORLD")
	ShadowOrbs:RegisterEvent("UNIT_POWER")
	ShadowOrbs:RegisterEvent("UNIT_DISPLAYPOWER")
	ShadowOrbs:RegisterEvent("PLAYER_REGEN_ENABLED")
	ShadowOrbs:RegisterEvent("PLAYER_REGEN_DISABLED")
	ShadowOrbs:SetScript("OnEvent",function(self, event, unit)
		local numShadowOrbs = UnitPower('player', SPELL_POWER_SHADOW_ORBS)
		if unit == "player" then
			for i = 1,maxShadowOrbs do
				if i <= numShadowOrbs then
					ShadowOrbs[i]:Show()
				else
					ShadowOrbs[i]:Hide()
				end
			end
		end
		
	end)
end
--Monk harmony bar
	if MyClass == "MONK" then 
	local chibar = CreateFrame("Frame",nil,UIParent)
	chibar:SetSize(174, 16)
	chibar:SetPoint("CENTER",UIParent,"CENTER",0,-100)
	for i=1,5 do
		chibar[i] = CreateFrame("StatusBar",nil,chibar)
		chibar[i]:SetSize(30, 16)
		chibar[i]:SetStatusBarTexture(statusbar)
		chibar[i]:SetStatusBarColor(0.0, 1.00 , 0.59)
		chibar[i]:CreateShadow()
		if i==1 then
			chibar[i]:SetPoint("LEFT", chibar, "LEFT")
		else
			chibar[i]:SetPoint("LEFT", chibar[i-1], "RIGHT", 6, 0)
		end
		chibar[i]:Hide()
	end
	chibar:RegisterEvent("PLAYER_ENTERING_WORLD")
	chibar:RegisterEvent("UNIT_POWER")
	chibar:RegisterEvent("UNIT_DISPLAYPOWER")
	chibar:SetScript("OnEvent",function(self, event, unit)
		local chinum = UnitPower("player",SPELL_POWER_LIGHT_FORCE)
		local chimax = UnitPowerMax("player",SPELL_POWER_LIGHT_FORCE)
		if unit == "player" then
			if chinum ~= chimax then
				if chimax == 4 then
					chibar[5]:Hide()
					for i = 1,4 do
						chibar[i]:SetWidth(39)
					end
				elseif chimax == 5 then
					chibar[5]:Show()
					for i = 1,5 do
						chibar[i]:SetWidth(30)
					end
				end
			end
			for i = 1,chimax do
				if i <= chinum then
					chibar[i]:Show()
				else
					chibar[i]:Hide()
				end
			end
		end
	end)
end
--DK and QS
--下面是DK的,,,
local runes = {
	{1, 0, 0},   -- blood
	{0, .5, 0},  -- unholy
	{0, 1, 1},   -- frost
	{.9, .1, 1}, -- death
}
local runemap = { 1, 2, 5, 6, 3, 4 }
local OnUpdate = function(self, elapsed)
	local duration = self.duration + elapsed
	if(duration >= self.max) then
		return self:SetScript("OnUpdate", nil)
	else
		self.duration = duration
		return self:SetValue(duration)
	end
end
local UpdateType = function(self, rid, alt)
	local rune = self[runemap[rid]]
	local colors = runes[GetRuneType(rid) or alt]
	local r, g, b = colors[1], colors[2], colors[3]
	rune:SetStatusBarColor(r, g, b)
end
local function OnEvent(self, event, unit)
	if event == "RUNE_POWER_UPDATE" or "PLAYER_ENTERING_WORLD" then 
		for i=1, 6 do
			local rune = self[runemap[i]]
			if(rune) then
				local start, duration, runeReady = GetRuneCooldown(i)
				if(runeReady) then
					rune:SetMinMaxValues(0, 1)
					rune:SetValue(1)
					rune:SetScript("OnUpdate", nil)
				else
					rune.duration = GetTime() - start
					rune.max = duration
					rune:SetMinMaxValues(1, duration)
					rune:SetScript("OnUpdate", OnUpdate)
				end
			end
		end
	end
	if event == "RUNE_TYPE_UPDATE" then
		for i=1, 6 do
			UpdateType(self, i, math.floor((runemap[i]+1)/2))
		end
	end
end
if MyClass == "DEATHKNIGHT" or MyClass == "PALADIN" then
    local count
	if MyClass == "DEATHKNIGHT" then 
		count = 6
		RuneFrame.Show = RuneFrame.Hide
		RuneFrame:Hide()
	elseif MyClass == "PALADIN" then
		count = 5
	end
	local bars = CreateFrame("Frame", nil, UIParent)
	bars:SetSize(174, 10)
	bars:SetPoint("BOTTOMRIGHT",UIParent ,"BOTTOM",-93,330)
	for i = 1, count do
		bars[i] =CreateFrame("StatusBar", nil, bars)
		bars[i]:SetStatusBarTexture(statusbar)
		bars[i]:GetStatusBarTexture():SetHorizTile(false)
		bars[i]:SetSize((174-6*(count-1))/count, 16)
		if (i == 1) then
			bars[i]:SetPoint("LEFT", bars, "LEFT")
		else
			bars[i]:SetPoint("LEFT", bars[i-1], "RIGHT", 6, 0)
		end
        if MyClass == "PALADIN" then
            bars[i]:SetStatusBarColor(0.9, 0.9, 0)
			bars[i]:Hide()
		end
		bars[i]:CreateShadow()
	end
	if MyClass == "DEATHKNIGHT" then
		for i=1,6 do
			UpdateType(bars, i, math.floor((runemap[i]+1)/2))
		end
	end
	if MyClass == "DEATHKNIGHT" then
		bars:RegisterEvent("RUNE_POWER_UPDATE")
		bars:RegisterEvent("RUNE_TYPE_UPDATE")
		bars:RegisterEvent("PLAYER_ENTERING_WORLD")
		bars:RegisterEvent("PLAYER_REGEN_ENABLED")
		bars:RegisterEvent("PLAYER_REGEN_DISABLED")
		bars:SetScript("OnEvent", OnEvent)
	elseif MyClass == "PALADIN" then
		bars:RegisterEvent("PLAYER_ENTERING_WORLD")
		bars:RegisterEvent("UNIT_POWER")
		bars:RegisterEvent("UNIT_DISPLAYPOWER")
		bars:RegisterEvent("PLAYER_REGEN_ENABLED")
		bars:RegisterEvent("PLAYER_REGEN_DISABLED")
		bars:SetScript("OnEvent",function(self, event, unit)
			local num = UnitPower('player', SPELL_POWER_HOLY_POWER)
			if unit == "player" then
				for i = 1,count do
					if i <= num then
						bars[i]:Show()
					else
						bars[i]:Hide()
					end
				end
			end
		end)
	end
end
	--combopoints
	if MyClass == "ROGUE" or MyClass == "DRUID" then 
	local ComboPointBar = CreateFrame("Frame", nil, UIParent)
	ComboPointBar:SetSize(140, 16)
	ComboPointBar:SetPoint("CENTER",UIParent,"CENTER",0,-80)
	for i = 1, 5 do
		ComboPointBar[i] =CreateFrame("StatusBar", nil, ComboPointBar)
		ComboPointBar[i]:SetStatusBarTexture(statusbar)
		ComboPointBar[i]:GetStatusBarTexture():SetHorizTile(false)
		ComboPointBar[i]:SetSize(24, 16)
		if (i == 1) then
			ComboPointBar[i]:SetPoint("LEFT", ComboPointBar, "LEFT")
		else
			ComboPointBar[i]:SetPoint("LEFT", ComboPointBar[i-1], "RIGHT", 5, 0)
		end
		if i ~= 5 then 
			ComboPointBar[i]:SetStatusBarColor(0.9, 0.9, 0)
		else
			ComboPointBar[i]:SetStatusBarColor(1, 0.2, 0.2)
		end
		ComboPointBar[i]:CreateShadow()
		ComboPointBar[i]:Hide()
	end
	ComboPointBar:RegisterEvent("PLAYER_ENTERING_WORLD")
	ComboPointBar:RegisterEvent("UNIT_COMBO_POINTS")
	ComboPointBar:RegisterEvent("PLAYER_TARGET_CHANGED")
	ComboPointBar:SetScript("OnEvent", function(self)
		cp = GetComboPoints('player', 'target')
		for i=1,5 do
			if(i <= cp) then
				self[i]:Show()
			else
				self[i]:Hide()
			end
		end
	end)
	end
--鸟德
	if MyClass == "DRUID" then 
	local ECLIPSE_BAR_SOLAR_BUFF_ID = ECLIPSE_BAR_SOLAR_BUFF_ID
	local ECLIPSE_BAR_LUNAR_BUFF_ID = ECLIPSE_BAR_LUNAR_BUFF_ID
	local SPELL_POWER_ECLIPSE = SPELL_POWER_ECLIPSE
	local MOONKIN_FORM = MOONKIN_FORM
	local eb = CreateFrame('Frame', nil, UIParent)
	eb:SetSize(140, 16)
	eb:SetPoint("CENTER",UIParent,"CENTER",0,-110)
	eb:CreateShadow()
	local lb = CreateFrame('StatusBar', nil, eb)
	lb:SetPoint('LEFT', eb, 'LEFT')
	lb:SetSize(140,16)
	lb:SetStatusBarTexture(statusbar)
	lb:SetStatusBarColor(0.27, 0.47, 0.74)
	eb.LunarBar = lb
	local sb = CreateFrame('StatusBar', nil, eb)
	sb:SetPoint('LEFT', lb:GetStatusBarTexture(), 'RIGHT', 0, 0)
	sb:SetSize(140, 16)
	sb:SetStatusBarTexture(statusbar)
	sb:SetStatusBarColor(0.9, 0.6, 0.3)
	eb.SolarBar = sb
	local h = CreateFrame("Frame", nil, eb)
	h:SetFrameLevel(eb:GetFrameLevel()+1)
	h:SetAllPoints(eb)
	local ebInd = MakeFontString(h, 10, "THINOUTLINE")
	ebInd:SetPoint('CENTER', h, 'CENTER', 0, 0)
		
	eb:RegisterEvent("ECLIPSE_DIRECTION_CHANGE")
	eb:RegisterEvent("PLAYER_TALENT_UPDATE")
	eb:RegisterEvent("UNIT_POWER")
	eb:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
	eb:RegisterEvent("PLAYER_ENTERING_WORLD")
	eb:RegisterEvent("PLAYER_REGEN_DISABLED")
	eb:RegisterEvent("PLAYER_REGEN_ENABLED")
	eb:SetScript("OnEvent", function(self, event, unit, powerType)
		if event == "ECLIPSE_DIRECTION_CHANGE" or event == "PLAYER_ENTERING_WORLD" then
			local dir = GetEclipseDirection()
			if dir=="sun" then
				ebInd:SetText("|cff4478BC>>>|r")
			elseif dir=="moon" then
				ebInd:SetText("|cffE5994C<<<|r")
			end
		end
		if event == "PLAYER_TALENT_UPDATE" or event == "UPDATE_SHAPESHIFT_FORM" or event == "PLAYER_ENTERING_WORLD" then
			local showBar
			local form = GetShapeshiftFormID()
			if(not form) then
				local ptt = GetSpecialization()
				if(ptt and ptt == 1) then -- player has balance spec
					showBar = true
				end
			elseif(form == MOONKIN_FORM) then
				showBar = true
			end

			if(showBar) then
				eb:Show()
			else
				eb:Hide()
			end
		end
		if event == "UNIT_POWER" then
			if(unit ~= "player" or (event == 'UNIT_POWER' and powerType ~= 'ECLIPSE')) then return end

			local power = UnitPower('player', SPELL_POWER_ECLIPSE)
			local maxPower = UnitPowerMax('player', SPELL_POWER_ECLIPSE)

			if(self.LunarBar) then
				self.LunarBar:SetMinMaxValues(-maxPower, maxPower)
				self.LunarBar:SetValue(power)
			end

			if(self.SolarBar) then
				self.SolarBar:SetMinMaxValues(-maxPower, maxPower)
				self.SolarBar:SetValue(power * -1)
			end
		end
		if event == "PLAYER_ENTERING_WORLD" then 
			local power = UnitPower('player', SPELL_POWER_ECLIPSE)
			local maxPower = UnitPowerMax('player', SPELL_POWER_ECLIPSE)

			if(self.LunarBar) then
				self.LunarBar:SetMinMaxValues(-maxPower, maxPower)
				self.LunarBar:SetValue(power)
			end

			if(self.SolarBar) then
				self.SolarBar:SetMinMaxValues(-maxPower, maxPower)
				self.SolarBar:SetValue(power * -1)
			end
		end
	end)
	end
--warlock
	if MyClass == "WARLOCK" then 
	local MAX_POWER_PER_EMBER = 10
	local SPELL_POWER_DEMONIC_FURY = SPELL_POWER_DEMONIC_FURY
	local SPELL_POWER_BURNING_EMBERS = SPELL_POWER_BURNING_EMBERS
	local SPELL_POWER_SOUL_SHARDS = SPELL_POWER_SOUL_SHARDS
	local SPEC_WARLOCK_DESTRUCTION = SPEC_WARLOCK_DESTRUCTION
	local SPEC_WARLOCK_DESTRUCTION_GLYPH_EMBERS = 63304
	local SPEC_WARLOCK_AFFLICTION = SPEC_WARLOCK_AFFLICTION
	local SPEC_WARLOCK_AFFLICTION_GLYPH_SHARDS = 63302
	local SPEC_WARLOCK_DEMONOLOGY = SPEC_WARLOCK_DEMONOLOGY
	local LATEST_SPEC = 0

	local Colors = {
		[1] = {148/255, 130/255, 201/255, 1},
		[2] = {95/255, 222/255,  95/255, 1},
		[3] = {222/255, 95/255,  95/255, 1},
	}
	local bars = CreateFrame('Frame', nil, UIParent)
	bars:SetSize(132, 16)
	bars:SetPoint("CENTER",UIParent,"CENTER",0,-100)
	for i = 1, 4 do
		bars[i] = CreateFrame("StatusBar", nil, bars)
		bars[i]:SetSize(40, 16)
		bars[i]:SetStatusBarTexture(statusbar)
		local gradient = bars[i]:CreateTexture(nil, "BACKGROUND")
		gradient:SetPoint("TOPLEFT")
		gradient:SetPoint("BOTTOMRIGHT")
		gradient:SetTexture(statusbar)
		gradient:SetGradientAlpha("VERTICAL", .3, .3, .3, .6, .1, .1, .1, .6)
		bars[i]:CreateShadow()
		if i == 1 then
			bars[i]:SetPoint("LEFT", bars)
		else
			bars[i]:SetPoint("LEFT", bars[i-1], "RIGHT", 6, 0)
		end
	end
	bars:RegisterEvent("UNIT_POWER")
	bars:RegisterEvent("UNIT_DISPLAYPOWER")
	bars:RegisterEvent("PLAYER_ENTERING_WORLD")
	bars:RegisterEvent("PLAYER_TALENT_UPDATE")
	bars:RegisterEvent("PLAYER_REGEN_DISABLED")
	bars:RegisterEvent("PLAYER_REGEN_ENABLED")
	bars:SetScript("OnEvent", function(self,event,unit, powerType)
		if event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_TALENT_UPDATE" then
			local wsb = self
			local spacing = 6
			local w = wsb:GetWidth()
			local s = 0

			local spec = GetSpecialization()
			if spec then
				if not wsb:IsShown() then
					wsb:Show()
				end

				if LATEST_SPEC ~= spec then
					for i = 1, 4 do
						local max = select(2, wsb[i]:GetMinMaxValues())
						if spec == SPEC_WARLOCK_AFFLICTION then
							wsb[i]:SetValue(max)
						else
							wsb[i]:SetValue(0)
						end
						wsb[i]:Show()
					end
				end

				if spec == SPEC_WARLOCK_DESTRUCTION then
					local maxembers = 3

					for i = 1, GetNumGlyphSockets() do
						local glyphID = select(4, GetGlyphSocketInfo(i))
						if glyphID == SPEC_WARLOCK_DESTRUCTION_GLYPH_EMBERS then maxembers = 4 end
					end

					for i = 1, maxembers do
						if i ~= maxembers then
							wsb[i]:SetWidth(w / maxembers - spacing)
							s = s + (w / maxembers)
						else
							wsb[i]:SetWidth(w - s)
						end
						wsb[i]:SetStatusBarColor(unpack(Colors[SPEC_WARLOCK_DESTRUCTION]))
					end

					if maxembers == 3 then wsb[4]:Hide() else wsb[4]:Show() end
				elseif spec == SPEC_WARLOCK_AFFLICTION then
					local maxshards = 3

					for i = 1, GetNumGlyphSockets() do
						local glyphID = select(4, GetGlyphSocketInfo(i))
						if glyphID == SPEC_WARLOCK_AFFLICTION_GLYPH_SHARDS then maxshards = 4 end
					end

					for i = 1, maxshards do
						if i ~= maxshards then
							wsb[i]:SetWidth(w / maxshards - spacing)
							s = s + (w / maxshards)
						else
							wsb[i]:SetWidth(w - s)
						end
						wsb[i]:SetStatusBarColor(unpack(Colors[SPEC_WARLOCK_AFFLICTION]))
					end

					if maxshards == 3 then wsb[4]:Hide() else wsb[4]:Show() end
				elseif spec == SPEC_WARLOCK_DEMONOLOGY then
					wsb[2]:Hide()
					wsb[3]:Hide()
					wsb[4]:Hide()
					wsb[1]:SetWidth(wsb:GetWidth())
					wsb[1]:SetStatusBarColor(unpack(Colors[SPEC_WARLOCK_DEMONOLOGY]))
				end
			else
				if wsb:IsShown() then
					wsb:Hide()
				end
			end
		end
		
		if (event == "UNIT_POWER" or event == "UNIT_DISPLAYPOWER") and UnitAffectingCombat("player") then
			if(unit ~= "player" or (powerType ~= "BURNING_EMBERS" and powerType ~= "SOUL_SHARDS" and powerType ~= "DEMONIC_FURY")) then return end
			local wsb = self
			local spec = GetSpecialization()

			if spec then
				if (spec == SPEC_WARLOCK_DESTRUCTION) then
					local maxPower = UnitPowerMax("player", SPELL_POWER_BURNING_EMBERS, true)
					local power = UnitPower("player", SPELL_POWER_BURNING_EMBERS, true)
					local numEmbers = power / MAX_POWER_PER_EMBER
					local numBars = floor(maxPower / MAX_POWER_PER_EMBER)

					for i = 1, numBars do
						wsb[i]:SetMinMaxValues((MAX_POWER_PER_EMBER * i) - MAX_POWER_PER_EMBER, MAX_POWER_PER_EMBER * i)
						wsb[i]:SetValue(power)
					end
				elseif ( spec == SPEC_WARLOCK_AFFLICTION ) then
					local numShards = UnitPower("player", SPELL_POWER_SOUL_SHARDS)
					local maxShards = UnitPowerMax("player", SPELL_POWER_SOUL_SHARDS)

					for i = 1, maxShards do
						if i <= numShards then
							wsb[i]:SetAlpha(1)
						else
							wsb[i]:SetAlpha(0)
						end
					end
				elseif spec == SPEC_WARLOCK_DEMONOLOGY then
					local power = UnitPower("player", SPELL_POWER_DEMONIC_FURY)
					local maxPower = UnitPowerMax("player", SPELL_POWER_DEMONIC_FURY)
					wsb[1]:SetAlpha(1)
					wsb[1]:SetMinMaxValues(0, maxPower)
					wsb[1]:SetValue(power)
				end
			end
		end
		
	end)
end

--法爷
	if MyClass == "MAGE" then
	
	local bars = CreateFrame("Frame", nil, UIParent)
	bars:SetSize(150, 14)
	bars:SetPoint("CENTER",UIParent,"Center",0,-100)
	
	for i = 1,6 do
		bars[i] = CreateFrame("StatusBar", nil, f)
		bars[i]:SetSize((150-6*(6-1))/6, 16)
		bars[i]:SetStatusBarTexture(statusbar)
		bars[i]:SetStatusBarColor(0,0.76,1)
		bars[i]:CreateShadow()
		bars[i]:Hide()
		if (i == 1) then
			bars[i]:SetPoint("LEFT", bars)
		else
			bars[i]:SetPoint("LEFT", bars[i-1], "RIGHT", 6, 0)
		end
	end
	bars:RegisterEvent("PLAYER_ENTERING_WORLD")
	bars:RegisterEvent("UNIT_AURA")
	
	bars:SetScript("OnEvent",function(self,event,unit)
		local num = select(4, UnitDebuff("player", GetSpellInfo(36032)))
		if num == nil then num = 0 end
		if unit ~= "player" then return end
		for i = 1,6 do
			if i <= num then
				self[i]:Show()
			else
				self[i]:Hide()
			end
		end
	end)
end
