-- ================= XUAN HUB GUI =================
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")

pcall(function()
	player.PlayerGui:FindFirstChild("XuanHubUI"):Destroy()
end)

-- ================= SETTINGS PERSISTENCE =================
local settingsFileName = "XuanHubSettings.json"
local defaultSettings = {
	autoCollectMoney = false,
	autoCollectRadioactive = false,
	autoSpin = false,
	spinDelay = 0.5,
	antiAfk = false,
	autoReconnect = false
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

local gui = Instance.new("ScreenGui")
gui.Name = "XuanHubUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = player:WaitForChild("PlayerGui")

-- ================= LOADING SCREEN =================
local loadingFrame = Instance.new("Frame")
loadingFrame.Size = UDim2.new(0, 300, 0, 200)
loadingFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
loadingFrame.BackgroundColor3 = Color3.fromRGB(40, 35, 50)
loadingFrame.BorderSizePixel = 0
loadingFrame.Parent = gui
loadingFrame.ZIndex = 10
Instance.new("UICorner", loadingFrame).CornerRadius = UDim.new(0, 12)

local loadingStroke = Instance.new("UIStroke", loadingFrame)
loadingStroke.Color = Color3.fromRGB(255, 105, 180)
loadingStroke.Thickness = 2

local loadingIcon = Instance.new("ImageLabel", loadingFrame)
loadingIcon.Size = UDim2.new(0, 100, 0, 100)
loadingIcon.Position = UDim2.new(0.5, -50, 0, 30)
loadingIcon.BackgroundTransparency = 1
loadingIcon.Image = "rbxassetid://103326199885496"
loadingIcon.ScaleType = Enum.ScaleType.Fit
loadingIcon.ImageTransparency = 1
loadingIcon.ZIndex = 11
Instance.new("UICorner", loadingIcon).CornerRadius = UDim.new(1, 0)

local loadingTitle = Instance.new("TextLabel", loadingFrame)
loadingTitle.Size = UDim2.new(1, -20, 0, 40)
loadingTitle.Position = UDim2.new(0, 10, 0, 140)
loadingTitle.BackgroundTransparency = 1
loadingTitle.Text = "Xuan Hub"
loadingTitle.TextColor3 = Color3.fromRGB(255, 105, 180)
loadingTitle.Font = Enum.Font.GothamBold
loadingTitle.TextSize = 28
loadingTitle.TextTransparency = 1
loadingTitle.ZIndex = 11

-- Main Frame (Full UI)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 520, 0, 340)
mainFrame.Position = UDim2.new(0.5, -260, 0.5, -170)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 35, 50)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = gui
mainFrame.Visible = false
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
local miniIcon = Instance.new("ImageLabel", miniFrame)
miniIcon.Size = UDim2.new(0, 35, 0, 35)
miniIcon.Position = UDim2.new(0, 8, 0.5, -17)
miniIcon.BackgroundColor3 = Color3.fromRGB(50, 45, 60)
miniIcon.BorderSizePixel = 0
miniIcon.Image = "rbxassetid://103326199885496"
miniIcon.ScaleType = Enum.ScaleType.Fit
Instance.new("UICorner", miniIcon).CornerRadius = UDim.new(1, 0)

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
local logo = Instance.new("ImageLabel")
logo.Size = UDim2.new(0, 35, 0, 35)
logo.Position = UDim2.new(0, 8, 0, 8)
logo.BackgroundColor3 = Color3.fromRGB(50, 45, 60)
logo.BorderSizePixel = 0
logo.Parent = header
logo.Image = "rbxassetid://103326199885496" 
logo.ScaleType = Enum.ScaleType.Fit
Instance.new("UICorner", logo).CornerRadius = UDim.new(1, 0)

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

-- Main Tab Button
local mainTab = Instance.new("TextButton", sidebar)
mainTab.Size = UDim2.new(1, -10, 0, 35)
mainTab.Position = UDim2.new(0, 5, 0, 10)
mainTab.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
mainTab.Text = "⚡  Main"
mainTab.TextColor3 = Color3.new(1,1,1)
mainTab.Font = Enum.Font.GothamBold
mainTab.TextSize = 14
mainTab.TextXAlignment = Enum.TextXAlignment.Left
mainTab.AutoButtonColor = false
Instance.new("UICorner", mainTab).CornerRadius = UDim.new(0, 8)
local mainPadding = Instance.new("UIPadding", mainTab)
mainPadding.PaddingLeft = UDim.new(0, 10)

-- Event Tab Button
local eventTab = Instance.new("TextButton", sidebar)
eventTab.Size = UDim2.new(1, -10, 0, 35)
eventTab.Position = UDim2.new(0, 5, 0, 50)
eventTab.BackgroundColor3 = Color3.fromRGB(60, 55, 70)
eventTab.Text = "✨  Event"
eventTab.TextColor3 = Color3.new(1,1,1)
eventTab.Font = Enum.Font.GothamBold
eventTab.TextSize = 14
eventTab.TextXAlignment = Enum.TextXAlignment.Left
eventTab.AutoButtonColor = false
Instance.new("UICorner", eventTab).CornerRadius = UDim.new(0, 8)
local eventPadding = Instance.new("UIPadding", eventTab)
eventPadding.PaddingLeft = UDim.new(0, 10)

-- Settings Tab Button
local afkTab = Instance.new("TextButton", sidebar)
afkTab.Size = UDim2.new(1, -10, 0, 35)
afkTab.Position = UDim2.new(0, 5, 0, 90)
afkTab.BackgroundColor3 = Color3.fromRGB(60, 55, 70)
afkTab.Text = "⚙️  Settings"
afkTab.TextColor3 = Color3.new(1,1,1)
afkTab.Font = Enum.Font.GothamBold
afkTab.TextSize = 14
afkTab.TextXAlignment = Enum.TextXAlignment.Left
afkTab.AutoButtonColor = false
Instance.new("UICorner", afkTab).CornerRadius = UDim.new(0, 8)
local afkPadding = Instance.new("UIPadding", afkTab)
afkPadding.PaddingLeft = UDim.new(0, 10)

-- Player Profile Section
local profileFrame = Instance.new("Frame", sidebar)
profileFrame.Size = UDim2.new(1, -10, 0, 60)
profileFrame.Position = UDim2.new(0, 5, 1, -65)
profileFrame.BackgroundColor3 = Color3.fromRGB(25, 20, 35)
profileFrame.BorderSizePixel = 0
Instance.new("UICorner", profileFrame).CornerRadius = UDim.new(0, 8)

-- Avatar Icon (Player Thumbnail)
local avatarIcon = Instance.new("ImageLabel", profileFrame)
avatarIcon.Size = UDim2.new(0, 40, 0, 40)
avatarIcon.Position = UDim2.new(0, 8, 0, 10)
avatarIcon.BackgroundColor3 = Color3.fromRGB(50, 45, 60)
avatarIcon.BorderSizePixel = 0
Instance.new("UICorner", avatarIcon).CornerRadius = UDim.new(1, 0)

local success, thumbnailId = pcall(function()
	return Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
end)
if success then
	avatarIcon.Image = thumbnailId
else
	avatarIcon.Image = "rbxassetid://103326199885496"
end

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

-- Main Content Area
local mainContent = Instance.new("Frame", mainFrame)
mainContent.Size = UDim2.new(1, -150, 1, -60)
mainContent.Position = UDim2.new(0, 145, 0, 55)
mainContent.BackgroundTransparency = 1
mainContent.Visible = true

-- Auto Collect Money Section
local moneyLabel = Instance.new("TextLabel", mainContent)
moneyLabel.Size = UDim2.new(1, -20, 0, 30)
moneyLabel.Position = UDim2.new(0, 10, 0, 10)
moneyLabel.BackgroundTransparency = 1
moneyLabel.Text = "Auto Collect Money"
moneyLabel.TextColor3 = Color3.new(1,1,1)
moneyLabel.Font = Enum.Font.GothamBold
moneyLabel.TextSize = 16
moneyLabel.TextXAlignment = Enum.TextXAlignment.Left

local moneyToggle = Instance.new("TextButton", mainContent)
moneyToggle.Size = UDim2.new(0, 50, 0, 24)
moneyToggle.Position = UDim2.new(1, -65, 0, 13)
moneyToggle.BackgroundColor3 = Color3.fromRGB(60, 55, 70)
moneyToggle.Text = ""
moneyToggle.AutoButtonColor = false
Instance.new("UICorner", moneyToggle).CornerRadius = UDim.new(1, 0)

local moneyCircle = Instance.new("Frame", moneyToggle)
moneyCircle.Size = UDim2.new(0, 18, 0, 18)
moneyCircle.Position = UDim2.new(0, 3, 0.5, -9)
moneyCircle.BackgroundColor3 = Color3.new(1,1,1)
Instance.new("UICorner", moneyCircle).CornerRadius = UDim.new(1, 0)

-- Event Content Area
local eventContent = Instance.new("Frame", mainFrame)
eventContent.Size = UDim2.new(1, -150, 1, -60)
eventContent.Position = UDim2.new(0, 145, 0, 55)
eventContent.BackgroundTransparency = 1
eventContent.Visible = false

-- Auto Collect Section
local collectLabel = Instance.new("TextLabel", eventContent)
collectLabel.Size = UDim2.new(1, -20, 0, 30)
collectLabel.Position = UDim2.new(0, 10, 0, 10)
collectLabel.BackgroundTransparency = 1
collectLabel.Text = "Auto Collect Radioactive Coins"
collectLabel.TextColor3 = Color3.new(1,1,1)
collectLabel.Font = Enum.Font.GothamBold
collectLabel.TextSize = 16
collectLabel.TextXAlignment = Enum.TextXAlignment.Left

local collectToggle = Instance.new("TextButton", eventContent)
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

-- Divider Line 1
local divider1 = Instance.new("Frame", eventContent)
divider1.Size = UDim2.new(1, -20, 0, 1)
divider1.Position = UDim2.new(0, 10, 0, 47)
divider1.BackgroundColor3 = Color3.fromRGB(80, 75, 90)
divider1.BorderSizePixel = 0

-- Auto Spin Section
local spinLabel = Instance.new("TextLabel", eventContent)
spinLabel.Size = UDim2.new(1, -20, 0, 30)
spinLabel.Position = UDim2.new(0, 10, 0, 55)
spinLabel.BackgroundTransparency = 1
spinLabel.Text = "Auto Spin Radioactive Wheel"
spinLabel.TextColor3 = Color3.new(1,1,1)
spinLabel.Font = Enum.Font.GothamBold
spinLabel.TextSize = 16
spinLabel.TextXAlignment = Enum.TextXAlignment.Left

local spinToggle = Instance.new("TextButton", eventContent)
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

-- Spin Delay Input
local spinDelayLabel = Instance.new("TextLabel", eventContent)
spinDelayLabel.Size = UDim2.new(0, 80, 0, 18)
spinDelayLabel.Position = UDim2.new(0, 10, 0, 84)
spinDelayLabel.BackgroundTransparency = 1
spinDelayLabel.Text = "Spin Delay:"
spinDelayLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
spinDelayLabel.Font = Enum.Font.Gotham
spinDelayLabel.TextSize = 12
spinDelayLabel.TextXAlignment = Enum.TextXAlignment.Left

local spinDelayBox = Instance.new("TextBox", eventContent)
spinDelayBox.Size = UDim2.new(0, 60, 0, 22)
spinDelayBox.Position = UDim2.new(0, 90, 0, 82)
spinDelayBox.BackgroundColor3 = Color3.fromRGB(50, 45, 60)
spinDelayBox.BorderSizePixel = 0
spinDelayBox.Text = "0.5"
spinDelayBox.TextColor3 = Color3.new(1,1,1)
spinDelayBox.Font = Enum.Font.Gotham
spinDelayBox.TextSize = 12
spinDelayBox.PlaceholderText = "0.5"
spinDelayBox.ClearTextOnFocus = false
Instance.new("UICorner", spinDelayBox).CornerRadius = UDim.new(0, 5)

-- Divider Line 2
local divider2 = Instance.new("Frame", eventContent)
divider2.Size = UDim2.new(1, -20, 0, 1)
divider2.Position = UDim2.new(0, 10, 0, 115)
divider2.BackgroundColor3 = Color3.fromRGB(80, 75, 90)
divider2.BorderSizePixel = 0

-- Auto Obby Section
local obbyLabel = Instance.new("TextLabel", eventContent)
obbyLabel.Size = UDim2.new(1, -100, 0, 30)
obbyLabel.Position = UDim2.new(0, 10, 0, 123)
obbyLabel.BackgroundTransparency = 1
obbyLabel.Text = "Auto Obby"
obbyLabel.TextColor3 = Color3.new(1,1,1)
obbyLabel.Font = Enum.Font.GothamBold
obbyLabel.TextSize = 16
obbyLabel.TextXAlignment = Enum.TextXAlignment.Left

local obbyButton = Instance.new("TextButton", eventContent)
obbyButton.Size = UDim2.new(0, 80, 0, 28)
obbyButton.Position = UDim2.new(1, -90, 0, 124)
obbyButton.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
obbyButton.Text = "Click"
obbyButton.TextColor3 = Color3.new(1,1,1)
obbyButton.Font = Enum.Font.GothamBold
obbyButton.TextSize = 14
obbyButton.AutoButtonColor = false
Instance.new("UICorner", obbyButton).CornerRadius = UDim.new(0, 6)

local obbyDropdown = Instance.new("TextButton", eventContent)
obbyDropdown.Size = UDim2.new(0, 25, 0, 28)
obbyDropdown.Position = UDim2.new(1, -120, 0, 124)
obbyDropdown.BackgroundColor3 = Color3.fromRGB(80, 75, 90)
obbyDropdown.Text = "?"
obbyDropdown.TextColor3 = Color3.new(1,1,1)
obbyDropdown.Font = Enum.Font.GothamBold
obbyDropdown.TextSize = 14
obbyDropdown.AutoButtonColor = false
Instance.new("UICorner", obbyDropdown).CornerRadius = UDim.new(0, 6)

local obbyInfo = Instance.new("Frame", eventContent)
obbyInfo.Size = UDim2.new(1, -20, 0, 60)
obbyInfo.Position = UDim2.new(0, 10, 0, 157)
obbyInfo.BackgroundColor3 = Color3.fromRGB(50, 45, 60)
obbyInfo.BorderSizePixel = 0
obbyInfo.Visible = false
Instance.new("UICorner", obbyInfo).CornerRadius = UDim.new(0, 6)

local obbyInfoText = Instance.new("TextLabel", obbyInfo)
obbyInfoText.Size = UDim2.new(1, -10, 1, -10)
obbyInfoText.Position = UDim2.new(0, 5, 0, 5)
obbyInfoText.BackgroundTransparency = 1
obbyInfoText.Text = "Click the button if the radioactive start and u will get instant lucky block from obby"
obbyInfoText.TextColor3 = Color3.fromRGB(200, 200, 200)
obbyInfoText.Font = Enum.Font.Gotham
obbyInfoText.TextSize = 12
obbyInfoText.TextWrapped = true
obbyInfoText.TextXAlignment = Enum.TextXAlignment.Left
obbyInfoText.TextYAlignment = Enum.TextYAlignment.Top

obbyDropdown.MouseButton1Click:Connect(function()
	local TweenService = game:GetService("TweenService")
	local isVisible = obbyInfo.Visible
	
	if not isVisible then
		obbyInfo.Visible = true
		obbyInfo.Size = UDim2.new(1, -20, 0, 0)
		local tween = TweenService:Create(obbyInfo, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Size = UDim2.new(1, -20, 0, 60)
		})
		tween:Play()
	else
		local tween = TweenService:Create(obbyInfo, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			Size = UDim2.new(1, -20, 0, 0)
		})
		tween:Play()
		tween.Completed:Connect(function()
			obbyInfo.Visible = false
		end)
	end
end)

-- AFK Content Area (with scrolling)
local afkContent = Instance.new("ScrollingFrame", mainFrame)
afkContent.Size = UDim2.new(1, -150, 1, -60)
afkContent.Position = UDim2.new(0, 145, 0, 55)
afkContent.BackgroundTransparency = 1
afkContent.BorderSizePixel = 0
afkContent.ScrollBarThickness = 6
afkContent.ScrollBarImageColor3 = Color3.fromRGB(255, 105, 180)
afkContent.CanvasSize = UDim2.new(0, 0, 0, 200)
afkContent.Visible = false

local afkListLayout = Instance.new("UIListLayout", afkContent)
afkListLayout.SortOrder = Enum.SortOrder.LayoutOrder
afkListLayout.Padding = UDim.new(0, 5)

local afkPadding = Instance.new("UIPadding", afkContent)
afkPadding.PaddingLeft = UDim.new(0, 10)
afkPadding.PaddingRight = UDim.new(0, 10)
afkPadding.PaddingTop = UDim.new(0, 10)
afkPadding.PaddingBottom = UDim.new(0, 10)

-- Update canvas size when layout changes
afkListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	afkContent.CanvasSize = UDim2.new(0, 0, 0, afkListLayout.AbsoluteContentSize.Y + 20)
end)

-- Anti-AFK Section
local antiAfkContainer = Instance.new("Frame", afkContent)
antiAfkContainer.Size = UDim2.new(1, -20, 0, 35)
antiAfkContainer.BackgroundTransparency = 1
antiAfkContainer.LayoutOrder = 1

local antiAfkLabel = Instance.new("TextLabel", antiAfkContainer)
antiAfkLabel.Size = UDim2.new(1, -150, 1, 0)
antiAfkLabel.Position = UDim2.new(0, 0, 0, 0)
antiAfkLabel.BackgroundTransparency = 1
antiAfkLabel.Text = "Anti-AFK"
antiAfkLabel.TextColor3 = Color3.new(1,1,1)
antiAfkLabel.Font = Enum.Font.GothamBold
antiAfkLabel.TextSize = 16
antiAfkLabel.TextXAlignment = Enum.TextXAlignment.Left

local antiAfkToggle = Instance.new("TextButton", antiAfkContainer)
antiAfkToggle.Size = UDim2.new(0, 50, 0, 24)
antiAfkToggle.Position = UDim2.new(1, -55, 0.5, -12)
antiAfkToggle.BackgroundColor3 = Color3.fromRGB(60, 55, 70)
antiAfkToggle.Text = ""
antiAfkToggle.AutoButtonColor = false
Instance.new("UICorner", antiAfkToggle).CornerRadius = UDim.new(1, 0)

local antiAfkCircle = Instance.new("Frame", antiAfkToggle)
antiAfkCircle.Size = UDim2.new(0, 18, 0, 18)
antiAfkCircle.Position = UDim2.new(0, 3, 0.5, -9)
antiAfkCircle.BackgroundColor3 = Color3.new(1,1,1)
Instance.new("UICorner", antiAfkCircle).CornerRadius = UDim.new(1, 0)

local afkDropdown = Instance.new("TextButton", antiAfkContainer)
afkDropdown.Size = UDim2.new(0, 25, 0, 28)
afkDropdown.Position = UDim2.new(1, -110, 0.5, -14)
afkDropdown.BackgroundColor3 = Color3.fromRGB(80, 75, 90)
afkDropdown.Text = "?"
afkDropdown.TextColor3 = Color3.new(1,1,1)
afkDropdown.Font = Enum.Font.GothamBold
afkDropdown.TextSize = 14
afkDropdown.AutoButtonColor = false
Instance.new("UICorner", afkDropdown).CornerRadius = UDim.new(0, 6)

local afkInfo = Instance.new("Frame", afkContent)
afkInfo.Size = UDim2.new(1, -20, 0, 0)
afkInfo.BackgroundColor3 = Color3.fromRGB(50, 45, 60)
afkInfo.BorderSizePixel = 0
afkInfo.Visible = false
afkInfo.ClipsDescendants = true
afkInfo.LayoutOrder = 2
Instance.new("UICorner", afkInfo).CornerRadius = UDim.new(0, 6)

local afkInfoText = Instance.new("TextLabel", afkInfo)
afkInfoText.Size = UDim2.new(1, -10, 1, -10)
afkInfoText.Position = UDim2.new(0, 5, 0, 5)
afkInfoText.BackgroundTransparency = 1
afkInfoText.Text = "Prevents Roblox from kicking you after 20 minutes of inactivity. Keeps you in the game."
afkInfoText.TextColor3 = Color3.fromRGB(200, 200, 200)
afkInfoText.Font = Enum.Font.Gotham
afkInfoText.TextSize = 12
afkInfoText.TextWrapped = true
afkInfoText.TextXAlignment = Enum.TextXAlignment.Left
afkInfoText.TextYAlignment = Enum.TextYAlignment.Top

afkDropdown.MouseButton1Click:Connect(function()
	local TweenService = game:GetService("TweenService")
	local isVisible = afkInfo.Visible
	
	if not isVisible then
		afkInfo.Visible = true
		afkInfo.Size = UDim2.new(1, -20, 0, 0)
		local tween = TweenService:Create(afkInfo, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Size = UDim2.new(1, -20, 0, 60)
		})
		tween:Play()
	else
		local tween = TweenService:Create(afkInfo, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			Size = UDim2.new(1, -20, 0, 0)
		})
		tween:Play()
		tween.Completed:Connect(function()
			afkInfo.Visible = false
		end)
	end
end)

-- Divider Line
local afkDivider = Instance.new("Frame", afkContent)
afkDivider.Size = UDim2.new(1, -20, 0, 1)
afkDivider.BackgroundColor3 = Color3.fromRGB(80, 75, 90)
afkDivider.BorderSizePixel = 0
afkDivider.LayoutOrder = 3

-- Auto Reconnect Section
local reconnectContainer = Instance.new("Frame", afkContent)
reconnectContainer.Size = UDim2.new(1, -20, 0, 35)
reconnectContainer.BackgroundTransparency = 1
reconnectContainer.LayoutOrder = 4

local reconnectLabel = Instance.new("TextLabel", reconnectContainer)
reconnectLabel.Size = UDim2.new(1, -150, 1, 0)
reconnectLabel.Position = UDim2.new(0, 0, 0, 0)
reconnectLabel.BackgroundTransparency = 1
reconnectLabel.Text = "Auto Reconnect"
reconnectLabel.TextColor3 = Color3.new(1,1,1)
reconnectLabel.Font = Enum.Font.GothamBold
reconnectLabel.TextSize = 16
reconnectLabel.TextXAlignment = Enum.TextXAlignment.Left

local reconnectToggle = Instance.new("TextButton", reconnectContainer)
reconnectToggle.Size = UDim2.new(0, 50, 0, 24)
reconnectToggle.Position = UDim2.new(1, -55, 0.5, -12)
reconnectToggle.BackgroundColor3 = Color3.fromRGB(60, 55, 70)
reconnectToggle.Text = ""
reconnectToggle.AutoButtonColor = false
Instance.new("UICorner", reconnectToggle).CornerRadius = UDim.new(1, 0)

local reconnectCircle = Instance.new("Frame", reconnectToggle)
reconnectCircle.Size = UDim2.new(0, 18, 0, 18)
reconnectCircle.Position = UDim2.new(0, 3, 0.5, -9)
reconnectCircle.BackgroundColor3 = Color3.new(1,1,1)
Instance.new("UICorner", reconnectCircle).CornerRadius = UDim.new(1, 0)

local reconnectDropdown = Instance.new("TextButton", reconnectContainer)
reconnectDropdown.Size = UDim2.new(0, 25, 0, 28)
reconnectDropdown.Position = UDim2.new(1, -110, 0.5, -14)
reconnectDropdown.BackgroundColor3 = Color3.fromRGB(80, 75, 90)
reconnectDropdown.Text = "?"
reconnectDropdown.TextColor3 = Color3.new(1,1,1)
reconnectDropdown.Font = Enum.Font.GothamBold
reconnectDropdown.TextSize = 14
reconnectDropdown.AutoButtonColor = false
Instance.new("UICorner", reconnectDropdown).CornerRadius = UDim.new(0, 6)

local reconnectInfo = Instance.new("Frame", afkContent)
reconnectInfo.Size = UDim2.new(1, -20, 0, 0)
reconnectInfo.BackgroundColor3 = Color3.fromRGB(50, 45, 60)
reconnectInfo.BorderSizePixel = 0
reconnectInfo.Visible = false
reconnectInfo.ClipsDescendants = true
reconnectInfo.LayoutOrder = 5
Instance.new("UICorner", reconnectInfo).CornerRadius = UDim.new(0, 6)

local reconnectInfoText = Instance.new("TextLabel", reconnectInfo)
reconnectInfoText.Size = UDim2.new(1, -10, 0, 65)
reconnectInfoText.Position = UDim2.new(0, 5, 0, 5)
reconnectInfoText.BackgroundTransparency = 1
reconnectInfoText.Text = "Automatically rejoins the game when you get disconnected.\n\nNote: Won't reconnect if 'Failed to reconnect' error appears."
reconnectInfoText.TextColor3 = Color3.fromRGB(200, 200, 200)
reconnectInfoText.Font = Enum.Font.Gotham
reconnectInfoText.TextSize = 12
reconnectInfoText.TextWrapped = true
reconnectInfoText.TextXAlignment = Enum.TextXAlignment.Left
reconnectInfoText.TextYAlignment = Enum.TextYAlignment.Top

reconnectDropdown.MouseButton1Click:Connect(function()
	local TweenService = game:GetService("TweenService")
	local isVisible = reconnectInfo.Visible
	
	if not isVisible then
		reconnectInfo.Visible = true
		reconnectInfo.Size = UDim2.new(1, -20, 0, 0)
		local tween = TweenService:Create(reconnectInfo, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Size = UDim2.new(1, -20, 0, 75)
		})
		tween:Play()
	else
		local tween = TweenService:Create(reconnectInfo, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			Size = UDim2.new(1, -20, 0, 0)
		})
		tween:Play()
		tween.Completed:Connect(function()
			reconnectInfo.Visible = false
		end)
	end
end)

-- Divider Line 2
local afkDivider2 = Instance.new("Frame", afkContent)
afkDivider2.Size = UDim2.new(1, -20, 0, 1)
afkDivider2.BackgroundColor3 = Color3.fromRGB(80, 75, 90)
afkDivider2.BorderSizePixel = 0
afkDivider2.LayoutOrder = 6

-- Server Actions Section
local serverActionsContainer = Instance.new("Frame", afkContent)
serverActionsContainer.Size = UDim2.new(1, -20, 0, 70)
serverActionsContainer.BackgroundTransparency = 1
serverActionsContainer.LayoutOrder = 7

local serverActionsLabel = Instance.new("TextLabel", serverActionsContainer)
serverActionsLabel.Size = UDim2.new(1, 0, 0, 25)
serverActionsLabel.Position = UDim2.new(0, 0, 0, 0)
serverActionsLabel.BackgroundTransparency = 1
serverActionsLabel.Text = "Server Actions"
serverActionsLabel.TextColor3 = Color3.new(1,1,1)
serverActionsLabel.Font = Enum.Font.GothamBold
serverActionsLabel.TextSize = 16
serverActionsLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Server Hop Button
local serverHopButton = Instance.new("TextButton", serverActionsContainer)
serverHopButton.Size = UDim2.new(0, 155, 0, 32)
serverHopButton.Position = UDim2.new(0, 0, 0, 30)
serverHopButton.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
serverHopButton.Text = "Server Hop"
serverHopButton.TextColor3 = Color3.new(1,1,1)
serverHopButton.Font = Enum.Font.GothamBold
serverHopButton.TextSize = 14
serverHopButton.AutoButtonColor = false
Instance.new("UICorner", serverHopButton).CornerRadius = UDim.new(0, 6)

-- Rejoin Button
local rejoinButton = Instance.new("TextButton", serverActionsContainer)
rejoinButton.Size = UDim2.new(0, 155, 0, 32)
rejoinButton.Position = UDim2.new(1, -155, 0, 30)
rejoinButton.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
rejoinButton.Text = "Rejoin"
rejoinButton.TextColor3 = Color3.new(1,1,1)
rejoinButton.Font = Enum.Font.GothamBold
rejoinButton.TextSize = 14
rejoinButton.AutoButtonColor = false
Instance.new("UICorner", rejoinButton).CornerRadius = UDim.new(0, 6)

-- Tab Switching
mainTab.MouseButton1Click:Connect(function()
	mainTab.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
	eventTab.BackgroundColor3 = Color3.fromRGB(60, 55, 70)
	afkTab.BackgroundColor3 = Color3.fromRGB(60, 55, 70)
	mainContent.Visible = true
	eventContent.Visible = false
	afkContent.Visible = false
end)

eventTab.MouseButton1Click:Connect(function()
	mainTab.BackgroundColor3 = Color3.fromRGB(60, 55, 70)
	eventTab.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
	afkTab.BackgroundColor3 = Color3.fromRGB(60, 55, 70)
	mainContent.Visible = false
	eventContent.Visible = true
	afkContent.Visible = false
end)

afkTab.MouseButton1Click:Connect(function()
	mainTab.BackgroundColor3 = Color3.fromRGB(60, 55, 70)
	eventTab.BackgroundColor3 = Color3.fromRGB(60, 55, 70)
	afkTab.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
	mainContent.Visible = false
	eventContent.Visible = false
	afkContent.Visible = true
end)

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
local autoObby = false
local collectingMoney = false

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
			-- Get delay from input box with validation
			local delayValue = tonumber(spinDelayBox.Text) or 0.5
			if delayValue <= 0 then delayValue = 0.5 end
			task.wait(delayValue)
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

-- Obby Button logic (executes once per click)
obbyButton.MouseButton1Click:Connect(function()
	pcall(function()
		local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
		if not hrp then return end
		
		local mapVariants = workspace:FindFirstChild("MapVariants")
		local radioactive = mapVariants and mapVariants:FindFirstChild("Radioactive")
		local obbyEnd = radioactive and radioactive:FindFirstChild("ObbyEnd")
		
		if obbyEnd then
			firetouchinterest(hrp, obbyEnd, 0)
			task.wait()
			firetouchinterest(hrp, obbyEnd, 1)
		end
	end)
end)

-- Auto Collect Money logic
local function findMyBase()
	for _, base in ipairs(workspace:WaitForChild("Bases_NEW"):GetChildren()) do
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
	while true do
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

-- Money Button logic
moneyToggle.MouseButton1Click:Connect(function()
	collectingMoney = not collectingMoney
	if collectingMoney then
		moneyToggle.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
		moneyCircle.Position = UDim2.new(1, -21, 0.5, -9)
	else
		moneyToggle.BackgroundColor3 = Color3.fromRGB(60, 55, 70)
		moneyCircle.Position = UDim2.new(0, 3, 0.5, -9)
	end
end)

-- ================= ANTI-AFK & AUTO RECONNECT =================

local antiAfkEnabled = false
local autoReconnectEnabled = false

-- Anti-AFK Logic (Prevents 20 min AFK kick)
local VirtualUser = game:GetService("VirtualUser")
player.Idled:Connect(function()
	if antiAfkEnabled then
		VirtualUser:CaptureController()
		VirtualUser:ClickButton2(Vector2.new())
	end
end)

-- Auto Reconnect on Disconnect (except "Failed to reconnect")
do
	local PromptOverlay = game.CoreGui:WaitForChild("RobloxPromptGui"):WaitForChild("promptOverlay")
	local function reconnect()
		task.wait(0.01)
		pcall(function()
			game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
		end)
	end

	for _, child in ipairs(PromptOverlay:GetChildren()) do
		if child.Name == "ErrorPrompt" and autoReconnectEnabled then
			-- Check if it's not "Failed to reconnect" error
			task.spawn(function()
				task.wait(0.1)
				local errorText = ""
				for _, desc in ipairs(child:GetDescendants()) do
					if desc:IsA("TextLabel") then
						errorText = errorText .. desc.Text:lower()
					end
				end
				if not errorText:find("failed to reconnect") then
					reconnect()
				end
			end)
			break
		end
	end

	PromptOverlay.ChildAdded:Connect(function(child)
		if child.Name == "ErrorPrompt" and autoReconnectEnabled then
			-- Check if it's not "Failed to reconnect" error
			task.spawn(function()
				task.wait(0.1)
				local errorText = ""
				for _, desc in ipairs(child:GetDescendants()) do
					if desc:IsA("TextLabel") then
						errorText = errorText .. desc.Text:lower()
					end
				end
				if not errorText:find("failed to reconnect") then
					reconnect()
				end
			end)
		end
	end)
end

-- Anti-AFK Toggle Button logic
antiAfkToggle.MouseButton1Click:Connect(function()
	antiAfkEnabled = not antiAfkEnabled
	if antiAfkEnabled then
		antiAfkToggle.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
		antiAfkCircle.Position = UDim2.new(1, -21, 0.5, -9)
	else
		antiAfkToggle.BackgroundColor3 = Color3.fromRGB(60, 55, 70)
		antiAfkCircle.Position = UDim2.new(0, 3, 0.5, -9)
	end
end)

-- Auto Reconnect Toggle Button logic
reconnectToggle.MouseButton1Click:Connect(function()
	autoReconnectEnabled = not autoReconnectEnabled
	if autoReconnectEnabled then
		reconnectToggle.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
		reconnectCircle.Position = UDim2.new(1, -21, 0.5, -9)
	else
		reconnectToggle.BackgroundColor3 = Color3.fromRGB(60, 55, 70)
		reconnectCircle.Position = UDim2.new(0, 3, 0.5, -9)
	end
end)

-- Server Hop Button logic
serverHopButton.MouseButton1Click:Connect(function()
	pcall(function()
		local TeleportService = game:GetService("TeleportService")
		local HttpService = game:GetService("HttpService")
		local PlaceId = game.PlaceId
		local JobId = game.JobId
		
		local servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
		
		for _, server in pairs(servers.data) do
			if server.id ~= JobId and server.playing < server.maxPlayers then
				TeleportService:TeleportToPlaceInstance(PlaceId, server.id, player)
				break
			end
		end
	end)
end)

-- Rejoin Button logic
rejoinButton.MouseButton1Click:Connect(function()
	pcall(function()
		game:GetService("TeleportService"):Teleport(game.PlaceId, player)
	end)
end)

-- ================= LOADING ANIMATION & SETTINGS APPLY =================

-- Animate loading screen
task.spawn(function()
	-- Fade in frame
	TweenService:Create(loadingFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		BackgroundTransparency = 0
	}):Play()
	TweenService:Create(loadingStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Transparency = 0
	}):Play()
	
	-- Fade in icon
	task.wait(0.1)
	TweenService:Create(loadingIcon, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		ImageTransparency = 0
	}):Play()
	
	-- Fade in title
	task.wait(0.2)
	TweenService:Create(loadingTitle, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		TextTransparency = 0
	}):Play()
	
	-- Wait 5 seconds total (including fade in time)
	task.wait(4.3)
	
	-- Fade out loading screen
	local fadeOut = TweenService:Create(loadingFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
		BackgroundTransparency = 1
	})
	TweenService:Create(loadingStroke, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
		Transparency = 1
	}):Play()
	TweenService:Create(loadingIcon, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
		ImageTransparency = 1
	}):Play()
	TweenService:Create(loadingTitle, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
		TextTransparency = 1
	}):Play()
	fadeOut:Play()
	
	fadeOut.Completed:Connect(function()
		loadingFrame:Destroy()
		mainFrame.Visible = true
	end)
end)

-- Apply saved settings
task.spawn(function()
	task.wait(0.5) -- Wait for GUI to fully load
	
	-- Apply Auto Collect Money
	if savedSettings.autoCollectMoney then
		collectingMoney = true
		moneyToggle.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
		moneyCircle.Position = UDim2.new(1, -21, 0.5, -9)
	end
	
	-- Apply Auto Collect Radioactive
	if savedSettings.autoCollectRadioactive then
		active = true
		collectToggle.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
		collectCircle.Position = UDim2.new(1, -21, 0.5, -9)
	end
	
	-- Apply Auto Spin
	if savedSettings.autoSpin then
		spinning = true
		spinToggle.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
		spinCircle.Position = UDim2.new(1, -21, 0.5, -9)
	end
	
	-- Apply Spin Delay
	spinDelayBox.Text = tostring(savedSettings.spinDelay)
	
	-- Apply Anti-AFK
	if savedSettings.antiAfk then
		antiAfkEnabled = true
		antiAfkToggle.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
		antiAfkCircle.Position = UDim2.new(1, -21, 0.5, -9)
	end
	
	-- Apply Auto Reconnect
	if savedSettings.autoReconnect then
		autoReconnectEnabled = true
		reconnectToggle.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
		reconnectCircle.Position = UDim2.new(1, -21, 0.5, -9)
	end
end)

-- Update toggle handlers to save settings
local originalMoneyToggle = moneyToggle.MouseButton1Click
moneyToggle.MouseButton1Click:Connect(function()
	savedSettings.autoCollectMoney = collectingMoney
	saveSettings(savedSettings)
end)

local originalCollectToggle = collectToggle.MouseButton1Click
collectToggle.MouseButton1Click:Connect(function()
	savedSettings.autoCollectRadioactive = active
	saveSettings(savedSettings)
end)

local originalSpinToggle = spinToggle.MouseButton1Click
spinToggle.MouseButton1Click:Connect(function()
	savedSettings.autoSpin = spinning
	saveSettings(savedSettings)
end)

spinDelayBox.FocusLost:Connect(function()
	local delayValue = tonumber(spinDelayBox.Text) or 0.5
	if delayValue <= 0 then delayValue = 0.5 end
	savedSettings.spinDelay = delayValue
	saveSettings(savedSettings)
end)

local originalAntiAfkToggle = antiAfkToggle.MouseButton1Click
antiAfkToggle.MouseButton1Click:Connect(function()
	savedSettings.antiAfk = antiAfkEnabled
	saveSettings(savedSettings)
end)

local originalReconnectToggle = reconnectToggle.MouseButton1Click
reconnectToggle.MouseButton1Click:Connect(function()
	savedSettings.autoReconnect = autoReconnectEnabled
	saveSettings(savedSettings)
end)
