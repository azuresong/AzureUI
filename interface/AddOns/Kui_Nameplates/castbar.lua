local kui = LibStub('Kui-1.0')
local addon = LibStub('AceAddon-3.0'):GetAddon('KuiNameplates')
local mod = addon:NewModule('CastBar', 'AceEvent-3.0')

mod.uiName = 'Cast bars'

local castEvents = {
	['UNIT_SPELLCAST_START']          = true,
	['UNIT_SPELLCAST_FAILED']         = true,
	['UNIT_SPELLCAST_STOP']           = true,
	['UNIT_SPELLCAST_INTERRUPTED']    = true,
	['UNIT_SPELLCAST_DELAYED']        = true,
	['UNIT_SPELLCAST_CHANNEL_START']  = true,
	['UNIT_SPELLCAST_CHANNEL_UPDATE'] = true,
	['UNIT_SPELLCAST_CHANNEL_STOP']   = true
}

local UnitGUID, GetUnitName, UnitChannelInfo, UnitCastingInfo, GetTime, format =
      UnitGUID, GetUnitName, UnitChannelInfo, UnitCastingInfo, GetTime, format

------------------------------------------------------------- Script handlers --
local function OnCastbarUpdate(bar, elapsed)
	if bar.channel then
		bar.progress = bar.progress - elapsed
	else
		bar.progress = bar.progress + elapsed
	end

	if not bar.duration or
	   ((not bar.channel and bar.progress >= bar.duration) or
	   (bar.channel and bar.progress <= 0))
	then
		-- hide the castbar
		bar:Hide()
		bar.progress = 0
		return
	end

	-- display progress
	if bar.max then
		bar.curr:SetText(format("%.1f", bar.progress))

		if bar.delay == 0 or not bar.delay then
			bar.max:SetText(format("%.1f", bar.duration))
		else
			-- display delay
			if bar.channel then
				-- time is removed
				bar.max:SetText(format("%.1f", bar.duration)..
					'|cffff0000-'..format("%.1f", bar.delay)..'|r')
			else
				-- time is added
				bar.max:SetText(format("%.1f", bar.duration)..
					'|cffff0000+'..format("%.1f", bar.delay)..'|r')
			end
		end
	end

	bar.bar:SetValue(bar.progress/bar.duration)
end

---------------------------------------------------------------------- create --
function mod:CreateCastbar(msg, frame)
	-- container ---------------------------------------------------------------
	frame.castbar = CreateFrame('Frame', nil, frame.parent)
	frame.castbar:Hide()
	
	-- background --------------------------------------------------------------
	frame.castbar.bg = frame.castbar:CreateTexture(nil, 'BACKGROUND')
	frame.castbar.bg:SetTexture(kui.m.t.solid)
	frame.castbar.bg:SetVertexColor(0, 0, 0, .85)

	frame.castbar.bg:SetHeight(addon.sizes.cbheight)
	
	frame.castbar.bg:SetPoint('TOPLEFT', frame.bg.fill, 'BOTTOMLEFT', 0, -1)
	frame.castbar.bg:SetPoint('TOPRIGHT', frame.bg.fill, 'BOTTOMRIGHT', 0, 0)
	
	-- cast bar ------------------------------------------------------------
	frame.castbar.bar = CreateFrame("StatusBar", nil, frame.castbar)
	frame.castbar.bar:SetStatusBarTexture(kui.m.t.bar)

	frame.castbar.bar:SetPoint('TOPLEFT', frame.castbar.bg, 'TOPLEFT', 1, -1)
	frame.castbar.bar:SetPoint('BOTTOMLEFT', frame.castbar.bg, 'BOTTOMLEFT', 1, 1)
	frame.castbar.bar:SetPoint('RIGHT', frame.castbar.bg, 'RIGHT', -1, 0)

	frame.castbar.bar:SetFrameLevel(2)
	frame.castbar.bar:SetMinMaxValues(0, 1)

	-- uninterruptible cast shield -----------------------------------------
	frame.castbar.shield = frame.overlay:CreateTexture(nil, 'ARTWORK')
	frame.castbar.shield:SetTexture('Interface\\AddOns\\Kui_Nameplates\\Shield')
	frame.castbar.shield:SetTexCoord(0, .46875, 0, .5625)

	frame.castbar.shield:SetSize(addon.sizes.shieldw, addon.sizes.shieldh)
	frame.castbar.shield:SetPoint('LEFT', frame.castbar.bg, -7, 0)

	frame.castbar.shield:SetBlendMode('BLEND')
	frame.castbar.shield:SetDrawLayer('ARTWORK', 7)
	frame.castbar.shield:SetVertexColor(1, .1, .1)
	
	frame.castbar.shield:Hide()
	
	-- cast bar text -------------------------------------------------------
	if self.db.profile.display.spellname then
		frame.castbar.name = frame:CreateFontString(frame.castbar, {
			size = 'name' })
		frame.castbar.name:SetPoint('TOPLEFT', frame.castbar.bg, 'BOTTOMLEFT', 2, -2)
		frame.castbar.name:SetPoint('TOPRIGHT', frame.castbar.bg, 'BOTTOMRIGHT', -2, 0)
		frame.castbar.name:SetJustifyH('LEFT')
	end

	if self.db.profile.display.casttime then
		frame.castbar.curr = frame:CreateFontString(frame.castbar, {
			size = 'name' })
		frame.castbar.curr:SetPoint('TOPRIGHT', frame.castbar.bg, 'BOTTOMRIGHT', -2, -2)

		frame.castbar.max = frame:CreateFontString(frame.castbar, {
			size = 'small' })
		frame.castbar.max:SetAlpha(.5)
		frame.castbar.max:SetPoint('TOPRIGHT', frame.castbar.curr, 'TOPLEFT', -1, 0)

		frame.castbar.name:SetPoint('TOPRIGHT', frame.castbar.curr, 'TOPLEFT', -1, 0)
	end

	if frame.spell then
		-- cast bar icon background ----------------------------------------
		frame.spellbg = frame.castbar:CreateTexture(nil, 'BACKGROUND')
		frame.spellbg:SetTexture(kui.m.t.solid)
		frame.spellbg:SetSize(addon.sizes.icon, addon.sizes.icon)

		frame.spellbg:SetVertexColor(0, 0, 0, .85)

		frame.spellbg:SetPoint('TOPRIGHT', frame.health, 'TOPLEFT', -2, 1)

		-- cast bar icon ---------------------------------------------------
		frame.spell:ClearAllPoints()
		frame.spell:SetParent(frame.castbar)
		frame.spell:SetSize(addon.sizes.icon - 2, addon.sizes.icon - 2)

		frame.spell:SetPoint('TOPRIGHT', frame.spellbg, -1, -1)

		frame.spell:SetTexCoord(.1, .9, .1, .9)
	end

	-- scripts -------------------------------------------------------------
	frame.castbar:HookScript('OnShow', function(bar)
		if bar.interruptible then
			bar.bar:SetStatusBarColor(unpack(self.db.profile.display.barcolour))
			bar.shield:Hide()
		else
			bar.bar:SetStatusBarColor(.8, .1, .1)
			bar.shield:Show()
		end
	end)

	frame.castbar:HookScript('OnHide', function(bar)
		bar.shield:Hide()
	end)

	frame.castbar:SetScript('OnUpdate', OnCastbarUpdate)
end
------------------------------------------------------------------------ Hide --
function mod:HideCastbar(msg, frame)
    if frame.castbar then
        frame.castbar.duration = nil
        frame.castbar.id = nil
        frame.castbar:Hide()
    end
end
-------------------------------------------------------------- Event handlers --
function mod.UnitCastEvent(e, unit, ...)
	if unit == 'player' then return end
	local guid, name, f = UnitGUID(unit), GetUnitName(unit), nil
	--guid, name = UnitGUID('target'), GetUnitName('target')

	-- [debug]
	--print('CastEvent: ['..e..'] from ['..unit..'] (GUID: ['..(guid or 'nil')..']) (Name: ['..(name or 'nil')..'])')

	-- fetch the unit's nameplate
	f = addon:GetNameplate(guid, name)
	if f then
		if not f.castbar or f.trivial then return end
		if	e == 'UNIT_SPELLCAST_STOP' or
			e == 'UNIT_SPELLCAST_FAILED' or
			e == 'UNIT_SPELLCAST_INTERRUPTED'
		then
			-- these occasionally fire after a new _START
			local _, _, castID = ...
			if f.castbar.id ~= castID then
				return
			end
		end

		mod[e](mod, f, unit)
	end
end

function mod:UNIT_SPELLCAST_START(frame, unit, channel)
	local castbar = frame.castbar
	local name, _, text, texture, startTime, endTime, _, castID,
	      notInterruptible

	if channel then
		name, _, text, texture, startTime, endTime, _, castID, notInterruptible
			= UnitChannelInfo(unit)
	else
		name, _, text, texture, startTime, endTime, _, castID, notInterruptible
			= UnitCastingInfo(unit)
	end

	if not name then
		frame.castbar:Hide()
		return
	end

	castbar.id            = castID
	castbar.channel       = channel
	castbar.interruptible = not notInterruptible
	castbar.duration      = (endTime/1000) - (startTime/1000)
	castbar.delay         = 0

	if frame.spell then
		frame.spell:SetTexture(texture)
	end

	if castbar.name then
		castbar.name:SetText(name)
	end

	if castbar.channel then
		castbar.progress = (endTime/1000) - GetTime()
	else
		castbar.progress = GetTime() - (startTime/1000)
	end

	frame.castbar:Show()
end

function mod:UNIT_SPELLCAST_DELAYED(frame, unit, channel)
	local castbar = frame.castbar
	local _, name, startTime, endTime

	if channel then
		name, _, _, _, startTime, endTime = UnitChannelInfo(unit)
	else
		name, _, _, _, startTime, endTime = UnitCastingInfo(unit)
	end

	if not name then
		return
	end

	local newProgress
	if castbar.channel then
		newProgress	= (endTime/1000) - GetTime()
	else
		newProgress	= GetTime() - (startTime/1000)
	end

	castbar.delay = (castbar.delay or 0) + castbar.progress - newProgress
	castbar.progress = newProgress
end

function mod:UNIT_SPELLCAST_CHANNEL_START(frame, unit)
	self:UNIT_SPELLCAST_START(frame, unit, true)
end
function mod:UNIT_SPELLCAST_CHANNEL_UPDATE(frame, unit)
	self:UNIT_SPELLCAST_DELAYED(frame, unit, true)
end

function mod:UNIT_SPELLCAST_STOP(frame, unit)
	frame.castbar:Hide()
end
function mod:UNIT_SPELLCAST_FAILED(frame, unit)
	frame.castbar:Hide()
end
function mod:UNIT_SPELLCAST_INTERRUPTED(frame, unit)
	frame.castbar:Hide()
end
function mod:UNIT_SPELLCAST_CHANNEL_STOP(frame, unit)
	frame.castbar:Hide()
end

function mod:IsCasting(msg, frame)
	if not frame.castbar or not frame.target then return end

	local name = UnitCastingInfo('target')
	local channel = false

	if not name then
		name = UnitChannelInfo('target')
		channel = true
	end

	if name then
		-- if they're casting or channeling, try to show a castbar
		self:UNIT_SPELLCAST_START(frame, 'target', channel)
	end
end

-------------------------------------------------------------------- Register --
function mod:GetOptions()
	return {
		enabled = {
			name = 'Enable cast bar',
			desc = 'Show cast bars (at all)',
			type = 'toggle',
			order = 0,
			disabled = false
		},
		display = {
			name = 'Display',
			type = 'group',
			inline = true,
			disabled = function(info)
				return not self.db.profile.enabled
			end,
			args = {
				casttime = {
					name = 'Show cast time',
					desc = 'Show cast time and time remaining',
					type = 'toggle',
					order = 4
				},
				spellname = {
					name = 'Show spell name',
					type = 'toggle',
					order = 3
				},
				spellicon = {
					name = 'Show spell icon',
					type = 'toggle',
					order = 2
				},
				barcolour = {
					name = 'Bar colour',
					desc = 'The colour of the cast bar (during interruptible casts)',
					type = 'color',
					order = 1
				},
			}
		}
	}
end

function mod:OnInitialize()
	self.db = addon.db:RegisterNamespace(self.moduleName, {
		profile = {
			enabled   = true,
			display = {
				casttime  = true,
				spellname = true,
				spellicon = true,
				barcolour = { .43, .47, .55, 1 },
			}
		}
	})

	addon:RegisterSize('frame', 'cbheight', 4)
	addon:RegisterSize('frame', 'icon', 16)
	addon:RegisterSize('frame', 'shieldw', 10)
	addon:RegisterSize('frame', 'shieldh', 12)

	addon:InitModuleOptions(self)
end

function mod:OnEnable()
	self:RegisterMessage('KuiNameplates_PostCreate', 'CreateCastbar')
	self:RegisterMessage('KuiNameplates_PostHide', 'HideCastbar')
	self:RegisterMessage('KuiNameplates_PostShow', 'IsCasting')
	self:RegisterMessage('KuiNameplates_PostTarget', 'IsCasting')

	for event,_ in pairs(castEvents) do
		self:RegisterEvent(event, self.UnitCastEvent)
	end

	local _,frame
    for _, frame in pairs(addon.frameList) do
    	if not frame.castbar then
    		self:CreateCastbar(nil, frame)
    	end
	end
end
