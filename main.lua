-- [[ Altrfy3 shop - 4 Drift Modes Edition ]]
local SGui = Instance.new("ScreenGui", game.CoreGui)
local Main = Instance.new("Frame", SGui)
local MiniBtn = Instance.new("ImageButton", SGui)
local HttpService = game:GetService("HttpService")
local File = "Altrfy3_Data.json"
local Codes = {}

-- إعدادات الحماية والواجهة
SGui.Name = "SG_" .. math.random(1000, 9999)
Main.Size = UDim2.new(0, 320, 0, 450)
Main.Position = UDim2.new(0.5, -160, 0.5, -225)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.Active, Main.Draggable = true, true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 15)

-- زر الإخفاء
MiniBtn.Size = UDim2.new(0, 55, 0, 55)
MiniBtn.Position = UDim2.new(0, 10, 0, 10)
MiniBtn.Image = "rbxassetid://10604313936"
MiniBtn.Visible = false
Instance.new("UICorner", MiniBtn).CornerRadius = UDim.new(1, 0)

-- العنوان
local Title = Instance.new("TextLabel", Main)
Title.Size, Title.Text = UDim2.new(1, 0, 0, 45), "Altrfy3 shop - أبو يوسف 🇸🇦"
Title.TextColor3, Title.Font = Color3.new(
