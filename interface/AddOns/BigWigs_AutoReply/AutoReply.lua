--@Name: BigWigs [AutoReply]
--@Author: Kiezo
--@Version: 1.03
--@ToDo:
--===============================================================================

AR_VERSION = "1.03";
AR = LibStub("AceAddon-3.0"):NewAddon("Auto Reply", "AceEvent-3.0", "AceConsole-3.0")

arDebug = false
arEncounterInProgress = false
arWhisperers = {}
arEncounterName = ""
arPlayerName = ""
arPlayerBTag = ""

--===============================================================================
--INITIALIZATION
--===============================================================================
function AR:OnInitialize()

	self:RegisterEvent("CHAT_MSG_WHISPER")	
	self:RegisterEvent("CHAT_MSG_BN_WHISPER")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")

	arPlayerName = UnitName("player")
	arPlayerBTag = select(2, BNGetInfo())

	if BigWigsLoader then
		BigWigsLoader.RegisterMessage(AR, "BigWigs_OnBossEngage", "onBossEngage")
		BigWigsLoader.RegisterMessage(AR, "BigWigs_OnBossWipe", "onBossEnd")
		BigWigsLoader.RegisterMessage(AR, "BigWigs_OnBossWin", "onBossEnd")
		dprint("BigWigsLoader present. Messages registered.")
	end

	self:RegisterChatCommand("ar", "SlashHandler")
end
function AR:SlashHandler(input)
	if not input or input:trim() == "" then
		print("Auto Reply |c00FF0000v"..AR_VERSION.."|r loaded successfully.")	
	elseif (input == "debug") then
		arDebug = not arDebug
		if (arDebug) then
			print("|c00FF0000AR|r: Debugging |c0000FF00ON|r.")
		else
			print("|c00FF0000AR|r: Debugging |c00FF0000OFF|r.")
		end
	elseif (input == "author") then
		print("|c00FF0000Ar|r: Addon Author -  Kiezo - Bleeding Hollow [H] <Inverse Logic>. HUGE Thanks to Funkydude and the rest of the BigWigs authors.")	
	else
		print("|c00FF0000AR|r: Not a recognized command.")
	end
end


function AR:PLAYER_ENTERING_WORLD()
	table.removeall(arWhisperers)
	arEncounterName = ""
	arEncounterInProgress = false
end

--===============================================================================
--HANDLING WHISPERS
--===============================================================================
function AR:onBossEngage(self, module)
	if (not module.moduleName or not module.encounterId) then return end
	dprint("Boss Engaged: "..module.moduleName)

	arEncounterName = module.moduleName
	arEncounterInProgress = true
end

function AR:onBossEnd(self, module)
	if (not module.moduleName or not module.encounterId) then return end
	dprint("Boss End: "..module.moduleName)

	local result = "";
	if (self == "BigWigs_OnBossWipe") then result = "wiped on" else result = "defeated" end

	for i, whisperer in ipairs(arWhisperers) do
		if type(whisperer) == "string" then
			--this was a normal whisper sent
			SendChatMessage(string.format("<BigWigs> %s has %s [%s] %s.", arPlayerName, result, AR:ReportRaidDifficulty(), arEncounterName), "WHISPER", nil, whisperper)
		else
			--this was a BNet whisper, so I have an ID instead
			BNSendWhisper(whisperer, string.format("<BigWigs> %s has %s [%s] %s.", arPlayerName, result, AR:ReportRaidDifficulty(), arEncounterName), "WHISPER")
		end
	end

	table.removeall(arWhisperers)
	arEncounterName = ""
	arEncounterInProgress = false
end

function AR:CHAT_MSG_WHISPER(self, msg, sender)
	if not arEncounterInProgress then return end
	
	dprint("Chat Whisper Received")

	if (type(sender) == "string" and sender~=arPlayerName and not UnitInRaid(sender))then
		if (not AR:TableContains(arWhisperers, sender) or msg == "status") then
			if (not AR:TableContains(arWhisperers, sender)) then
				table.insert(arWhisperers, sender)
			end	

			local eHealth = AR:EncounterHealth(AR:GetBosses())
			local eDiff = AR:ReportRaidDifficulty()

			local chatMsg = "<BigWigs> "..arPlayerName.." is currently in combat with ["..eDiff.."] "..arEncounterName.." ("..string.format("%.0f", eHealth).."%)."
			SendChatMessage(chatMsg, "WHISPER", nil, sender)
		end
	end
end

function AR:CHAT_MSG_BN_WHISPER(self, msg, sender, _, _, _, _, _, _, _, _, _, _, pID)
	if not arEncounterInProgress then return end

	dprint("BNet Whisper Received")

	if (type(pID) == "number" and sender~=arPlayerBTag) then
		if (not AR:TableContains(arWhisperers, pID) or msg == "status") then
			if (not AR:TableContains(arWhisperers, pID)) then
				table.insert(arWhisperers, pID)
			end

			local eHealth = AR:EncounterHealth(AR:GetBosses())
			local eDiff = AR:ReportRaidDifficulty()

			local chatMsg = "<BigWigs> "..arPlayerName.." is currently in combat with ["..eDiff.."] "..arEncounterName.." ("..string.format("%.0f", eHealth).."%)."
			BNSendWhisper(pID, chatMsg)
		end
	end
end

--===============================================================================
--UTILITY FUNCTIONS
--===============================================================================
function AR:GetBosses()
	local bossNames = {} --reset bossNames in case of error in previous attempt

	for i=1,MAX_BOSS_FRAMES do
		if UnitExists("boss"..i) then
			bossNames["boss"..i] = UnitName("boss"..i)
		end
	end
	return bossNames;
end

function AR:BossCount(bosses)
	local bossCount = 0

	for bNumber,bName in pairs(bosses) do
		bossCount = bossCount + 1 
	end

	return bossCount;
end

function AR:EncounterHealth(bosses)
	local encounterHealth = 0

	for i=1, AR:BossCount(bosses) do
		local bossHealth = UnitHealth("boss"..i)/UnitHealthMax("boss"..i) * 100;
		encounterHealth = encounterHealth + (bossHealth/AR:BossCount(bosses))
	end

	return encounterHealth;
end

function AR:TableContains(table, element)
	for _, value in pairs(table) do
		if value == element then
			return true
		end
	end
	return false
end

function AR:ReportRaidDifficulty()
	difficulty = select(3, GetInstanceInfo())
	
	if (difficulty == 4) then
		return "25"
	elseif (difficulty == 5) then
		return "10H"
	elseif (difficulty == 6) then
		return "25H"
	elseif (difficulty == 7) then
		return "LFR"
	elseif (difficulty == 3) then
		return "10"
	end
end

--===============================================================================
--DEBUGGING FUNCTIONS
--===============================================================================
function table.removeall(table)
	for v, k in pairs(table) do
		table[v] = nil
	end
end

function dprint(text)
	if (arDebug) then
		print("AutoReply: "..text)
	end
end