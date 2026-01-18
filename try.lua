-- ================= XUAN HUB GUI =================
local Players = game:GetService("Players")
local player = Players.LocalPlayer

pcall(function()
	player.PlayerGui:FindFirstChild("XuanHubUI"):Destroy()
end)

local gui = Instance.new("ScreenGui")
gui.Name = "XuanHubUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = player:WaitForChild("PlayerGui")

-- Main Frame (Full UI)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 520, 0, 340)
mainFrame.Position = UDim2.new(0.5, -260, 0.5, -170)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 35, 50)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = gui
mainFrame.Visible = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)

local mainStroke = Instance.new("UIStroke", mainFrame)
mainStroke.Color = Color3.fromRGB(255, 105, 180)
mainStroke.Thickness = 2

-- Minimized Frame
local miniFrame = Instance.new("Frame")
miniFrame.Size = UDim2.new(0, 180, 0, 50)
miniFrame.Position = UDim2.new(0.5, -90, 0.1, 0)
miniFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
miniFrame.BorderSizePixel = 0
miniFrame.Active = true
miniFrame.Draggable = true
miniFrame.Parent = gui
miniFrame.Visible = false
Instance.new("UICorner", miniFrame).CornerRadius = UDim.new(0, 25)

local miniStroke = Instance.new("UIStroke", miniFrame)
miniStroke.Color = Color3.fromRGB(255, 105, 180)
miniStroke.Thickness = 2
miniStroke.Transparency = 0.5

-- Mini Icon
local miniIcon = Instance.new("TextLabel", miniFrame)
miniIcon.Size = UDim2.new(0, 45, 1, 0)
miniIcon.Position = UDim2.new(0, 5, 0, 0)
miniIcon.BackgroundTransparency = 1
miniIcon.Text = "💮"
miniIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
miniIcon.Font = Enum.Font.GothamBold
miniIcon.TextSize = 24

-- Mini Title
local miniTitle = Instance.new("TextLabel", miniFrame)
miniTitle.Size = UDim2.new(0, 90, 1, 0)
miniTitle.Position = UDim2.new(0, 50, 0, 0)
miniTitle.BackgroundTransparency = 1
miniTitle.Text = "Xuan Hub"
miniTitle.TextColor3 = Color3.new(1,1,1)
miniTitle.Font = Enum.Font.GothamBold
miniTitle.TextSize = 16
miniTitle.TextXAlignment = Enum.TextXAlignment.Left

-- Mini Expand Button
local expandBtn = Instance.new("TextButton", miniFrame)
expandBtn.Size = UDim2.new(0, 30, 0, 30)
expandBtn.Position = UDim2.new(1, -38, 0.5, -15)
expandBtn.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
expandBtn.Text = "+"
expandBtn.TextColor3 = Color3.new(1,1,1)
expandBtn.Font = Enum.Font.GothamBold
expandBtn.TextSize = 18
expandBtn.AutoButtonColor = false
Instance.new("UICorner", expandBtn).CornerRadius = UDim.new(1, 0)

-- Header
local header = Instance.new("Frame", mainFrame)
header.Size = UDim2.new(1, 0, 0, 50)
header.BackgroundColor3 = Color3.fromRGB(100, 60, 120)
header.BorderSizePixel = 0
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 12)

local headerGradient = Instance.new("UIGradient", header)
headerGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 60, 120)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 40, 80))
}

-- Logo Icon
local logo = Instance.new("TextLabel", header)
logo.Size = UDim2.new(0, 40, 0, 40)
logo.Position = UDim2.new(0, 10, 0, 5)
logo.BackgroundTransparency = 1
logo.Text = "💮"
logo.TextColor3 = Color3.fromRGB(255, 255, 255)
logo.Font = Enum.Font.GothamBold
logo.TextSize = 22

-- Title
local headerTitle = Instance.new("TextLabel", header)
headerTitle.Size = UDim2.new(0, 200, 1, 0)
headerTitle.Position = UDim2.new(0, 55, 0, 0)
headerTitle.BackgroundTransparency = 1
headerTitle.Text = "Xuan Hub"
headerTitle.TextColor3 = Color3.new(1,1,1)
headerTitle.Font = Enum.Font.GothamBold
headerTitle.TextSize = 18
headerTitle.TextXAlignment = Enum.TextXAlignment.Left

-- Discord Link
local discordLink = Instance.new("TextLabel", header)
discordLink.Size = UDim2.new(0, 200, 0, 14)
discordLink.Position = UDim2.new(0, 55, 0, 28)
discordLink.BackgroundTransparency = 1
discordLink.Text = "discord.gg/kaydensdens"
discordLink.TextColor3 = Color3.fromRGB(200, 200, 200)
discordLink.Font = Enum.Font.Gotham
discordLink.TextSize = 11
discordLink.TextXAlignment = Enum.TextXAlignment.Left

-- Minimize Button
local minimizeBtn = Instance.new("TextButton", header)
minimizeBtn.Size = UDim2.new(0, 35, 0, 35)
minimizeBtn.Position = UDim2.new(1, -82, 0, 8)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(60, 50, 70)
minimizeBtn.Text = "-"
minimizeBtn.TextColor3 = Color3.new(1,1,1)
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 20
minimizeBtn.AutoButtonColor = false
Instance.new("UICorner", minimizeBtn).CornerRadius = UDim.new(0, 8)

-- Close Button
local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.new(0, 35, 0, 35)
closeBtn.Position = UDim2.new(1, -42, 0, 8)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 80)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 16
closeBtn.AutoButtonColor = false
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 8)

-- Sidebar
local sidebar = Instance.new("Frame", mainFrame)
sidebar.Size = UDim2.new(0, 140, 1, -50)
sidebar.Position = UDim2.new(0, 0, 0, 50)
sidebar.BackgroundColor3 = Color3.fromRGB(30, 25, 40)
sidebar.BorderSizePixel = 0

-- Event Tab Button
local eventTab = Instance.new("TextButton", sidebar)
eventTab.Size = UDim2.new(1, -10, 0, 35)
eventTab.Position = UDim2.new(0, 5, 0, 10)
eventTab.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
eventTab.Text = "✨  Event"
eventTab.TextColor3 = Color3.new(1,1,1)
eventTab.Font = Enum.Font.GothamBold
eventTab.TextSize = 14
eventTab.TextXAlignment = Enum.TextXAlignment.Left
eventTab.AutoButtonColor = false
Instance.new("UICorner", eventTab).CornerRadius = UDim.new(0, 8)
local eventPadding = Instance.new("UIPadding", eventTab)
eventPadding.PaddingLeft = UDim.new(0, 10)

-- Player Profile Section
local profileFrame = Instance.new("Frame", sidebar)
profileFrame.Size = UDim2.new(1, -10, 0, 60)
profileFrame.Position = UDim2.new(0, 5, 1, -65)
profileFrame.BackgroundColor3 = Color3.fromRGB(25, 20, 35)
profileFrame.BorderSizePixel = 0
Instance.new("UICorner", profileFrame).CornerRadius = UDim.new(0, 8)

-- Avatar Icon
local avatarIcon = Instance.new("TextLabel", profileFrame)
avatarIcon.Size = UDim2.new(0, 40, 0, 40)
avatarIcon.Position = UDim2.new(0, 8, 0, 10)
avatarIcon.BackgroundColor3 = Color3.fromRGB(50, 45, 60)
avatarIcon.Text = "👤"
avatarIcon.TextColor3 = Color3.fromRGB(200, 200, 200)
avatarIcon.Font = Enum.Font.GothamBold
avatarIcon.TextSize = 20
Instance.new("UICorner", avatarIcon).CornerRadius = UDim.new(1, 0)

-- Player Display Name
local playerName = Instance.new("TextLabel", profileFrame)
playerName.Size = UDim2.new(1, -60, 0, 20)
playerName.Position = UDim2.new(0, 53, 0, 12)
playerName.BackgroundTransparency = 1
playerName.Text = player.DisplayName
playerName.TextColor3 = Color3.new(1,1,1)
playerName.Font = Enum.Font.GothamBold
playerName.TextSize = 13
playerName.TextXAlignment = Enum.TextXAlignment.Left
playerName.TextTruncate = Enum.TextTruncate.AtEnd

-- Player Username
local userName = Instance.new("TextLabel", profileFrame)
userName.Size = UDim2.new(1, -60, 0, 16)
userName.Position = UDim2.new(0, 53, 0, 32)
userName.BackgroundTransparency = 1
userName.Text = "@" .. player.Name
userName.TextColor3 = Color3.fromRGB(150, 150, 150)
userName.Font = Enum.Font.Gotham
userName.TextSize = 11
userName.TextXAlignment = Enum.TextXAlignment.Left
userName.TextTruncate = Enum.TextTruncate.AtEnd

-- Content Area
local content = Instance.new("Frame", mainFrame)
content.Size = UDim2.new(1, -150, 1, -60)
content.Position = UDim2.new(0, 145, 0, 55)
content.BackgroundTransparency = 1

-- Auto Collect Section
local collectLabel = Instance.new("TextLabel", content)
collectLabel.Size = UDim2.new(1, -20, 0, 30)
collectLabel.Position = UDim2.new(0, 10, 0, 10)
collectLabel.BackgroundTransparency = 1
collectLabel.Text = "Auto Collect"
collectLabel.TextColor3 = Color3.new(1,1,1)
collectLabel.Font = Enum.Font.GothamBold
collectLabel.TextSize = 16
collectLabel.TextXAlignment = Enum.TextXAlignment.Left

local collectToggle = Instance.new("TextButton", content)
collectToggle.Size = UDim2.new(0, 50, 0, 24)
collectToggle.Position = UDim2.new(1, -65, 0, 13)
collectToggle.BackgroundColor3 = Color3.fromRGB(60, 55, 70)
collectToggle.Text = ""
collectToggle.AutoButtonColor = false
Instance.new("UICorner", collectToggle).CornerRadius = UDim.new(1, 0)

local collectCircle = Instance.new("Frame", collectToggle)
collectCircle.Size = UDim2.new(0, 18, 0, 18)
collectCircle.Position = UDim2.new(0, 3, 0.5, -9)
collectCircle.BackgroundColor3 = Color3.new(1,1,1)
Instance.new("UICorner", collectCircle).CornerRadius = UDim.new(1, 0)

-- Auto Spin Section
local spinLabel = Instance.new("TextLabel", content)
spinLabel.Size = UDim2.new(1, -20, 0, 30)
spinLabel.Position = UDim2.new(0, 10, 0, 55)
spinLabel.BackgroundTransparency = 1
spinLabel.Text = "Auto Spin"
spinLabel.TextColor3 = Color3.new(1,1,1)
spinLabel.Font = Enum.Font.GothamBold
spinLabel.TextSize = 16
spinLabel.TextXAlignment = Enum.TextXAlignment.Left

local spinToggle = Instance.new("TextButton", content)
spinToggle.Size = UDim2.new(0, 50, 0, 24)
spinToggle.Position = UDim2.new(1, -65, 0, 58)
spinToggle.BackgroundColor3 = Color3.fromRGB(60, 55, 70)
spinToggle.Text = ""
spinToggle.AutoButtonColor = false
Instance.new("UICorner", spinToggle).CornerRadius = UDim.new(1, 0)

local spinCircle = Instance.new("Frame", spinToggle)
spinCircle.Size = UDim2.new(0, 18, 0, 18)
spinCircle.Position = UDim2.new(0, 3, 0.5, -9)
spinCircle.BackgroundColor3 = Color3.new(1,1,1)
Instance.new("UICorner", spinCircle).CornerRadius = UDim.new(1, 0)

-- Credits Section
local credits = Instance.new("Frame", content)
credits.Size = UDim2.new(1, -20, 0, 80)
credits.Position = UDim2.new(0, 10, 1, -90)
credits.BackgroundColor3 = Color3.fromRGB(50, 45, 60)
credits.BorderSizePixel = 0
Instance.new("UICorner", credits).CornerRadius = UDim.new(0, 10)

local creditsTitle = Instance.new("TextLabel", credits)
creditsTitle.Size = UDim2.new(1, -20, 0, 25)
creditsTitle.Position = UDim2.new(0, 10, 0, 5)
creditsTitle.BackgroundTransparency = 1
creditsTitle.Text = "💮 Credits"
creditsTitle.TextColor3 = Color3.fromRGB(255, 182, 193)
creditsTitle.Font = Enum.Font.GothamBold
creditsTitle.TextSize = 14
creditsTitle.TextXAlignment = Enum.TextXAlignment.Left

local creditsText = Instance.new("TextLabel", credits)
creditsText.Size = UDim2.new(1, -20, 0, 45)
creditsText.Position = UDim2.new(0, 10, 0, 30)
creditsText.BackgroundTransparency = 1
creditsText.Text = "Made by Xuan\nJoin discord.gg/kaydensdens"
creditsText.TextColor3 = Color3.fromRGB(180, 180, 180)
creditsText.Font = Enum.Font.Gotham
creditsText.TextSize = 11
creditsText.TextXAlignment = Enum.TextXAlignment.Left
creditsText.TextYAlignment = Enum.TextYAlignment.Top

-- Button Interactions
minimizeBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = false
	miniFrame.Visible = true
end)

expandBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = true
	miniFrame.Visible = false
end)

closeBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

-- ================= FUNCTIONALITY LOGIC =================

local character, humanoidRootPart
local EventFolder = nil

local PullDelay = 0.1
local HeightOffset = 3
local active = false
local spinning = false

-- Character handler (safe)
local function setupCharacter(char)
	character = char
	humanoidRootPart = char:WaitForChild("HumanoidRootPart", 10)
end

if player.Character then
	setupCharacter(player.Character)
end
player.CharacterAdded:Connect(setupCharacter)

-- Find EventParts WITHOUT BLOCKING GUI
task.spawn(function()
	while not EventFolder do
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
	while true do
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

-- Collect Button logic
collectToggle.MouseButton1Click:Connect(function()
	active = not active
	if active then
		collectToggle.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
		collectCircle.Position = UDim2.new(1, -21, 0.5, -9)
	else
		collectToggle.BackgroundColor3 = Color3.fromRGB(60, 55, 70)
		collectCircle.Position = UDim2.new(0, 3, 0.5, -9)
	end
end)

-- Auto Spin logic
task.spawn(function()
	while true do
		if spinning then
			pcall(function()
				game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Net"):WaitForChild("RF/WheelSpin.Roll"):InvokeServer()
			end)
			task.wait(1)
		else
			task.wait(0.5)
		end
	end
end)

-- Spin Button logic
spinToggle.MouseButton1Click:Connect(function()
	spinning = not spinning
	if spinning then
		spinToggle.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
		spinCircle.Position = UDim2.new(1, -21, 0.5, -9)
	else
		spinToggle.BackgroundColor3 = Color3.fromRGB(60, 55, 70)
		spinCircle.Position = UDim2.new(0, 3, 0.5, -9)
	end
end)
