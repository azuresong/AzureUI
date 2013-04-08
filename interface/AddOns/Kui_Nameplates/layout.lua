--[[
	Kui Nameplates
	Kesava-Auchindoun
]]

local addon, ns = ...
local kui = LibStub('Kui-1.0')
local LSM = LibStub('LibSharedMedia-3.0')
local kn = LibStub('AceAddon-3.0'):GetAddon('KuiNameplates')

--KuiNameplatesDebug=true
-- uncommenting this line will display a white box where the default UI's
-- nameplate is rendered, a black background where the pixel-perfect plate from
-- this addon is rendered (if "Fix aliasing" is enabled), the GUID/name
-- status of any visible plates and the detected reaction type of the plate.

kn.font = ''
kn.fontSizes = {}
kn.sizes = {}
kn.frameList = {}

-- Custom reaction colours
kn.r = {
    { .7, .2, .1 }, -- hated
    { 1, .8, 0 },   -- neutral
    { .2, .6, .1 }, -- friendly
	{ .5, .5, .5 }, -- tapped
}

-- sizes of frame elements
kn.defaultSizes = {
	frame = {
		width    = 110,
		height   = 11,
		twidth   = 55,
		theight  = 7,
		bgOffset = 4  -- inset offset for the frame glow (frame.bg)
	},
	font = {
		combopoints = 13,
		large       = 10,
		spellname   = 9,
		name        = 9,
		small       = 8
	},
}

local loadedGUIDs, loadedNames = {}, {}
local targetExists, targetFound
local profile, uiscale

--------------------------------------------------------------------- globals --
local select, strfind, strsplit, pairs, ipairs, unpack, tinsert, type
    = select, strfind, strsplit, pairs, ipairs, unpack, tinsert, type

------------------------------------------------------------ helper functions --

local function SetFontSize(fs, size)
	if profile.fonts.options.onesize then
		size = kn.fontSizes['name']
	end

	if type(size) == 'string' and fs.size and kn.fontSizes[size] then
		fs.size = size
		size = kn.fontSizes[size]
	end

	local font, _, flags = fs:GetFont()
	fs:SetFont(font, size, flags)
end

local function CreateFontString(self, parent, obj)
	-- store size as a key of kn.fontSizes so that it can be recalled & scaled
	-- correctly. Used by SetFontSize.
	local sizeKey

	obj = obj or {}	
	obj.mono = profile.fonts.options.monochrome
	obj.outline = profile.fonts.options.outline
	obj.size = obj.size or 'name'

	if type(obj.size) == 'string' then
		sizeKey = obj.size
		obj.size = kn.fontSizes[sizeKey]
	end

	if profile.fonts.options.onesize then
		obj.size = kn.fontSizes['name']
	end

	if not obj.font then
		obj.font = kn.font
	end

	local fs = kui.CreateFontString(parent, obj)
	fs.size = sizeKey

	--fs.SetFontSize = SetFontSize
	--fs.SetFontStyle = SetFontStyle

	tinsert(self.fontObjects, fs)
	return fs
end

kn.SetFontSize = SetFontSize
kn.CreateFontString = CreateFontString

------------------------------------------------------------- Frame functions --
-- set colour of health bar according to reaction/threat
local function SetHealthColour(self)
	if self.hasThreat then
		self.health.reset = true
		self.health:SetStatusBarColor(unpack(profile.tank.barcolour))
		return
	end

	local r, g, b = self.oldHealth:GetStatusBarColor()
	if self.health.reset  or
	   r ~= self.health.r or
	   g ~= self.health.g or
	   b ~= self.health.b
	then
		-- store the default colour
		self.health.r, self.health.g, self.health.b = r, g, b
		self.health.reset, self.friend, self.player = nil, nil, nil

		if g > .9 and r == 0 and b == 0 then
			-- friendly NPC
			self.friend = true
			r, g, b = unpack(kn.r[3])
		elseif b > .9 and r == 0 and g == 0 then
			-- friendly player
			self.friend = true
			self.player = true
			r, g, b = 0, .3, .6
		elseif r > .9 and g == 0 and b == 0 then
			-- enemy NPC
			r, g, b = unpack(kn.r[1])
		elseif (r + g) > 1.8 and b == 0 then
			-- neutral NPC
			r, g, b = unpack(kn.r[2])
		elseif b > .9 and (r+g) > 1.06 and (r+g) < 1.1 then
			-- tapped NPC
			r, g, b = unpack(kn.r[4])
		else
			-- enemy player, use default UI colour
			self.player = true
		end

		self.health:SetStatusBarColor(r, g, b)
	end
end

local function SetNameColour(self)
	if self.friend then
		self.name:SetTextColor(unpack(profile.text.friendlyname))
	else
		self.name:SetTextColor(unpack(profile.text.enemyname))
	end
end

local function SetGlowColour(self, r, g, b, a)
	if not r then
		-- set default colour
		r, g, b = 0, 0, 0
	end

	if not a then
		a = .85
	end

    self.bg:SetVertexColor(r, g, b, a)
end

local function StoreFrameGUID(self, guid)
	if not guid then return end
	if self.guid and loadedGUIDs[self.guid] then
		if self.guid ~= guid then
			-- the currently stored guid is incorrect
			loadedGUIDs[self.guid] = nil
		else
			return
		end
	end

	self.guid = guid
	loadedGUIDs[guid] = self

	if loadedNames[self.name.text] == self then
		loadedNames[self.name.text] = nil
	end
end

---------------------------------------------------- Update health bar & text --
local function OnHealthValueChanged(oldBar, curr)
	local frame	= oldBar:GetParent():GetParent()
	local min, max	= oldBar:GetMinMaxValues()
	local deficit,    big, sml, condition, display, pattern, rules
	    = max - curr, '',  ''

	frame.health:SetMinMaxValues(min, max)
	frame.health:SetValue(curr)
	
	-- select correct health display pattern
	if frame.friend then
		pattern = profile.hp.friendly
	else
		pattern = profile.hp.hostile
	end

	-- parse pattern into big/sml
	rules = { strsplit(';', pattern) }

	for k, rule in ipairs(rules) do
		condition, display = strsplit(':', rule)

		if condition == '<' then
			condition = curr < max
		elseif condition == '=' then
			condition = curr == max
		elseif condition == '<=' or condition == '=<' then
			condition = curr <= max
		else
			condition = nil
		end

		if condition then
			if display == 'd' then
				big = '-'..kui.num(deficit)
				sml = kui.num(curr)
			elseif display == 'm' then
				big = kui.num(max)
			elseif display == 'c' then
				big = kui.num(curr)
				sml = curr ~= max and kui.num(max)
			elseif display == 'p' then
				big = floor(curr / max * 100)
				sml = kui.num(curr)
			end

			break
		end
	end

	frame.health.p:SetText(big)

	if frame.health.mo then
		frame.health.mo:SetText(sml)
	end
end

------------------------------------------------------- Frame script handlers --
local function OnFrameShow(self)
	-- reset name
	self.name.text = self.oldName:GetText()
	self.name:SetText(self.name.text)

	if profile.hp.mouseover then
		-- force un-highlight
		self.highlighted = true
	end
	
	-- classifications
	if self.level.enabled then
		if self.boss:IsVisible() then
			self.level:SetText('??b')
			self.level:SetTextColor(1, 0, 0)
			self.level:Show()
		elseif self.state:IsVisible() then
			if self.state:GetTexture() == "Interface\\Tooltips\\EliteNameplateIcon"
			then
				self.level:SetText(self.level:GetText()..'+')
			else
				self.level:SetText(self.level:GetText()..'r')
			end
		end
	else
		self.level:Hide()
	end
	
	if self.state:IsVisible() then
		-- hide the elite/rare dragon
		self.state:Hide()
	end

	if not loadedNames[self.name.text] and
	   not self.guid
	then
		-- store this frame's name
		loadedNames[self.name.text] = self
	end
	
	---------------------------------------------- Trivial sizing/positioning --
	if self.firstChild:GetScale() < 1 then
		if not self.trivial then
			-- initialise trivial unit sizes
			if uiscale then
				self.parent:SetSize(self:GetWidth()/uiscale, self:GetHeight()/uiscale)
			end
			
			local w,h = self.parent:GetSize()
			local x,y = 
				floor((w / 2) - (kn.sizes.twidth / 2)),
				floor((h / 2) - (kn.sizes.theight / 2))
		
			self.health:ClearAllPoints()
			self.bg:ClearAllPoints()
			self.bg.fill:ClearAllPoints()
			self.name:ClearAllPoints()
			
			self.level:Hide()
			self.health.p:Hide()
			
			if self.health.mo then
				self.health.mo:Hide()
			end
			
			--SetFontSize(self.name, 'small')
			self.name:SetJustifyH('CENTER')
			
			self.name:SetPoint('BOTTOM', self.health, 'TOP', 0, -3)
						
			self.bg.fill:SetSize(kn.sizes.twidth, kn.sizes.theight)
			self.health:SetSize(kn.sizes.twidth-2, kn.sizes.theight-2)
			
			self.health:SetPoint('BOTTOMLEFT', x+1, y+1)
			
			self.bg.fill:SetPoint('BOTTOMLEFT', x, y)
			
			self.bg:SetPoint('BOTTOMLEFT', x-(kn.sizes.bgOffset-2), y-(kn.sizes.bgOffset-2))
			self.bg:SetPoint('TOPRIGHT', self.parent, 'BOTTOMLEFT', x+kn.sizes.twidth+(kn.sizes.bgOffset-2), y+kn.sizes.theight+(kn.sizes.bgOffset-2))
		
			self.trivial = true
		else
			-- (performed each time a trivial frame is shown)
			self.level:Hide()
		end
	elseif self.trivial then
		-- return to normal sizes
		if uiscale then
			self.parent:SetSize(self:GetWidth()/uiscale, self:GetHeight()/uiscale)
		end
		
		local w,h = self.parent:GetSize()
		local x,y =
			floor((w / 2) - (kn.sizes.width / 2)), 
			floor((h / 2) - (kn.sizes.height / 2))
		
		self.health:ClearAllPoints()
		self.bg:ClearAllPoints()
		self.bg.fill:ClearAllPoints()
		self.name:ClearAllPoints()
			
		self.health.p:Show()	
		
		if self.health.mo then
			self.health.mo:Show()
		end
		
		--SetFontSize(self.name, 'name')
		self.name:SetJustifyH('LEFT')
		self.name:SetPoint('RIGHT', self.health.p, 'LEFT')
		
		if self.level.enabled then
			self.name:SetPoint('LEFT', self.level, 'RIGHT', -2, 0)
			self.level:Show()
		else
			self.name:SetPoint('BOTTOMLEFT', self.health, 'TOPLEFT', 2, uiscale and -(2/uiscale) or -2)
		end
		
		self.bg.fill:SetSize(kn.sizes.width, kn.sizes.height)		
		self.health:SetSize(kn.sizes.width - 2, kn.sizes.height - 2)
		
		self.health:SetPoint('BOTTOMLEFT', x+1, y+1)
		
		self.bg.fill:SetPoint('BOTTOMLEFT', x, y)
		
		self.bg:SetPoint('BOTTOMLEFT', x-kn.sizes.bgOffset, y-kn.sizes.bgOffset)
		self.bg:SetPoint('TOPRIGHT', self.parent, 'BOTTOMLEFT', x+(kn.sizes.width)+kn.sizes.bgOffset, y+(kn.sizes.height)+kn.sizes.bgOffset)
		
		self.trivial = nil
	end

	self:UpdateFrame()
	self:UpdateFrameCritical()
	
	-- force health update
	OnHealthValueChanged(self.oldHealth, self.oldHealth:GetValue())
	self:SetGlowColour()

	if self.carrier then
		-- TODO TEST only show players
		--[[if self.friend and self.player then
			self.carrier.DoShow = true
		else
			self.carrier.DoShow = nil
			self.carrier:Hide()
		end]]

		self.carrier.DoShow = true
	end

	kn:SendMessage('KuiNameplates_PostShow', self)
end

local function OnFrameHide(self)
	if self.carrier then
		self.carrier:Hide()
	end

	if self.guid and loadedGUIDs[self.guid] == self then
		-- remove guid from the store
		loadedGUIDs[self.guid] = nil	end

	self.guid = nil

	if loadedNames[self.name.text] == self then
		-- remove name from store
		-- if there are name duplicates, this will be recreated in an onupdate
		loadedNames[self.name.text] = nil
	end

	self.lastAlpha	= 0
	self.fadingTo	= nil
	self.hasThreat	= nil
	self.target		= nil

	-- unset stored health bar colours
	self.health.r, self.health.g, self.health.b, self.health.reset
		= nil, nil, nil, nil
	
	kn:SendMessage('KuiNameplates_PostHide', self)	
end

local function OnFrameEnter(self)
	self:StoreGUID(UnitGUID('mouseover'))

	if self.highlight then
		self.highlight:Show()
	end

	if profile.hp.mouseover then
		self.health.p:Show()
		if self.health.mo then self.health.mo:Show() end
	end
end

local function OnFrameLeave(self)
	if self.highlight then
		self.highlight:Hide()
	end

	if not self.target and profile.hp.mouseover then
		self.health.p:Hide()
		if self.health.mo then self.health.mo:Hide() end
	end
end

-- stuff that needs to be updated every frame
local function OnFrameUpdate(self, e)
	self.elapsed	= self.elapsed + e
	self.critElap	= self.critElap + e

	if self.carrier then
		------------------------------------------------------------ Position --
		local scale = self.firstChild:GetScale()
		local x, y = select(4, self.firstChild:GetPoint())
		x = (x / uiscale) * scale
		y = (y / uiscale) * scale
		
		self.carrier:SetPoint('BOTTOMLEFT', UIParent, 'BOTTOMLEFT', floor(x-(self.carrier:GetWidth()/2)), floor(y))
		
		-- show the frame after it's been moved so it doesn't flash
		-- .DoShow is set OnFrameShow
		if self.carrier.DoShow then
			self.carrier:Show()
			self.carrier.DoShow = nil
		end
	end
	
	self.defaultAlpha = self:GetAlpha()
	------------------------------------------------------------------- Alpha --
	if (self.defaultAlpha == 1 and
	    targetExists)          or
	   (profile.fade.fademouse and
	    self.highlighted)
	then
		self.currentAlpha = 1
	elseif	targetExists or profile.fade.fadeall then
		self.currentAlpha = profile.fade.fadedalpha or .3
	else
		self.currentAlpha = 1
	end
	------------------------------------------------------------------ Fading --
	if profile.fade.smooth then
		-- track changes in the alpha level and intercept them
		if self.currentAlpha ~= self.lastAlpha then
			if not self.fadingTo or self.fadingTo ~= self.currentAlpha then
				if kui.frameIsFading(self) then
					kui.frameFadeRemoveFrame(self)
				end

				-- fade to the new value
				self.fadingTo 	  = self.currentAlpha
				local alphaChange = (self.fadingTo - (self.lastAlpha or 0))

				kui.frameFade(self.carrier and self.carrier or self, {
					mode		= alphaChange < 0 and 'OUT' or 'IN',
					timeToFade	= abs(alphaChange) * (profile.fade.fadespeed or .5),
					startAlpha	= self.lastAlpha or 0,
					endAlpha	= self.fadingTo,
					finishedFunc = function()
						self.fadingTo = nil
					end,
				})
			end

			self.lastAlpha = self.currentAlpha
		end
	else
		(self.carrier and self.carrier or self):SetAlpha(self.currentAlpha)
	end
	
	-- call delayed updates
	if self.elapsed > 1 then
		self.elapsed = 0
		self:UpdateFrame()
	end

	if self.critElap > .1 then
		self.critElap = 0
		self:UpdateFrameCritical()
	end
end

-- stuff that can be updated less often
local function UpdateFrame(self)
	if not loadedNames[self.name.text] and
	   not self.guid
	then
		-- ensure a frame is still stored for this name, as name conflicts cause
		-- it to be erased when another might still exist
		-- also ensure that if this frame is targeted, this is the stored frame
		-- for its name
		loadedNames[self.name.text] = self
	end

	-- Health bar colour
	self:SetHealthColour()
	
	-- Name text colour
	self:SetNameColour()
end

-- stuff that needs to be updated often
local function UpdateFrameCritical(self)
	------------------------------------------------------------------ Threat --
	if self.glow:IsVisible() then
		self.glow.wasVisible = true

		-- set glow to the current default ui's colour
		self.glow.r, self.glow.g, self.glow.b = self.glow:GetVertexColor()
		self:SetGlowColour(self.glow.r, self.glow.g, self.glow.b)

		if not self.friend and profile.tank.enabled then
			-- in tank mode; is the default glow red (are we tanking)?
			self.hasThreat = (self.glow.g + self.glow.b) < .1

			if self.hasThreat then
				-- tanking; recolour bar & glow
				local r, g, b, a = unpack(profile.tank.glowcolour)
				self:SetGlowColour(r, g, b, a)
				self:SetHealthColour()
			end
		end
	elseif self.glow.wasVisible then
		self.glow.wasVisible = nil

		-- restore shadow glow colour
		self:SetGlowColour()

		if self.hasThreat then
			-- lost threat
			self.hasThreat = nil
			self:SetHealthColour()
		end
	end
	------------------------------------------------------------ Target stuff --
	if targetExists and
	   self.defaultAlpha == 1 and
	   self.name.text == UnitName('target')
	then
		-- this frame is probably targeted
		if not targetFound then
			-- this frame is definitely targeted
			targetFound = true

			if not self.target then
				-- just became targeted
				self.target = true
				self:StoreGUID(UnitGUID('target'))

				if self.carrier then
					-- move this frame above others
					-- default UI uses a level of 10 by default & 20 on the target
					self.carrier:SetFrameLevel(10)
				end

				if profile.hp.mouseover then
					self.health.p:Show()
					if self.health.mo then self.health.mo:Show() end
				end
				
				kn:SendMessage('KuiNameplates_PostTarget', self)
			end
		end
	elseif self.target then
		self.target = nil

		if not self.highlighted and profile.hp.mouseover then
			self.health.p:Hide()
			if self.health.mo then self.health.mo:Hide() end
		end
	end

	if not self.target and self.carrier then
		self.carrier:SetFrameLevel(1)
	end
	--------------------------------------------------------------- Mouseover --
	if self.oldHighlight:IsShown() then
		if not self.highlighted then
			self.highlighted = true
			OnFrameEnter(self)
		end
	elseif self.highlighted then
		self.highlighted = false
		OnFrameLeave(self)
	end
	
	-- [debug]
	if _G['KuiNameplatesDebug'] then
		if self.guid then
			self.guidtext:SetText(self.guid)

			if loadedGUIDs[self.guid] ~= self then
				self.guidtext:SetTextColor(1,0,0)
			else
				self.guidtext:SetTextColor(1,1,1)
			end
		else
			self.guidtext:SetText(nil)
		end

		if self.name.text and loadedNames[self.name.text] == self then
			self.nametext:SetText('Has name')
		else
			self.nametext:SetText(nil)
		end
		
		if self.friend then
			self.isfriend:SetText('friendly')
		else
			self.isfriend:SetText('not friendly')
		end
	end
end

--------------------------------------------------------------- KNP functions --
function kn:GetNameplate(guid, name)
	local gf, nf = loadedGUIDs[guid], loadedNames[name]

	if gf then
		return gf
	elseif nf then
		return nf
	else
		return nil
	end
end

function kn:IsNameplate(frame)
	if frame:GetName() and strfind(frame:GetName(), '^NamePlate%d') then
		local nameTextChild = select(2, frame:GetChildren())
		if nameTextChild then
			local nameTextRegion = nameTextChild:GetRegions()
			return (nameTextRegion and nameTextRegion:GetObjectType() == 'FontString')
		end
	end
end

function kn:InitFrame(frame)
	frame.init = true
	frame.fontObjects = {}
	
	local overlayChild, nameTextChild = frame:GetChildren()
	local healthBar, castBar = overlayChild:GetChildren()
	
	local _, castbarOverlay, shieldedRegion, spellIconRegion
		= castBar:GetRegions()

	local nameTextRegion = nameTextChild:GetRegions()
    local
		glowRegion, overlayRegion, highlightRegion, levelTextRegion,
		bossIconRegion, raidIconRegion, stateIconRegion
		= overlayChild:GetRegions()

	highlightRegion:SetTexture(nil)
	bossIconRegion:SetTexture(nil)
	shieldedRegion:SetTexture(nil)
	castbarOverlay:SetTexture(nil)
	glowRegion:SetTexture(nil)

	-- disable default cast bar
	castBar:SetParent(nil)
	castbarOverlay.Show = function() return end
	castBar:SetScript('OnShow', function() castBar:Hide() end)

	frame.firstChild = overlayChild
	
	frame.bg    = overlayRegion
	frame.glow  = glowRegion
	frame.boss  = bossIconRegion
	frame.state = stateIconRegion
	frame.level = levelTextRegion
	frame.icon  = raidIconRegion
	frame.spell = spellIconRegion

	frame.oldHealth = healthBar
	frame.oldHealth:Hide()

	frame.oldName = nameTextRegion
	frame.oldName:Hide()
	
	frame.oldHighlight = highlightRegion

    --------------------------------------------------------- Frame functions --
    frame.CreateFontString      = CreateFontString
    frame.UpdateFrame			= UpdateFrame
    frame.UpdateFrameCritical	= UpdateFrameCritical
    frame.SetHealthColour   	= SetHealthColour
    frame.SetNameColour   	    = SetNameColour
    frame.SetGlowColour     	= SetGlowColour
	frame.StoreGUID				= StoreFrameGUID

	--[[ TODO
		past this point a frame has been initialised but not "created"
		it should be possible to hide/reset anything created after this
		when a profile change or setting change is detected, cycle all frames
		and reset them
	]]

    ------------------------------------------------------------------ Layout --
	local parent
	if profile.general.fixaa and uiscale then
		frame.carrier = CreateFrame('Frame', nil, WorldFrame)
		frame.carrier:SetFrameStrata('BACKGROUND')
		frame.carrier:SetSize(frame:GetWidth()/uiscale, frame:GetHeight()/uiscale)
		frame.carrier:SetScale(uiscale)
		
		frame.carrier:SetPoint('CENTER', UIParent)
		frame.carrier:Hide()
		
		-- [debug]
		if _G['KuiNameplatesDebug'] then
			frame.carrier:SetBackdrop({ bgFile = kui.m.t.solid })
			frame.carrier:SetBackdropColor(0,0,0,.5)
		end
		
		parent = frame.carrier
	else
		parent = frame
	end

	frame.parent = parent
	
	-- using CENTER breaks pixel-perfectness with oddly sized frames
	-- .. so we have to align frames manually.
	local w,h = parent:GetSize()
	frame.x = floor((w / 2) - (kn.sizes.width / 2))
	frame.y = floor((h / 2) - (kn.sizes.height / 2))

	self:CreateBackground(frame)
	self:CreateHealthBar(frame)

	-- raid icon ---------------------------------------------------------------
	frame.icon:SetParent(parent)
	--frame.icon:SetSize(24, 24)

	frame.icon:ClearAllPoints()
	frame.icon:SetPoint('BOTTOM', parent, 'TOP', 0, -5)

	-- overlay (text is parented to this) --------------------------------------
	frame.overlay = CreateFrame('Frame', nil, parent)
	frame.overlay:SetAllPoints(frame.health)
	frame.overlay:SetFrameLevel(frame.health:GetFrameLevel()+1)

	self:CreateHighlight(frame)
	self:CreateHealthText(frame)
	
	if profile.hp.showalt then
		self:CreateAltHealthText(frame)
	end

	if profile.text.level then
		self:CreateLevel(frame)
	else
		frame.level:Hide()
	end

	self:CreateName(frame)
	
    ----------------------------------------------------------------- Scripts --
	frame:HookScript('OnShow', OnFrameShow)
	frame:HookScript('OnHide', OnFrameHide)
    frame:HookScript('OnUpdate', OnFrameUpdate)

	frame.oldHealth:HookScript('OnValueChanged', OnHealthValueChanged)

	-- [debug]
	if _G['KuiNameplatesDebug'] then
		frame:SetBackdrop({bgFile=kui.m.t.solid})
		frame:SetBackdropColor(1, 1, 1, .5)

		frame.isfriend = frame:CreateFontString(frame.overlay)
		frame.isfriend:SetPoint('BOTTOM', frame, 'TOP')
		
		frame.guidtext = frame:CreateFontString(frame.overlay)
		frame.guidtext:SetPoint('TOP', frame, 'BOTTOM')

		frame.nametext = frame:CreateFontString(frame.overlay)
		frame.nametext:SetPoint('TOP', frame.guidtext, 'BOTTOM')
	end

	------------------------------------------------------------ Finishing up --
	--frame.UpdateScales = UpdateScales

    frame.elapsed	= 0
	frame.critElap	= 0

	kn:SendMessage('KuiNameplates_PostCreate', frame)
	
	-- force OnShow
	OnFrameShow(frame)
end

---------------------------------------------------------------------- Events --
function kn:PLAYER_TARGET_CHANGED()
	targetExists = UnitExists('target')
	targetFound = nil
end

-- automatic toggling of enemy frames
function kn:PLAYER_REGEN_ENABLED()
	SetCVar('nameplateShowEnemies', 0)
end
function kn:PLAYER_REGEN_DISABLED()
	SetCVar('nameplateShowEnemies', 1)
end

------------------------------------------------------------- Script handlers --
kn.numFrames = 0

do
	local WorldFrame, lastUpdate
		= WorldFrame, 1

	function kn:OnUpdate()
		local frames = select('#', WorldFrame:GetChildren())

		if frames ~= self.numFrames then
			local i, f

			for i = 1, frames do
				f = select(i, WorldFrame:GetChildren())
				if self:IsNameplate(f) and not f.init then
					self:InitFrame(f)
					tinsert(self.frameList, f)
				end
			end

			self.numFrames = frames
		end
	end

	kn:ScheduleRepeatingTimer('OnUpdate', .1)
end

function kn:ToggleCombatEvents(io)
	if io then
		kn:RegisterEvent('PLAYER_REGEN_ENABLED')
		kn:RegisterEvent('PLAYER_REGEN_DISABLED')
	else
		kn:UnregisterEvent('PLAYER_REGEN_ENABLED')
		kn:UnregisterEvent('PLAYER_REGEN_DISABLED')
	end
end

-------------------------------------------------- Listen for profile changes --
function kn:ProfileChanged()
	profile = self.db.profile
end

---------------------------------------------------- Post db change functions --
-- n.b. this is absolutely terrible and horrible and i hate it
kn.configChangedFuncs.runOnce.fontscale = function(val)
	kn:ScaleFontSizes()
end
kn.configChangedFuncs.fontscale = function(frame, val)
	local _, fontObject
	for _, fontObject in pairs(frame.fontObjects) do
		if type(fontObject.size) == 'string' then
			SetFontSize(fontObject, kn.fontSizes[fontObject.size])
		end
	end
end

kn.configChangedFuncs.outline = function(frame, val)
	local _, fontObject
	for _, fontObject in pairs(frame.fontObjects) do
		kui.ModifyFontFlags(fontObject, val, 'OUTLINE')
	end
end

kn.configChangedFuncs.monochrome = function(frame, val)
	local _, fontObject
	for _, fontObject in pairs(frame.fontObjects) do
		kui.ModifyFontFlags(fontObject, val, 'MONOCHROME')
	end
end

kn.configChangedFuncs.fontscale = function(frame, val)
	local _, fontObject
	for _, fontObject in pairs(frame.fontObjects) do
		if type(fontObject.size) == 'string' then
			SetFontSize(fontObject, kn.fontSizes[fontObject.size])
		end
	end
end
kn.configChangedFuncs.onesize = kn.configChangedFuncs.fontscale

kn.configChangedFuncs.Health = function(frame)
	if frame:IsShown() then
		-- update health display
		OnHealthValueChanged(frame.oldHealth, frame.oldHealth:GetValue())
	end
end
kn.configChangedFuncs.friendly = kn.configChangedFuncs.Health
kn.configChangedFuncs.hostile = kn.configChangedFuncs.Health

kn.configChangedFuncs.runOnce.font = function(val)
	kn.font = LSM:Fetch(LSM.MediaType.FONT, val)
end
kn.configChangedFuncs.font = function(frame, val)
	local _, fontObject
	for _, fontObject in pairs(frame.fontObjects) do
		local _, size, flags = fontObject:GetFont()
		fontObject:SetFont(kn.font, size, flags)
	end
end

-------------------------------------------------------------------- Finalise --
-- scale a frame/font size to keep it relatively the same with any uiscale
function ScaleFrameSize(key)
	local size = kn.defaultSizes.frame[key]
	kn.sizes[key] = (uiscale and floor(size/uiscale) or size)
end

function ScaleFontSize(key)
	local size = kn.defaultSizes.font[key]
	kn.fontSizes[key] = size * profile.fonts.options.fontscale
		
	if uiscale then
		kn.fontSizes[key] = kn.fontSizes[key] / uiscale
	end
end

-- [initialise and] scale frame sizes
function kn:ScaleFrameSizes()
	local k,_
	for k,_ in pairs(kn.defaultSizes.frame) do
		ScaleFrameSize(k)
	end
end

-- [initialise and] scale font sizes
function kn:ScaleFontSizes()
	local k,_
	for k,_ in pairs(kn.defaultSizes.font) do
		ScaleFontSize(k)
	end
end

-- modules must use this to add correctly scaled sizes
-- font sizes can then be called as a key in kn.CreateFontString
function kn:RegisterSize(type, key, size)
	if type ~= 'frame' and type ~= 'font' then return end

	kn.defaultSizes[type][key] = size

	if type == 'frame' then
		ScaleFrameSize(key)
	else
		ScaleFontSize(key)
	end
end

function kn:OnEnable()
	profile = self.db.profile
    
	if profile.general.fixaa then
		uiscale = UIParent:GetEffectiveScale()
	end
		
	self:ScaleFrameSizes()
	self:ScaleFontSizes()
	
	-- fetch font path from lsm
	self.font = LSM:Fetch(LSM.MediaType.FONT, profile.fonts.options.font)
    
	-------------------------------------- Health bar smooth update functions --
	-- (spoon-fed by oUF_Smooth)
	if profile.hp.smooth then
		local f, smoothing, GetFramerate, min, max, abs
			= CreateFrame('Frame'), {}, GetFramerate, math.min, math.max, math.abs

		function kn.SetValueSmooth(self, value)
			local _, maxv = self:GetMinMaxValues()

			if value == self:GetValue() or (self.prevMax and self.prevMax ~= maxv) then
				-- finished smoothing/max health updated
				smoothing[self] = nil
				self:OrigSetValue(value)
			else
				smoothing[self] = value
			end

			self.prevMax = maxv
		end

		f:SetScript('OnUpdate', function()
			local limit = 30/GetFramerate()
			
			for bar, value in pairs(smoothing) do
				local cur = bar:GetValue()
				local new = cur + min((value-cur)/3, max(value-cur, limit))

				if new ~= new then
					new = value
				end

				bar:OrigSetValue(new)

				if cur == value or abs(new - value) < 2 then
					bar:OrigSetValue(value)
					smoothing[bar] = nil
				end
			end
		end)
	end

	self:RegisterEvent('PLAYER_TARGET_CHANGED')
	self.ToggleCombatEvents(profile.general.combat)
end
