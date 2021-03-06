
local L = LibStub("AceLocale-3.0"):GetLocale("Big Wigs")
local loader = LibStub("AceAddon-3.0"):NewAddon("BigWigsLoader")

-----------------------------------------------------------------------
-- Generate our version variables
--

local REPO = "REPO"
local ALPHA = "ALPHA"
local RELEASE = "RELEASE"
local UNKNOWN = "UNKNOWN"
local BIGWIGS_RELEASE_TYPE, BIGWIGS_RELEASE_REVISION

do
	-- START: MAGIC WOWACE VOODOO VERSION STUFF
	local releaseType = RELEASE
	local releaseRevision = nil
	local releaseString = nil
	--@alpha@
	-- The following code will only be present in alpha ZIPs.
	releaseType = ALPHA
	--@end-alpha@

	-- This will (in ZIPs), be replaced by the highest revision number in the source tree.
	releaseRevision = tonumber("10686")

	-- If the releaseRevision ends up NOT being a number, it means we're running a SVN copy.
	if type(releaseRevision) ~= "number" then
		releaseRevision = -1
		releaseType = REPO
	end

	-- Then build the release string, which we can add to the interface option panel.
	local majorVersion = GetAddOnMetadata("BigWigs", "Version") or "3.?"
	if releaseType == REPO then
		releaseString = L["You are running a source checkout of Big Wigs %s directly from the repository."]:format(majorVersion)
	elseif releaseType == RELEASE then
		releaseString = L["You are running an official release of Big Wigs %s (revision %d)"]:format(majorVersion, releaseRevision)
	elseif releaseType == ALPHA then
		releaseString = L["You are running an ALPHA RELEASE of Big Wigs %s (revision %d)"]:format(majorVersion, releaseRevision)
	end
	BIGWIGS_RELEASE_TYPE = releaseType
	BIGWIGS_RELEASE_REVISION = releaseRevision
	loader.BIGWIGS_RELEASE_STRING = releaseString
	-- END: MAGIC WOWACE VOODOO VERSION STUFF
end

-----------------------------------------------------------------------
-- Locals
--

local ldb = nil
local tooltipFunctions = {}
local pName = UnitName("player")
local next = next
local loaderUtilityFrame = CreateFrame("Frame")

-- Try to grab unhooked copies of critical loading funcs (hooked by some crappy addons)
local GetCurrentMapAreaID = GetCurrentMapAreaID
local SetMapToCurrentZone = SetMapToCurrentZone
loader.GetCurrentMapAreaID = GetCurrentMapAreaID
loader.SetMapToCurrentZone = SetMapToCurrentZone

-- Version
local usersAlpha = {}
local usersRelease = {}
-- Only set highestReleaseRevision if we're actually using a release of BigWigs.
-- If we set this as an alpha user we will alert release users with out-of-date warnings
-- and class them as out-of-date in /bwv (if our alpha version is higher). But they may be
-- using the latest available release version of BigWigs. This method ensures they are
-- classed as up-to-date in /bwv if they use the latest available release of BigWigs
-- even if our alpha is revisions ahead.
local highestReleaseRevision = BIGWIGS_RELEASE_TYPE == RELEASE and BIGWIGS_RELEASE_REVISION or -1
-- The highestAlphaRevision is so we can alert old alpha users (we didn't previously)
local highestAlphaRevision = BIGWIGS_RELEASE_TYPE == ALPHA and BIGWIGS_RELEASE_REVISION or -1

-- Loading
local loadOnZoneAddons = {} -- Will contain all names of addons with an X-BigWigs-LoadOn-Zone directive. Filled in OnInitialize, garbagecollected in OnEnable.
local loadOnCoreEnabled = {} -- BigWigs modulepacks that should load when a hostile zone is entered or the core is manually enabled, this would be the default plugins Bars, Messages etc
local loadOnZone = {} -- BigWigs modulepack that should load on a specific zone
local loadOnCoreLoaded = {} -- BigWigs modulepacks that should load when the core is loaded
local loadOnWorldBoss = {} -- Packs that should load when targetting a specific mob
-- XXX shouldn't really be named "menus", it's actually panels in interface options now
local menus = {} -- contains the main menus for BigWigs, once the core is loaded they will get injected
local enableZones = {} -- contains the zones in which BigWigs will enable
local worldBosses = {} -- contains the list of world bosses per zone that should enable the core

do
	local c = "BigWigs_Classic"
	local bc = "BigWigs_BurningCrusade"
	local wotlk = "BigWigs_WrathOfTheLichKing"
	local cata = "BigWigs_Cataclysm"
	local lw = "LittleWigs"

	loader.zoneList = {
		[696]=c, [755]=c,
		[775]=bc, [780]=bc, [779]=bc, [776]=bc, [465]=bc, [473]=bc, [799]=bc, [782]=bc,
		[604]=wotlk, [543]=wotlk, [535]=wotlk, [529]=wotlk, [527]=wotlk, [532]=wotlk, [531]=wotlk, [609]=wotlk, [718]=wotlk,
		[752]=cata, [758]=cata, [754]=cata, [824]=cata, [800]=cata, [773]=cata,

		[877]=lw, [871]=lw, [874]=lw, [885]=lw, [867]=lw, [919]=lw,
	}
end

-----------------------------------------------------------------------
-- Utility
--

local function sysprint(msg)
	print("|cFF33FF99Big Wigs|r: "..msg)
end

local getGroupMembers = nil
do
	local members = {}
	function getGroupMembers()
		local raid = GetNumGroupMembers()
		local party = GetNumSubgroupMembers()
		if raid == 0 and party == 0 then return end
		wipe(members)
		if raid > 0 then
			for i = 1, raid do
				local n = GetRaidRosterInfo(i)
				if n then members[#members + 1] = n end
			end
		elseif party > 0 then
			members[#members + 1] = pName
			for i = 1, 4 do
				local n = UnitName("party" .. i)
				if n then members[#members + 1] = n end
			end
		end
		return members
	end
end

local function load(obj, name)
	if obj then return true end
	-- Verify that the addon isn't disabled
	local _, _, _, enabled = GetAddOnInfo(name)
	if not enabled then
		sysprint("Error loading " .. name .. " ("..name.." is not enabled)")
		return
	end
	-- Load the addon
	local succ, err = LoadAddOn(name)
	if not succ then
		sysprint("Error loading " .. name .. " (" .. err .. ")")
		return
	end
	return true
end

local function loadAddons(tbl)
	if not tbl then return end
	for i, addon in next, tbl do
		if not IsAddOnLoaded(addon) and load(nil, addon) then
			loader:SendMessage("BigWigs_ModulePackLoaded", addon)
		end
	end
	tbl = nil
end

local function loadZone(zone)
	if not zone then return end
	loadAddons(loadOnZone[zone])
end

local function loadAndEnableCore()
	load(BigWigs, "BigWigs_Core")
	if not BigWigs then return end
	BigWigs:Enable()
end

local function loadCoreAndOpenOptions()
	if not BigWigsOptions and (InCombatLockdown() or UnitAffectingCombat("player")) then
		sysprint(L["Due to Blizzard restrictions the config must first be opened out of combat, before it can be accessed in combat."])
		return
	end
	loadAndEnableCore()
	load(BigWigsOptions, "BigWigs_Options")
	if not BigWigsOptions then return end
	BigWigsOptions:Open()
end

-----------------------------------------------------------------------
-- Version listing functions
--

local function versionTooltipFunc(tt)
	-- Try to avoid calling getGroupMembers as long as possible.
	-- XXX We should just get a file-local boolean flag that we update
	-- whenever we receive a version reply from someone. That way we
	-- reduce the processing required to open a simple tooltip.
	local add = nil
	for player, version in next, usersRelease do
		if version < highestReleaseRevision then
			add = true
			break
		end
	end
	if not add then
		for player, version in next, usersAlpha do
			-- If this person's alpha version isn't SVN (-1) and it's lower than the highest found release version minus 1 because
			-- of tagging, or it's lower than the highest found alpha version (with a 10 revision leeway) then that person is out-of-date
			if version ~= -1 and (version < (highestReleaseRevision - 1) or version < (highestAlphaRevision - 10)) then
				add = true
				break
			end
		end
	end
	if not add then
		local m = getGroupMembers()
		if m then
			for i, player in next, m do
				if not usersRelease[player] and not usersAlpha[player] then
					add = true
					break
				end
			end
		end
	end
	if add then
		tt:AddLine(L["There are people in your group with older versions or without Big Wigs. You can get more details with /bwv."], 1, 0, 0, 1)
	end
end

-----------------------------------------------------------------------
-- Loader initialization
--

local reqFuncAddons = {
	BigWigs_Core = true,
	BigWigs_Options = true,
	BigWigs_Plugins = true,
}

function loader:OnInitialize()
	if BigWigs3DB and BigWigs3DB.namespaces then
		BigWigs3DB.namespaces["BigWigs_Plugins_Tip of the Raid"] = nil -- XXX temp
	end

	for i = 1, GetNumAddOns() do
		local name, _, _, enabled = GetAddOnInfo(i)
		if enabled and not IsAddOnLoaded(i) and IsAddOnLoadOnDemand(i) then
			local meta = GetAddOnMetadata(i, "X-BigWigs-LoadOn-CoreEnabled")
			if meta then
				loadOnCoreEnabled[#loadOnCoreEnabled + 1] = name
			end
			meta = GetAddOnMetadata(i, "X-BigWigs-LoadOn-CoreLoaded")
			if meta then
				loadOnCoreLoaded[#loadOnCoreLoaded + 1] = name
			end
			meta = GetAddOnMetadata(i, "X-BigWigs-LoadOn-ZoneId")
			if meta then
				loadOnZoneAddons[#loadOnZoneAddons + 1] = name
			end
			meta = GetAddOnMetadata(i, "X-BigWigs-LoadOn-WorldBoss")
			if meta then
				loadOnWorldBoss[#loadOnWorldBoss + 1] = name
			end
		elseif not enabled and reqFuncAddons[name] then
			sysprint(L["coreAddonDisabled"])
		end
	end

	-- register for these messages OnInit so we receive these messages when the core and modules oninitialize fires
	self:RegisterMessage("BigWigs_BossModuleRegistered")
	self:RegisterMessage("BigWigs_CoreLoaded")

	local icon = LibStub("LibDBIcon-1.0", true)
	if icon and ldb then
		if not BigWigs3IconDB then BigWigs3IconDB = {} end
		icon:Register("BigWigs", ldb, BigWigs3IconDB)
	end
	self:RegisterTooltipInfo(versionTooltipFunc)

	-- Cleanup function.
	-- TODO: look into having a way for our boss modules not to create a table when no options are changed.
	if BigWigs3DB and BigWigs3DB.namespaces then
		for k,v in next, BigWigs3DB.namespaces do
			if k:find("BigWigs_Bosses_", nil, true) and not next(v) then
				BigWigs3DB.namespaces[k] = nil
			end
		end
	end

	self.OnInitialize = nil
end

do
	local function iterateZones(addon, override, ...)
		for i = 1, select("#", ...) do
			local rawZone = select(i, ...)
			local zone = tonumber(rawZone:trim())
			if zone then
				-- register the zone for enabling.
				enableZones[zone] = true

				if not loadOnZone[zone] then loadOnZone[zone] = {} end
				loadOnZone[zone][#loadOnZone[zone] + 1] = addon

				if override then
					loadOnZone[override][#loadOnZone[override] + 1] = addon
				else
					menus[zone] = true
				end
			else
				sysprint(("The zone ID %q from the addon %q was not parsable."):format(tostring(rawZone), tostring(addon)))
			end
		end
	end

	local currentZone = nil
	local function iterateWorldBosses(addon, override, ...)
		for i = 1, select("#", ...) do
			local rawZoneOrBoss = select(i, ...)
			local zoneOrBoss = tonumber(rawZoneOrBoss:trim())
			if zoneOrBoss then
				if not currentZone then
					-- register the zone for enabling.
					enableZones[zoneOrBoss] = "world"

					currentZone = zoneOrBoss

					if not loadOnZone[zoneOrBoss] then loadOnZone[zoneOrBoss] = {} end
					loadOnZone[zoneOrBoss][#loadOnZone[zoneOrBoss] + 1] = addon

					if override then
						loadOnZone[override][#loadOnZone[override] + 1] = addon
					else
						menus[zoneOrBoss] = true
					end
				else
					worldBosses[zoneOrBoss] = currentZone
					currentZone = nil
				end
			else
				sysprint(("The zone ID %q from the addon %q was not parsable."):format(tostring(rawZoneOrBoss), tostring(addon)))
			end
		end
	end

	function loader:OnEnable()
		for i, name in next, loadOnZoneAddons do
			local menu = tonumber(GetAddOnMetadata(name, "X-BigWigs-Menu"))
			if menu then
				if not loadOnZone[menu] then loadOnZone[menu] = {} end
				menus[menu] = true
			end
			local zones = GetAddOnMetadata(name, "X-BigWigs-LoadOn-ZoneId")
			if zones then
				iterateZones(name, menu, strsplit(",", zones))
			end
		end
		loadOnZoneAddons, iterateZones = nil, nil
		for i, name in next, loadOnWorldBoss do
			local menu = tonumber(GetAddOnMetadata(name, "X-BigWigs-Menu"))
			if menu then
				if not loadOnZone[menu] then loadOnZone[menu] = {} end
				menus[menu] = true
			end
			local zones = GetAddOnMetadata(name, "X-BigWigs-LoadOn-WorldBoss")
			if zones then
				iterateWorldBosses(name, menu, strsplit(",", zones))
			end
		end
		loadOnWorldBoss, iterateWorldBosses = nil, nil

		-- XXX hopefully remove this some day, try to teach people not to force load our modules.
		for i = 1, GetNumAddOns() do
			local name, _, _, enabled = GetAddOnInfo(i)
			if enabled and not IsAddOnLoadOnDemand(i) then
				for j = 1, select("#", GetAddOnOptionalDependencies(i)) do
					local meta = select(j, GetAddOnOptionalDependencies(i))
					if meta and (meta == "BigWigs_Core" or meta == "BigWigs_Plugins") then
						print("|cFF33FF99Big Wigs|r: The addon '|cffffff00"..name.."|r' is forcing Big Wigs to load prematurely, notify the Big Wigs authors!")
					end
				end
				for j = 1, select("#", GetAddOnDependencies(i)) do
					local meta = select(j, GetAddOnDependencies(i))
					if meta and (meta == "BigWigs_Core" or meta == "BigWigs_Plugins") then
						print("|cFF33FF99Big Wigs|r: The addon '|cffffff00"..name.."|r' is forcing Big Wigs to load prematurely, notify the Big Wigs authors!")
					end
				end
			end
		end

		loaderUtilityFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
		loaderUtilityFrame:RegisterEvent("GROUP_ROSTER_UPDATE")

		loaderUtilityFrame:RegisterEvent("CHAT_MSG_ADDON")
		self:RegisterMessage("BigWigs_AddonMessage")
		RegisterAddonMessagePrefix("BigWigs")

		self:RegisterMessage("BigWigs_CoreEnabled")
		self:RegisterMessage("BigWigs_CoreDisabled")

		self:GROUP_ROSTER_UPDATE()
		self:ZONE_CHANGED_NEW_AREA()

		self:RegisterMessage("BigWigs_CoreOptionToggled", "UpdateDBMFaking")
		local isFakingDBM = nil
		-- Somewhat ugly, but saves loading AceDB with the loader instead of the the core for this 1 feature
		if BigWigs3DB and BigWigs3DB.profileKeys and BigWigs3DB.profiles then
			local name = UnitName("player")
			local realm = GetRealmName()
			if name and realm and BigWigs3DB.profileKeys[name.." - "..realm] then
				local key = BigWigs3DB.profiles[BigWigs3DB.profileKeys[name.." - "..realm]]
				isFakingDBM = key.fakeDBMVersion
			end
		end
		self:UpdateDBMFaking(nil, "fakeDBMVersion", isFakingDBM)

		self.OnEnable = nil
	end
end

-----------------------------------------------------------------------
-- DBM faking
--

do
	local DBMdotRevision = "9085"
	local DBMdotDisplayVersion = "5.2.2"
	local function dbmFaker(_, _, prefix, revision, _, displayVersion)
		if prefix == "H" then
			SendAddonMessage("D4", "V\t"..DBMdotRevision.."\t"..DBMdotRevision.."\t"..DBMdotDisplayVersion.."\t"..GetLocale(), IsPartyLFG() and "INSTANCE_CHAT" or "RAID")
		elseif prefix == "V" then
			-- If there are people with newer versions than us, suddenly we've upgraded!
			local rev, dotRev = tonumber(revision), tonumber(DBMdotRevision)
			if rev and displayVersion and rev ~= 99999 and rev > dotRev then
				DBMdotRevision = revision
				DBMdotDisplayVersion = displayVersion
				dbmFaker(nil, nil, "H") -- Re-send addon message.
			end
		end
	end
	function loader:UpdateDBMFaking(_, key, value)
		if key == "fakeDBMVersion" then
			if value then
				RegisterAddonMessagePrefix("D4")
				self:RegisterMessage("DBM_AddonMessage", dbmFaker)
				if IsInRaid() or IsInGroup() then
					dbmFaker(nil, nil, "H") -- Send addon message if feature is being turned on inside a raid/group.
				end
			else
				self:UnregisterMessage("DBM_AddonMessage")
			end
		end
	end
end

-----------------------------------------------------------------------
-- Callback handler
--

do
	local callbackMap = {}
	function loader:RegisterMessage(msg, func)
		if type(msg) ~= "string" then error(":RegisterMessage(message, function) attempted to register invalid message, must be a string!") end
		if not callbackMap[msg] then callbackMap[msg] = {} end
		callbackMap[msg][self] = func or msg
	end
	function loader:UnregisterMessage(msg)
		if type(msg) ~= "string" then error(":UnregisterMessage(message) attempted to unregister an invalid message, must be a string!") end
		if not callbackMap[msg] then return end
		callbackMap[msg][self] = nil
		if not next(callbackMap[msg]) then
			callbackMap[msg] = nil
		end
	end

	function loader:SendMessage(msg, ...)
		if callbackMap[msg] then
			for k,v in next, callbackMap[msg] do
				if type(v) == "function" then
					v(msg, ...)
				else
					k[v](k, msg, ...)
				end
			end
		end
	end

	local function UnregisterAllMessages(_, module)
		for k,v in next, callbackMap do
			for j in next, v do
				if j == module then
					loader.UnregisterMessage(module, k)
				end
			end
		end
	end
	loader:RegisterMessage("BigWigs_OnBossDisable", UnregisterAllMessages)
	loader:RegisterMessage("BigWigs_OnPluginDisable", UnregisterAllMessages)
end

-----------------------------------------------------------------------
-- Events
--

loaderUtilityFrame:SetScript("OnEvent", function(_, event, ...)
	loader[event](loader, ...)
end)

function loader:CHAT_MSG_ADDON(prefix, msg, _, sender)
	if prefix == "BigWigs" then
		local bwPrefix, bwMsg = msg:match("^(%u-):(.+)")
		if bwPrefix then
			self:SendMessage("BigWigs_AddonMessage", bwPrefix, bwMsg, sender)
		end
	elseif prefix == "D4" then
		self:SendMessage("DBM_AddonMessage", sender, strsplit("\t", msg))
	end
end

do
	local warnedOutOfDate = nil

	loaderUtilityFrame.timer = loaderUtilityFrame:CreateAnimationGroup()
	loaderUtilityFrame.timer:SetScript("OnFinished", function()
		SendAddonMessage("BigWigs", (BIGWIGS_RELEASE_TYPE == RELEASE and "VR:%d" or "VRA:%d"):format(BIGWIGS_RELEASE_REVISION), IsPartyLFG() and "INSTANCE_CHAT" or "RAID")
	end)
	local anim = loaderUtilityFrame.timer:CreateAnimation()
	anim:SetDuration(5)

	function loader:BigWigs_AddonMessage(event, prefix, message, sender)
		if prefix == "VR" or prefix == "VQ" then
			if prefix == "VQ" then
				loaderUtilityFrame.timer:Stop()
				loaderUtilityFrame.timer:Play()
			end
			message = tonumber(message)
			-- PhoenixStyle does a mass version check to see what boss mods people are using for some reason.
			-- It uses version 0 in the query so we just respond to this normally but stop attributing these people as using Big Wigs.
			if not message or message == 0 then return end
			usersRelease[sender] = message
			usersAlpha[sender] = nil
			if message > highestReleaseRevision then highestReleaseRevision = message end
			if BIGWIGS_RELEASE_TYPE == RELEASE and BIGWIGS_RELEASE_REVISION ~= -1 and message > BIGWIGS_RELEASE_REVISION and not warnedOutOfDate then
				sysprint(L["There is a new release of Big Wigs available (/bwv). You can visit curse.com, wowinterface.com, wowace.com or use the Curse Updater to get the new release."])
				warnedOutOfDate = true
			end
		elseif prefix == "VRA" or prefix == "VQA" then
			if prefix == "VQA" then
				loaderUtilityFrame.timer:Stop()
				loaderUtilityFrame.timer:Play()
			end
			message = tonumber(message)
			if not message or message == 0 then return end
			usersAlpha[sender] = message
			usersRelease[sender] = nil
			if message > highestAlphaRevision then highestAlphaRevision = message end
			if BIGWIGS_RELEASE_TYPE == ALPHA and BIGWIGS_RELEASE_REVISION ~= -1 and ((message-10) > BIGWIGS_RELEASE_REVISION or highestReleaseRevision > BIGWIGS_RELEASE_REVISION) and not warnedOutOfDate then
				sysprint(L["Your alpha version of Big Wigs is out of date (/bwv)."])
				warnedOutOfDate = true
			end
		end
	end
end

do
	local queueLoad = {}
	-- Kazzak, Doomwalker, Salyis's Warband, Sha of Anger, Nalak, Oondasta
	local warnedThisZone = {[465]=true,[473]=true,[807]=true,[809]=true,[928]=true,[929]=true} -- World Bosses
	function loader:PLAYER_REGEN_ENABLED()
		loaderUtilityFrame:UnregisterEvent("PLAYER_REGEN_ENABLED")
		sysprint(L["Combat has ended, Big Wigs has now finished loading."])
		if load(BigWigs, "BigWigs_Core") then
			for k,v in next, queueLoad do
				if v == "unloaded" then
					queueLoad[k] = "loaded"
					if BigWigs:IsEnabled() and loadOnZone[k] then
						loadZone(k)
					else
						BigWigs:Enable()
					end
				end
			end
		end
	end

	function loader:PLAYER_TARGET_CHANGED()
		local guid = UnitGUID("target")
		if guid then
			local mobId = tonumber(guid:sub(6, 10), 16)
			if worldBosses[mobId] then
				local id = worldBosses[mobId]
				if InCombatLockdown() or UnitAffectingCombat("player") then
					if not queueLoad[id] then
						queueLoad[id] = "unloaded"
						loaderUtilityFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
						sysprint(L["Waiting until combat ends to finish loading due to Blizzard combat restrictions."])
					end
				else
					queueLoad[id] = "loaded"
					if load(BigWigs, "BigWigs_Core") then
						if BigWigs:IsEnabled() then
							loadZone(id)
						else
							BigWigs:Enable()
						end
					end
				end
			end
		end
	end

	function loader:ZONE_CHANGED_NEW_AREA()
		-- Zone checking
		local inside = IsInInstance()
		local id
		if not inside and WorldMapFrame:IsShown() then
			local prevId = GetCurrentMapAreaID()
			SetMapToCurrentZone()
			id = GetCurrentMapAreaID()
			SetMapByID(prevId)
		else
			SetMapToCurrentZone()
			id = GetCurrentMapAreaID()
		end

		-- Module loading
		if enableZones[id] then
			if enableZones[id] == "world" then
				if BigWigs and not UnitIsDeadOrGhost("player") then
					BigWigs:Disable() -- Might be leaving an LFR and entering a world enable zone, disable first
				end
				loaderUtilityFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
				self:PLAYER_TARGET_CHANGED()
			else
				loaderUtilityFrame:UnregisterEvent("PLAYER_TARGET_CHANGED")
				if not IsEncounterInProgress() and (InCombatLockdown() or UnitAffectingCombat("player")) then
					if not queueLoad[id] then
						queueLoad[id] = "unloaded"
						loaderUtilityFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
						sysprint(L["Waiting until combat ends to finish loading due to Blizzard combat restrictions."])
					end
				else
					queueLoad[id] = "loaded"
					if load(BigWigs, "BigWigs_Core") then
						if BigWigs:IsEnabled() and loadOnZone[id] then
							loadZone(id)
						else
							BigWigs:Enable()
						end
					end
				end
			end
		else
			loaderUtilityFrame:UnregisterEvent("PLAYER_TARGET_CHANGED")
			if BigWigs and not UnitIsDeadOrGhost("player") then
				BigWigs:Disable() -- Alive in a non-enable zone, disable
			end
		end

		-- Lacking zone modules
		local zoneAddon = loader.zoneList[id]
		if zoneAddon and not warnedThisZone[id] then
			local _, _, _, enabled = GetAddOnInfo(zoneAddon)
			if not enabled then
				sysprint((L["Please note that this zone requires the -[[|cFF436EEE%s|r]]- plugin for timers to be displayed."]):format(zoneAddon))
				warnedThisZone[id] = true
			end
		end
	end
end

do
	local grouped = nil
	function loader:GROUP_ROSTER_UPDATE()
		local groupType = (IsPartyLFG() and 3) or (IsInRaid() and 2) or (IsInGroup() and 1)
		if (not grouped and groupType) or (grouped and groupType and grouped ~= groupType) then
			grouped = groupType
			self:ZONE_CHANGED_NEW_AREA()
			SendAddonMessage("BigWigs", (BIGWIGS_RELEASE_TYPE == RELEASE and "VQ:%d" or "VQA:%d"):format(BIGWIGS_RELEASE_REVISION), groupType == 3 and "INSTANCE_CHAT" or "RAID")
		elseif grouped and not groupType then
			grouped = nil
			wipe(usersRelease)
			wipe(usersAlpha)
			self:ZONE_CHANGED_NEW_AREA()
		end
	end
end

function loader:BigWigs_BossModuleRegistered(_, _, module)
	if module.worldBoss then
		enableZones[module.zoneId] = "world"
		worldBosses[module.worldBoss] = module.zoneId
	else
		enableZones[module.zoneId] = true
	end
end

function loader:BigWigs_CoreEnabled()
	if ldb then
		ldb.icon = "Interface\\AddOns\\BigWigs\\Textures\\icons\\core-enabled"
	end

	loadAddons(loadOnCoreEnabled)

	-- core is enabled, unconditionally load the zones
	loadZone(GetCurrentMapAreaID())
end

function loader:BigWigs_CoreDisabled()
	if ldb then
		ldb.icon = "Interface\\AddOns\\BigWigs\\Textures\\icons\\core-disabled"
	end
end

function loader:BigWigs_CoreLoaded()
	loadAddons(loadOnCoreLoaded)
end

-----------------------------------------------------------------------
-- API
--

function loader:RegisterTooltipInfo(func)
	for i, v in next, tooltipFunctions do
		if v == func then
			error(("The function %q has already been registered."):format(func))
		end
	end
	tooltipFunctions[#tooltipFunctions+1] = func
end

function loader:GetZoneMenus()
	return menus
end

function loader:LoadZone(zone)
	loadZone(zone)
end

-----------------------------------------------------------------------
-- LDB Plugin
--

local ldb11 = LibStub("LibDataBroker-1.1", true)
if ldb11 then
	ldb = ldb11:NewDataObject("BigWigs", {
		type = "launcher",
		label = "Big Wigs",
		icon = "Interface\\AddOns\\BigWigs\\Textures\\icons\\core-disabled",
	})

	function ldb.OnClick(self, button)
		if button == "RightButton" then
			loadCoreAndOpenOptions()
		else
			loadAndEnableCore()
			if IsAltKeyDown() then
				if IsControlKeyDown() then
					BigWigs:Disable()
				else
					for name, module in BigWigs:IterateBossModules() do
						if module:IsEnabled() then module:Disable() end
					end
					sysprint(L["All running modules have been disabled."])
				end
			else
				for name, module in BigWigs:IterateBossModules() do
					if module:IsEnabled() then module:Reboot() end
				end
				sysprint(L["All running modules have been reset."])
			end
		end
	end

	function ldb.OnTooltipShow(tt)
		tt:AddLine("Big Wigs")
		local h = nil
		if BigWigs and BigWigs:IsEnabled() then
			local added = nil
			for name, module in BigWigs:IterateBossModules() do
				if module:IsEnabled() then
					if not added then
						tt:AddLine(L["Active boss modules:"], 1, 1, 1)
						added = true
					end
					tt:AddLine(module.displayName)
				end
			end
		end
		for i, v in next, tooltipFunctions do
			v(tt)
		end
		tt:AddLine(L.tooltipHint, 0.2, 1, 0.2, 1)
	end
end

-----------------------------------------------------------------------
-- Slash commands
--

hash_SlashCmdList["/bw"] = nil
hash_SlashCmdList["/bigwigs"] = nil
SLASH_BigWigs1 = "/bw"
SLASH_BigWigs2 = "/bigwigs"
SlashCmdList.BigWigs = loadCoreAndOpenOptions

do
	local hexColors = nil
	local coloredNames = setmetatable({}, {__index =
		function(self, key)
			if type(key) == "nil" then return nil end
			local _, class = UnitClass(key)
			if class then
				self[key] = hexColors[class] .. key:gsub("%-.+", "*") .. "|r" -- Replace server names with *
			else
				self[key] = "|cffcccccc" .. key:gsub("%-.+", "*") .. "|r" -- Replace server names with *
			end
			return self[key]
		end
	})
	local function coloredNameVersion(name, version, alpha)
		if version == -1 then version = "svn" alpha = nil end
		return ("%s|cffcccccc(%s%s)|r"):format(coloredNames[name], version or "unknown", alpha and "-alpha" or "")
	end
	local function showVersions()
		local m = getGroupMembers()
		if not m then return end
		if not hexColors then
			hexColors = {}
			for k, v in next, (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS) do
				hexColors[k] = "|cff" .. ("%02x%02x%02x"):format(v.r * 255, v.g * 255, v.b * 255)
			end
		end
		local good = {} -- highest release users
		local ugly = {} -- old version users
		local bad = {} -- non-bw users
		for i, player in next, m do
			if usersRelease[player] then
				if usersRelease[player] < highestReleaseRevision then
					ugly[#ugly + 1] = coloredNameVersion(player, usersRelease[player])
				else
					good[#good + 1] = coloredNameVersion(player, usersRelease[player])
				end
			elseif usersAlpha[player] then
				-- If this person's alpha version isn't SVN (-1) and it's higher or the same as the highest found release version minus 1 because
				-- of tagging, or it's higher or the same as the highest found alpha version (with a 10 revision leeway) then that person's good
				if (usersAlpha[player] >= (highestReleaseRevision - 1) and usersAlpha[player] >= (highestAlphaRevision - 10)) or usersAlpha[player] == -1 then
					good[#good + 1] = coloredNameVersion(player, usersAlpha[player], ALPHA)
				else
					ugly[#ugly + 1] = coloredNameVersion(player, usersAlpha[player], ALPHA)
				end
			else
				bad[#bad + 1] = coloredNames[player]
			end
		end
		if #good > 0 then print(L["Up to date:"], unpack(good)) end
		if #ugly > 0 then print(L["Out of date:"], unpack(ugly)) end
		if #bad > 0 then print(L["No Big Wigs 3.x:"], unpack(bad)) end
	end

	SLASH_BIGWIGSVERSION1 = "/bwv"
	SlashCmdList.BIGWIGSVERSION = showVersions
end

-----------------------------------------------------------------------
-- Interface options
--
do
	local frame = CreateFrame("Frame", nil, UIParent)
	frame.name = "Big Wigs"
	frame:Hide()
	local function removeFrame()
		for k, f in next, INTERFACEOPTIONS_ADDONCATEGORIES do
			if f == frame then
				tremove(INTERFACEOPTIONS_ADDONCATEGORIES, k)
				break
			end
		end
	end
	frame:SetScript("OnShow", function()
		removeFrame()
		loadCoreAndOpenOptions()
	end)

	InterfaceOptions_AddCategory(frame)
	loader.RemoveInterfaceOptions = removeFrame
end

BigWigsLoader = loader -- Set global

