Xuannn
Xuannn
zxuan677
+1
•
have 1k+ vouches

Xuannn
Xuannn

 — 3:17 AM
d nagana picture
sakit
Kai — 3:18 AM
tingin ng ginawa
Xuannn
Xuannn

 — 3:18 AM
local success, thumbnailId = pcall(function()
    return Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
end)
if success then
    avatarIcon.Image = thumbnailId
else
    avatarIcon.Image = "rbxassetid://114680894021538"
end
local logo = Instance.new("ImageLabel", header)
logo.Size = UDim2.new(0, 35, 0, 35)
logo.Position = UDim2.new(0, 8, 0, 8)
logo.BackgroundTransparency = 1
logo.Image = "rbxassetid://114680894021538" 
logo.ScaleType = Enum.ScaleType.Fit
Kai — 3:20 AM
player image 'to ah
Xuannn
Xuannn

 — 3:21 AM
oonga
mali ngani na send
Xuannn
Xuannn

 — 3:21 AM
eto
Kai — 3:21 AM
tanggalin mo header
local logo = Instance.new("ImageLabel")
logo.Size = UDim2.new(0, 35, 0, 35)
logo.Position = UDim2.new(0, 8, 0, 8)
logo.BackgroundTransparency = 1
logo.Parent = header
logo.Image = "rbxassetid://103326199885496" 
logo.ScaleType = Enum.ScaleType.Fit 
Xuannn
Xuannn

 — 3:24 AM
ganon padin
Kai — 3:25 AM
nakaexist ba image?
pa send nga link
Xuannn
Xuannn

 — 3:26 AM
Image
luh not found nakalagay
Kai — 3:27 AM
.
don't forget to add the parent
Xuannn
Xuannn

 — 3:28 AM
bat 96 nayan
sayo yan noh
Kai — 3:29 AM
copy texture id not assetid
Xuannn
Xuannn

 — 3:29 AM
ay
san makikita?
Kai — 3:29 AM
103326199885496
Image
Xuannn
Xuannn

 — 3:39 AM
Image
Image
I'll make it my self nalang
Thx kai
Kai — 3:47 AM
hmm add slider for the auto spin
Xuannn
Xuannn

 — 3:47 AM
User input ginawa ko
😓
Kai — 3:48 AM
user input?
remove others text at playerframe
Xuannn
Xuannn

 — 3:48 AM
Silamag lalagay
Kai — 3:48 AM
PlayerImage > playerusername
Xuannn
Xuannn

 — 3:48 AM
HAHAHAHAHA
Bahala sila dyan
Kai — 3:49 AM
send player frame gui
Xuannn
Xuannn

 — 3:49 AM
Teka
Kai — 3:49 AM
send mo buong gui mo h'wag lang mga functions
Xuannn
Xuannn

 — 3:50 AM
-- ================= XUAN HUB GUI =================
local Players = game:GetService("Players")
local player = Players.LocalPlayer

pcall(function()
	player.PlayerGui:FindFirstChild("XuanHubUI"):Destroy()
Expand
message.txt
13 KB
Yan gui
Ung auto obby wala payan function
Kai — 3:52 AM
WIP 'yan
brb, gonna edit at studio
Kai — 3:52 AM
eto function ng auto obby
Xuannn
Xuannn

 — 3:53 AM
Image
Ganito na itsura nya
Mali
Na ss
Kai — 3:54 AM
HAHAH
Xuannn
Xuannn

 — 3:54 AM
Image
Yan
Kai — 3:55 AM
ilan maximum ng spin delay at minimum?
Xuannn
Xuannn

 — 3:56 AM
Wala HAHAHAHHA
Kai — 3:56 AM
baliw
Xuannn
Xuannn

 — 3:56 AM
Nilagay ko lang validation
Kai — 3:56 AM
Bakit wala
Xuannn
Xuannn

 — 3:56 AM
If character ilagay nila nkaa default sa 0.5
If not positive number default sa 0.5
Ayon lang
HAHAHAHAHHAHAHA
Walang maximum at minimum
Kai — 3:57 AM
Dapat may minimum at maximum
like if yung gagamit gusto ng 0 spin delay edi magagawa nila
Xuannn
Xuannn

 — 3:58 AM
Sabog ang device
Ni test ko ung obby
Napunta kng sya doon sa entrance ng obby
Kai — 4:03 AM
eto?
Xuannn
Xuannn

 — 4:03 AM
Oo
Nilagay ko kasi sa script ko
Kai — 4:04 AM
check mo inven
Xuannn
Xuannn

 — 4:04 AM
Nung ni on ko nag teleport don
Tas pag pumasok ako bumabalik sa entrance
Ay
Oonga
Nakuha ung reward
Nakalagay u got 5 radio active coin
Kai — 4:06 AM
HAHA
Xuannn
Xuannn

 — 4:07 AM
Lucky block daw binibigay eh
Hindi coin
Kai — 4:07 AM
radioactive lucky block
Xuannn
Xuannn

 — 4:08 AM
Wala sakin
Kai — 4:14 AM
bulok
sa'kin meron
Xuannn
Xuannn

 — 4:14 AM
task.spawn(function()
    while true do
        if autoObby then
            pcall(function()
                local hrp = player.Character or player.CharacterAdded:Wait():WaitForChild("HumanoidRootPart")
                local obbyEnd = workspace:WaitForChild("MapVariants"):WaitForChild("Radioactive"):WaitForChild("ObbyEnd")
                firetouchinterest(hrp, obbyEnd, 0)
                task.wait()
                firetouchinterest(hrp, obbyEnd, 1)
            end)
            task.wait(0.5)
        else
            task.wait(0.5)
        end
    end
end)


tama ba for button?
Kai — 4:16 AM
toggle or button?
Xuannn
Xuannn

 — 4:16 AM
toggle
hahahaha
Kai — 4:17 AM
gagana kaya 'yan sa toggle? HAHA nawawala yung radioactive sa mapvariant eh
Xuannn
Xuannn

 — 4:18 AM
ayan ung function ko kanina kaso naka and pala hindi or
ngayon d ko sure
naka base lang yan sa code na binigay mo eh
Kai — 4:19 AM
gagana lang yung code na binigay 'ko sa'yo pag exist na yung radioactive
Xuannn
Xuannn

 — 4:19 AM
oonga
tinry ko kanina
napuna lang sa entrance ng obby
Kai — 4:21 AM
mapupunta talaga sa entrance ng obby, fire touch interest kasi
parang magandang gawin jan is isang toggle tween to the end and instantly end
like pipiliin ng player kung ano ang gusto
execute mo nga 'to
-- ================= XUAN HUB GUI =================
local Players = game:GetService("Players")
local player = Players.LocalPlayer

pcall(function()
	player.PlayerGui:FindFirstChild("XuanHubUI"):Destroy()
Expand
message.txt
13 KB
﻿
Kai
kaiii583940
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

-- Avatar Icon (Player Thumbnail)
local avatarIcon = Instance.new("ImageLabel", profileFrame)
avatarIcon.Name = "avatarIcon"
avatarIcon.BackgroundColor3 = Color3.fromRGB(50, 45, 60)
avatarIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
avatarIcon.BorderSizePixel = 0
avatarIcon.Position = UDim2.new(0, 8, 0, 10)
avatarIcon.Size = UDim2.new(0, 40, 0, 40)
UICorner_2.CornerRadius = UDim.new(1, 0)
UICorner_2.Parent = avatarIcon

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
playerUsername.Name = "playerUsername"
playerUsername.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
playerUsername.BackgroundTransparency = 1.000
playerUsername.BorderColor3 = Color3.fromRGB(0, 0, 0)
playerUsername.BorderSizePixel = 0
playerUsername.Position = UDim2.new(0, 54, 0, 20)
playerUsername.Size = UDim2.new(1, -60, 0, 20)
playerUsername.Font = Enum.Font.GothamBold
playerUsername.Text = player.Name
playerUsername.TextColor3 = Color3.fromRGB(255, 255, 255)
playerUsername.TextSize = 13.000
playerUsername.TextWrapped = true
playerUsername.TextXAlignment = Enum.TextXAlignment.Left

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

-- Divider Line 1
local divider1 = Instance.new("Frame", content)
divider1.Size = UDim2.new(1, -20, 0, 1)
divider1.Position = UDim2.new(0, 10, 0, 47)
divider1.BackgroundColor3 = Color3.fromRGB(80, 75, 90)
divider1.BorderSizePixel = 0

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

-- Spin Delay Input
local spinDelayLabel = Instance.new("TextLabel", content)
spinDelayLabel.Size = UDim2.new(0, 80, 0, 18)
spinDelayLabel.Position = UDim2.new(0, 10, 0, 84)
spinDelayLabel.BackgroundTransparency = 1
spinDelayLabel.Text = "Spin Delay:"
spinDelayLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
spinDelayLabel.Font = Enum.Font.Gotham
spinDelayLabel.TextSize = 12
spinDelayLabel.TextXAlignment = Enum.TextXAlignment.Left

local spinDelayBox = Instance.new("TextBox", content)
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
local divider2 = Instance.new("Frame", content)
divider2.Size = UDim2.new(1, -20, 0, 1)
divider2.Position = UDim2.new(0, 10, 0, 115)
divider2.BackgroundColor3 = Color3.fromRGB(80, 75, 90)
divider2.BorderSizePixel = 0

-- Auto Obby Section
local obbyLabel = Instance.new("TextLabel", content)
obbyLabel.Size = UDim2.new(1, -20, 0, 30)
obbyLabel.Position = UDim2.new(0, 10, 0, 123)
obbyLabel.BackgroundTransparency = 1
obbyLabel.Text = "Auto Obby"
obbyLabel.TextColor3 = Color3.new(1,1,1)
obbyLabel.Font = Enum.Font.GothamBold
obbyLabel.TextSize = 16
obbyLabel.TextXAlignment = Enum.TextXAlignment.Left

local obbyToggle = Instance.new("TextButton", content)
obbyToggle.Size = UDim2.new(0, 50, 0, 24)
obbyToggle.Position = UDim2.new(1, -65, 0, 126)
obbyToggle.BackgroundColor3 = Color3.fromRGB(60, 55, 70)
obbyToggle.Text = ""
obbyToggle.AutoButtonColor = false
Instance.new("UICorner", obbyToggle).CornerRadius = UDim.new(1, 0)

local obbyCircle = Instance.new("Frame", obbyToggle)
obbyCircle.Size = UDim2.new(0, 18, 0, 18)
obbyCircle.Position = UDim2.new(0, 3, 0.5, -9)
obbyCircle.BackgroundColor3 = Color3.new(1,1,1)
Instance.new("UICorner", obbyCircle).CornerRadius = UDim.new(1, 0)
message.txt
13 KB
