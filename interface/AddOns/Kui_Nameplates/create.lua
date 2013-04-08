local addon = LibStub('AceAddon-3.0'):GetAddon('KuiNameplates')
local kui = LibStub('Kui-1.0')

_G['KuiNameplatesFilesLoaded-150'] = true

------------------------------------------------------------------ Background --
function addon:CreateBackground(frame)
	-- frame glow
	frame.bg:SetParent(frame.parent)
	frame.bg:SetTexture('Interface\\AddOns\\Kui_Nameplates\\FrameGlow')
	frame.bg:SetTexCoord(0, .469, 0, .625)
	frame.bg:SetVertexColor(0, 0, 0, .9)

	-- solid background
	frame.bg.fill = frame.parent:CreateTexture(nil, 'BACKGROUND')
	frame.bg.fill:SetTexture(kui.m.t.solid)
	frame.bg.fill:SetVertexColor(0, 0, 0, .8)
	frame.bg.fill:SetDrawLayer('ARTWORK', 1) -- 1 sub-layer above .bg

	frame.bg.fill:SetSize(addon.sizes.width, addon.sizes.height)
	frame.bg.fill:SetPoint('BOTTOMLEFT', frame.x, frame.y)

	frame.bg:ClearAllPoints()
	frame.bg:SetPoint('BOTTOMLEFT',
		frame.x - addon.sizes.bgOffset,
		frame.y - addon.sizes.bgOffset)
	frame.bg:SetPoint('TOPRIGHT', frame.parent, 'BOTTOMLEFT',
		frame.x + addon.sizes.width + addon.sizes.bgOffset,
		frame.y + addon.sizes.height + addon.sizes.bgOffset)
end

------------------------------------------------------------------ Health bar --
function addon:CreateHealthBar(frame)
	frame.health = CreateFrame('StatusBar', nil, frame.parent)
	frame.health:SetStatusBarTexture(kui.m.t.bar)

	frame.health:ClearAllPoints()
	frame.health:SetSize(addon.sizes.width-2, addon.sizes.height-2)
	frame.health:SetPoint('BOTTOMLEFT', frame.x+1, frame.y+1)

	if addon.SetValueSmooth then
		-- smooth bar
		frame.health.OrigSetValue = frame.health.SetValue
		frame.health.SetValue = addon.SetValueSmooth
	end
end

------------------------------------------------------------------- Highlight --
function addon:CreateHighlight(frame)
	if not addon.db.profile.general.highlight then return end

	frame.highlight = frame.overlay:CreateTexture(nil, 'ARTWORK')
	frame.highlight:SetTexture(kui.m.t.bar)
	frame.highlight:SetAllPoints(frame.health)

	frame.highlight:SetVertexColor(1, 1, 1)
	frame.highlight:SetBlendMode('ADD')
	frame.highlight:SetAlpha(.4)
	frame.highlight:Hide()
end

----------------------------------------------------------------- Health text --
function addon:CreateHealthText(frame)
	frame.health.p = frame:CreateFontString(frame.overlay, {
		font = addon.font, size = 'large', outline = "OUTLINE" })
	frame.health.p:SetJustifyH('RIGHT')
	frame.health.p:SetPoint('BOTTOMRIGHT', frame.health, 'TOPRIGHT',
		-2, addon.uiscale and -(3/addon.uiscale) or -3)
end
function addon:UpdateHealthText(frame)
	if frame.trivial then
		frame.health.p:Hide()
	else
		frame.health.p:Show()
	end
end

------------------------------------------------------------- Alt health text --
function addon:CreateAltHealthText(frame)
	frame.health.mo = frame:CreateFontString(frame.overlay, {
		font = addon.font, size = 'small', outline = "OUTLINE" })
	frame.health.mo:SetJustifyH('RIGHT')
	frame.health.mo:SetPoint('BOTTOMRIGHT', frame.health,
		-2, addon.uiscale and -(3/addon.uiscale) or -3)
	frame.health.mo:SetAlpha(.6)
end
function addon:UpdateAltHealthText(frame)
	if frame.trivial then
		frame.health.mo:Hide()
	else
		frame.health.mo:Show()
	end
end
function addon:DisableAltHealthText(frame)
	frame.health.mo:Hide()
end

------------------------------------------------------------------ Level text --
function addon:CreateLevel(frame)
	if not frame.level then return end
	
	frame.level = frame:CreateFontString(frame.level, { reset = true,
		font = addon.font, size = 'name', outline = 'OUTLINE' })
	frame.level:SetParent(frame.overlay)
	
	frame.level:ClearAllPoints()
	frame.level:SetPoint('BOTTOMLEFT', frame.health, 'TOPLEFT',
		2, addon.uiscale and -(2/addon.uiscale) or -2)
	frame.level.enabled = true
end
function addon:UpdateLevel(frame)
	if frame.trivial then
		frame.level:Hide()
	else
		frame.level:Show()
	end
	
	self:UpdateName(frame)
end
function addon:HideLevel(frame)
	frame.level:Hide()
	frame.level.enabled = nil
end

------------------------------------------------------------------- Name text --
function addon:CreateName(frame)	
	frame.name = frame:CreateFontString(frame.overlay, {
		font = addon.font, size = 'name', outline = 'OUTLINE' })
	frame.name:SetHeight(13)
	
	self:UpdateName(frame)
end
function addon:UpdateName(frame)
	if not frame.name then return end
	
	frame.name:ClearAllPoints()
	
	if frame.trivial then
		addon.SetFontSize(frame.name, addon.fontSizes.small)
	
		frame.name:SetJustifyH('CENTER')
		frame.name:SetPoint('BOTTOMLEFT', frame.health, 'TOPLEFT', -10, 0)
		frame.name:SetPoint('BOTTOMRIGHT', frame.health, 'TOPRIGHT', 10, 0)
	else
		addon.SetFontSize(frame.name, addon.fontSizes.name)
	
		frame.name:SetJustifyH('LEFT')
		frame.name:SetPoint('RIGHT', frame.health.p, 'LEFT')
	
		if frame.level and frame.level.enabled then
			frame.name:SetPoint('LEFT', frame.level, 'RIGHT', -2, 0)
		else
			frame.name:SetPoint('BOTTOMLEFT', frame.health, 'TOPLEFT',
				2, addon.uiscale and -(2/addon.uiscale) or -2)
		end
	end
end