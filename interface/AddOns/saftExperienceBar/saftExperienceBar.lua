-- Locale ----------------
--------------------------
L = GetLocale() == "zhCN" and { 
["Hated"] = "仇恨",
["Hostile"] = "敌对",
["Unfriendly"] = "冷淡",
["Neutral"] = "中立",
["Friendly"] = "友善",
["Honored"] = "尊敬",
["Revered"] = "崇敬",
["Exalted"] = "崇拜",
["Experience:"] = "经验值",
['Current: %s/%s (%d%%)'] = '当前: %s/%s (%d%%)',
['Remaining: %s'] = '剩余: %s',
['|cffb3e1ffRested: %s (%d%%)'] = '|cffb3e1ff双倍: %s (%d%%)',
['Reputation: %s'] = '声望: %s',
['Standing: |c'] = '状态: |c',
['Rep: %s/%s (%d%%)'] = '当前: %s/%s (%d%%)',

} or {} 

setmetatable(L, {__index = function(t, i) return i end})

-- Config ----------------
--------------------------
--Bar Height and Width
--local barHeight, barWidth = 6, 160
local barHeight, barWidth = 10, 500 --去掉本行注释并注释上一行可以设置经验条的长短

--Where you want the fame to be anchored
--------AnchorPoint, AnchorTo, RelativePoint, xOffset, yOffset
local Anchor = { "TOPLEFT", UIParent, "TOPLEFT", 3, -3 } --位置

--Fonts
showText = false -- Set to false to hide text
font,fontsize,flags = [[Fonts\ARKai_T.ttf]], 8, "THINOUTLINE"

--Texture used for bar
barTex = "Interface\\Buttons\\WHITE8x8"

-----------------------------------------------------------
-- Don't edit past here unless you know what your doing! --
-----------------------------------------------------------
-- Tables ----------------
--------------------------
local function CreateSpark(f)
	if f.spark == nil then
		local spark = f:CreateTexture(nil, "OVERLAY")
		spark:SetTexture[[Interface\CastingBar\UI-CastingBar-Spark]]
		spark:SetBlendMode("ADD")
		spark:SetAlpha(.8)
		spark:SetPoint("TOPLEFT", f:GetStatusBarTexture(), "TOPRIGHT", -5, 7)
		spark:SetPoint("BOTTOMRIGHT", f:GetStatusBarTexture(), "BOTTOMRIGHT", 5, -7)
		f.spark = spark
	end
end

local saftXPBar = {}

local FactionInfo = {
	[1] = {{ 170/255, 70/255,  70/255 }, L["Hated"], "FFaa4646"},
	[2] = {{ 170/255, 70/255,  70/255 }, L["Hostile"], "FFaa4646"},
	[3] = {{ 170/255, 70/255,  70/255 }, L["Unfriendly"], "FFaa4646"},
	[4] = {{ 200/255, 180/255, 100/255 }, L["Neutral"], "FFc8b464"},
	[5] = {{ 75/255,  175/255, 75/255 }, L["Friendly"], "FF4baf4b"},
	[6] = {{ 75/255,  175/255, 75/255 }, L["Honored"], "FF4baf4b"},
	[7] = {{ 75/255,  175/255, 75/255 }, L["Revered"], "FF4baf4b"},
	[8] = {{ 155/255,  255/255, 155/255 }, L["Exalted"],"FF9bff9b"},
}
-- Functions -------------
--------------------------
-- 格式化数值,k,m,...
local ShortValue = function(value)
	if value >= 1e6 then
		return ("%.0fm"):format(value / 1e6):gsub("%.?0+([km])$", "%1")
	elseif value >= 1e3 or value <= -1e3 then
		return ("%.0fk"):format(value / 1e3):gsub("%.?+([km])$", "%1")
	else
		return value
	end
end
-- ??
function CommaValue(amount)
	local formatted = amount
	while true do  
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
		if (k==0) then
			break
		end
	end
	return formatted
end
-- 染色(声望和经验的)
function colorize(r)
	return FactionInfo[r][3]
end
--构架,初始化
function saftXPBar:Initialize()
	local frame = self.frame
	
	--Create Background and Border创建背景和边框
	local backdrop = CreateFrame("Frame", "saftXP_Backdrop", frame)
	backdrop:SetHeight(barHeight)
	backdrop:SetWidth(barWidth)
	backdrop:SetPoint(unpack(Anchor))
	backdrop:SetBackdrop({bgFile = barTex, edgeFile = barTex, edgeSize = 1, insets = { left = 1, right = 1, top = 1, bottom = 1}})
	backdrop:SetBackdropColor(0, 0, 0,0.5)
	backdrop:SetBackdropBorderColor(0,0,0)
	
	--if IsAddOnLoaded("!MyGUI") and UIMovableFrames then tinsert(UIMovableFrames, backdrop) end
	
	backdrop:SetFrameLevel(0)
	frame.backdrop = backdrop
	
	--Create XP Status Bar创建经验条
	local xpBar = CreateFrame("StatusBar", "saftXP_Bar", frame, "TextStatusBar")
	xpBar:SetWidth(barWidth-2)
	xpBar:SetHeight(barHeight-2)
	xpBar:SetPoint("TOP", backdrop,"TOP", 0, -1)
	xpBar:SetStatusBarTexture(barTex)
	xpBar:SetFrameLevel(2)
	frame.xpBar = xpBar
	CreateSpark(frame.xpBar)
	
	--Create Rested XP Status Bar创建休息条
	local restedxpBar = CreateFrame("StatusBar", "saftrestedXP_Bar", frame, "TextStatusBar")
	restedxpBar:SetWidth(barWidth-2)
	restedxpBar:SetHeight(barHeight-2)
	restedxpBar:SetPoint("TOP", backdrop,"TOP", 0, -1)
	restedxpBar:SetStatusBarTexture(barTex)
	restedxpBar:SetFrameLevel(1)
	restedxpBar:Hide()
	frame.restedxpBar = restedxpBar
	CreateSpark(frame.restedxpBar)
	
	--Create Reputation Status Bar(Only used if not max level)创建声望条(未满级时使用)
	local repBar = CreateFrame("StatusBar", "saftRep_Bar", frame, "TextStatusBar")
	repBar:SetWidth(barWidth-2)
	repBar:SetHeight(1)
	repBar:SetPoint("BOTTOM",xpBar,"BOTTOM", 0, -2)
	repBar:SetStatusBarTexture(barTex)
	repBar:SetFrameLevel(3)
	repBar:Hide()
	frame.repBar = repBar
	CreateSpark(frame.repBar)
	
	--Create frame used for mouseover and dragging创建鼠标移上去和拖动时的框体
	local mouseFrame = CreateFrame("Frame", "saftXP_dragFrame", frame)
	mouseFrame:SetAllPoints(backdrop)
	mouseFrame:SetFrameLevel(3)
	mouseFrame:EnableMouse(true)
	frame.mouseFrame = mouseFrame
	
	--Create XP Text创建经验条文字
	if showText == true then
		local xpText = mouseFrame:CreateFontString("saftXP_Text", "OVERLAY")
		xpText:SetFont(font, fontsize, flags)
		xpText:SetPoint("CENTER", backdrop, "CENTER", 0, 0.5)

		frame.xpText = xpText
	end
	
	--Event handling事件
	frame:RegisterEvent("PLAYER_LEVEL_UP")
	frame:RegisterEvent("PLAYER_XP_UPDATE")
	frame:RegisterEvent("UPDATE_EXHAUSTION")
	frame:RegisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE")
	frame:RegisterEvent("UPDATE_FACTION")
    frame:SetScript("OnEvent", function() 
		self:ShowBar() 
    end)
end

-- Setup bar info设置条信息
function saftXPBar:ShowBar()
	if UnitLevel("player") ~= MAX_PLAYER_LEVEL then
		local XP, maxXP = UnitXP("player"), UnitXPMax("player")
		local restXP = GetXPExhaustion()
		local percXP = floor(XP/maxXP*100)
		local str
		--Setup Text
		if self.frame.xpText then
			if restXP then
				str = format("%s/%s (%s%%|cffb3e1ff+%d%%|r)", ShortValue(XP), ShortValue(maxXP), percXP, restXP/maxXP*100)
			else
				str = format("%s/%s (%s%%)", ShortValue(XP), ShortValue(maxXP), percXP)
			end
			self.frame.xpText:SetText(str)
		end
		--Setup Bar
		if GetXPExhaustion() then 
			if not self.frame.restedxpBar:IsShown() then
				self.frame.restedxpBar:Show()
			end
			self.frame.restedxpBar:SetStatusBarColor(0, .4, .8)
			self.frame.restedxpBar:SetMinMaxValues(min(0, XP), maxXP)
			self.frame.restedxpBar:SetValue(XP+restXP)
		else
			if self.frame.restedxpBar:IsShown() then
				self.frame.restedxpBar:Hide()
			end
		end
		
		self.frame.xpBar:SetStatusBarColor(.5, 0, .75)
		self.frame.xpBar:SetMinMaxValues(min(0, XP), maxXP)
		self.frame.xpBar:SetValue(XP)	

		if GetWatchedFactionInfo() then
			local name, rank, min, max, value = GetWatchedFactionInfo()
			if not self.frame.repBar:IsShown() then self.frame.repBar:Show() end
			self.frame.repBar:SetStatusBarColor(unpack(FactionInfo[rank][1]))
			self.frame.repBar:SetMinMaxValues(min, max)
			self.frame.repBar:SetValue(value)
			self.frame.xpBar:SetHeight(barHeight-4)
			self.frame.restedxpBar:SetHeight(barHeight-4)
		else
			if self.frame.repBar:IsShown() then self.frame.repBar:Hide() end
			self.frame.xpBar:SetHeight(barHeight-2)
			self.frame.restedxpBar:SetHeight(barHeight-2)
		end
		
		--Setup Exp Tooltip
		self.frame.mouseFrame:SetScript("OnEnter", function()
			GameTooltip:SetOwner(self.frame.mouseFrame, "ANCHOR_TOP", -3, barHeight) --经验条鼠标提示位置
			GameTooltip:ClearLines()
			GameTooltip:AddLine(L["Experience:"])
			GameTooltip:AddLine(string.format(L['Current: %s/%s (%d%%)'], CommaValue(XP), CommaValue(maxXP), (XP/maxXP)*100))
			GameTooltip:AddLine(string.format(L['Remaining: %s'], CommaValue(maxXP-XP)))	
			if restXP then
				GameTooltip:AddLine(string.format(L['|cffb3e1ffRested: %s (%d%%)'], CommaValue(restXP), restXP/maxXP*100))
			end
			if GetWatchedFactionInfo() then
				local name, rank, min, max, value = GetWatchedFactionInfo()
				GameTooltip:AddLine(" ")
				GameTooltip:AddLine(string.format(L['Reputation: %s'], name))
				GameTooltip:AddLine(string.format(L['Standing: |c']..colorize(rank)..'%s|r', FactionInfo[rank][2]))
				GameTooltip:AddLine(string.format(L['Rep: %s/%s (%d%%)'], CommaValue(value-min), CommaValue(max-min), (value-min)/(max-min)*100))
				GameTooltip:AddLine(string.format(L['Remaining: %s'], CommaValue(max-value)))
			end
			GameTooltip:Show()
		end)
		self.frame.mouseFrame:SetScript("OnLeave", function() GameTooltip:Hide() end)
		
		--Send experience info in chat
		self.frame.mouseFrame:SetScript("OnMouseDown", function()
			if IsShiftKeyDown() then
				if GetNumRaidMembers() > 0 then
					SendChatMessage("I'm currently at "..CommaValue(XP).."/"..CommaValue(maxXP).." ("..floor((XP/maxXP)*100).."%) experience.","RAID")
				elseif GetNumPartyMembers() > 0 then
					SendChatMessage("I'm currently at "..CommaValue(XP).."/"..CommaValue(maxXP).." ("..floor((XP/maxXP)*100).."%) experience.","PARTY")
				end
			end
		end)
	else
		if GetWatchedFactionInfo() then
			local name, rank, min, max, value = GetWatchedFactionInfo()
			local str
			--Setup Text
			if self.frame.xpText then
				str = format("%d / %d (%d%%)", value-min, max-min, (value-min)/(max-min)*100)
				self.frame.xpText:SetText(str)
			end
			--Setup Bar
			self.frame.xpBar:SetStatusBarColor(unpack(FactionInfo[rank][1]))
			self.frame.xpBar:SetMinMaxValues(min, max)
			self.frame.xpBar:SetValue(value)
			--Setup Exp Tooltip
			self.frame.mouseFrame:SetScript("OnEnter", function()
				GameTooltip:SetOwner(self.frame.mouseFrame, "ANCHOR_TOP", -3, barHeight) --声望条鼠标提示位置
				GameTooltip:ClearLines()
				GameTooltip:AddLine(string.format(L['Reputation: %s'], name))
				GameTooltip:AddLine(string.format(L['Standing: |c']..colorize(rank)..'%s|r', FactionInfo[rank][2]))
				GameTooltip:AddLine(string.format(L['Rep: %s/%s (%d%%)'], CommaValue(value-min), CommaValue(max-min), (value-min)/(max-min)*100))
				GameTooltip:AddLine(string.format(L['Remaining: %s'], CommaValue(max-value)))
				GameTooltip:Show()
			end)
			self.frame.mouseFrame:SetScript("OnLeave", function() GameTooltip:Hide() end)
			
			--Send reputation info in chat
			self.frame.mouseFrame:SetScript("OnMouseDown", function()
				if IsShiftKeyDown() then
					if GetNumRaidMembers() > 0 then
						SendChatMessage("I'm currently "..FactionInfo[rank][2].." with "..name.." ("..(value-min).."/"..(max-min)..").","RAID")
					elseif GetNumPartyMembers() > 0 then
						SendChatMessage("I'm currently "..FactionInfo[rank][2].." with "..name.." ("..(value-min).."/"..(max-min)..").","PARTY")
					end
				end
			end)

			if not self.frame:IsShown() then self.frame:Show() end
		else
			self.frame:Hide()
		end
	end
end

-- Event Stuff -----------
--------------------------
local frame = CreateFrame("Frame",nil,UIParent)
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function()
	saftXPBar:Initialize()
	saftXPBar:ShowBar()
end)

saftXPBar.frame = frame