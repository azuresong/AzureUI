-- don't load if class is wrong
local _, class = UnitClass("player")
if class ~= "PALADIN" then return end

local _, xmod = ...
xmod = xmod.retmodule
local db

local function Get(info)
	return db[info[#info]]
end

local function Set(info, val)
	db[info[#info]] = val
	
	if info[#info] == "prio" then
		xmod.Update()
	end
end

function xmod.BuildOptions()
	db = xmod.db

	-- legend for the actions
	local tx = {}
	local actions = xmod.GetActions()
	for k, v in pairs(actions) do
		table.insert(tx, format("\n%s - %s", k, v.info))
	end
	table.sort(tx)
	local prioInfo = "Legend:\n" .. table.concat(tx)

	return {
		order = 1, type = "group", childGroups = "tab", name = "Retribution",
		args = {
			tabPriority = {
				order = 1, type = "group", name = "Priority", args = {
					igPrio = {
						order = 1, type = "group", inline = true, name = "",
						args = {
							info = {
								order = 1, type = "description", name = prioInfo,
							},
							normalPrio = {
								order = 2, type="group", inline = true, name = "Normal priority",
								args = {
									prio = {
										order = 2, type = "input", width = "full", name = "",
										get = Get, set = Set,
									},
									infoCMD = {
										order = 3, type = "description", name = "Sample command line usage: /clcinfo retprio inq tv5 how exo cs j tv3",
									},
								},
							},
							--[[
							zealPrio = {
								order = 3, type="group", inline = true, name = "Zealotry priority",
								args = {
									usePrioZeal = {
										order = 1, type = "toggle", width = "full", name = "Enable zealotry priority",
										get = Get, set = Set,
									},
									prioZeal = {
										order = 2, type = "input", width = "full", name = "",
										get = Get, set = Set,
									},
									infoCMD = {
										order = 3, type = "description", name = "Sample command line usage: /clcinfo retpriozeal inqa tv cs exoud how exo",
									},
								},
							},
							--]]
							disclaimer = {
								order = 4, type = "description", name = "|cffff0000These are just examples, make sure you adjust them properly!|cffffffff",
							},
						},
					},
				},
			},
			tabSettings = {
				order = 2, type = "group", name = "Settings", args = {
					igRange = {
						order = 1, type = "group", inline = true, name = "Range check",
						args = {
							rangePerSkill = {
								type = "toggle", width = "full", name = "Range check for each skill instead of only melee range.",
								get = Get, set = Set,
							},
						},
					},
					igInquisition = {
						order = 2, type = "group", inline = true, name = "Inquisition",
						args = {
							inqRefresh = {
								order = 1, type = "range", min = 1, max = 15, step = 0.1, name = "Time before refresh",
								get = Get, set = Set,
							},
							inqApplyMin = {
								order = 2, type = "range", min = 1, max = 5, step = 1, name = "Min HP for Inquisition",
								get = Get, set = Set,
							},
						},
					},
					clashes = {
						order = 3, type = "group", inline = true, name = "Clashes",
						args = {
							howclash = {
								order = 1, type = "range", min = 0, max = 2, step = 0.01, name = "Hammer of Wrath",
								get = Get, set = Set,
							},
						},
					},
					extra = {
						order = 3, type = "group", inline = true, name = "Extra",
						args = {
							ssduration = {
								order = 1, type = "range", min = 0, max = 30, step = 1, name = "Time left on SS before suggesting refresh",
								get = Get, set = Set,
							},
						},
					},
				},
			},
		},
	}
end