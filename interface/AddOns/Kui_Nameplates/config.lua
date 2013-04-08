local addon = LibStub('AceAddon-3.0'):GetAddon('KuiNameplates')

------------------------------------------------------------------ Ace config --
local AceConfig = LibStub('AceConfig-3.0')
local AceConfigDialog = LibStub('AceConfigDialog-3.0')

--------------------------------------------------------------- Options table --
do
	local handlers = {}
	local handlerProto = {}
	local handlerMeta = { __index = handlerProto }

	function handlerProto:ResolveInfo(info)
		local p = self.dbPath.db.profile
	
		local child, k
		for i = 1, #info do
			k = info[i]

			if i < #info then
				if not child then
					child = p[k]
				else
					child = child[k]
				end
			end
		end

		return child or p, k
	end

	function handlerProto:Get(info, ...)
		local p, k = self:ResolveInfo(info)

		if info.type == 'color' then
			return unpack(p[k])
		else
			return p[k]
		end
	end

	function handlerProto:Set(info, val, ...)
		local p, k = self:ResolveInfo(info)

		if info.type == 'color' then
			p[k] = { val, ... }
		else
			p[k] = val
		end

		if self.dbPath.ConfigChanged then
			-- inform module of configuration change
			self.dbPath.ConfigChanged(k, p)
		end
	end

	function addon:GetOptionHandler(mod)
		if not handlers[mod] then
			handlers[mod] = setmetatable({ dbPath = mod }, handlerMeta)
		end

		return handlers[mod]
	end

	local options = {
		name = 'Kui Nameplates',
		handler = addon:GetOptionHandler(addon),
		type = 'group',
		get = 'Get',
		set = 'Set',
		args = {
			header = {
				type = 'header',
				name = '|cffff0000Many options currently require a UI reload to take effect.|r',
				order = 0
			},
			general = {
				name = 'General display',
				type = 'group',
				order = 1,
				args = {
					combat = {
						name = 'Auto toggle in combat',
						desc = 'Automatically toggle on/off hostile nameplates upon entering/leaving combat',
						type = 'toggle',
						order = 0
					},
					highlight = {
						name = 'Highlight',
						desc = 'Highlight plates on mouse over (when not targeted)',
						type = 'toggle',
						order = 1
					},
					fixaa = {
						name = 'Fix aliasing',
						desc = 'Attempt to make plates appear sharper. Has a positive effect on FPS, but will make plates appear a bit "loose", especially at low frame rates. Works best when uiscale is disabled and at even resolutions.\n\n|cffff0000UI reload required to take effect.\n\nCurrently will not work correctly if a viewport addon is in use.|r',
						type = 'toggle',
						order = 4
					},
				}
			},
			fade = {
				name = 'Frame fading',
				type = 'group',
				order = 2,
				args = {
					fadedalpha = {
						name = 'Faded alpha',
						desc = 'The alpha value to which plates fade out to',
						type = 'range',
						min = 0,
						max = 1,
						isPercent = true,
						order = 4
					},
					fademouse = {
						name = 'Fade in with mouse',
						desc = 'Fade plates in on mouse-over',
						type = 'toggle',
						order = 1
					},
					fadeall = {
						name = 'Fade all frames',
						desc = 'Fade out all frames by default (rather than in)',
						type = 'toggle',
						order = 2
					},
					smooth = {
						name = 'Smoothly fade',
						desc = 'Smoothly fade plates in/out (fading is instant when disabled)',
						type = 'toggle',
						order = 0
					},
					fadespeed = {
						name = 'Smooth fade speed',
						desc = 'Fade animation speed modifier (lower is faster)',
						type = 'range',
						min = 0,
						softMax = 5,
						order = 3,
						disabled = function(info)
							return not addon.db.profile.fade.smooth
						end
					}
				}
			},
			text = {
				name = 'Text',
				type = 'group',
				order = 3,
				args = {
					level = {
						name = 'Show levels',
						desc = 'Show levels on nameplates',
						type = 'toggle',
						order = 2
					},
					friendlyname = {
						name = 'Friendly name text colour',
						desc = 'The colour of names of friendly units',
						type = 'color',
						order = 4,
					},
					enemyname = {
						name = 'Enemy name text colour',
						desc = 'The colour of names of enemy units',
						type = 'color',
						order = 5,
					},
				}
			},
			hp = {
				name = 'Health display',
				type = 'group',
				order = 4,
				args = {
					showalt = {
						name = 'Show contextual health',
						desc = 'Show alternate (contextual) health values as well as main values',
						type = 'toggle',
						order = 1
					},
					mouseover = {
						name = 'Show on mouse over',
						desc = 'Show health only on mouse over or on the targeted plate',
						type = 'toggle',
						order = 2
					},
					smooth = {
						name = 'Smooth health bar',
						desc = 'Smoothly animate health bar value updates',
						type = 'toggle',
						width = 'double',
						order = 3
					},
					friendly = {
						name = 'Friendly health format',
						desc = 'The health display pattern for friendly units',
						type = 'input',
						pattern = '([<=]:[dmcpb];)',
						order = 5
					},
					hostile = {
						name = 'Hostile health format',
						desc = 'The health display pattern for hostile or neutral units',
						type = 'input',
						pattern = '([<=]:[dmcpb];)',
						order = 6
					}
				}
			},
			tank = {
				name = 'Tank mode',
				type = 'group',
				order = 5,
				args = {
					enabled = {
						name = 'Enable tank mode',
						desc = 'Change the colour of a plate\'s health bar and border when you have threat on its unit',
						type = 'toggle',
						order = 0
					},
					barcolour = {
						name = 'Bar colour',
						desc = 'The bar colour to use when you have threat',
						type = 'color',
						order = 1
					},
					glowcolour = {
						name = 'Glow colour',
						desc = 'The glow (border) colour to use when you have threat',
						type = 'color',
						hasAlpha = true,
						order = 2
					},
				}
			},
			fonts = {
				name = 'Fonts',
				type = 'group',
				args = {
					options = {
						name = 'Global font settings',
						type = 'group',
						inline = true,
						args = {
							font = {
								name = 'Font',
								desc = 'The font used for all text on nameplates',
								type = 'select',
								dialogControl = 'LSM30_Font',
								values = AceGUIWidgetLSMlists.font,
							},
							fontscale = {
								name = 'Font scale',
								desc = 'The scale of all fonts displayed on nameplates',
								type = 'range',
								min = 0.01,
								softMax = 2,
							},
							outline = {
								name = 'Outline',
								desc = 'Display an outline on all fonts',
								type = 'toggle',
							},
							monochrome = {
								name = 'Monochrome',
								desc = 'Don\'t anti-alias fonts',
								type = 'toggle'
							},
							onesize = {
								name = 'Use one font size',
								desc = 'Use the same font size for all strings. Useful when using a pixel font.',
								type = 'toggle'
							},
						}
					},
				}
			},
			reload = {
				name = 'Reload UI',
				type = 'execute',
				width = 'triple',
				order = 99,
				func = ReloadUI
			},
		}
	}

	-- create module.ConfigChanged function
	-- TODO cycle these when changing profiles (or something)
	function addon:CreateConfigChangedListener(module)
		if module.configChangedFuncs and not module.ConfigChanged then
			module.ConfigChanged = function(key, profile)
				if module.configChangedFuncs.runOnce and
				   module.configChangedFuncs.runOnce[key]
				then
					-- call runOnce function
					module.configChangedFuncs.runOnce[key](profile[key])
				end

				if module.configChangedFuncs[key] then
					-- iterate frames and call
					for _, frame in pairs(addon.frameList) do
						module.configChangedFuncs[key](frame, profile[key])
					end
				end
			end
		end
	end

	-- create an options table for the given module
	function addon:InitModuleOptions(module)
		if not module.GetOptions then return end
		local opts = module:GetOptions()
		local name = module.uiName or module.moduleName

		self:CreateConfigChangedListener(module)

		options.args[name] = {
			name = name,
			handler = self:GetOptionHandler(module),
			type = 'group',
			order = 50+#handlers,
			get = 'Get',
			set = 'Set',
			args = opts
		}
	end

	addon.configChangedFuncs = { runOnce = {} }
	addon:CreateConfigChangedListener(addon)

	AceConfig:RegisterOptionsTable('kuinameplates', options)
	AceConfigDialog:AddToBlizOptions('kuinameplates', 'Kui Nameplates')
end

--------------------------------------------------------------- Slash command --
SLASH_KUINAMEPLATES1 = '/kuinameplates'
SLASH_KUINAMEPLATES2 = '/knp'

function SlashCmdList.KUINAMEPLATES()
	InterfaceOptionsFrame_OpenToCategory('Kui Nameplates')
end
