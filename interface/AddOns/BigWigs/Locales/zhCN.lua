local L = LibStub("AceLocale-3.0"):NewLocale("Big Wigs", "zhCN")

if not L then return end

-- Core.lua
L["%s has been defeated"] = "%s被击败了！"

L.bosskill = "首领死亡"
L.bosskill_desc = "首领被击杀时显示提示信息。"
L.berserk = "狂暴"
L.berserk_desc = "当首领进入狂暴状态时发出警报。"
L.stages = "阶段"
L.stages_desc = "启用首领不同阶段的相关功能，如近距离显示、计时条等。"

L.already_registered = "|cffff0000警告：|r |cff00ff00%s|r（|cffffff00%s|r）在 Big Wigs 中已经存在模块，但存在模块仍试图重新注册。可能由于更新失败的原因，通常表示您有两份模块拷贝在您插件的文件夹中。建议删除所有 Big Wigs 文件夹并重新安装。"

-- Loader / Options.lua
L["You are running an official release of Big Wigs %s (revision %d)"] = "你所使用的 Big Wigs %s 为官方正式版（修订号%d）"
L["You are running an ALPHA RELEASE of Big Wigs %s (revision %d)"] = "你所使用的 Big Wigs %s 为“α测试版”（修订号%d）"
L["You are running a source checkout of Big Wigs %s directly from the repository."] = "你所使用的 Big Wigs %s 为从源直接检出的。"
L["There is a new release of Big Wigs available (/bwv). You can visit curse.com, wowinterface.com, wowace.com or use the Curse Updater to get the new release."] = "有新的 Big Wigs 正式版可用。（/bwv）你可以访问 curse.com，wowinterface.com，wowace.com 或使用 Curse 更新器来更新到新的正式版。"
L["Your alpha version of Big Wigs is out of date (/bwv)."] = "Big Wigs α 测试版已过期。（/bwv）。"

L.tooltipHint = "|cffeda55f点击|r图标重置所有运行中的模块。|cffeda55fAlt-点击|r可以禁用所有首领模块。"
L["Active boss modules:"] = "激活首领模块："
L["All running modules have been reset."] = "所有运行中的模块都已重置。"
L["All running modules have been disabled."] = "所有运行中的模块都已禁用。"

L["There are people in your group with older versions or without Big Wigs. You can get more details with /bwv."] = "在你队伍里使用旧版本或没有使用 Big Wigs。你可以用 /bwv 获得详细内容。"
L["Up to date:"] = "已更新："
L["Out of date:"] = "过期："
L["No Big Wigs 3.x:"] = "没有 Big Wigs 3.x："

L["Waiting until combat ends to finish loading due to Blizzard combat restrictions."] = "因为暴雪的战斗限制将在等待战斗结束后加载。"
L["Combat has ended, Big Wigs has now finished loading."] = "战斗已结束，Big Wigs 已完成加载。"
L["Due to Blizzard restrictions the config must first be opened out of combat, before it can be accessed in combat."] = "由于暴雪的限制必须脱离战斗后才可进行配置，然后才可以在战斗中使用。"

L["Please note that this zone requires the -[[|cFF436EEE%s|r]]- plugin for timers to be displayed."] = "请注意，这个区域需要 -[[|cFF436EEE%s|r]]- 插件计时器才可被显示。"

L.coreAddonDisabled = "当%s被禁用时，Big Wigs 将无法正常工作。你可以在角色选择屏幕的插件控制面板开启它们。"

-- Options.lua
L["Customize ..."] = "自定义…"
L["Profiles"] = "配置文件"
L.introduction = "欢迎使用 Big Wigs 戏弄各个首领。请系好安全带，吃吃花生并享受这次旅行。它不会吃了你的孩子，但会协助你的团队与新的首领进行战斗就如同享受饕餮大餐一样。"
L["Configure ..."] = "配置…"
L.configureDesc = "关闭插件选项窗口并配置显示项，如计时条、信息。\n\n如果需要自定义更多幕后时间，你可以展开左侧 Big Wigs 找到“自定义…”小项进行设置。"
L["Sound"] = "音效"
L.soundDesc = "信息出现时伴随着音效。有些人更容易在听到何种音效后发现何种警报，而不是阅读的实际信息。\n\n|cffff4411即使被关闭，默认的团队警报音效可能会随其它玩家的团队警报出现，那些声音与这里用的不同。|r"
L["Show Blizzard warnings"] = "暴雪警报"
L.blizzardDesc = "暴雪提供了他们自己的警报信息。我们认为，这些信息太长和复杂。我们试着简化这些消息而不打扰游戏的乐趣，并不需要你做什么。\n\n|cffff4411当关闭时，暴雪警报将不会再屏幕中间显示，但是仍将显示在聊天框体内。|r"
L["Flash Screen"] = "闪屏"
L.flashDesc = "某些技能极其重要到需要充分被重视。当这些能力对你造成影响时 Big Wigs 可以使屏幕闪烁。"
L["Raid icons"] = "团队标记"
L.raidiconDesc = "团队中有些首领模块使用团队标记来为某些中了特定技能的队员打上标记。例如类似“炸弹”类或心灵控制的技能。如果你关闭此功能，你将不会给队员打标记。\n\n|cffff4411只有团队领袖或被提升为助理时才可以这么做！|r"
L["Minimap icon"] = "小地图图标"
L["Toggle show/hide of the minimap icon."] = "打开或关闭小地图图标。"
L["Configure"] = "配置"
L["Test"] = "测试"
L["Reset positions"] = "重置位置"
L["Colors"] = "颜色"
L["Select encounter"] = "选择战斗"
L["List abilities in group chat"] = "列出技能到团队聊天"
L["Block boss movies"] = "阻止首领过场动画"
L["After you've seen a boss movie once, Big Wigs will prevent it from playing again."] = "在看过一次首领过场动画以后，Big Wigs 将防止它再次播放。"
L["Prevented boss movie '%d' from playing."] = "防止首领过场动画“%d”被播放。"
L["Pretend I'm using DBM"] = "假如我使用 DBM"
L.pretendDesc = "如果 DBM 用户进行版本检查，看看谁在使用 DBM，他们会看到你的列表上。当公会强制使用 DBM 时非常有用。"
L["Create custom DBM bars"] = "创建自定义 DBM 计时条"
L.dbmBarDesc = "如果 DBM 用户发送计时器或自定义“披萨”计时条，Big Wigs 将显示它们。"
L.chatMessages = "聊天框体信息"
L.chatMessagesDesc = "除了显示设置，输出所有 Big Wigs 信息到默认聊天框体。"

L.slashDescTitle = "|cFFFED000命令行：|r"
L.slashDescPull = "|cFFFED000/pull:|r 发送拉怪倒数提示到团队。"
L.slashDescRaidBar = "|cFFFED000/raidbar:|r 发送自定义计时条到团队。"
L.slashDescLocalBar = "|cFFFED000/localbar:|r 创建一个只有自身可见的自定义计时条。"
L.slashDescRange = "|cFFFED000/range:|r 开启范围侦测。"
L.slashDescVersion = "|cFFFED000/bwv:|r 进行 Big Wigs 版本检测。"
L.slashDescConfig = "|cFFFED000/bw:|r 开启 Big Wigs 配置。"

L.BAR = "计时条"
L.MESSAGE = "信息"
L.ICON = "标记"
L.SAY = "说"
L.FLASH = "闪烁"
L.EMPHASIZE = "醒目"
L.ME_ONLY = "只对自身"
L.ME_ONLY_desc = "当启用此选项时只有对你有影响的技能信息才会被显示。比如，“炸弹：玩家”将只会在你是炸弹时显示。"
L.PULSE = "脉冲"
L.PULSE_desc = "除了闪屏之外，也可以使特定技能的图标随之显示在你的屏幕上，以提高注意力。"
L.MESSAGE_desc = "大多数遇到技能出现一个或多个信息时 Big Wigs 将在屏幕上显示。如果禁用此选项，没有信息附加选项，如果有，将会被显示。"
L.BAR_desc = "当遇到某些技能时计时条将会适当显示。如果这个功能伴随着你想要隐藏的计时条，禁用此选项。"
L.FLASH_desc = "有些技能可能比其他的更重要。如果想这些重要技能施放时屏幕进行闪烁，选中此选项。"
L.ICON_desc = "Big Wigs 可以根据技能用图标标记人物。这将使他们更容易被辨认。"
L.SAY_desc = "聊天泡泡容易辨认。Big Wigs 将使用说的信息方式通知给附近的人告诉他们你中了什么技能。"
L.EMPHASIZE_desc = "启用这些将特别醒目所相关遇到技能的任何信息或计时条。信息将被放大，计时条将会闪烁并有不同的颜色，技能即将出现时会使用计时音效，基本上你会发现它。"
L.PROXIMITY = "近距离显示"
L.PROXIMITY_desc = "有些技能有时会要求团队散开。近距离显示为这些技能独立的设置一个窗口告诉你谁离你过近是并且是不安全的。"
L.TANK = "只对坦克"
L.TANK_desc = "有些技能只对坦克重要。如想看到这些技能警报而无视你的职业，禁用此选项。"
L.HEALER = "只对治疗"
L.HEALER_desc = "有些技能只对治疗重要。如想看到这些技能警报而无视你的职业，禁用此选项。"
L.TANK_HEALER = "只对坦克和治疗"
L.TANK_HEALER_desc = "有些技能只对坦克和治疗重要。如想看到这些技能警报而无视你的职业，禁用此选项。"
L.DISPEL = "只对驱散和打断"
L.DISPEL_desc = "如果希望看到你不能打断和驱散的技能警报，禁用此选项。"
L["Advanced options"] = "高级选项"
L["<< Back"] = "<< 返回"

L.tank = "|cFFFF0000只警报坦克。|r"
L.healer = "|cFFFF0000只警报治疗。|r"
L.tankhealer = "|cFFFF0000只警报坦克和治疗。|r"
L.dispeller = "|cFFFF0000只警报驱散和打断。|r"

L.About = "关于"
L.Developers = "开发者"
L.Maintainers = "维护"
L.License = "许可"
L.Website = "网站"
L.Contact = "联系方式"
L["See license.txt in the main Big Wigs folder."] = "查看 license.txt 位于 Big Wigs 主文件夹。"
L["irc.freenode.net in the #wowace channel"] = "#wowace 频道位于 irc.freenode.net"
L["Thanks to the following for all their help in various fields of development"] = "感谢他们在各个领域的开发与帮助"

-- Statistics
L.statistics = "统计"
L.norm25 = "25人"
L.heroic25 = "25人英雄"
L.norm10 = "10人"
L.heroic10 = "10人英雄"
L.lfr = "随机团队"
L.wipes = "团灭："
L.kills = "击杀："
L.bestkill = "最快击杀："

