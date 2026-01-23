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
	HasOutline = true,
	OutlineThickness = 3
})

-- Add version tag
Window:Tag({
	Title = "Server: " .. tostring(game.PlaceVersion),
	Icon = "solar:server-bold",
	Color = Color3.fromRGB(255, 105, 180),
	Border = true,
})

-- ================= TABS =================
local MainTab = Window:Tab({
	Title = "Main",
	Icon = "solar:home-2-bold",
	IconColor = Color3.fromRGB(255, 105, 180),
	IconShape = "Square",
	Border = true,
})

local EventTab = Window:Tab({
	Title = "Event",
	Icon = "solar:star-bold",
	IconColor = Color3.fromRGB(255, 215, 0),
	IconShape = "Square",
	Border = true,
})

local SettingsTab = Window:Tab({
	Title = "Settings",
	Icon = "solar:settings-bold",
	IconColor = Color3.fromRGB(150, 150, 150),
	IconShape = "Square",
	Border = true,
})

-- ================= FUNCTIONALITY LOGIC =================
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
local upgradeSpeedAmount = savedSettings.upgradeSpeedAmount
local autoRebirth = false

-- Character handler
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

-- Auto Spin loop
task.spawn(function()
	while scriptRunning do
		if spinning then
			pcall(function()
				game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Net"):WaitForChild("RF/WheelSpin.Roll"):InvokeServer()
			end)
			task.wait(savedSettings.spinDelay)
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

-- Anti-AFK (Always Enabled)
local vu = game:GetService("VirtualUser")
player.Idled:Connect(function()
	vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
	task.wait(1)
	vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

-- Auto Reconnect (Always Enabled)
pcall(function()
	game.CoreGui.RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
		if child.Name == 'ErrorPrompt' and child:FindFirstChild('MessageArea') and child.MessageArea:FindFirstChild("ErrorFrame") then
			game:GetService("TeleportService"):Teleport(game.PlaceId, player)
		end
	end)
end)

-- ================= MAIN TAB =================
MainTab:Section({
	Title = "Farming",
})

-- Auto Collect Money
MainTab:Toggle({
	Flag = "AutoCollectMoney",
	Title = "Auto Collect Money",
	Value = savedSettings.autoCollectMoney,
	Callback = function(state)
		collectingMoney = state
		savedSettings.autoCollectMoney = state
		saveSettings(savedSettings)
		
		if state then
			task.spawn(function()
				while collectingMoney and scriptRunning do
					pcall(function()
						if character and humanoidRootPart then
							for _, v in pairs(workspace.Debris:GetChildren()) do
								if v.Name == "Money" and v:FindFirstChild("Mesh") then
									v.CFrame = humanoidRootPart.CFrame
								end
							end
						end
					end)
					wait(PullDelay)
				end
			end)
		end
	end
})

MainTab:Space()

-- Sell All Button
MainTab:Button({
	Title = "Sell All Inventory",
	Icon = "solar:trash-bin-trash-bold",
	Color = Color3.fromRGB(200, 50, 80),
	Justify = "Center",
	Callback = function()
		pcall(function()
			for _, tool in pairs(player.Backpack:GetChildren()) do
				if tool:IsA("Tool") then
					game:GetService("ReplicatedStorage").Events.SellTool:FireServer(tool)
				end
			end
			if character then
				for _, tool in pairs(character:GetChildren()) do
					if tool:IsA("Tool") then
						game:GetService("ReplicatedStorage").Events.SellTool:FireServer(tool)
					end
				end
			end
		end)
		WindUI:Notify({
			Title = "Sold",
			Content = "All inventory items sold!",
			Icon = "check",
			Duration = 3,
		})
	end
})

MainTab:Space()

-- Sell Held Tool
MainTab:Button({
	Title = "Sell Held Tool",
	Icon = "solar:hand-money-bold",
	Color = Color3.fromRGB(255, 105, 180),
	Justify = "Center",
	Callback = function()
		pcall(function()
			if character then
				local tool = character:FindFirstChildOfClass("Tool")
				if tool then
					game:GetService("ReplicatedStorage").Events.SellTool:FireServer(tool)
					WindUI:Notify({
						Title = "Sold",
						Content = "Held tool sold!",
						Icon = "check",
						Duration = 3,
					})
				else
					WindUI:Notify({
						Title = "No Tool",
						Content = "No tool equipped!",
						Icon = "alert-circle",
						Duration = 3,
					})
				end
			end
		end)
	end
})

MainTab:Space()
MainTab:Space()

MainTab:Section({
	Title = "Upgrades",
})

-- Auto Upgrade Base
MainTab:Toggle({
	Flag = "AutoUpgradeBase",
	Title = "Auto Upgrade Base",
	Value = savedSettings.autoUpgradeBase,
	Callback = function(state)
		autoUpgradeBase = state
		savedSettings.autoUpgradeBase = state
		saveSettings(savedSettings)
		
		if state then
			task.spawn(function()
				while autoUpgradeBase and scriptRunning do
					pcall(function()
						game:GetService("ReplicatedStorage").Events.UpgradeBase:FireServer()
					end)
					wait(0.5)
				end
			end)
		end
	end
})

MainTab:Space()

-- Auto Upgrade Carry
MainTab:Toggle({
	Flag = "AutoUpgradeCarry",
	Title = "Auto Upgrade Carry",
	Value = savedSettings.autoUpgradeCarry,
	Callback = function(state)
		autoUpgradeCarry = state
		savedSettings.autoUpgradeCarry = state
		saveSettings(savedSettings)
		
		if state then
			task.spawn(function()
				while autoUpgradeCarry and scriptRunning do
					pcall(function()
						game:GetService("ReplicatedStorage").Events.UpgradeCarry:FireServer()
					end)
					wait(0.5)
				end
			end)
		end
	end
})

MainTab:Space()

-- Auto Upgrade Speed
MainTab:Toggle({
	Flag = "AutoUpgradeSpeed",
	Title = "Auto Upgrade Speed",
	Value = savedSettings.autoUpgradeSpeed,
	Callback = function(state)
		autoUpgradeSpeed = state
		savedSettings.autoUpgradeSpeed = state
		saveSettings(savedSettings)
		
		if state then
			task.spawn(function()
				while autoUpgradeSpeed and scriptRunning do
					pcall(function()
						for i = 1, upgradeSpeedAmount do
							game:GetService("ReplicatedStorage").Events.UpgradeSpeed:FireServer()
							wait(0.1)
						end
					end)
					wait(0.5)
				end
			end)
		end
	end
})

MainTab:Dropdown({
	Title = "Speed Amount",
	Values = { "1", "5", "10" },
	Value = tostring(savedSettings.upgradeSpeedAmount),
	Callback = function(value)
		upgradeSpeedAmount = tonumber(value)
		savedSettings.upgradeSpeedAmount = upgradeSpeedAmount
		saveSettings(savedSettings)
	end
})

MainTab:Space()

-- Auto Rebirth
MainTab:Toggle({
	Flag = "AutoRebirth",
	Title = "Auto Rebirth",
	Value = savedSettings.autoRebirth,
	Callback = function(state)
		autoRebirth = state
		savedSettings.autoRebirth = state
		saveSettings(savedSettings)
		
		if state then
			task.spawn(function()
				while autoRebirth and scriptRunning do
					pcall(function()
						game:GetService("ReplicatedStorage").Events.Rebirth:FireServer()
					end)
					wait(1)
				end
			end)
		end
	end
})

-- ================= EVENT TAB =================
EventTab:Section({
	Title = "Radioactive Event",
})

-- Auto Collect Radioactive
EventTab:Toggle({
	Flag = "AutoCollectRadioactive",
	Title = "Auto Collect Radioactive Coins",
	Desc = "(Patched, it will still collect but not many)",
	Value = savedSettings.autoCollectRadioactive,
	Callback = function(state)
		active = state
		savedSettings.autoCollectRadioactive = state
		saveSettings(savedSettings)
		
		if state then
			task.spawn(function()
				while active and scriptRunning do
					pcall(function()
						if character and humanoidRootPart then
							EventFolder = workspace:FindFirstChild("EventFolder")
							if EventFolder then
								for _, coin in pairs(EventFolder:GetChildren()) do
									if coin.Name == "Coin" and coin:IsA("Model") and coin:FindFirstChild("Coin") then
										local coinPart = coin.Coin
										if (coinPart.Position - humanoidRootPart.Position).Magnitude < 200 then
											coinPart.CFrame = humanoidRootPart.CFrame + Vector3.new(0, HeightOffset, 0)
										end
									end
								end
							end
						end
					end)
					wait(PullDelay)
				end
			end)
		end
	end
})

EventTab:Space()

-- Auto Spin
EventTab:Toggle({
	Flag = "AutoSpin",
	Title = "Auto Spin Radioactive Wheel",
	Value = savedSettings.autoSpin,
	Callback = function(state)
		spinning = state
		savedSettings.autoSpin = state
		saveSettings(savedSettings)
		
		if state then
			task.spawn(function()
				while spinning and scriptRunning do
					pcall(function()
						game:GetService("ReplicatedStorage").Events.Spin:FireServer()
					end)
					wait(savedSettings.spinDelay)
				end
			end)
		end
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
	Flag = "AutoObby",
	Title = "Auto Obby",
	Value = savedSettings.autoObby,
	Callback = function(state)
		autoObby = state
		savedSettings.autoObby = state
		saveSettings(savedSettings)
	end
})

-- ================= SETTINGS TAB =================
SettingsTab:Section({
	Title = "Game Settings",
})

-- Anti-AFK
SettingsTab:Toggle({
	Flag = "AntiAFK",
	Title = "Anti-AFK",
	Desc = "Prevents Roblox from kicking you after 20 minutes of inactivity",
	Value = savedSettings.antiAfk,
	Callback = function(state)
		savedSettings.antiAfk = state
		saveSettings(savedSettings)
		
		if state then
			local vu = game:GetService("VirtualUser")
			player.Idled:Connect(function()
				if savedSettings.antiAfk then
					vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
					wait(1)
					vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
				end
			end)
		end
	end
})

SettingsTab:Space()

-- Auto Reconnect
SettingsTab:Toggle({
	Flag = "AutoReconnect",
	Title = "Auto Reconnect",
	Desc = "Automatically rejoins the game when you get disconnected",
	Value = savedSettings.autoReconnect,
	Callback = function(state)
		savedSettings.autoReconnect = state
		saveSettings(savedSettings)
		
		if state then
			game:GetService("CoreGui").DescendantAdded:Connect(function(descendant)
				if savedSettings.autoReconnect and descendant.Name == "ErrorPrompt" then
					wait(0.1)
					game:GetService("TeleportService"):Teleport(game.PlaceId, player)
				end
			end)
		end
	end
})

SettingsTab:Space()
SettingsTab:Space()

SettingsTab:Section({
	Title = "Server Actions",
})

local ServerGroup = SettingsTab:Group()

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

-- ================= FINALIZE =================
WindUI:Notify({
	Title = "Xuan Hub Loaded",
	Content = "Welcome " .. player.DisplayName .. "!",
	Icon = "check",
	Duration = 5,
})

print("--===== XUAN HUB READY =====--")
