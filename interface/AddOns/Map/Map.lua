local F, C = unpack(Aurora)


local function Kill(object)
	object.Show = dummy
	object:Hide()
end
local function KillTex(object, kill)
	for i=1, object:GetNumRegions() do
		local region = select(i, object:GetRegions())
		if region:GetObjectType() == "Texture" then
			if kill then
				Kill(region)
			else
				region:SetTexture(nil)
			end
		end
	end		
end
local function CreateBackdrop(f, t)
	if f.backdrop then return end
	
	local b = CreateFrame("Frame", nil, f)
	b:SetPoint("TOPLEFT", -2, 2)
	b:SetPoint("BOTTOMRIGHT", 2, -2)
	F.CreateBD(b)

	if f:GetFrameLevel() - 1 >= 0 then
		b:SetFrameLevel(f:GetFrameLevel() - 1)
	else
		b:SetFrameLevel(0)
	end
	
	f.backdrop = b
end
local function CreateBackdrop1(f, t)
	if f.backdrop then return end
	
	local b = CreateFrame("Frame", nil, f)
	b:SetPoint("TOPLEFT", -2, 2)
	b:SetPoint("BOTTOMRIGHT", 2, -2)
	F.SetBD(b)

	if f:GetFrameLevel() - 1 >= 0 then
		b:SetFrameLevel(f:GetFrameLevel() - 1)
	else
		b:SetFrameLevel(0)
	end
	
	f.backdrop = b
end

local function CreateBackdropBD(f,a,e,c,d) 
   if f.backdrop then return end 
   
   local b = CreateFrame("Frame", nil, f ) 
   b:SetPoint("TOPLEFT", a, e) 
   b:SetPoint("BOTTOMRIGHT", c, d) 
   b:SetFrameStrata("FULLSCREEN") 
   F.CreateBD(b) 

   if f:GetFrameLevel() - 1 >= 0 then 
      b:SetFrameLevel(f:GetFrameLevel() - 1) 
   else 
      b:SetFrameLevel(0) 
   end 
   
   f.backdrop = b 
end 

local function SkinCheckBox(frame)
	KillTex(frame)
	CreateBackdrop(frame)
	frame.backdrop:SetPoint("TOPLEFT", 4, -4)
	frame.backdrop:SetPoint("BOTTOMRIGHT", -4, 4)
	
	if frame.SetCheckedTexture then
		frame:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
	end
	
	frame:SetDisabledTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled")
end

local function SkinCloseButton(f, SetPoint)
	for i=1, f:GetNumRegions() do
		local region = select(i, f:GetRegions())
		if region:GetObjectType() == "Texture" then
			region:SetDesaturated(1)
		end
	end	
	
	if SetPoint then
		f:SetPoint("TOPRIGHT", SetPoint, "TOPRIGHT", -4, -4)
	end
end
F.ReskinClose1 = function(f, t) 
   f:SetSize(17, 17) 
   f:SetPoint("TOPRIGHT", -4, -4) 
   f:SetNormalTexture("") 
   f:SetHighlightTexture("") 
   f:SetPushedTexture("") 
   f:SetDisabledTexture("") 
   F.CreateBD(f, 0) 

   local tex = f:CreateTexture(nil, "BACKGROUND") 
   tex:SetPoint("TOPLEFT") 
   tex:SetPoint("BOTTOMRIGHT") 
   tex:SetTexture(C.media.backdrop) 
   tex:SetGradientAlpha("VERTICAL", 0, 0, 0, .3, .35, .35, .35, .35) 

   local text = f:CreateFontString(nil, "OVERLAY") 
   text:SetFont("fonts\\Frizqt__.TTF", 12, "THINOUTLINE") 
   text:SetPoint("CENTER", 1, 0) 
   text:SetText(t) 

   f:HookScript("OnEnter", function(self) text:SetTextColor(1, .1, .1) end) 
    f:HookScript("OnLeave", function(self) text:SetTextColor(1, 1, 1) end) 
end 

do
	SetfontString = function(parent, fontName, fontHeight, fontStyle)
		local fs = parent:CreateFontString(nil, "OVERLAY")
		fs:SetFont("Fonts\\Frizqt__.ttf", fontHeight, fontStyle)
		fs:SetJustifyH("LEFT")
		fs:SetShadowColor(0, 0, 0)
		fs:SetShadowOffset(1.25, -1.25)
		return fs
	end
end	


--World Map
	
CreateBackdrop1(WorldMapFrame)

WorldMapDetailFrame.backdrop = CreateFrame("Frame", nil, WorldMapFrame)
F.CreateBD(WorldMapDetailFrame.backdrop)
WorldMapDetailFrame.backdrop:SetPoint("TOPLEFT", WorldMapDetailFrame, "TOPLEFT", -2, 2)
WorldMapDetailFrame.backdrop:SetPoint("BOTTOMRIGHT", WorldMapDetailFrame, "BOTTOMRIGHT", 2, -2)
WorldMapDetailFrame.backdrop:SetFrameLevel(WorldMapDetailFrame:GetFrameLevel() - 2)

SkinCloseButton(WorldMapFrameCloseButton)
SkinCloseButton(WorldMapFrameSizeDownButton)
SkinCloseButton(WorldMapFrameSizeUpButton)
									
F.ReskinDropDown(WorldMapLevelDropDown)
F.ReskinDropDown(WorldMapZoneMinimapDropDown)
F.ReskinDropDown(WorldMapContinentDropDown)
F.ReskinDropDown(WorldMapZoneDropDown)
			
F.Reskin(WorldMapZoomOutButton)
WorldMapZoomOutButton:SetPoint("LEFT", WorldMapZoneDropDown, "RIGHT", 0, 4)
WorldMapLevelUpButton:SetPoint("TOPLEFT", WorldMapLevelDropDown, "TOPRIGHT", -2, 8)
WorldMapLevelDownButton:SetPoint("BOTTOMLEFT", WorldMapLevelDropDown, "BOTTOMRIGHT", -2, 2)
SkinCheckBox(WorldMapTrackQuest)
SkinCheckBox(WorldMapQuestShowObjectives)
SkinCheckBox(WorldMapShowDigSites)
         WorldMapDetailFrame.backdrop = CreateFrame("Frame", nil, WorldMapFrame) 
         F.CreateBD(WorldMapDetailFrame.backdrop) 
         WorldMapDetailFrame.backdrop:SetPoint("TOPLEFT", WorldMapDetailFrame, "TOPLEFT", -2, 2) 
         WorldMapDetailFrame.backdrop:SetPoint("BOTTOMRIGHT", WorldMapDetailFrame, "BOTTOMRIGHT", 2, -2) 
         WorldMapDetailFrame.backdrop:SetFrameLevel(WorldMapDetailFrame:GetFrameLevel() - 2) 

         F.ReskinClose(WorldMapFrameCloseButton) 
         F.ReskinClose1(WorldMapFrameSizeDownButton,"S") 
         F.ReskinClose1(WorldMapFrameSizeUpButton,"L") 
                           
         F.ReskinDropDown(WorldMapLevelDropDown) 
         F.ReskinDropDown(WorldMapZoneMinimapDropDown) 
         F.ReskinDropDown(WorldMapContinentDropDown) 
         F.ReskinDropDown(WorldMapZoneDropDown) 
         
         F.ReskinScroll(WorldMapQuestDetailScrollFrameScrollBar) 
         F.ReskinScroll(WorldMapQuestScrollFrameScrollBar) 
         
         F.Reskin(WorldMapZoomOutButton) 
         WorldMapZoomOutButton:SetPoint("LEFT", WorldMapZoneDropDown, "RIGHT", 0, 4) 
         WorldMapLevelUpButton:SetPoint("TOPLEFT", WorldMapLevelDropDown, "TOPRIGHT", -2, 8) 
         WorldMapLevelDownButton:SetPoint("BOTTOMLEFT", WorldMapLevelDropDown, "BOTTOMRIGHT", -2, 2) 
         
         F.ReskinCheck(WorldMapTrackQuest) 
         F.ReskinCheck(WorldMapQuestShowObjectives) 
         F.ReskinCheck(WorldMapShowDigSites) 
         
         --Mini 
         local function SmallSkin() 
            WorldMapLevelDropDown:ClearAllPoints() 
            WorldMapLevelDropDown:SetPoint("TOPLEFT", WorldMapDetailFrame, "TOPLEFT", -17, 27) 

            WorldMapFrame.backdrop:ClearAllPoints() 
            WorldMapFrame.backdrop:SetPoint("TOPLEFT",WorldMapDetailFrame,"TOPLEFT", -11, 25)     --微调这里可以解决边框丢失1px 
            WorldMapFrame.backdrop:SetPoint("BOTTOMRIGHT",WorldMapDetailFrame,"BOTTOMRIGHT", 11, -22)  --微调这里可以解决边框丢失1px 
            WorldMapFrame.backdrop:SetFrameLevel(WorldMapFrame:GetFrameLevel()) 
            WorldMapFrame.backdrop:EnableMouse(true) 
             
            WorldMapFrameCloseButton:ClearAllPoints() 
            WorldMapFrameCloseButton:SetPoint("TOPRIGHT", WorldMapFrame.backdrop, "TOPRIGHT", -3, -3) 
            WorldMapFrameCloseButton:SetFrameLevel(WorldMapFrame.backdrop:GetFrameLevel()+1) 
             
            WorldMapFrameSizeUpButton:ClearAllPoints() 
            WorldMapFrameSizeUpButton:SetPoint("TOPRIGHT", WorldMapFrame.backdrop, "TOPRIGHT", -22, -3) 
            WorldMapFrameSizeUpButton:SetFrameLevel(WorldMapFrame.backdrop:GetFrameLevel()+1) 
             
            WorldMapQuestShowObjectivesText:SetParent(WorldMapFrame) 
            WorldMapQuestShowObjectivesText:ClearAllPoints() 
            WorldMapQuestShowObjectivesText:SetPoint("BOTTOMRIGHT", WorldMapFrame.backdrop, "BOTTOMRIGHT", -9, 4) 
            WorldMapQuestShowObjectivesText:SetFont("Fonts\\Frizqt__.ttf", 12, "OUTLINE") 
            WorldMapQuestShowObjectivesText:SetShadowOffset(0, 0) 
            WorldMapQuestShowObjectivesText:SetTextColor(WorldMapQuestShowObjectivesText:GetTextColor()) 
            WorldMapQuestShowObjectives:SetParent(WorldMapFrame) 
            WorldMapQuestShowObjectives:ClearAllPoints() 
            WorldMapQuestShowObjectives:SetSize(20,20) 
            WorldMapQuestShowObjectives:SetPoint("CENTER", WorldMapQuestShowObjectivesText, "LEFT",-10,0)       
             
            WorldMapTrackQuest:SetParent(WorldMapFrame) 
            WorldMapTrackQuest:ClearAllPoints() 
            WorldMapTrackQuest:SetSize(20,20) 
            WorldMapTrackQuest:SetPoint("BOTTOMLEFT", WorldMapFrame.backdrop,"BOTTOMLEFT", 8, 1) 
            WorldMapTrackQuestText:SetFont("Fonts\\Frizqt__.ttf", 12, "OUTLINE") 
            WorldMapTrackQuestText:SetPoint("LEFT",WorldMapTrackQuest,"RIGHT",5,0) 
            WorldMapTrackQuestText:SetShadowOffset(0, 0) 
            WorldMapTrackQuestText:SetTextColor(WorldMapQuestShowObjectivesText:GetTextColor())             
             
            WorldMapShowDigSitesText:SetFont("Fonts\\Frizqt__.ttf", 12, "OUTLINE") 
            WorldMapShowDigSitesText:SetShadowOffset(0, 0) 
            WorldMapShowDigSitesText:ClearAllPoints() 
            WorldMapShowDigSitesText:SetPoint("BOTTOMRIGHT",WorldMapFrame.backdrop,"BOTTOMRIGHT",-230,4) 
            WorldMapShowDigSitesText:SetTextColor(WorldMapQuestShowObjectivesText:GetTextColor()) 
            WorldMapShowDigSites:SetParent(WorldMapFrame) 
            WorldMapShowDigSites:ClearAllPoints() 
            WorldMapShowDigSites:SetPoint("CENTER", WorldMapShowDigSitesText, "LEFT", -10, 0) 
            WorldMapShowDigSites:SetSize(20,20) 
             
         end 
         
         --大地图不追踪任务 
         local function LargeSkin() 
            if not InCombatLockdown() then 
               WorldMapFrame:SetParent(UIParent) 
               WorldMapFrame:SetFrameStrata("FULLSCREEN") 
               WorldMapFrame:EnableMouse(false) 
               WorldMapFrame:EnableKeyboard(false) 
               SetUIPanelAttribute(WorldMapFrame, "area", "center"); 
               SetUIPanelAttribute(WorldMapFrame, "allowOtherPanels", true) 
            end 
             
            WorldMapFrame.backdrop:ClearAllPoints() 
            WorldMapFrame.backdrop:SetPoint("TOPLEFT", WorldMapDetailFrame, "TOPLEFT", -15, 64) --微调这里可以解决边框丢失1px 
            WorldMapFrame.backdrop:SetPoint("BOTTOMRIGHT", WorldMapDetailFrame, "BOTTOMRIGHT", 15, -23)    --微调这里可以解决边框丢失1px 
            WorldMapFrame.backdrop:SetFrameLevel(WorldMapFrame:GetFrameLevel()) 
            WorldMapFrame.backdrop:EnableMouse(true) 
             
            WorldMapFrameCloseButton:ClearAllPoints() 
            WorldMapFrameCloseButton:SetPoint("TOPRIGHT", WorldMapFrame.backdrop, "TOPRIGHT", -3, -3) 
            WorldMapFrameCloseButton:SetFrameLevel(WorldMapFrame.backdrop:GetFrameLevel()+1) 
             
            WorldMapFrameSizeDownButton:ClearAllPoints() 
            WorldMapFrameSizeDownButton:SetPoint("TOPRIGHT", WorldMapFrame.backdrop, "TOPRIGHT", -22, -3) 
            WorldMapFrameSizeDownButton:SetFrameLevel(WorldMapFrame.backdrop:GetFrameLevel()+1) 
             
            WorldMapQuestShowObjectivesText:SetParent(WorldMapFrame) 
            WorldMapQuestShowObjectivesText:ClearAllPoints() 
            WorldMapQuestShowObjectivesText:SetPoint("BOTTOMRIGHT", WorldMapFrame.backdrop, "BOTTOMRIGHT", -11, 4) 
            WorldMapQuestShowObjectivesText:SetFont("Fonts\\Frizqt__.ttf", 12, "OUTLINE") 
            WorldMapQuestShowObjectivesText:SetShadowOffset(0, 0) 
            WorldMapQuestShowObjectivesText:SetTextColor(WorldMapQuestShowObjectivesText:GetTextColor()) 
            WorldMapQuestShowObjectives:SetParent(WorldMapFrame) 
            WorldMapQuestShowObjectives:ClearAllPoints() 
            WorldMapQuestShowObjectives:SetSize(20,20) 
            WorldMapQuestShowObjectives:SetPoint("CENTER", WorldMapQuestShowObjectivesText, "LEFT",-10,0)       
             
            WorldMapShowDigSitesText:SetFont("Fonts\\Frizqt__.ttf", 12, "OUTLINE") 
            WorldMapShowDigSitesText:SetShadowOffset(0, 0) 
            WorldMapShowDigSitesText:ClearAllPoints() 
            WorldMapShowDigSitesText:SetPoint("BOTTOMRIGHT",WorldMapFrame.backdrop,"BOTTOMRIGHT",-230,4) 
            WorldMapShowDigSitesText:SetTextColor(WorldMapQuestShowObjectivesText:GetTextColor()) 
            WorldMapShowDigSites:SetParent(WorldMapFrame) 
            WorldMapShowDigSites:ClearAllPoints() 
            WorldMapShowDigSites:SetPoint("CENTER", WorldMapShowDigSitesText, "LEFT", -10, 0) 
            WorldMapShowDigSites:SetSize(20,20) 
             
         end 
       
         --大地图追踪任务 
         local function QuestSkin() 
            if not InCombatLockdown() then 
               WorldMapFrame:SetParent(UIParent) 
               WorldMapFrame:SetFrameStrata("FULLSCREEN") 
               WorldMapFrame:EnableMouse(false) 
               WorldMapFrame:EnableKeyboard(false) 
               SetUIPanelAttribute(WorldMapFrame, "area", "center"); 
               SetUIPanelAttribute(WorldMapFrame, "allowOtherPanels", true) 
            end 
             
            WorldMapFrame.backdrop:ClearAllPoints() 
            WorldMapFrame.backdrop:SetPoint("TOPLEFT", WorldMapDetailFrame, "TOPLEFT", -15.5, 63.5)   --微调这里可以解决边框丢失1px 
            WorldMapFrame.backdrop:SetPoint("BOTTOMRIGHT", WorldMapDetailFrame, "BOTTOMRIGHT", 324.5, -230)  --微调这里可以解决边框丢失1px 
            WorldMapFrame.backdrop:SetFrameStrata("FULLSCREEN") 
            WorldMapFrame.backdrop:EnableMouse(true) 
             
            WorldMapFrameCloseButton:ClearAllPoints() 
            WorldMapFrameCloseButton:SetPoint("TOPRIGHT", WorldMapFrame.backdrop, "TOPRIGHT", -3, -3) 
            WorldMapFrameCloseButton:SetFrameLevel(WorldMapFrame.backdrop:GetFrameLevel()+1) 
             
            WorldMapFrameSizeDownButton:ClearAllPoints() 
            WorldMapFrameSizeDownButton:SetPoint("TOPRIGHT", WorldMapFrame.backdrop, "TOPRIGHT", -22, -3) 
            WorldMapFrameSizeDownButton:SetFrameLevel(WorldMapFrame.backdrop:GetFrameLevel()+1) 
             
            WorldMapQuestShowObjectivesText:SetParent(WorldMapFrame) 
            WorldMapQuestShowObjectivesText:ClearAllPoints() 
            WorldMapQuestShowObjectivesText:SetPoint("BOTTOMRIGHT", WorldMapFrame.backdrop, "BOTTOMRIGHT", -11, 4) 
            WorldMapQuestShowObjectivesText:SetFont("Fonts\\Frizqt__.ttf", 12, "OUTLINE") 
            WorldMapQuestShowObjectivesText:SetShadowOffset(0, 0) 
            WorldMapQuestShowObjectivesText:SetTextColor(WorldMapQuestShowObjectivesText:GetTextColor()) 
            WorldMapQuestShowObjectives:SetParent(WorldMapFrame) 
            WorldMapQuestShowObjectives:ClearAllPoints() 
            WorldMapQuestShowObjectives:SetSize(18,18) 
            WorldMapQuestShowObjectives:SetPoint("CENTER", WorldMapQuestShowObjectivesText, "LEFT",-10,0)       
             
            WorldMapTrackQuest:SetParent(WorldMapFrame) 
            WorldMapTrackQuest:ClearAllPoints() 
            WorldMapTrackQuest:SetSize(20,20) 
            WorldMapTrackQuest:SetPoint("BOTTOMLEFT", WorldMapFrame.backdrop,"BOTTOMLEFT", 13, 1) 
            WorldMapTrackQuestText:SetFont("Fonts\\Frizqt__.ttf", 12, "OUTLINE") 
            WorldMapTrackQuestText:SetPoint("LEFT",WorldMapTrackQuest,"RIGHT",5,0) 
            WorldMapTrackQuestText:SetShadowOffset(0, 0) 
            WorldMapTrackQuestText:SetTextColor(WorldMapQuestShowObjectivesText:GetTextColor())             
             
            WorldMapShowDigSitesText:SetFont("Fonts\\Frizqt__.ttf", 12, "OUTLINE") 
            WorldMapShowDigSitesText:SetShadowOffset(0, 0) 
            WorldMapShowDigSitesText:ClearAllPoints() 
            WorldMapShowDigSitesText:SetPoint("BOTTOMRIGHT",WorldMapFrame.backdrop,"BOTTOMRIGHT",-230,4) 
            WorldMapShowDigSitesText:SetTextColor(WorldMapQuestShowObjectivesText:GetTextColor()) 
            WorldMapShowDigSites:SetParent(WorldMapFrame) 
            WorldMapShowDigSites:ClearAllPoints() 
            WorldMapShowDigSites:SetPoint("CENTER", WorldMapShowDigSitesText, "LEFT", -10, 0) 
            WorldMapShowDigSites:SetSize(20,20) 

            --任务描述 
            if not WorldMapQuestDetailScrollFrame.backdrop then 
               CreateBackdropBD(WorldMapQuestDetailScrollFrame,-2,2,2,-2) 
               WorldMapQuestDetailScrollFrame.backdrop:SetPoint("TOPLEFT", -21.5, 2)   --微调这里可以解决边框丢失1px 
               WorldMapQuestDetailScrollFrame.backdrop:SetPoint("BOTTOMRIGHT", 23.5, -4)   --微调这里可以解决边框丢失1px 
            end 
            --任务奖励 
            if not WorldMapQuestRewardScrollFrame.backdrop then 
               CreateBackdropBD(WorldMapQuestRewardScrollFrame,-2,2,2,-2) 
               WorldMapQuestRewardScrollFrame.backdrop:SetPoint("TOPLEFT", 0.5, 2)   --微调这里可以解决边框丢失1px 
               WorldMapQuestRewardScrollFrame.backdrop:SetPoint("BOTTOMRIGHT", 20.5, -4)   --微调这里可以解决边框丢失1px   
            end 
            --地图右侧任务目录 
            if not WorldMapQuestScrollFrame.backdrop then 
               CreateBackdropBD(WorldMapQuestScrollFrame,-2,2,2,-2) 
               WorldMapQuestScrollFrame.backdrop:SetPoint("TOPLEFT", 0.5, 1.5)   --微调这里可以解决边框丢失1px 
               WorldMapQuestScrollFrame.backdrop:SetPoint("BOTTOMRIGHT", 24.5, -2.5)   --微调这里可以解决边框丢失1px   
            end 
         end         
			
local function FixSkin()
	KillTex(WorldMapFrame)
	if WORLDMAP_SETTINGS.size == WORLDMAP_FULLMAP_SIZE then
		LargeSkin()
	elseif WORLDMAP_SETTINGS.size == WORLDMAP_WINDOWED_SIZE then
		SmallSkin()
	elseif WORLDMAP_SETTINGS.size == WORLDMAP_QUESTLIST_SIZE then
		QuestSkin()
	end
	
	if not InCombatLockdown() then
		WorldMapFrame:SetScale(1)
		WorldMapFrameSizeDownButton:Show()
		WorldMapFrame:SetFrameLevel(10)
	else
		WorldMapFrameSizeDownButton:Disable()
		WorldMapFrameSizeUpButton:Disable()
	end	
				
	WorldMapFrameAreaLabel:SetFont("Fonts\\Frizqt__.ttf", 50, "OUTLINE")
	WorldMapFrameAreaLabel:SetShadowOffset(2, -2)
	WorldMapFrameAreaLabel:SetTextColor(0.90, 0.8294, 0.6407)	
				
	WorldMapFrameAreaDescription:SetFont("Fonts\\Frizqt__.ttf", 40, "OUTLINE")
	WorldMapFrameAreaDescription:SetShadowOffset(2, -2)	
				
	WorldMapZoneInfo:SetFont("Fonts\\Frizqt__.ttf", 27, "OUTLINE")
	WorldMapZoneInfo:SetShadowOffset(2, -2)		
end
			
WorldMapFrame:HookScript("OnShow", FixSkin)
hooksecurefunc("WorldMapFrame_SetFullMapView", LargeSkin)
hooksecurefunc("WorldMapFrame_SetQuestMapView", QuestSkin)
hooksecurefunc("WorldMap_ToggleSizeUp", FixSkin)
			
WorldMapFrame:RegisterEvent("PLAYER_LOGIN")
WorldMapFrame:HookScript("OnEvent", function(self, event)
	if event == "PLAYER_LOGIN" then
		if not GetCVarBool("miniWorldMap") then
			ToggleFrame(WorldMapFrame)				
			ToggleFrame(WorldMapFrame)
		end
	end
end)
			
local coords = CreateFrame("Frame", "CoordsFrame", WorldMapFrame)
local fontheight = select(2, WorldMapQuestShowObjectivesText:GetFont())*1.1
coords:SetFrameLevel(90)
coords.PlayerText = SetfontString(CoordsFrame, "Fonts\\Frizqt__.ttf", fontheight, "THINOUTLINE")
coords.MouseText = SetfontString(CoordsFrame, "Fonts\\Frizqt__.ttf", fontheight, "THINOUTLINE")
coords.PlayerText:SetTextColor(WorldMapQuestShowObjectivesText:GetTextColor())
coords.MouseText:SetTextColor(WorldMapQuestShowObjectivesText:GetTextColor())
coords.PlayerText:SetPoint("TOPLEFT", WorldMapButton, "TOPLEFT", 5, -5)
coords.PlayerText:SetText("Player:   0, 0")
coords.MouseText:SetPoint("TOPLEFT", coords.PlayerText, "BOTTOMLEFT", 0, -5)
coords.MouseText:SetText("Mouse:   0, 0")
local int = 0
			
WorldMapFrame:HookScript("OnUpdate", function(self, elapsed)
				
	if InCombatLockdown() then
		WorldMapFrameSizeDownButton:Disable()
		WorldMapFrameSizeUpButton:Disable()
	else
		WorldMapFrameSizeDownButton:Enable()
		WorldMapFrameSizeUpButton:Enable()			
	end
				
	if WORLDMAP_SETTINGS.size == WORLDMAP_FULLMAP_SIZE then
		WorldMapFrameSizeUpButton:Hide()
		WorldMapFrameSizeDownButton:Show()
	elseif WORLDMAP_SETTINGS.size == WORLDMAP_WINDOWED_SIZE then
		WorldMapFrameSizeUpButton:Show()
		WorldMapFrameSizeDownButton:Hide()
	elseif WORLDMAP_SETTINGS.size == WORLDMAP_QUESTLIST_SIZE then
		WorldMapFrameSizeUpButton:Hide()
		WorldMapFrameSizeDownButton:Show()
	end		

	int = int + 1
				
	if int >= 3 then
		local inInstance, _ = IsInInstance()
		local x,y = GetPlayerMapPosition("player")
			x = math.floor(100 * x)
			y = math.floor(100 * y)
		if x ~= 0 and y ~= 0 then
			coords.PlayerText:SetText(PLAYER..":   "..x..", "..y)
		else
			coords.PlayerText:SetText(" ")
		end
					
		local scale = WorldMapDetailFrame:GetEffectiveScale()
		local width = WorldMapDetailFrame:GetWidth()
		local height = WorldMapDetailFrame:GetHeight()
		local centerX, centerY = WorldMapDetailFrame:GetCenter()
		local x, y = GetCursorPosition()
		local adjustedX = (x / scale - (centerX - (width/2))) / width
		local adjustedY = (centerY + (height/2) - y / scale) / height	

		if (adjustedX >= 0  and adjustedY >= 0 and adjustedX <= 1 and adjustedY <= 1) then
			adjustedX = math.floor(100 * adjustedX)
			adjustedY = math.floor(100 * adjustedY)
			coords.MouseText:SetText(MOUSE_LABEL..":   "..adjustedX..", "..adjustedY)
		else
			coords.MouseText:SetText(" ")
		end				
int = 0
	end				
end)	
