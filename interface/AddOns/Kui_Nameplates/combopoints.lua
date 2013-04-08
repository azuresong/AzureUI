local addon = LibStub('AceAddon-3.0'):GetAddon('KuiNameplates')
local mod = addon:NewModule('ComboPoints', 'AceEvent-3.0')

mod.uiName = 'Combo points'

local function ComboPointsUpdate(self)
	if self.points and self.points > 0 then
		local size = (13 + ((18 - 13) / 5) * self.points)
		local blue = (1 - (1 / 5) * self.points)

		addon.SetFontSize(self, size)

		self:SetText(self.points)
		self:SetTextColor(1, 1, blue)
		self:Show()
	elseif self:GetText() then
		self:SetText('')
		self:Hide()
	end
end
-------------------------------------------------------------- Event handlers --
function mod:UNIT_COMBO_POINTS(event, unit)
	if not unit then return end

	local guid, name = UnitGUID(unit), UnitName(unit)
	local f = addon:GetNameplate(guid, name)
	
	if f then
		if f.cp then
			f.cp.points = GetComboPoints(unit, unit)
			f.cp:Update()
		end
	end

	-- clear points on other frames
	local _, frame
	for _, frame in pairs(addon.frameList) do
		if frame.cp and frame ~= f then
			self:HideComboPoints(nil, frame)
		end
	end
end
---------------------------------------------------------------------- Create --
function mod:CreateComboPoints(msg, frame)
	frame.cp = frame:CreateFontString(frame.health, {
		font = addon.font, size = 'combopoints', outline = 'OUTLINE', shadow = true })
	frame.cp:SetPoint('LEFT', frame.health, 'RIGHT', 5, 1)
	frame.cp.Update = ComboPointsUpdate
	frame.cp:Hide()
end
------------------------------------------------------------------------ Hide --
function mod:HideComboPoints(msg, frame)
	if frame.cp then
		frame.cp.points = nil
		frame.cp:Update()
	end
end
---------------------------------------------------- Post db change functions --
mod.configChangedFuncs = { runOnce = {} }
mod.configChangedFuncs.runOnce.enabled = function(val)
	if val then
		mod:Enable()
	else
		mod:Disable()
	end
end

-------------------------------------------------------------------- Register --
function mod:GetOptions()
	return {
		enabled = {
			name = 'Show combo points',
			desc = 'Show combo points on the target',
			type = 'toggle'
		},
	}
end

function mod:OnInitialize()
	self.db = addon.db:RegisterNamespace(self.moduleName, {
		profile = {
			enabled = true,
		}
	})

	addon:InitModuleOptions(self)
	mod:SetEnabledState(self.db.profile.enabled)
end

function mod:OnEnable()
	self:RegisterMessage('KuiNameplates_PostCreate', 'CreateComboPoints')
	self:RegisterMessage('KuiNameplates_PostHide', 'HideComboPoints')

	self:RegisterEvent('UNIT_COMBO_POINTS')

	local _, frame
	for _, frame in pairs(addon.frameList) do
		if not frame.cp then
			self:CreateComboPoints(nil, frame)
		end
	end
end

function mod:OnDisable()
	self:UnregisterEvent('UNIT_COMBO_POINTS')

	local _, frame
	for _, frame in pairs(addon.frameList) do
		self:HideComboPoints(nil, frame)
	end
end