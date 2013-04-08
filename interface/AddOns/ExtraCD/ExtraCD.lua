﻿ExtraCD = LibStub("AceAddon-3.0"):NewAddon("ExtraCD", "AceEvent-3.0","AceConsole-3.0","AceTimer-3.0")

local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local AceConfig = LibStub("AceConfig-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ExtraCD")
local LSM = LibStub("LibSharedMedia-3.0")
local mod = ExtraCD
local tinsert, tremove = table.insert, table.remove
local tonumber, tostring = tonumber, tostring
local ECD_TEXT = "ExtraCD"
local ECD_VERSION = "1.1.1"
local ECD_AUTHOR = "superk"
local active = {}
local equippedItems = {}
local cdcache = {}
local unusedOverlays = {}
local unusedButtons = {}
local cdreset ={}

local dbDefaults = {
	profile = {
		Position = nil,
		talent = true,
		enchant = true,
		item = true,
		itemset = true,
		spec = true,
		enchantppm = true,
		lock = false,
		combat = false,
		showcd = false,
		showglow = true,
		showtext = true,
		overlayAtProc = false,
		glowOpacity = 1,
		tip = true,
		textOpacity = 1,
		dataLock = true,
		dataVersion = 0,
		textsize = 12,
		iconsize = 25,
		textfont = "Friz Quadrata TT",
		iconborder = "Blizzard Tooltip",
		iconinterval = 4,
		rowmax = 10,
		spells = {},
		procs = {},
		sorting = false,
		sortingData = {},
	}	
}

mod.CD_TYPE = {
	["talent"] = L["talent"],
	["spec"] = L["spec"],
	["item set"] = L["item set"],
	["item"] = L["item"],
	["enchant"] = L["enchant"],
}

--[[mod.CLASS = {
	["ALL"] = L["ALL"],
	["WARRIOR"] = L["WARRIOR"],
	["DEATHKNIGHT"] = L["DEATHKNIGHT"],
	["PALADIN"] = L["PALADIN"],
	["MONK"] = L["MONK"],
	["PRIEST"] = L["PRIEST"],
	["SHAMAN"] = L["SHAMAN"],
	["DRUID"] = L["DRUID"],
	["ROGUE"] = L["ROGUE"],
	["MAGE"] = L["MAGE"],
	["WARLOCK"] = L["WARLOCK"],
	["HUNTER"] = L["HUNTER"],
}]]

mod.HASTE_BONUS = {
	[2825] = 30,
	[80353] = 30,
	[90355] = 30,
	[32182] = 30,
}

mod.EVENT = {
	["SPELL_DAMAGE"] = true,
	["SPELL_PERIODIC_HEAL"] = true,
	["SPELL_HEAL"] = true,
	["SPELL_AURA_APPLIED"] = true,
	["SPELL_AURA_REFRESH"] = true,
	["SPELL_ENERGIZE"] = true,
	["SPELL_CAST_SUCCESS"] = true,
	["SPELL_CAST_START"] = true, -- for early frost
	["SPELL_SUMMON"] = true, -- for t12 2p
}

function mod:log(msg) DEFAULT_CHAT_FRAME:AddMessage("|cAAEEFF22ExtraCD|r:" .. (msg or "")) end

function mod:ChangeProfile()
	self:InitDB()
	self:LoadPosition()
	self:RemoveDataOptions()
	self:AddDataToOptions()
	self:ResetAllIcons()
end

function mod:ShowConfig()
	InterfaceOptionsFrame_OpenToCategory(GetAddOnMetadata("ExtraCD", "Title"))
end

function mod:OnInitialize()
	self.db1 = LibStub("AceDB-3.0"):New("ExtraCDDB", dbDefaults, "Default")
	--DEFAULT_CHAT_FRAME:AddMessage(ECD_TEXT .. ECD_VERSION .. ECD_AUTHOR .."  - /ecd ");
	self:RegisterChatCommand("ExtraCD", "ShowConfig")
	self:RegisterChatCommand("ecd", "ShowConfig")
	self.db1.RegisterCallback(self, "OnProfileChanged", "ChangeProfile")
	self.db1.RegisterCallback(self, "OnProfileCopied", "ChangeProfile")
	self.db1.RegisterCallback(self, "OnProfileReset", "ChangeProfile")
	self.db = self.db1.profile
	local bliz_options = {
		name = "ExtraCD",
		type = 'group',
	}
	bliz_options.args = {
		load = {
		name = L["Load Config"],
		type = 'execute',
		func = function()
			self:OnOptionCreate() 
			bliz_options.args.load.disabled = true 
			GameTooltip:Hide()	
		end,
		}
	}
	AceConfig:RegisterOptionsTable("ExtraCD_bliz", bliz_options)
	AceConfigDialog:AddToBlizOptions("ExtraCD_bliz", "ExtraCD")
end

function mod:OnEnable()
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED","OnTalentChanged")
	self:RegisterEvent("PLAYER_TALENT_UPDATE","OnTalentChanged")
	self:RegisterEvent("UNIT_INVENTORY_CHANGED","OnInventoryChanged")
	self:RegisterEvent("PLAYER_REGEN_DISABLED","EnterCombat")
	self:RegisterEvent("PLAYER_REGEN_ENABLED","LeaveCombat")
	self:RegisterEvent("PET_BATTLE_OPENING_START", "EnterPetBattle")
	self:RegisterEvent("PET_BATTLE_CLOSE", "LeavePetBattle")	
	
	self.bar = self:CreateBar()
	self:InitDB()
	self:LoadPosition()
	self:ScanPlayerICDs()
	self:AddIcon(self.bar)
end

function mod:OnDisable()

end

function mod:CreateBar()
	local bar = CreateFrame("Frame", nil, UIParent)
	bar:SetMovable(not self.db.lock)
	bar:SetWidth(120)
	bar:SetHeight(30)
	bar:SetClampedToScreen(true)
	bar:EnableMouse(false)
	--bar:SetScript("OnMouseDown",function(self,button) if button == "LeftButton" and bar:IsMovable() then self:StartMoving() end end)
	--bar:SetScript("OnMouseUp",function(self,button) if button == "LeftButton" and bar:IsMovable() then self:StopMovingOrSizing() ExtraCD:SavePosition() end end)
	bar:Show()
	
	--for sorting
	bar.active = active
	
	return bar
end

function mod:LoadPosition()
	self.bar:ClearAllPoints()
	local p = self.db.Position
	if p then
		self.bar:SetPoint(p.point, UIParent, p.relativePoint, p.xOfs, p.yOfs)
	else
		self.bar:SetPoint("CENTER", UIParent, "CENTER")
	end
end

function mod:SavePosition()
	local p = self.db.Position
	local point, _, relativePoint, xOfs, yOfs = self.bar:GetPoint()
	if not p then 
		self.db.Position = {}
		p = self.db.Position
	end
	p.point = point
	p.relativePoint = relativePoint
	p.xOfs = xOfs
	p.yOfs = yOfs
end
function mod:AddIcon(bar)
	local inCombat = UnitAffectingCombat("player")
	if self.db.combat and not inCombat then bar:Hide() else bar:Show() end
	for k in pairs(active) do
		self:CreateIcon(k, bar)
	end
end

local function createOverlay(btn)
	if mod.db.glowOpacity > 0 and mod.db.showglow then
		local isize = mod.db.iconsize
		local fsize = mod.db.textsize
		local overlay = tremove(unusedOverlays)
		if not overlay then
			overlay = CreateFrame("Frame", nil, btn, "ExtraCDSpellActivationAlert")
		end
		overlay:ClearAllPoints()
		overlay:SetParent(btn)
		overlay:SetAlpha(mod.db.glowOpacity)
		overlay:SetPoint("TOPLEFT", btn, "TOPLEFT", -isize * 0.4, isize * 0.4)
		overlay:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", isize * 0.4, -isize * 0.4);
		btn.overlay = overlay
		overlay.animIn:Play()
	end
end

function mod:OverlayGlowAnimOutFinished(animGroup)
    local overlay = animGroup:GetParent()
    overlay:Hide()
    tinsert(unusedOverlays, overlay)
end

function mod:CreateIcon(order, bar)
	local isize = self.db.iconsize
	local fsize = self.db.textsize
	local btn = tremove(unusedButtons)
	if not btn then
		btn = CreateFrame("Button", nil, bar)
	end
	btn:EnableMouse(true)
	btn:RegisterForClicks("AnyUp", "AnyDown")
	btn:SetWidth(isize)
	btn:SetHeight(isize)
	local row = math.ceil(order / self.db.rowmax) - 1
	if (order - 1) % self.db.rowmax == 0 then 
		btn:SetPoint("TOPLEFT", bar, 0, -(isize + self.db.iconinterval) * row )
	else
		btn:SetPoint("TOPLEFT", bar[order-1], isize + self.db.iconinterval, 0)
	end
	--btn:SetFrameStrata("LOW")
	btn:Show()
	local cd = CreateFrame("Cooldown",nil,btn)
	-- if you want using omnicc or cooldowncount to manage the cd text, comment the code below
	cd.noomnicc = true
	cd.noCooldownCount = true
	-- end
	cd:SetAllPoints(btn)
	cd:Hide()
	local backdrop = {
		-- path to the background texture
		bgFile = active[order].icon,  
		-- path to the border texture
		edgeFile = LSM:Fetch("border", self.db.iconborder),
		-- true to repeat the background texture to fill the frame, false to scale it
		-- tile = true,
		-- size (width or height) of the square repeating background tiles (in pixels)
		tileSize = isize + 2,
		-- thickness of edge segments and square size of edge corners (in pixels)
		edgeSize = 0.3 * isize,
		-- distance from the edges of the frame to those of the background texture (in pixels)
		--[[ insets = {
			left = 12,
			right = 12,
			top = 12,
			bottom =12
		}]]
	}
	btn:SetBackdrop(backdrop)
	local text = btn:CreateFontString(nil,"ARTWORK")
	text:SetFont(LSM:Fetch("font", self.db.textfont) or STANDARD_TEXT_FONT,fsize,"OUTLINE")
	text:SetTextColor(1,1,0,1)
	text:SetPoint("CENTER",btn,"CENTER",0,0)
	text:SetAlpha(self.db.textOpacity)
	
	btn.CreateOverlay = createOverlay
	if not self.db.overlayAtProc then btn:CreateOverlay() end
	-- btn.texture = texture
	btn.backrop = backdrop
	btn.text = text
	btn.cd = cd
	-- btn.border = border
	btn.cooldown = active[order].cd
	btn.ppm = active[order].ppm
	btn.duration = active[order].duration
	btn.link = GetSpellLink(active[order].id)
	btn.order = order
	bar[order] = btn
	if self.db.tip then 
		btn:SetScript("OnEnter",function(self, motion)
			if self.link then
				GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
				GameTooltip:SetHyperlink(self.link)				
				--[[local data = mod:GetSpellData()
				local desc = data[active[order].id].desc
				if desc and desc ~= "" then
					GameTooltip:AddLine(desc, 1, 0, 0)
				end]]
				GameTooltip:Show()
			end 
		end)
		btn:SetScript("OnLeave",function(self,motion)
			GameTooltip:Hide() 
		end)
	end
	btn:SetScript("OnMouseDown", function(self, button) if button == "LeftButton" and bar:IsMovable() then bar:StartMoving() end end)
	btn:SetScript("OnMouseUp", function(self, button) if button == "LeftButton" and bar:IsMovable() then bar:StopMovingOrSizing() mod:SavePosition() end end)
	btn:SetScript("OnClick", function(self, button) if button == "RightButton" and IsControlKeyDown() then mod.db.spells[tostring(active[order].id)].enable = false mod:ResetAllIcons() mod:ResetActiveOrders() end end)
end

function mod:ScanPlayerICDs()
	local _, class = UnitClass("player")
	local link1 = GetInventoryItemLink("player", 13)
	local link2 = GetInventoryItemLink("player", 14)
	local link3 = GetInventoryItemLink("player", 16)
	local trinket1
	local trinket2
	local waepon1
	if link1 then trinket1 = link1:match("item:(%d+)") end
	if link2 then trinket2 = link2:match("item:(%d+)") end
	if link3 then weapon1 = link3:match("item:(%d+)") end
		
	local items = {}
	for i = 1, 19 do
		local link = GetInventoryItemLink("player", i)
		if link then
			items[tonumber(link:match("item:(%d+)"))] = true
		end
	end

	for k, v in pairs(self.db.spells) do
		if v.enable then		
			if v.type == "talent" and self.db.talent then
				if v.class == class then
					local _, icon, _, _, learnt = GetTalentInfo(v.talent)
					if learnt then
						tinsert (active, {cd = v.cd , icon = icon, id = tonumber(k), type = "talent", duration = v.duration or 0})
					end
				end
			elseif v.type == "enchant" and self.db.enchant then
				local link = GetInventoryItemLink("player", v.slot)
				if link then
					local itemID, enchant = link:match("item:(%d+):(%d+)")
					for _, id in ipairs(v.enchant) do
						if tonumber(enchant or -1) == id then
							--local icon = GetItemIcon(tonumber(itemID))
							local _, _, icon = GetSpellInfo(tonumber(k))
							if v.ppm and not self.db.enchantppm then break end
							tinsert (active, {cd = v.cd, ppm = v.ppm, icon = icon, id = tonumber(k), type = "enchant", duration = v.duration or 0})
							break
						end
					end
				end
			elseif v.type == "spec" and self.db.spec and v.class == class then
				local playerSpec = GetSpecialization()
				for _, spec in ipairs(v.spec) do
					if spec == playerSpec then 
						local _, _, icon = GetSpellInfo(tonumber(k))
						tinsert (active, {cd = v.cd , icon = icon, id = tonumber(k), type = "spec", duration = v.duration or 0})
						break
					end		
				end
			elseif v.type == "itemset" and self.db.itemset then
				local p = 0
				for _, item in ipairs(v.items) do
					if items[item] then
						p = p + 1
					end
				end
				if p >= v.piece then
					local _, _, icon = GetSpellInfo(tonumber(k))
					tinsert (active, {cd = v.cd, icon = icon, id = tonumber(k), type = "itemset", duration = v.duration or 0})
				end
			elseif v.type == "item" and self.db.item then
				for _, item in ipairs(v.item) do
					local icon = GetItemIcon(item)
					if tonumber(trinket1 or -1) == item then
						tinsert (active, {cd = v.cd, icon = icon, id = tonumber(k), type = "item", slot = 13, duration = v.duration or 0})
						break
					elseif tonumber(trinket2 or -1) == item  then
						tinsert (active, {cd = v.cd, icon = icon, id = tonumber(k), type = "item", slot = 14, duration = v.duration or 0})
						break
					elseif tonumber(weapon1 or -1) == item  then
						tinsert (active, {cd = v.cd, icon = icon, id = tonumber(k), type = "item", slot = 16, duration = v.duration or 0})
						break
					end
				end
			elseif v.type == "custom" then
				local _, _, icon = GetSpellInfo(tostring(k))
				tinsert (active, {cd = v.cd or 0, icon = icon, id = tonumber(k), type = "custom", duration = v.duration or 0})
			end
		end
	end
	if self.db.sorting then
		table.sort(active, function(a, b)
			if not self.db.sortingData[tostring(a.id)] then
				self.db.sortingData[tostring(a.id)] = {order = 100}
			end
			if not self.db.sortingData[tostring(b.id)] then
				self.db.sortingData[tostring(b.id)] = {order = 100}
			end
			return self.db.sortingData[tostring(a.id)].order < self.db.sortingData[tostring(b.id)].order
		end)
	else
		table.sort(active, function(a, b) return a.id < b.id end)
	end
end

function mod:IsEquipedChanged()
	local changed = {}
	changed[20] = false
	for i = 1, 19 do
		changed[i] = false
		local link = GetInventoryItemLink("player", i)
		if link then
			local itemid = tonumber(link:match("item:(%d+)"))
			if equippedItems[i] ~= itemid then
				equippedItems[i] = itemid
				changed[i] = true
				changed[20] = true
			end
		else
			if equippedItems[i] then
				equippedItems[i] = nil
				changed[i] = true
				changed[20] = true
			end
		end				
	end
	return changed[20], changed
end

function mod:OnTalentChanged()
	if self.db.talent then
		self:ResetAllIcons()
		self:ResetActiveOrders()
	end
end

function mod:OnInventoryChanged(event,uid)
	local changed, t = self:IsEquipedChanged()
	if uid ~= "player" then return end
	if self.db.item or self.db.enchant then
		if changed then self:ResetAllIcons() self:ResetActiveOrders() end
	end
	for k, v in pairs(active) do
		if v.slot and t[v.slot] then 
			self:StartTimer(k, true)
		end
	end
end

function mod:ResetActiveOrders()
	if self.db.sorting and self.options then
		AceConfigDialog:SelectGroup("ExtraCD", "Advance")
		-- re-add sorting data
		for k, v in pairs(self.db.sortingData) do
			self.db.sortingData[k] = nil
		end
		for k, v in pairs(self.options.args.advance.args.sorting.args) do
			if tonumber(k) then
				self.options.args.advance.args.sorting.args[k] = nil
			end
		end
		for k, v in pairs(active) do
			self:AddSortingOption(k, v.id)
		end
	end
end

function mod:ResetAllIcons()
	self:ReleaseAllIcons()
	self:ScanPlayerICDs()
	self:AddIcon(self.bar)
	for k1, v1 in pairs(cdcache) do
		for k2, v2 in pairs(active) do
			if k1 == v2.id then 
				if (v1.cd or 0 ) + v1.start > GetTime() then
					self:StartTimer(k2, false, GetTime() - v1.start )
				end
			end
		end
	end
end

function mod:ReleaseAllIcons()
	for k, v in pairs (active) do
		local btn = self.bar[k]
		if btn then
			cdcache[v.id] = {start = btn.start or -200, cd = btn.cooldown}
			btn:Hide()
			self.bar[k] = nil
			active[k] = nil
		end
	end
end

local time = {}
local function UpdateIcon(btn, elapsed)
	if not time[btn] then time[btn] = 0 end
	time[btn] = time[btn] + elapsed
	if time[btn] > 0.2 then
		if btn.duration + btn.start > GetTime() then
			if not btn.overlay then	btn:CreateOverlay() end
			btn.timeleft = btn.start + btn.duration - GetTime()
			if mod.db.textOpacity > 0 and mod.db.showtext then
				btn.text:SetTextColor(0, 1, 0, mod.db.textOpacity)
			end
		else
			btn.timeleft = btn.start + btn.cooldown - GetTime()
			if btn.overlay then
				if btn.overlay.animIn:IsPlaying() then
					btn.overlay.animIn:Stop()
				end
				btn.overlay.animOut:Play()
				btn.overlay = nil
			end
			if mod.db.textOpacity > 0 and mod.db.showtext then
				btn.text:SetTextColor(1, 0, 0, mod.db.textOpacity)
			end
		end
		if btn.timeleft <= 0 then
			mod:EndTimer(btn.order)
		else 
			mod:UpdateText(btn.text, floor(btn.timeleft + 0.5))
		end
		time[btn] = time[btn] - 0.2
	end
end

function mod:EndTimer(order)
	local btn = self.bar[order]
	btn.timeleft = -1
	btn.start = nil
	btn.text:SetText("")
	if self.db.showcd then
		btn.cd:Hide()
	end
	if not self.db.overlayAtProc then btn:CreateOverlay() end
	btn:SetScript("OnUpdate", nil)
end

function mod:UpdateText(text, timeleft)
	if self.db.textOpacity > 0 and self.db.showtext then
		text:SetFormattedText("%d", timeleft)
	end
end

function mod:StartTimer(order, ...)
	local precd, past = select (1 , ...)
	local btn = self.bar[order]
	if active[order].ppm and active[order].ppm > 0 and (not active[order].cd or active[order].cd <= 0) then
		local haste =  math.max(GetCombatRatingBonus(CR_HASTE_MELEE),GetCombatRatingBonus(CR_HASTE_SPELL),GetCombatRatingBonus(CR_HASTE_RANGED)) / 100
		local buffId
		for i = 1, 40 do
			buffId = select(11, UnitBuff("player", i))
			if self.HASTE_BONUS[buffId] then haste = (1 + haste) * (1 + self.HASTE_BONUS[buffId] / 100) - 1 end
		end		
		local cd = 60 / active[order].ppm / (1 + haste)
		btn.cooldown = cd
		active[order].cd = cd
	end
	if precd then 
		btn.duration = 0
	else
		btn.duration = active[order].duration
	end
	-- if btn.start and btn.start + btn.cooldown > GetTime() then return end
	btn.start = GetTime() - (past or 0)
	if self.db.showcd then
		btn.cd:Show()
		btn.cd:SetCooldown(btn.start, active[order].cd)
	end
	btn:SetScript("OnUpdate", UpdateIcon)
end

function mod:PLAYER_ENTERING_WORLD()
	self:IsEquipedChanged()
end

function mod:EnterCombat()
	if self.db.combat then self.bar:Show() end
	self:StartProcTest()
end

function mod:LeaveCombat()
	if self.db.combat then self.bar:Hide() end
	self:EndProcTest()
end

local startProcTest = false
function mod:StartProcTest()
	startProcTest = true
end

function mod:EndProcTest()
	startProcTest = false
	local db = self.db.procs
	for k, v in pairs(db) do
		for i = #(v.data), 1, -1 do
			local sample = v.data[i]
			v.samples = v.samples + 1
			if sample > (v.maxInterval or 0) then 
				v.maxInterval = sample
			end
			if sample < (v.minInterval or 1000) then
				v.minInterval = sample
			end
			v.avgInterval = (v.avgInterval * (v.samples - 1) + sample ) / (v.samples)
			tremove(v.data)
		end
		v.lastProc = nil
	end
end

function mod:COMBAT_LOG_EVENT_UNFILTERED(event, ...)
	local timestamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceFlags2, destGUID, destName, destFlags, destFlags2, spellId, spellName = select (1, ...)
	if sourceGUID == UnitGUID("player") or (destGUID == UnitGUID("player") and CombatLog_Object_IsA(sourceFlags, COMBATLOG_FILTER_NEUTRAL_UNITS)) then
		--print(sourceFlags, sourceFlags2, sourceGUID, sourceName,destName,destFlags,event,spellName,spellId)
		--self:log(spellName .. spellId)
		if self.EVENT[event] then
			local dbKey = tostring(spellId)
			if self.db.spells[dbKey] then
				for k, v in pairs (active) do
					if v.id == spellId then
						--[[if v.id == 116 and event ~= "SPELL_CAST_START" then
							return
						else]]
						self:StartTimer(k)
							--[[return
						end]]
					end
				end
			end
			if startProcTest and self.db.procs[dbKey] and self.db.procs[dbKey].enable then
				local db = self.db.procs[dbKey]
				if db.lastProc then
					tinsert(db.data, timestamp - db.lastProc)
				end
				db.lastProc = timestamp
			end
			if cdreset[spellId] then
				for k,v in pairs (active) do
					if v.id == cdreset[spellId] then self:EndTimer(k) return end
				end
			end
		end
	end
end

function mod:EnterPetBattle()
	self.bar:Hide()
end

function mod:LeavePetBattle()
	if not self.db.combat then self.bar:Show() end
end
