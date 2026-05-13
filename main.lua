-- [[ Altrfy3 shop - Abu Yousef Special Edition ]]
local SGui = Instance.new("ScreenGui", game.CoreGui)
local Main = Instance.new("Frame", SGui)
local MiniBtn = Instance.new("ImageButton", SGui)
local HttpService = game:GetService("HttpService")
local File = "Altrfy3_Data.json"
local Codes = {}

-- إعدادات زر الإخفاء (الدائري)
MiniBtn.Size = UDim2.new(0, 55, 0, 55)
MiniBtn.Position = UDim2.new(0, 10, 0, 10)
MiniBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 150)
MiniBtn.Image = "rbxassetid://10604313936"
MiniBtn.Visible = false
Instance.new("UICorner", MiniBtn).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", MiniBtn).Thickness = 2

-- القائمة الأساسية
Main.Size = UDim2.new(0, 320, 0, 400)
Main.Position = UDim2.new(0.5, -160, 0.5, -200)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.Active, Main.Draggable = true, true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 15)

-- زر التصغير (-)
local MinBtn = Instance.new("TextButton", Main)
MinBtn.Size = UDim2.new(0, 35, 0, 35)
MinBtn.Position = UDim2.new(1, -40, 0, 5)
MinBtn.Text, MinBtn.TextSize = "-", 25
MinBtn.BackgroundColor3, MinBtn.TextColor3 = Color3.fromRGB(200, 0, 0), Color3.new(1, 1, 1)
Instance.new("UICorner", MinBtn)

MinBtn.MouseButton1Click:Connect(function() Main.Visible = false MiniBtn.Visible = true end)
MiniBtn.MouseButton1Click:Connect(function() Main.Visible = true MiniBtn.Visible = false end)

-- العنوان
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 45)
Title.Text = "Altrfy3 shop - أبو يوسف 🇸🇦"
Title.TextColor3, Title.TextSize = Color3.new(1, 1, 1), 18
Title.Font = Enum.Font.GothamBold
Instance.new("UICorner", Title).CornerRadius = UDim.new(0, 15)
spawn(function() while wait() do Title.BackgroundColor3 = Color3.fromHSV(tick() % 5 / 5, 0.7, 0.8) end end)

local Cont = Instance.new("ScrollingFrame", Main)
Cont.Size, Cont.Position, Cont.BackgroundTransparency = UDim2.new(1, -20, 1, -70), UDim2.new(0, 10, 0, 60), 1
local List = Instance.new("UIListLayout", Cont)
List.Padding = UDim.new(0, 8)

-- [[ وظائف أبو يوسف للوزنيات - عالم المملكة ]]
local function GetVehicle()
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        local seat = char.Humanoid.SeatPart
        return seat and seat.Parent
    end
end

local function SetWeight(mode)
    local car = GetVehicle()
    if not car then return end
    
    -- حذف أي ترفيع قديم
    for _, v in pairs(car.PrimaryPart:GetChildren()) do
        if v:IsA("BodyGyro") then v:Destroy() end
    end

    if mode == "drift" then
        for _, part in pairs(car:GetDescendants()) do
            if part:IsA("WheelInstance") or part.Name == "Wheel" then
                part.Friction = 0.3
            end
        end
    elseif mode == "left" or mode == "right" then
        local gyro = Instance.new("BodyGyro", car.PrimaryPart)
        gyro.P = 3000
        gyro.MaxTorque = Vector3.new(400000, 0, 400000)
        local angle = mode == "left" and 35 or -35
        gyro.CFrame = car.PrimaryPart.CFrame * CFrame.Angles(0, 0, math.rad(angle))
    elseif mode == "reset" then
        for _, part in pairs(car:GetDescendants()) do
            if part:IsA("WheelInstance") or part.Name == "Wheel" then part.Friction = 1 end
        end
    end
end

-- واجهة الوزنيات
local function ShowScript()
    Cont:ClearAllChildren()
    Instance.new("UIListLayout", Cont).Padding = UDim.new(0, 8)
    local function B(t, c, f)
        local btn = Instance.new("TextButton", Cont)
        btn.Size, btn.Text, btn.BackgroundColor3, btn.TextColor3 = UDim2.new(1, 0, 0, 40), t, c, Color3.new(1,1,1)
        Instance.new("UICorner", btn)
        btn.MouseButton1Click:Connect(f)
    end
    B("🏎️ وزنية هجولة", Color3.fromRGB(0, 100, 100), function() SetWeight("drift") end)
    B("📐 ترفيع يسار", Color3.fromRGB(0, 120, 150), function() SetWeight("left") end)
    B("📐 ترفيع يمين", Color3.fromRGB(0, 120, 150), function() SetWeight("right") end)
    B("🔄 تصفية الوزنية", Color3.fromRGB(150, 0, 0), function() SetWeight("reset") end)
end

-- واجهة الأدمن وواجهة الدخول (نفس الأكواد السابقة)
local function ShowAdmin()
    Cont:ClearAllChildren()
    Instance.new("UIListLayout", Cont).Padding = UDim.new(0, 8)
    local nm = Instance.new("TextBox", Cont) nm.Size, nm.PlaceholderText = UDim2.new(1,0,0,35), "اسم الكود"
    local hr = Instance.new("TextBox", Cont) hr.Size, hr.PlaceholderText = UDim2.new(1,0,0,35), "الساعات"
    local btn = Instance.new("TextButton", Cont)
    btn.Size, btn.Text, btn.BackgroundColor3 = UDim2.new(1,0,0,40), "حفظ الكود", Color3.new(0,0.5,0)
    btn.MouseButton1Click:Connect(function()
        Codes[nm.Text] = {Exp = os.time() + (tonumber(hr.Text) or 1) * 3600}
        if writefile then writefile(File, HttpService:JSONEncode(Codes)) end
        nm.Text = "تم!" wait(1) nm.Text = ""
    end)
    B("🔙 عودة", Color3.fromRGB(60, 60, 60), function() MainUI() end)
end

function MainUI()
    Cont:ClearAllChildren()
    Instance.new("UIListLayout", Cont).Padding = UDim.new(0, 8)
    local inp = Instance.new("TextBox", Cont)
    inp.Size, inp.PlaceholderText, inp.Text = UDim2.new(1, 0, 0, 50), "أدخل الكود هنا...", ""
    inp.BackgroundColor3, inp.TextColor3 = Color3.fromRGB(30, 30, 30), Color3.new(1, 1, 1)
    Instance.new("UICorner", inp)
    local ent = Instance.new("TextButton", Cont)
    ent.Size, ent.Text, ent.BackgroundColor3 = UDim2.new(1,0,0,45), "تفعيل 🔓", Color3.new(0, 0.4, 0)
    Instance.new("UICorner", ent)
    ent.MouseButton1Click:Connect(function()
        if isfile and isfile(File) then Codes = HttpService:JSONDecode(readfile(File)) end
        if inp.Text == "IFC" then ShowAdmin()
        elseif Codes[inp.Text] and os.time() < Codes[inp.Text].Exp then ShowScript()
        else inp.Text = "" inp.PlaceholderText = "خطأ!" end
    end)
end

MainUI()
