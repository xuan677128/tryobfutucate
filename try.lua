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

-- Global Auto Obby logic
task.spawn(function()
	local runOnce = function()
		if not autoObby then return end
		if not character or not humanoidRootPart then return end
		
		local radioactiveFolder = workspace.MapVariants:FindFirstChild("Radioactive")
		if not radioactiveFolder then return end
		
		local orb = radioactiveFolder:FindFirstChild("Orb")
		if not orb then return end
		
		local hrp = orb:FindFirstChild("HumanoidRootPart")
		if not hrp then return end
		
		wait(0.5)
		
		for i = 1, 30 do
			if not autoObby or not scriptRunning then break end
			
			local parts = radioactiveFolder:GetDescendants()
			for _, obj in pairs(parts) do
				if obj:IsA("BasePart") and obj.CanCollide and obj.Name ~= "HumanoidRootPart" then
					pcall(function()
						firetouchinterest(humanoidRootPart, obj, 0)
						wait()
						firetouchinterest(humanoidRootPart, obj, 1)
					end)
				end
			end
			wait(0.1)
		end
	end

	workspace.MapVariants.ChildAdded:Connect(function(child)
		if child.Name == "Radioactive" then
			wait(0.5)
			runOnce()
		end
	end)
	
	if workspace.MapVariants:FindFirstChild("Radioactive") then
		runOnce()
	end
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
