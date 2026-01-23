-- ================= XUAN HUB GUI (WindUI Version) =================
if game.PlaceId ~= 131623223084840 then
	game:GetService("Players").LocalPlayer:Kick("Xuan Hub not supported this game!")
	return
end

print("--===== XUAN HUB LOADED (WindUI) =====--")

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local HttpService = game:GetService("HttpService")

-- ================= LOAD WINDUI =================
local WindUI = loadstring(game:HttpGet(
	"https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"
))()

-- ================= SET FONT (IMPORTANT) =================
-- WindUI text font
WindUI:SetFont("rbxasset://fonts/families/GothamSSm.json")

-- ================= SETTINGS PERSISTENCE =================
local settingsFileName = "XuanHubSettings.json"
local defaultSettings = {
	autoCollectMoney = false,
	autoCollectRadioactive = false,
	autoSpin = false,
	spinDelay = 0.5,
	antiAfk = false,
	autoReconnect = false,
	autoUpgradeBase = false,
	autoUpgradeCarry = false,
	autoUpgradeSpeed = false,
	upgradeSpeedAmount = 1,
	autoRebirth = false,
	autoObby = false
}

local function loadSettings()
	if not isfolder("XuanHub") then
		makefolder("XuanHub")
	end
	
	if isfile("XuanHub/" .. settingsFileName) then
		local success, data = pcall(function()
			return HttpService:JSONDecode(readfile("XuanHub/" .. settingsFileName))
		end)
		if success and data then
			return data
		end
	end
	return defaultSettings
end

local function saveSettings(settings)
	pcall(function()
		if not isfolder("XuanHub") then
			makefolder("XuanHub")
		end
		writefile("XuanHub/" .. settingsFileName, HttpService:JSONEncode(settings))
	end)
end

local savedSettings = loadSettings()

-- ================= CREATE WINDUI WINDOW =================
local Window = WindUI:CreateWindow({
	Folder = "XuanHub",
	Title = "XUAN HUB",
	Author = "by discord.gg/kaydensdens",
	Icon = "rbxassetid://103326199885496",
	Theme = "Midnight",
	Size = UDim2.fromOffset(640, 480),
	Draggable = true,
	HasOutline = true,
	OutlineThickness = 3,
    Resizable = true,
    KeySystem = {
        Note = "Key System for Xuan Hub.",
        API = {
            {
                Title = "Platoboost",
                Desc = "Click to copy.",
                Type = "platoboost",
                ServiceId = 19150,
                Secret = "de1c7213-1259-48ec-a052-9ad313dc3f79",
            },
        },
    },
})

-- Add version tag
Window:Tag({
	Title = "Server: " .. tostring(game.PlaceVersion),
	Icon = "solar:server-bold",
	Color = Color3.fromRGB(255, 105, 180),
	Border = true,
})

-- ================= TABS =================


local BaseTab = Window:Tab({
	Title = "Base",
	Icon = "layers-2",
	Locked = false,
})

local EventTab = Window:Tab({
	Title = "Event",
	Icon = "star",
	Locked = false,
})

local AutoTab = Window:Tab({
	Title = "Auto",
	Icon = "refresh-cw",
	Locked = false,
})

local MiscTab = Window:Tab({
	Title = "Misc",
	Icon = "settings",
	Locked = false,
})

-- Set Base tab as default
BaseTab:Select()

-- ================= FUNCTIONALITY LOGIC =================

-- Script running flag (to stop all loops when GUI is closed)
local scriptRunning = true

local character, humanoidRootPart
local EventFolder = nil

local PullDelay = 0.1
local HeightOffset = 3
local active = false
local spinning = false
local autoObby = false
local collectingMoney = false
local autoUpgradeBase = false
local autoUpgradeCarry = false
local autoUpgradeSpeed = false
local upgradeSpeedAmount = 1
local autoRebirth = false

-- Sell All confirmation
local lastSellAllClick = 0

-- Character handler (safe)
local function setupCharacter(char)
	character = char
	humanoidRootPart = char:WaitForChild("HumanoidRootPart", 10)
end

if player.Character then
	setupCharacter(player.Character)
end
player.CharacterAdded:Connect(setupCharacter)

-- Global Auto Obby logic (runs whenever obby activates and toggle is on)
task.spawn(function()
	local mapVariants = workspace:WaitForChild("MapVariants")
	
	local function runOnce(radioactive)
		if not autoObby or not humanoidRootPart then return end
		local obbyEnd = radioactive:WaitForChild("ObbyEnd", 5)
		if obbyEnd then
			firetouchinterest(humanoidRootPart, obbyEnd, 0)
			task.wait()
			firetouchinterest(humanoidRootPart, obbyEnd, 1)
		end
	end
	
	-- Check for existing on script start
	local existing = mapVariants:FindFirstChild("Radioactive")
	if existing and autoObby then
		runOnce(existing)
	end
	
	-- Listen for new activations
	mapVariants.ChildAdded:Connect(function(child)
		if child.Name == "Radioactive" and autoObby then
			runOnce(child)
		end
	end)
end)

-- Find EventParts WITHOUT BLOCKING GUI
task.spawn(function()
	while not EventFolder and scriptRunning do
		EventFolder = workspace:FindFirstChild("EventParts")
		task.wait(1)
	end
end)

-- Model part
local function getModelPart(model)
	if model.PrimaryPart then return model.PrimaryPart end
	for _, v in ipairs(model:GetDescendants()) do
		if v:IsA("BasePart") then
			model.PrimaryPart = v
			return v
		end
	end
end

-- Loop to pull models
task.spawn(function()
	while scriptRunning do
		if active and humanoidRootPart and EventFolder then
			for _, model in ipairs(EventFolder:GetChildren()) do
				if model:IsA("Model") then
					local part = getModelPart(model)
					if part then
						model:SetPrimaryPartCFrame(
							CFrame.new(humanoidRootPart.Position + Vector3.new(0, HeightOffset, 0))
						)
					end
				end
			end
		end
		task.wait(PullDelay)
	end
end)

-- Auto Spin logic
task.spawn(function()
	while scriptRunning do
		if spinning then
			pcall(function()
				game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Net"):WaitForChild("RF/WheelSpin.Roll"):InvokeServer()
			end)
			-- Get delay from input box with validation
			local delayValue = tonumber(savedSettings.spinDelay) or 0.5
			if delayValue <= 0 then delayValue = 0.5 end
			task.wait(delayValue)
		else
			task.wait(0.5)
		end
	end
end)

-- Auto Collect Money logic
local function findMyBase()
	for _, base in ipairs(workspace:WaitForChild("Bases"):GetChildren()) do
		if base:IsA("Model") then
			local holder = base:GetAttribute("Holder")
			if holder and holder == player.UserId then
				return base
			end
		end
	end
	return nil
end

task.spawn(function()
	while scriptRunning do
		if collectingMoney then
			local myBase = findMyBase()
			if myBase then
				for i = 1, 30 do
					pcall(function()
						local args = {
							"Collect Money",
							myBase.Name,
							tostring(i)
						}
						local PlotAction = game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Net"):WaitForChild("RF/Plot.PlotAction")
						PlotAction:InvokeServer(unpack(args))
					end)
					task.wait(0.01)
				end
			end
			task.wait(0.1)
		else
			task.wait(0.5)
		end
	end
end)

-- Auto Upgrade Base Loop
task.spawn(function()
	while scriptRunning do
		if autoUpgradeBase then
			pcall(function()
				game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Net"):WaitForChild("RE/Plot.UpgradeBase"):FireServer()
			end)
			task.wait(0.5)
		else
			task.wait(1)
		end
	end
end)

-- Auto Upgrade Carry Loop
task.spawn(function()
	while scriptRunning do
		if autoUpgradeCarry then
			pcall(function()
				game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunctions"):WaitForChild("UpgradeCarry"):InvokeServer()
			end)
			task.wait(0.5)
		else
			task.wait(1)
		end
	end
end)

-- Auto Upgrade Speed Loop
task.spawn(function()
	while scriptRunning do
		if autoUpgradeSpeed then
			pcall(function()
				local args = { upgradeSpeedAmount }
				game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunctions"):WaitForChild("UpgradeSpeed"):InvokeServer(unpack(args))
			end)
			task.wait(0.5)
		else
			task.wait(1)
		end
	end
end)

-- Auto Rebirth Loop
task.spawn(function()
	while scriptRunning do
		if autoRebirth then
			pcall(function()
				game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunctions"):WaitForChild("Rebirth"):InvokeServer()
			end)
			task.wait(1)
		else
			task.wait(1)
		end
	end
end)

-- Anti-AFK (toggleable)
local antiAfkEnabled = savedSettings.antiAfk or false
local antiAfkConn = nil
local vu = game:GetService("VirtualUser")
local function enableAntiAfk()
	if antiAfkConn then return end
	antiAfkConn = player.Idled:Connect(function()
		vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
		task.wait(1)
		vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
	end)
end
local function disableAntiAfk()
	if antiAfkConn then
		antiAfkConn:Disconnect()
		antiAfkConn = nil
	end
end
if antiAfkEnabled then
	enableAntiAfk()
end

-- Auto Reconnect (toggleable)
local autoReconnectEnabled = savedSettings.autoReconnect or false
local autoReconnectConn = nil
local function enableAutoReconnect()
	if autoReconnectConn then return end
	local success, conn = pcall(function()
		return game.CoreGui.RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
			if child.Name == 'ErrorPrompt' and child:FindFirstChild('MessageArea') and child.MessageArea:FindFirstChild("ErrorFrame") then
				game:GetService("TeleportService"):Teleport(game.PlaceId, player)
			end
		end)
	end)
	if success and conn then
		autoReconnectConn = conn
	end
end
local function disableAutoReconnect()
	if autoReconnectConn then
		autoReconnectConn:Disconnect()
		autoReconnectConn = nil
	end
end
if autoReconnectEnabled then
	enableAutoReconnect()
end



-- ================= BASE TAB =================
local UpgBase = BaseTab:Section({Title = "Main", Opened = true,})

local UpgBaseOnce = BaseTab:Button({
	Title = "Upgrade Base",
	Desc = "Purchase one base upgrade",
	Locked = false,
	Callback = function()
		pcall(function()
			game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Net"):WaitForChild("RE/Plot.UpgradeBase"):FireServer()
		end)
		WindUI:Notify({
			Title = "Upgraded",
			Content = "Base upgrade purchased!",
			Icon = "check",
			Duration = 3,
		})
	end
})

-- Upgrade Carry (manual)
local UpgCarryOnce = BaseTab:Button({
	Title = "Upgrade Carry",
	Desc = "Purchase one carry upgrade",
	Locked = false,
	Callback = function()
		pcall(function()
			game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunctions"):WaitForChild("UpgradeCarry"):InvokeServer()
		end)
		WindUI:Notify({
			Title = "Upgraded",
			Content = "Carry upgrade purchased!",
			Icon = "check",
			Duration = 3,
		})
	end
})

-- Buttons moved from Main (simplified)
local SellAllBtn = BaseTab:Button({
	Title = "Sell All Inventory",
	Desc = "Double-click within 0.5s to confirm sell all",
	Locked = false,
	Callback = function()
		local currentTime = tick()
		if currentTime - lastSellAllClick < 0.5 then
			-- Double click: sell
			pcall(function()
				game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunctions"):WaitForChild("SellAll"):InvokeServer()
			end)
			WindUI:Notify({
				Title = "Sold",
				Content = "All inventory items sold!",
				Icon = "check",
				Duration = 3,
			})
		else
			lastSellAllClick = currentTime
		end
	end
})

local SellHeldBtn = BaseTab:Button({
	Title = "Sell Held Tool",
	Desc = "Sells the brainrot you are currently holding",
	Locked = false,
	Callback = function()
		pcall(function()
			game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunctions"):WaitForChild("SellTool"):InvokeServer()
		end)
		WindUI:Notify({
			Title = "Sold",
			Content = "Held tool sold!",
			Icon = "check",
			Duration = 3,
		})
	end
})



-- ================= EVENT TAB =================
EventTab:Section({
	Title = "Radioactive Event",
	Opened = true,
})

-- Auto Collect Radioactive
EventTab:Toggle({
	Title = "Auto Collect Radioactive Coins",
	Desc = "(Patched, it will still collect but not many)",
	Value = savedSettings.autoCollectRadioactive,
	Callback = function(state)
		active = state
		savedSettings.autoCollectRadioactive = state
		saveSettings(savedSettings)
	end
})

EventTab:Space()

-- Auto Spin
EventTab:Toggle({
	Title = "Auto Spin Radioactive Wheel",
	Desc = "Automatically spins the radioactive wheel",
	Value = savedSettings.autoSpin,
	Callback = function(state)
		spinning = state
		savedSettings.autoSpin = state
		saveSettings(savedSettings)
	end
})

EventTab:Input({
	Title = "Spin Delay",
	Value = tostring(savedSettings.spinDelay),
	Placeholder = "0.5",
	Callback = function(value)
		local delay = tonumber(value)
		if delay and delay >= 0.1 then
			savedSettings.spinDelay = delay
			saveSettings(savedSettings)
		end
	end
})

EventTab:Space()

-- Auto Obby
EventTab:Toggle({
	Title = "Auto Obby",
	Desc = "Automatically completes the obby",
	Value = savedSettings.autoObby,
	Callback = function(state)
		autoObby = state
		savedSettings.autoObby = state
		saveSettings(savedSettings)
	end
})

-- ================= AUTO TAB =================
local AutoSection = AutoTab:Section({Title = "Auto Features", Opened = true,})

-- Auto Upgrade Base
local AutoUpgradeBaseToggle = AutoSection:Toggle({
	Title = "Auto Upgrade Base",
	Desc = "Automatically upgrades your base",
	Value = savedSettings.autoUpgradeBase,
	Callback = function(state)
		autoUpgradeBase = state
		savedSettings.autoUpgradeBase = state
		saveSettings(savedSettings)
	end
})

-- Auto Collect Money
local AutoCollectMoneyToggle = AutoSection:Toggle({
	Title = "Auto Collect Money",
	Desc = "Automatically collects money from your base",
	Value = savedSettings.autoCollectMoney,
	Callback = function(state)
		collectingMoney = state
		savedSettings.autoCollectMoney = state
		saveSettings(savedSettings)
	end
})

-- Auto Upgrade Carry
local AutoUpgradeCarryToggle = AutoSection:Toggle({
	Title = "Auto Upgrade Carry",
	Desc = "Automatically upgrades carry capacity",
	Value = savedSettings.autoUpgradeCarry,
	Callback = function(state)
		autoUpgradeCarry = state
		savedSettings.autoUpgradeCarry = state
		saveSettings(savedSettings)
	end
})

-- Auto Upgrade Speed
local AutoUpgradeSpeedToggle = AutoSection:Toggle({
	Title = "Auto Upgrade Speed",
	Desc = "Automatically upgrades movement speed",
	Value = savedSettings.autoUpgradeSpeed,
	Callback = function(state)
		autoUpgradeSpeed = state
		savedSettings.autoUpgradeSpeed = state
		saveSettings(savedSettings)
	end
})

local SpeedAmountDropdown = AutoSection:Dropdown({
	Title = "Speed Amount",
	Desc = "Select upgrade speed amount",
	Values = { "1", "5", "10" },
	Value = tostring(savedSettings.upgradeSpeedAmount),
	Multi = false,
	AllowNone = false,
	Callback = function(option)
		upgradeSpeedAmount = tonumber(option)
		savedSettings.upgradeSpeedAmount = upgradeSpeedAmount
		saveSettings(savedSettings)
		print("Speed amount set to: " .. tostring(option))
	end
})

-- Auto Rebirth
local AutoRebirthToggle = AutoSection:Toggle({
	Title = "Auto Rebirth",
	Desc = "Automatically rebirths when possible",
	Value = savedSettings.autoRebirth,
	Callback = function(state)
		autoRebirth = state
		savedSettings.autoRebirth = state
		saveSettings(savedSettings)
	end
})

-- ================= MISC TAB =================
local MiscSettings = MiscTab:Section({
	Title = "Game Settings",
	Opened = true,
})

-- Anti-AFK
MiscSettings:Toggle({
	Title = "Anti-AFK",
	Desc = "Prevents Roblox from kicking you after 20 minutes of inactivity",
	Value = savedSettings.antiAfk,
	Callback = function(state)
		antiAfkEnabled = state
		savedSettings.antiAfk = state
		saveSettings(savedSettings)
		if state then
			enableAntiAfk()
		else
			disableAntiAfk()
		end
	end
})

MiscSettings:Space()

-- Auto Reconnect
MiscSettings:Toggle({
	Title = "Auto Reconnect",
	Desc = "Automatically rejoins the game when you get disconnected",
	Value = savedSettings.autoReconnect,
	Callback = function(state)
		autoReconnectEnabled = state
		savedSettings.autoReconnect = state
		saveSettings(savedSettings)
		if state then
			enableAutoReconnect()
		else
			disableAutoReconnect()
		end
	end
})

MiscTab:Space()
MiscTab:Space()

MiscTab:Section({
	Title = "Server Actions",
	Opened = true,
})

local ServerGroup = MiscTab:Group()

ServerGroup:Button({
	Title = "Server Hop",
	Icon = "solar:refresh-bold",
	Color = Color3.fromRGB(255, 105, 180),
	Justify = "Center",
	Callback = function()
		local servers = {}
		local req = game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Desc&limit=100")
		local body = HttpService:JSONDecode(req)
		
		if body and body.data then
			for _, v in pairs(body.data) do
				if v.id ~= game.JobId and v.playing < v.maxPlayers then
					table.insert(servers, v)
				end
			end
			
			if #servers > 0 then
				local randomServer = servers[math.random(1, #servers)]
				game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, randomServer.id, player)
			end
		end
	end
})

ServerGroup:Space()

ServerGroup:Button({
	Title = "Rejoin",
	Icon = "solar:restart-bold",
	Color = Color3.fromRGB(255, 105, 180),
	Justify = "Center",
	Callback = function()
		game:GetService("TeleportService"):Teleport(game.PlaceId, player)
	end
})

-- ================= SETTINGS APPLY =================
task.spawn(function()
	task.wait(0.5) -- Wait for GUI to fully load
	
	-- Apply Auto Collect Money
	if savedSettings.autoCollectMoney then
		collectingMoney = true
	end
	
	-- Apply Auto Collect Radioactive
	if savedSettings.autoCollectRadioactive then
		active = true
	end
	
	-- Apply Auto Spin
	if savedSettings.autoSpin then
		spinning = true
	end
	
	-- Apply Auto Upgrade Base
	if savedSettings.autoUpgradeBase then
		autoUpgradeBase = true
	end
	
	-- Apply Auto Upgrade Carry
	if savedSettings.autoUpgradeCarry then
		autoUpgradeCarry = true
	end
	
	-- Apply Auto Upgrade Speed
	if savedSettings.autoUpgradeSpeed then
		autoUpgradeSpeed = true
	end
	
	-- Apply Upgrade Speed Amount
	if savedSettings.upgradeSpeedAmount then
		upgradeSpeedAmount = savedSettings.upgradeSpeedAmount
	end
	
	-- Apply Auto Rebirth
	if savedSettings.autoRebirth then
		autoRebirth = true
	end
	
	-- Apply Auto Obby
	if savedSettings.autoObby then
		autoObby = true
		
		-- Check for existing obby on script load
		task.spawn(function()
			local mapVariants = workspace:FindFirstChild("MapVariants")
			if mapVariants then
				local existing = mapVariants:FindFirstChild("Radioactive")
				if existing then
					local obbyEnd = existing:WaitForChild("ObbyEnd", 5)
					if obbyEnd and humanoidRootPart then
						firetouchinterest(humanoidRootPart, obbyEnd, 0)
						task.wait()
						firetouchinterest(humanoidRootPart, obbyEnd, 1)
					end
				end
			end
		end)
	end
	
	-- Apply Anti-AFK
	if savedSettings.antiAfk then
		antiAfkEnabled = true
		enableAntiAfk()
	else
		antiAfkEnabled = false
		disableAntiAfk()
	end

	-- Apply Auto Reconnect
	if savedSettings.autoReconnect then
		autoReconnectEnabled = true
		enableAutoReconnect()
	else
		autoReconnectEnabled = false
		disableAutoReconnect()
	end
end)

-- ================= FINALIZE =================
WindUI:Notify({
	Title = "Xuan Hub Loaded",
	Content = "Welcome " .. player.DisplayName .. "!",
	Icon = "check",
	Duration = 5,
})

print("--===== XUAN HUB READY =====--")
