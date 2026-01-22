		-- ================= XUAN HUB GUI =================
		if game.PlaceId ~= 131623223084840 then
			game:GetService("Players").LocalPlayer:Kick("Xuan Hub not supported this game!")
			return
		end
		print("--===== XUAN HUB LOADED =====--")
		local Players = game:GetService("Players")
		local player = Players.LocalPlayer
		local HttpService = game:GetService("HttpService")
		local TweenService = game:GetService("TweenService")

		-- Singleton Protection: Prevent multiple instances
		if game.CoreGui:FindFirstChild("XuanHubUI") then
			warn("XuanHub is already running!")
			return
		end

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

		local gui = Instance.new("ScreenGui")
		gui.Name = "XuanHubUI"
		gui.ResetOnSpawn = false
		gui.IgnoreGuiInset = true
		gui.Parent = player:WaitForChild("PlayerGui")

		-- Main Frame (Full UI)
		local mainFrame = Instance.new("Frame")
		mainFrame.Size = UDim2.new(0, 0, 0, 0)  -- Start small for zoom in
		mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
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

		-- Version Label
		local versionLabel = Instance.new("TextLabel", header)
		versionLabel.Size = UDim2.new(0, 100, 0, 25)
		versionLabel.Position = UDim2.new(1, -190, 0, 13)
		versionLabel.BackgroundTransparency = 1
		versionLabel.Text = "Server: " .. tostring(game.PlaceVersion) .. "!"
		versionLabel.TextColor3 = Color3.fromRGB(255, 105, 180)
		versionLabel.Font = Enum.Font.GothamBold
		versionLabel.TextSize = 13
		versionLabel.TextXAlignment = Enum.TextXAlignment.Center

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
		local mainContent = Instance.new("ScrollingFrame", mainFrame)
		mainContent.Size = UDim2.new(1, -150, 1, -60)
		mainContent.Position = UDim2.new(0, 145, 0, 55)
		mainContent.BackgroundTransparency = 1
		mainContent.BorderSizePixel = 0
		mainContent.ScrollBarThickness = 6
		mainContent.ScrollBarImageColor3 = Color3.fromRGB(255, 105, 180)
		mainContent.CanvasSize = UDim2.new(0, 0, 0, 350)
		mainContent.Visible = true

		local mainListLayout = Instance.new("UIListLayout", mainContent)
		mainListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		mainListLayout.Padding = UDim.new(0, 5)

		local mainPaddingLayout = Instance.new("UIPadding", mainContent)
		mainPaddingLayout.PaddingLeft = UDim.new(0, 10)
		mainPaddingLayout.PaddingRight = UDim.new(0, 10)
		mainPaddingLayout.PaddingTop = UDim.new(0, 10)
		mainPaddingLayout.PaddingBottom = UDim.new(0, 10)

		-- Update canvas size when layout changes
		mainListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			mainContent.CanvasSize = UDim2.new(0, 0, 0, mainListLayout.AbsoluteContentSize.Y + 20)
		end)

		-- Auto Collect Money Section
		local moneyContainer = Instance.new("Frame", mainContent)
		moneyContainer.Size = UDim2.new(1, -20, 0, 35)
		moneyContainer.BackgroundTransparency = 1
		moneyContainer.LayoutOrder = 1

		local moneyLabel = Instance.new("TextLabel", moneyContainer)
		moneyLabel.Size = UDim2.new(1, -60, 1, 0)
		moneyLabel.Position = UDim2.new(0, 0, 0, 0)
		moneyLabel.BackgroundTransparency = 1
		moneyLabel.Text = "Auto Collect Money"
		moneyLabel.TextColor3 = Color3.new(1,1,1)
		moneyLabel.Font = Enum.Font.GothamBold
		moneyLabel.TextSize = 16
		moneyLabel.TextXAlignment = Enum.TextXAlignment.Left

		local moneyToggle = Instance.new("TextButton", moneyContainer)
		moneyToggle.Size = UDim2.new(0, 50, 0, 24)
		moneyToggle.Position = UDim2.new(1, -55, 0.5, -12)
		moneyToggle.BackgroundColor3 = Color3.fromRGB(60, 55, 70)
		moneyToggle.Text = ""
		moneyToggle.AutoButtonColor = false
		Instance.new("UICorner", moneyToggle).CornerRadius = UDim.new(1, 0)

		local moneyCircle = Instance.new("Frame", moneyToggle)
		moneyCircle.Size = UDim2.new(0, 18, 0, 18)
		moneyCircle.Position = UDim2.new(0, 3, 0.5, -9)
		moneyCircle.BackgroundColor3 = Color3.new(1,1,1)
		Instance.new("UICorner", moneyCircle).CornerRadius = UDim.new(1, 0)

		-- Divider Line 1
		local mainDivider1 = Instance.new("Frame", mainContent)
		mainDivider1.Size = UDim2.new(1, -20, 0, 1)
		mainDivider1.BackgroundColor3 = Color3.fromRGB(80, 75, 90)
		mainDivider1.BorderSizePixel = 0
		mainDivider1.LayoutOrder = 2

		-- Sell All Button Section
		local sellAllContainer = Instance.new("Frame", mainContent)
		sellAllContainer.Size = UDim2.new(1, -20, 0, 35)
		sellAllContainer.BackgroundTransparency = 1
		sellAllContainer.LayoutOrder = 3

		local sellAllLabel = Instance.new("TextLabel", sellAllContainer)
		sellAllLabel.Size = UDim2.new(1, -90, 1, 0)
		sellAllLabel.Position = UDim2.new(0, 0, 0, 0)
		sellAllLabel.BackgroundTransparency = 1
		sellAllLabel.Text = "Sell All Inventory"
		sellAllLabel.TextColor3 = Color3.new(1,1,1)
		sellAllLabel.Font = Enum.Font.GothamBold
		sellAllLabel.TextSize = 16
		sellAllLabel.TextXAlignment = Enum.TextXAlignment.Left

		local sellAllButton = Instance.new("TextButton", sellAllContainer)
		sellAllButton.Size = UDim2.new(0, 80, 0, 28)
		sellAllButton.Position = UDim2.new(1, -85, 0.5, -14)
		sellAllButton.BackgroundColor3 = Color3.fromRGB(200, 50, 80)
		sellAllButton.Text = "Sell All"
		sellAllButton.TextColor3 = Color3.new(1,1,1)
		sellAllButton.Font = Enum.Font.GothamBold
		sellAllButton.TextSize = 14
		sellAllButton.AutoButtonColor = false
		Instance.new("UICorner", sellAllButton).CornerRadius = UDim.new(0, 6)

		-- Divider Line 2
		local mainDivider2 = Instance.new("Frame", mainContent)
		mainDivider2.Size = UDim2.new(1, -20, 0, 1)
		mainDivider2.BackgroundColor3 = Color3.fromRGB(80, 75, 90)
		mainDivider2.BorderSizePixel = 0
		mainDivider2.LayoutOrder = 4

		-- Sell Held Tool Button Section
		local sellHeldContainer = Instance.new("Frame", mainContent)
		sellHeldContainer.Size = UDim2.new(1, -20, 0, 35)
		sellHeldContainer.BackgroundTransparency = 1
		sellHeldContainer.LayoutOrder = 5

		local sellHeldLabel = Instance.new("TextLabel", sellHeldContainer)
		sellHeldLabel.Size = UDim2.new(1, -90, 1, 0)
		sellHeldLabel.Position = UDim2.new(0, 0, 0, 0)
		sellHeldLabel.BackgroundTransparency = 1
		sellHeldLabel.Text = "Sell Held Tool"
		sellHeldLabel.TextColor3 = Color3.new(1,1,1)
		sellHeldLabel.Font = Enum.Font.GothamBold
		sellHeldLabel.TextSize = 16
		sellHeldLabel.TextXAlignment = Enum.TextXAlignment.Left

		local sellHeldButton = Instance.new("TextButton", sellHeldContainer)
		sellHeldButton.Size = UDim2.new(0, 80, 0, 28)
		sellHeldButton.Position = UDim2.new(1, -85, 0.5, -14)
		sellHeldButton.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
		sellHeldButton.Text = "Sell"
		sellHeldButton.TextColor3 = Color3.new(1,1,1)
		sellHeldButton.Font = Enum.Font.GothamBold
		sellHeldButton.TextSize = 14
		sellHeldButton.AutoButtonColor = false
		Instance.new("UICorner", sellHeldButton).CornerRadius = UDim.new(0, 6)

		-- Divider Line 3
		local mainDivider3 = Instance.new("Frame", mainContent)
		mainDivider3.Size = UDim2.new(1, -20, 0, 1)
		mainDivider3.BackgroundColor3 = Color3.fromRGB(80, 75, 90)
		mainDivider3.BorderSizePixel = 0
		mainDivider3.LayoutOrder = 6

		-- Auto Upgrade Base Section
		local upgradeBaseContainer = Instance.new("Frame", mainContent)
		upgradeBaseContainer.Size = UDim2.new(1, -20, 0, 35)
		upgradeBaseContainer.BackgroundTransparency = 1
		upgradeBaseContainer.LayoutOrder = 7

		local upgradeBaseLabel = Instance.new("TextLabel", upgradeBaseContainer)
		upgradeBaseLabel.Size = UDim2.new(1, -60, 1, 0)
		upgradeBaseLabel.Position = UDim2.new(0, 0, 0, 0)
		upgradeBaseLabel.BackgroundTransparency = 1
		upgradeBaseLabel.Text = "Auto Upgrade Base"
		upgradeBaseLabel.TextColor3 = Color3.new(1,1,1)
		upgradeBaseLabel.Font = Enum.Font.GothamBold
		upgradeBaseLabel.TextSize = 16
		upgradeBaseLabel.TextXAlignment = Enum.TextXAlignment.Left

		local upgradeBaseToggle = Instance.new("TextButton", upgradeBaseContainer)
		upgradeBaseToggle.Size = UDim2.new(0, 50, 0, 24)
		upgradeBaseToggle.Position = UDim2.new(1, -55, 0.5, -12)
		upgradeBaseToggle.BackgroundColor3 = Color3.fromRGB(60, 55, 70)
		upgradeBaseToggle.Text = ""
		upgradeBaseToggle.AutoButtonColor = false
		Instance.new("UICorner", upgradeBaseToggle).CornerRadius = UDim.new(1, 0)

		local upgradeBaseCircle = Instance.new("Frame", upgradeBaseToggle)
		upgradeBaseCircle.Size = UDim2.new(0, 18, 0, 18)
		upgradeBaseCircle.Position = UDim2.new(0, 3, 0.5, -9)
		upgradeBaseCircle.BackgroundColor3 = Color3.new(1,1,1)
		Instance.new("UICorner", upgradeBaseCircle).CornerRadius = UDim.new(1, 0)

		-- Divider Line 4
		local mainDivider4 = Instance.new("Frame", mainContent)
		mainDivider4.Size = UDim2.new(1, -20, 0, 1)
		mainDivider4.BackgroundColor3 = Color3.fromRGB(80, 75, 90)
		mainDivider4.BorderSizePixel = 0
		mainDivider4.LayoutOrder = 8

		-- Auto Upgrade Carry Section
		local upgradeCarryContainer = Instance.new("Frame", mainContent)
		upgradeCarryContainer.Size = UDim2.new(1, -20, 0, 35)
		upgradeCarryContainer.BackgroundTransparency = 1
		upgradeCarryContainer.LayoutOrder = 9

		local upgradeCarryLabel = Instance.new("TextLabel", upgradeCarryContainer)
		upgradeCarryLabel.Size = UDim2.new(1, -60, 1, 0)
		upgradeCarryLabel.Position = UDim2.new(0, 0, 0, 0)
		upgradeCarryLabel.BackgroundTransparency = 1
		upgradeCarryLabel.Text = "Auto Upgrade Carry"
		upgradeCarryLabel.TextColor3 = Color3.new(1,1,1)
		upgradeCarryLabel.Font = Enum.Font.GothamBold
		upgradeCarryLabel.TextSize = 16
		upgradeCarryLabel.TextXAlignment = Enum.TextXAlignment.Left

		local upgradeCarryToggle = Instance.new("TextButton", upgradeCarryContainer)
		upgradeCarryToggle.Size = UDim2.new(0, 50, 0, 24)
		upgradeCarryToggle.Position = UDim2.new(1, -55, 0.5, -12)
		upgradeCarryToggle.BackgroundColor3 = Color3.fromRGB(60, 55, 70)
		upgradeCarryToggle.Text = ""
		upgradeCarryToggle.AutoButtonColor = false
		Instance.new("UICorner", upgradeCarryToggle).CornerRadius = UDim.new(1, 0)

		local upgradeCarryCircle = Instance.new("Frame", upgradeCarryToggle)
		upgradeCarryCircle.Size = UDim2.new(0, 18, 0, 18)
		upgradeCarryCircle.Position = UDim2.new(0, 3, 0.5, -9)
		upgradeCarryCircle.BackgroundColor3 = Color3.new(1,1,1)
		Instance.new("UICorner", upgradeCarryCircle).CornerRadius = UDim.new(1, 0)

		-- Divider Line 5
		local mainDivider5 = Instance.new("Frame", mainContent)
		mainDivider5.Size = UDim2.new(1, -20, 0, 1)
		mainDivider5.BackgroundColor3 = Color3.fromRGB(80, 75, 90)
		mainDivider5.BorderSizePixel = 0
		mainDivider5.LayoutOrder = 10

		-- Auto Upgrade Speed Section
		local upgradeSpeedContainer = Instance.new("Frame", mainContent)
		upgradeSpeedContainer.Size = UDim2.new(1, -20, 0, 60)
		upgradeSpeedContainer.BackgroundTransparency = 1
		upgradeSpeedContainer.LayoutOrder = 11

		local upgradeSpeedLabel = Instance.new("TextLabel", upgradeSpeedContainer)
		upgradeSpeedLabel.Size = UDim2.new(1, -60, 0, 30)
		upgradeSpeedLabel.Position = UDim2.new(0, 0, 0, 0)
		upgradeSpeedLabel.BackgroundTransparency = 1
		upgradeSpeedLabel.Text = "Auto Upgrade Speed"
		upgradeSpeedLabel.TextColor3 = Color3.new(1,1,1)
		upgradeSpeedLabel.Font = Enum.Font.GothamBold
		upgradeSpeedLabel.TextSize = 16
		upgradeSpeedLabel.TextXAlignment = Enum.TextXAlignment.Left

		local upgradeSpeedToggle = Instance.new("TextButton", upgradeSpeedContainer)
		upgradeSpeedToggle.Size = UDim2.new(0, 50, 0, 24)
		upgradeSpeedToggle.Position = UDim2.new(1, -55, 0, 3)
		upgradeSpeedToggle.BackgroundColor3 = Color3.fromRGB(60, 55, 70)
		upgradeSpeedToggle.Text = ""
		upgradeSpeedToggle.AutoButtonColor = false
		Instance.new("UICorner", upgradeSpeedToggle).CornerRadius = UDim.new(1, 0)

		local upgradeSpeedCircle = Instance.new("Frame", upgradeSpeedToggle)
		upgradeSpeedCircle.Size = UDim2.new(0, 18, 0, 18)
		upgradeSpeedCircle.Position = UDim2.new(0, 3, 0.5, -9)
		upgradeSpeedCircle.BackgroundColor3 = Color3.new(1,1,1)
		Instance.new("UICorner", upgradeSpeedCircle).CornerRadius = UDim.new(1, 0)

		-- Speed Amount Dropdown
		local speedAmountLabel = Instance.new("TextLabel", upgradeSpeedContainer)
		speedAmountLabel.Size = UDim2.new(0, 70, 0, 18)
		speedAmountLabel.Position = UDim2.new(0, 0, 0, 34)
		speedAmountLabel.BackgroundTransparency = 1
		speedAmountLabel.Text = "Amount:"
		speedAmountLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
		speedAmountLabel.Font = Enum.Font.Gotham
		speedAmountLabel.TextSize = 12
		speedAmountLabel.TextXAlignment = Enum.TextXAlignment.Left

		local speedAmountDropdown = Instance.new("TextButton", upgradeSpeedContainer)
		speedAmountDropdown.Size = UDim2.new(0, 60, 0, 22)
		speedAmountDropdown.Position = UDim2.new(0, 70, 0, 32)
		speedAmountDropdown.BackgroundColor3 = Color3.fromRGB(50, 45, 60)
		speedAmountDropdown.Text = "1 ▼"
		speedAmountDropdown.TextColor3 = Color3.new(1,1,1)
		speedAmountDropdown.Font = Enum.Font.Gotham
		speedAmountDropdown.TextSize = 12
		speedAmountDropdown.AutoButtonColor = false
		Instance.new("UICorner", speedAmountDropdown).CornerRadius = UDim.new(0, 5)

		-- Dropdown Menu for Speed Amount
		local speedDropdownMenu = Instance.new("Frame", gui)
		speedDropdownMenu.Size = UDim2.new(0, 60, 0, 66)
		speedDropdownMenu.Position = UDim2.new(0, 0, 0, 0)
		speedDropdownMenu.BackgroundColor3 = Color3.fromRGB(50, 45, 60)
		speedDropdownMenu.BorderSizePixel = 0
		speedDropdownMenu.Visible = false
		speedDropdownMenu.ZIndex = 100
		Instance.new("UICorner", speedDropdownMenu).CornerRadius = UDim.new(0, 5)

		local speedDropStroke = Instance.new("UIStroke", speedDropdownMenu)
		speedDropStroke.Color = Color3.fromRGB(255, 105, 180)
		speedDropStroke.Thickness = 1

		local speedOption1 = Instance.new("TextButton", speedDropdownMenu)
		speedOption1.Size = UDim2.new(1, 0, 0, 22)
		speedOption1.Position = UDim2.new(0, 0, 0, 0)
		speedOption1.BackgroundColor3 = Color3.fromRGB(50, 45, 60)
		speedOption1.Text = "1"
		speedOption1.TextColor3 = Color3.new(1,1,1)
		speedOption1.Font = Enum.Font.Gotham
		speedOption1.TextSize = 12
		speedOption1.AutoButtonColor = false
		speedOption1.ZIndex = 101
		local speedOption1Corner = Instance.new("UICorner", speedOption1)
		speedOption1Corner.CornerRadius = UDim.new(0, 4)

		local speedOption5 = Instance.new("TextButton", speedDropdownMenu)
		speedOption5.Size = UDim2.new(1, 0, 0, 22)
		speedOption5.Position = UDim2.new(0, 0, 0, 22)
		speedOption5.BackgroundColor3 = Color3.fromRGB(50, 45, 60)
		speedOption5.Text = "5"
		speedOption5.TextColor3 = Color3.new(1,1,1)
		speedOption5.Font = Enum.Font.Gotham
		speedOption5.TextSize = 12
		speedOption5.AutoButtonColor = false
		speedOption5.ZIndex = 101

		local speedOption5Corner = Instance.new("UICorner", speedOption5)
		speedOption5Corner.CornerRadius = UDim.new(0, 4)

		local speedOption10 = Instance.new("TextButton", speedDropdownMenu)
		speedOption10.Size = UDim2.new(1, 0, 0, 22)
		speedOption10.Position = UDim2.new(0, 0, 0, 44)
		speedOption10.BackgroundColor3 = Color3.fromRGB(50, 45, 60)
		speedOption10.Text = "10"
		speedOption10.TextColor3 = Color3.new(1,1,1)
		speedOption10.Font = Enum.Font.Gotham
		speedOption10.TextSize = 12
		speedOption10.AutoButtonColor = false
		speedOption10.ZIndex = 101
		local speedOption10Corner = Instance.new("UICorner", speedOption10)
		speedOption10Corner.CornerRadius = UDim.new(0, 4)

		-- Hide dropdown when scrolling or dragging
		mainContent:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
			speedDropdownMenu.Visible = false
		end)

		mainFrame:GetPropertyChangedSignal("Position"):Connect(function()
			speedDropdownMenu.Visible = false
		end)
		local mainDivider6 = Instance.new("Frame", mainContent)
		mainDivider6.Size = UDim2.new(1, -20, 0, 1)
		mainDivider6.BackgroundColor3 = Color3.fromRGB(80, 75, 90)
		mainDivider6.BorderSizePixel = 0
		mainDivider6.LayoutOrder = 12

		-- Auto Rebirth Section
		local rebirthContainer = Instance.new("Frame", mainContent)
		rebirthContainer.Size = UDim2.new(1, -20, 0, 35)
		rebirthContainer.BackgroundTransparency = 1
		rebirthContainer.LayoutOrder = 13

		local rebirthLabel = Instance.new("TextLabel", rebirthContainer)
		rebirthLabel.Size = UDim2.new(1, -60, 1, 0)
		rebirthLabel.Position = UDim2.new(0, 0, 0, 0)
		rebirthLabel.BackgroundTransparency = 1
		rebirthLabel.Text = "Auto Rebirth"
		rebirthLabel.TextColor3 = Color3.new(1,1,1)
		rebirthLabel.Font = Enum.Font.GothamBold
		rebirthLabel.TextSize = 16
		rebirthLabel.TextXAlignment = Enum.TextXAlignment.Left

		local rebirthToggle = Instance.new("TextButton", rebirthContainer)
		rebirthToggle.Size = UDim2.new(0, 50, 0, 24)
		rebirthToggle.Position = UDim2.new(1, -55, 0.5, -12)
		rebirthToggle.BackgroundColor3 = Color3.fromRGB(60, 55, 70)
		rebirthToggle.Text = ""
		rebirthToggle.AutoButtonColor = false
		Instance.new("UICorner", rebirthToggle).CornerRadius = UDim.new(1, 0)

		local rebirthCircle = Instance.new("Frame", rebirthToggle)
		rebirthCircle.Size = UDim2.new(0, 18, 0, 18)
		rebirthCircle.Position = UDim2.new(0, 3, 0.5, -9)
		rebirthCircle.BackgroundColor3 = Color3.new(1,1,1)
		Instance.new("UICorner", rebirthCircle).CornerRadius = UDim.new(1, 0)

		-- Confirmation Dialog for Sell All
		local confirmDialog = Instance.new("Frame", gui)
		confirmDialog.Size = UDim2.new(0, 320, 0, 140)
		confirmDialog.Position = UDim2.new(0.5, -160, 0.5, -70)
		confirmDialog.BackgroundColor3 = Color3.fromRGB(40, 35, 50)
		confirmDialog.BorderSizePixel = 0
		confirmDialog.Visible = false
		confirmDialog.ZIndex = 100
		Instance.new("UICorner", confirmDialog).CornerRadius = UDim.new(0, 12)

		local confirmStroke = Instance.new("UIStroke", confirmDialog)
		confirmStroke.Color = Color3.fromRGB(200, 50, 80)
		confirmStroke.Thickness = 2

		local confirmTitle = Instance.new("TextLabel", confirmDialog)
		confirmTitle.Size = UDim2.new(1, -20, 0, 30)
		confirmTitle.Position = UDim2.new(0, 10, 0, 10)
		confirmTitle.BackgroundTransparency = 1
		confirmTitle.Text = "⚠️ Warning"
		confirmTitle.TextColor3 = Color3.fromRGB(255, 105, 180)
		confirmTitle.Font = Enum.Font.GothamBold
		confirmTitle.TextSize = 18
		confirmTitle.TextXAlignment = Enum.TextXAlignment.Center
		confirmTitle.ZIndex = 101

		local confirmText = Instance.new("TextLabel", confirmDialog)
		confirmText.Size = UDim2.new(1, -20, 0, 40)
		confirmText.Position = UDim2.new(0, 10, 0, 45)
		confirmText.BackgroundTransparency = 1
		confirmText.Text = "This will sell ALL your inventory!\nAre you sure?"
		confirmText.TextColor3 = Color3.new(1,1,1)
		confirmText.Font = Enum.Font.Gotham
		confirmText.TextSize = 14
		confirmText.TextWrapped = true
		confirmText.TextXAlignment = Enum.TextXAlignment.Center
		confirmText.ZIndex = 101

		local confirmYesBtn = Instance.new("TextButton", confirmDialog)
		confirmYesBtn.Size = UDim2.new(0, 130, 0, 35)
		confirmYesBtn.Position = UDim2.new(0, 15, 1, -45)
		confirmYesBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 80)
		confirmYesBtn.Text = "Sell All"
		confirmYesBtn.TextColor3 = Color3.new(1,1,1)
		confirmYesBtn.Font = Enum.Font.GothamBold
		confirmYesBtn.TextSize = 14
		confirmYesBtn.AutoButtonColor = false
		confirmYesBtn.ZIndex = 101
		Instance.new("UICorner", confirmYesBtn).CornerRadius = UDim.new(0, 8)

		local confirmNoBtn = Instance.new("TextButton", confirmDialog)
		confirmNoBtn.Size = UDim2.new(0, 130, 0, 35)
		confirmNoBtn.Position = UDim2.new(1, -145, 1, -45)
		confirmNoBtn.BackgroundColor3 = Color3.fromRGB(60, 55, 70)
		confirmNoBtn.Text = "Cancel"
		confirmNoBtn.TextColor3 = Color3.new(1,1,1)
		confirmNoBtn.Font = Enum.Font.GothamBold
		confirmNoBtn.TextSize = 14
		confirmNoBtn.AutoButtonColor = false
		confirmNoBtn.ZIndex = 101
		Instance.new("UICorner", confirmNoBtn).CornerRadius = UDim.new(0, 8)

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

		local collectNote = Instance.new("TextLabel", eventContent)
		collectNote.Size = UDim2.new(1, -20, 0, 15)
		collectNote.Position = UDim2.new(0, 10, 0, 35)
		collectNote.BackgroundTransparency = 1
		collectNote.Text = "(Patched, it will still collect but not many)"
		collectNote.TextColor3 = Color3.fromRGB(180, 180, 180)
		collectNote.Font = Enum.Font.Gotham
		collectNote.TextSize = 12
		collectNote.TextXAlignment = Enum.TextXAlignment.Left

		local collectToggle = Instance.new("TextButton", eventContent)
		collectToggle.Size = UDim2.new(0, 50, 0, 24)
		collectToggle.Position = UDim2.new(1, -65, 0, 28)
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
		divider1.Position = UDim2.new(0, 10, 0, 62)
		divider1.BackgroundColor3 = Color3.fromRGB(80, 75, 90)
		divider1.BorderSizePixel = 0

		-- Auto Spin Section
		local spinLabel = Instance.new("TextLabel", eventContent)
		spinLabel.Size = UDim2.new(1, -20, 0, 30)
		spinLabel.Position = UDim2.new(0, 10, 0, 70)
		spinLabel.BackgroundTransparency = 1
		spinLabel.Text = "Auto Spin Radioactive Wheel"
		spinLabel.TextColor3 = Color3.new(1,1,1)
		spinLabel.Font = Enum.Font.GothamBold
		spinLabel.TextSize = 16
		spinLabel.TextXAlignment = Enum.TextXAlignment.Left

		local spinToggle = Instance.new("TextButton", eventContent)
		spinToggle.Size = UDim2.new(0, 50, 0, 24)
		spinToggle.Position = UDim2.new(1, -65, 0, 73)
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
		spinDelayLabel.Position = UDim2.new(0, 10, 0, 99)
		spinDelayLabel.BackgroundTransparency = 1
		spinDelayLabel.Text = "Spin Delay:"
		spinDelayLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
		spinDelayLabel.Font = Enum.Font.Gotham
		spinDelayLabel.TextSize = 12
		spinDelayLabel.TextXAlignment = Enum.TextXAlignment.Left

		local spinDelayBox = Instance.new("TextBox", eventContent)
		spinDelayBox.Size = UDim2.new(0, 60, 0, 22)
		spinDelayBox.Position = UDim2.new(0, 90, 0, 97)
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
		divider2.Position = UDim2.new(0, 10, 0, 130)
		divider2.BackgroundColor3 = Color3.fromRGB(80, 75, 90)
		divider2.BorderSizePixel = 0

		-- Auto Obby Section
		local obbyLabel = Instance.new("TextLabel", eventContent)
		obbyLabel.Size = UDim2.new(1, -20, 0, 30)
		obbyLabel.Position = UDim2.new(0, 10, 0, 138)
		obbyLabel.BackgroundTransparency = 1
		obbyLabel.Text = "Auto Obby"
		obbyLabel.TextColor3 = Color3.new(1,1,1)
		obbyLabel.Font = Enum.Font.GothamBold
		obbyLabel.TextSize = 16
		obbyLabel.TextXAlignment = Enum.TextXAlignment.Left

		local obbyToggle = Instance.new("TextButton", eventContent)
		obbyToggle.Size = UDim2.new(0, 50, 0, 24)
		obbyToggle.Position = UDim2.new(1, -65, 0, 141)
		obbyToggle.BackgroundColor3 = Color3.fromRGB(60, 55, 70)
		obbyToggle.Text = ""
		obbyToggle.AutoButtonColor = false
		Instance.new("UICorner", obbyToggle).CornerRadius = UDim.new(1, 0)

		local obbyCircle = Instance.new("Frame", obbyToggle)
		obbyCircle.Size = UDim2.new(0, 18, 0, 18)
		obbyCircle.Position = UDim2.new(0, 3, 0.5, -9)
		obbyCircle.BackgroundColor3 = Color3.new(1,1,1)
		Instance.new("UICorner", obbyCircle).CornerRadius = UDim.new(1, 0)

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
			-- Stop all running functions
			scriptRunning = false
			active = false
			spinning = false
			collectingMoney = false
			autoUpgradeBase = false
			autoUpgradeCarry = false
			autoUpgradeSpeed = false
			autoRebirth = false
			
			-- Destroy GUI
			gui:Destroy()
		end)

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
			-- Save the new state
			savedSettings.autoCollectRadioactive = active
			saveSettings(savedSettings)
		end)

		-- (Patched, it will still collect but not many)

		-- Auto Spin logic
		task.spawn(function()
			while scriptRunning do
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
			-- Save the new state
			savedSettings.autoSpin = spinning
			saveSettings(savedSettings)
		end)

		-- Obby Toggle logic (updated to use event-based detection)
		obbyToggle.MouseButton1Click:Connect(function()
			autoObby = not autoObby
			if autoObby then
				obbyToggle.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
				obbyCircle.Position = UDim2.new(1, -21, 0.5, -9)
			else
				obbyToggle.BackgroundColor3 = Color3.fromRGB(60, 55, 70)
				obbyCircle.Position = UDim2.new(0, 3, 0.5, -9)
			end
			-- Save the new state
			savedSettings.autoObby = autoObby
			saveSettings(savedSettings)
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

		-- Sell All Button logic (with confirmation)
		sellAllButton.MouseButton1Click:Connect(function()
			confirmDialog.Visible = true
		end)

		confirmYesBtn.MouseButton1Click:Connect(function()
			confirmDialog.Visible = false
			pcall(function()
				game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunctions"):WaitForChild("SellAll"):InvokeServer()
			end)
		end)

		confirmNoBtn.MouseButton1Click:Connect(function()
			confirmDialog.Visible = false
		end)

		-- Sell Held Tool Button logic
		sellHeldButton.MouseButton1Click:Connect(function()
			pcall(function()
				game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunctions"):WaitForChild("SellTool"):InvokeServer()
			end)
		end)

		-- Auto Upgrade Base Toggle logic
		upgradeBaseToggle.MouseButton1Click:Connect(function()
			autoUpgradeBase = not autoUpgradeBase
			if autoUpgradeBase then
				upgradeBaseToggle.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
				upgradeBaseCircle.Position = UDim2.new(1, -21, 0.5, -9)
			else
				upgradeBaseToggle.BackgroundColor3 = Color3.fromRGB(60, 55, 70)
				upgradeBaseCircle.Position = UDim2.new(0, 3, 0.5, -9)
			end
			-- Save the new state
			savedSettings.autoUpgradeBase = autoUpgradeBase
			saveSettings(savedSettings)
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

		-- Auto Upgrade Carry Toggle logic
		upgradeCarryToggle.MouseButton1Click:Connect(function()
			autoUpgradeCarry = not autoUpgradeCarry
			if autoUpgradeCarry then
				upgradeCarryToggle.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
				upgradeCarryCircle.Position = UDim2.new(1, -21, 0.5, -9)
			else
				upgradeCarryToggle.BackgroundColor3 = Color3.fromRGB(60, 55, 70)
				upgradeCarryCircle.Position = UDim2.new(0, 3, 0.5, -9)
			end
			-- Save the new state
			savedSettings.autoUpgradeCarry = autoUpgradeCarry
			saveSettings(savedSettings)
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

		-- Speed Amount Dropdown Toggle
		speedAmountDropdown.MouseButton1Click:Connect(function()
			local isVisible = not speedDropdownMenu.Visible
			speedDropdownMenu.Visible = isVisible
			if isVisible then
				-- Position dropdown below the button, accounting for scroll position
				local btnPos = speedAmountDropdown.AbsolutePosition
				local scrollOffset = mainContent.CanvasPosition.Y
				speedDropdownMenu.Position = UDim2.new(0, btnPos.X, 0, btnPos.Y + 24)
			end
		end)

		-- Hover effects for dropdown options
		speedOption1.MouseEnter:Connect(function()
			speedOption1.BackgroundColor3 = Color3.fromRGB(70, 65, 80)
		end)
		speedOption1.MouseLeave:Connect(function()
			speedOption1.BackgroundColor3 = Color3.fromRGB(50, 45, 60)
		end)

		speedOption5.MouseEnter:Connect(function()
			speedOption5.BackgroundColor3 = Color3.fromRGB(70, 65, 80)
		end)
		speedOption5.MouseLeave:Connect(function()
			speedOption5.BackgroundColor3 = Color3.fromRGB(50, 45, 60)
		end)

		speedOption10.MouseEnter:Connect(function()
			speedOption10.BackgroundColor3 = Color3.fromRGB(70, 65, 80)
		end)
		speedOption10.MouseLeave:Connect(function()
			speedOption10.BackgroundColor3 = Color3.fromRGB(50, 45, 60)
		end)

		speedOption1.MouseButton1Click:Connect(function()
			speedAmountDropdown.Text = "1 ▼"
			upgradeSpeedAmount = 1
			speedDropdownMenu.Visible = false
			savedSettings.upgradeSpeedAmount = 1
			saveSettings(savedSettings)
		end)

		speedOption5.MouseButton1Click:Connect(function()
			speedAmountDropdown.Text = "5 ▼"
			upgradeSpeedAmount = 5
			speedDropdownMenu.Visible = false
			savedSettings.upgradeSpeedAmount = 5
			saveSettings(savedSettings)
		end)

		speedOption10.MouseButton1Click:Connect(function()
			speedAmountDropdown.Text = "10 ▼"
			upgradeSpeedAmount = 10
			speedDropdownMenu.Visible = false
			savedSettings.upgradeSpeedAmount = 10
			saveSettings(savedSettings)
		end)

		-- Auto Upgrade Speed Toggle logic
		upgradeSpeedToggle.MouseButton1Click:Connect(function()
			autoUpgradeSpeed = not autoUpgradeSpeed
			if autoUpgradeSpeed then
				upgradeSpeedToggle.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
				upgradeSpeedCircle.Position = UDim2.new(1, -21, 0.5, -9)
			else
				upgradeSpeedToggle.BackgroundColor3 = Color3.fromRGB(60, 55, 70)
				upgradeSpeedCircle.Position = UDim2.new(0, 3, 0.5, -9)
			end
			-- Save the new state
			savedSettings.autoUpgradeSpeed = autoUpgradeSpeed
			saveSettings(savedSettings)
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

		-- Auto Rebirth Toggle logic
		rebirthToggle.MouseButton1Click:Connect(function()
			autoRebirth = not autoRebirth
			if autoRebirth then
				rebirthToggle.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
				rebirthCircle.Position = UDim2.new(1, -21, 0.5, -9)
			else
				rebirthToggle.BackgroundColor3 = Color3.fromRGB(60, 55, 70)
				rebirthCircle.Position = UDim2.new(0, 3, 0.5, -9)
			end
			-- Save the new state
			savedSettings.autoRebirth = autoRebirth
			saveSettings(savedSettings)
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
			-- Save the new state
			savedSettings.autoCollectMoney = collectingMoney
			saveSettings(savedSettings)
		end)

		-- ================= ANTI-AFK & AUTO RECONNECT =================

		-- Anti-AFK (Always Enabled - Prevents 20 min AFK kick)
		local antiAfkEnabled = true
		local vu = game:GetService("VirtualUser")
		player.Idled:Connect(function()
			vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
			task.wait(1)
			vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
		end)

		-- Auto Reconnect (Always Enabled)
		local autoReconnectEnabled = true
		pcall(function()
			game.CoreGui.RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
				if child.Name == 'ErrorPrompt' and child:FindFirstChild('MessageArea') and child.MessageArea:FindFirstChild("ErrorFrame") then
					game:GetService("TeleportService"):Teleport(game.PlaceId, player)
				end
			end)
		end)

		-- Anti-AFK Toggle (Always Enabled - Non-functional)
		antiAfkToggle.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
		antiAfkCircle.Position = UDim2.new(1, -21, 0.5, -9)
		antiAfkLabel.Text = "Anti-AFK (Always On)"

		antiAfkToggle.MouseButton1Click:Connect(function()
			-- Always enabled - do nothing
		end)

		-- Auto Reconnect Toggle (Always Enabled - Non-functional)
		reconnectToggle.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
		reconnectCircle.Position = UDim2.new(1, -21, 0.5, -9)
		reconnectLabel.Text = "Auto Reconnect (Always On)"

		reconnectToggle.MouseButton1Click:Connect(function()
			-- Always enabled - do nothing
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

		-- ================= BUTTON LOGICS =================

		-- Minimize Button logic
		minimizeBtn.MouseButton1Click:Connect(function()
			mainFrame.Visible = false
			miniFrame.Visible = true
		end)

		-- Expand Button logic (on mini frame)
		expandBtn.MouseButton1Click:Connect(function()
			miniFrame.Visible = false
			mainFrame.Visible = true
		end)

		-- Close Button logic
		closeBtn.MouseButton1Click:Connect(function()
			gui:Destroy()
			scriptRunning = false
		end)

		-- ================= SETTINGS APPLY =================
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
			
			-- Apply Auto Upgrade Base
			if savedSettings.autoUpgradeBase then
				autoUpgradeBase = true
				upgradeBaseToggle.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
				upgradeBaseCircle.Position = UDim2.new(1, -21, 0.5, -9)
			end
			
			-- Apply Auto Upgrade Carry
			if savedSettings.autoUpgradeCarry then
				autoUpgradeCarry = true
				upgradeCarryToggle.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
				upgradeCarryCircle.Position = UDim2.new(1, -21, 0.5, -9)
			end
			
			-- Apply Auto Upgrade Speed
			if savedSettings.autoUpgradeSpeed then
				autoUpgradeSpeed = true
				upgradeSpeedToggle.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
				upgradeSpeedCircle.Position = UDim2.new(1, -21, 0.5, -9)
			end
			
			-- Apply Upgrade Speed Amount
			if savedSettings.upgradeSpeedAmount then
				upgradeSpeedAmount = savedSettings.upgradeSpeedAmount
				speedAmountDropdown.Text = tostring(savedSettings.upgradeSpeedAmount) .. " ▼"
			end
			
			-- Apply Auto Rebirth
			if savedSettings.autoRebirth then
				autoRebirth = true
				rebirthToggle.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
				rebirthCircle.Position = UDim2.new(1, -21, 0.5, -9)
			end
			
			-- Apply Auto Obby
			if savedSettings.autoObby then
				autoObby = true
				obbyToggle.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
				obbyCircle.Position = UDim2.new(1, -21, 0.5, -9)
				
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
			
			-- Anti-AFK and Auto Reconnect are always enabled (no settings to apply)
		end)

		-- Save spin delay when changed
		spinDelayBox.FocusLost:Connect(function()
			local delayValue = tonumber(spinDelayBox.Text) or 0.5
			if delayValue <= 0 then delayValue = 0.5 end
			savedSettings.spinDelay = delayValue
			saveSettings(savedSettings)
		end)
    
