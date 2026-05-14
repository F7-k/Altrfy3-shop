-- [[ Altrfy3 shop - Mobile Buttons Fix ]]
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")

-- حذف أي نسخة قديمة لضمان نظافة الواجهة
if CoreGui:FindFirstChild("Altrfy3_Mobile") then
    CoreGui.Altrfy3_Mobile:Destroy()
end

local SGui = Instance.new("ScreenGui", CoreGui)
SGui.Name = "Altrfy3_Mobile"
SGui.DisplayOrder = 999 -- يخلي القائمة فوق كل شيء في الشاشة

local Main = Instance.new("Frame", SGui)
Main.Size = UDim2.new(0, 280, 0, 350)
Main.Position = UDim2.new(0.5, -140, 0.4, -175)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true -- مهم جداً للجوال (تقدر تحركها)
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 15)

-- العنوان (البنفسجي)
local Header = Instance.new("Frame", Main)
Header.Size = UDim2.new(1, 0, 0, 60)
Header.BackgroundColor3 = Color3.fromRGB(150, 70, 200)
Header.BorderSizePixel = 0
local HeaderCorner = Instance.new("UICorner", Header)
HeaderCorner.CornerRadius = UDim.new(0, 15)

local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(1, 0, 1, 0)
Title.Text = "Altrfy3 shop - أزرار الجوال 🇸🇦"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.BackgroundTransparency = 1

-- منطقة الأزرار
local BtnList = Instance.new("ScrollingFrame", Main)
BtnList.Size = UDim2.new(1, -20, 1, -80)
BtnList.Position = UDim2.new(0, 10, 0, 70)
BtnList.BackgroundTransparency = 1
BtnList.CanvasSize = UDim2.new(0, 0, 1.2, 0) -- يسمح بالسكرول إذا كثرت الأزرار
BtnList.ScrollBarThickness = 0

local Layout = Instance.new("UIListLayout", BtnList)
Layout.Padding = UDim.new(0, 10)
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- [[ وظيفة الوزنيات ]]
local function ApplyHandling(fric, steer, lift)
    local p = game.Players.LocalPlayer
    local char = p.Character
    local seat = char and char:FindFirstChild("Humanoid") and char.Humanoid.SeatPart
    if seat and seat:IsA("VehicleSeat") then
        local car = seat.Parent
        seat.MaxSteerAngle = steer
        -- تعديل الاحتكاك (الهجولة)
        for _, v in pairs(car:GetDescendants()) do
            if v:IsA("BasePart") and (v.Name:find("Wheel") or v:IsA("WheelInstance")) then
                v.Friction = fric
            end
        end
        -- إضافة الترفيع (إذا طلب)
        if lift ~= 0 then
            local g = car.PrimaryPart:FindFirstChild("Yusuf_Gyro") or Instance.new("BodyGyro", car.PrimaryPart)
            g.Name = "Yusuf_Gyro"
            g.MaxTorque = Vector3.new(500000, 0, 500000)
            g.P = 4500
            g.CFrame = car.PrimaryPart.CFrame * CFrame.Angles(0, 0, math.rad(lift))
        end
    end
end

-- [
 
