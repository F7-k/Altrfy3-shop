-- [[ Altrfy3 shop - Ultra Stealth & Pro Handling ]]
local SGui = Instance.new("ScreenGui", game.CoreGui)
local Main = Instance.new("Frame", SGui)
local MiniBtn = Instance.new("ImageButton", SGui)
local HttpService = game:GetService("HttpService")
local File = "Altrfy3_Data.json"
local Codes = {}

-- [[ نظام الحماية المتقدم ]]
SGui.Name = "Core_" .. math.random(10000, 99999)
local SecureKey = "Locked_" .. math.random(100,999)

-- واجهة المحل (تم تصغيرها وتنسيقها)
Main.Size = UDim2.new(0, 310, 0, 430)
Main.Position = UDim2.new(0.5, -155, 0.5, -215)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Main.Active, Main.Draggable = true, true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 15)
local Stroke = Instance.new("UIStroke", Main)
Stroke.Thickness, Stroke.Color = 2, Color3.fromRGB(0, 180, 180)

-- زر التصغير السحري
MiniBtn.Size = UDim2.new(0, 50, 0, 50)
MiniBtn.Position = UDim2.new(0, 15, 0, 15)
MiniBtn.Image = "rbxassetid://10604313936"
MiniBtn.Visible = false
Instance.new("UICorner", MiniBtn).CornerRadius = UDim.new(1, 0)

-- العنوان المتغير (حماية من الكشف بالاسم)
local Title = Instance.new("TextLabel", Main)
Title.Size, Title.Text = UDim2.new(1, 0, 0, 45), "Altrfy3 shop - Abu Yousef 🇸🇦"
Title.TextColor3, Title.Font = Color3.new(1, 1, 1), Enum.Font.GothamBold
Instance.new("UICorner", Title)
spawn(function() while wait() do Title.BackgroundColor3 = Color3.fromHSV(tick() % 5 / 5, 0.5, 0.6) end end)

local Cont = Instance.new("ScrollingFrame", Main)
Cont.Size, Cont.Position, Cont.BackgroundTransparency = UDim2.new(1, -20, 1, -75), UDim2.new(0, 10, 0, 60), 1
Instance.new("UIListLayout", Cont).Padding = UDim.new(0, 8)

-- [[ محرك الوزنيات المحمي ]]
local function GetCar()
    local p = game.Players.LocalPlayer
    local s = p.Character and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.SeatPart
    return s and s.Parent, s
end

local function ExecWeight(fric, steer, lift)
    local car, seat = GetCar()
    if not car then return end
    
    -- تنظيف آمن
    for _, v in pairs(car.PrimaryPart:GetChildren()) do
        if v.Name == SecureKey or v:IsA("BodyGyro") then v:Destroy() end
    end
    wait(0.05)

    if lift ~= 0 then
        local g = Instance.new("BodyGyro", car.PrimaryPart)
        g.Name = SecureKey
        g.MaxTorque = Vector3.new(450000, 0, 450000)
        g.P = 3500
        g.CFrame = car.PrimaryPart.CFrame
