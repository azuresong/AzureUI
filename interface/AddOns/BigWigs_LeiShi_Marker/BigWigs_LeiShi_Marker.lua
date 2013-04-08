--------------------------------------------------------------------------------
-- Module Declaration
--

local mod = BigWigs:NewBoss("Lei Shi Marker", 886)
if not mod then return end
mod:RegisterEnableMob(62983, 63275) -- Lei Shi, Corrupted Protector

local counter = 8
local timer = nil
local adds = {}

function mod:VerifyEnable(unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp > 8 and UnitCanAttack("player", unit) then
		return true
	end
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "ProtectApplied", 123250)
	self:Log("SPELL_AURA_REMOVED", "ProtectRemoved", 123250)
	self:Log("SPELL_AURA_APPLIED", "ProtectOnElementals", 123505)

	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "Kill", "boss1")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ProtectApplied()
	if UnitIsGroupLeader("player") or UnitIsGroupAssistant("player") then
		counter = 8
		wipe(adds)
		timer = self:ScheduleRepeatingTimer("MarkCheck", 0.04)
	end
end

function mod:ProtectRemoved()
	self:CancelTimer(timer)
	timer = nil
	wipe(adds)
end

do
	local function mark(unitId)
		SetRaidTarget(unitId, counter)
		counter = counter - 1
		if counter < 1 then counter = 8 end
	end

	local next, UnitGUID = next, UnitGUID
	function mod:MarkCheck()
		local GUID = UnitGUID("mouseover")
		if GUID and self:MobId(GUID) == 62995 and adds[GUID] ~= "marked" then
			adds[GUID] = "marked"
			mark("mouseover")
		end

		for guid in next, adds do
			if adds[guid] ~= "marked" then
				local unitId = mod:GetUnitIdByGUID(guid)
				if unitId then
					adds[guid] = "marked"
					mark(unitId)
				end
			end
		end
	end
end

function mod:ProtectOnElementals(args)
	if self:MobId(args.destGUID) == 62995 and not adds[args.destGUID] then
		adds[args.destGUID] = true
	end
end

function mod:Kill(_, _, _, _, spellId)
	if spellId == 127524 then -- Transform
		self:Disable()
	end
end

