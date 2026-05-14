-- [[ Altrfy3 shop - The Final Secure Fix ]]
local SGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local Main = Instance.new("Frame", SGui)
local MiniBtn = Instance.new("ImageButton", SGui)
local HttpService = game:GetService("HttpService")
local File = "Altrfy3_Data.json"
local Codes = {}

-- إعدادات الحماية الفائقة
SGui.Name = game:GetService("HttpService"):GenerateGUID(false)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.Size = UDim2.new(0, 310, 0, 430)
Main.Position = UDim2.new(0.5, -155, 0.5, -215)
Main.Active, Main.Draggable = true, true
Instance.new("UICorner", Main)

-- زر الإخفاء
MiniBtn.Size = UDim2.new(0, 55, 0, 55)
MiniBtn.Position = UDim2.new(0, 10, 0, 10)
MiniBtn.Image = "rbxassetid://10604313936"
MiniBtn.Visible = false
Instance.new("UICorner", MiniBtn).CornerRadius = UDim.new(1, 0)

-- العنوان
local Title = Instance.new("TextLabel", Main)
Title.Size, Title.Text = UDim2.new(1, 0, 0, 45), "Altrfy3 shop - أبو يوسف 🇸🇦"
Title.TextColor3, Title.Font = Color3.new(1, 1, 1), Enum.Font.GothamBold
Instance.new("UICorner", Title)
spawn(function() while wait() do Title.BackgroundColor3 = Color3.fromHSV(tick() % 5 / 5, 0.6, 0.7) end end)

local Cont = Instance.new("ScrollingFrame", Main)
Cont.Size, Cont.Position, Cont.BackgroundTransparency = UDim2.new(1, -20, 1, -75), UDim2.new(0, 10, 0, 60), 1
Instance.new("UIListLayout", Cont).Padding = UDim.new(0, 8)

-- [[ محرك اكتشاف السيارة القوي ]]
local function GetVehicle()
    local p = game.Players.LocalPlayer
    local char = p.Character
    if char and char:FindFirstChild("Humanoid") then
        local seat = char.Humanoid.SeatPart
        if seat and seat:IsA("VehicleSeat") then
            return seat.Parent, seat
        end
    end
    return nil, nil
end

local function ApplyHandling(fric, steer, lift)
    local car, seat = GetVehicle()
    if not car then return end
    
    for _, v in pairs(car:GetDescendants()) do
        if v:IsA("BodyGyro") or v.Name == "Yusuf_Gyro" then v:Destroy() end
    end

    if lift ~= 0 then
        local g = Instance.new("BodyGyro")
        g.Name = "Yusuf_Gyro"
        g.P = 4500
        g.MaxTorque = Vector3.new(500000, 0, 500000)
        g.CFrame = car.PrimaryPart.CFrame * CFrame.Angles(0, 0, math.rad(lift))
        g.Parent = car.PrimaryPart or car:FindFirstChildWhichIsA("BasePart")
    end

    if seat then
        seat.MaxSteerAngle = steer
        for _, p in pairs(car:GetDescendants()) do
            if p:IsA("BasePart") and (p.Name:find("Wheel") or p:IsA("WheelInstance")) then
                p.Friction = fric
            end
        end
    end
end

-- واجهة الأزرار (4 وزنيات هجولة)
local function ShowScript()
    Cont:ClearAllChildren()
    local function AddB(t, c, f)
        local b = Instance.new("TextButton", Cont)
        b.Size, b.Text, b.BackgroundColor3 = UDim2.new(1, 0, 0
 
