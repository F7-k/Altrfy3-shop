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
            -- يبحث عن السيارة بأكثر من طريقة لضمان الاشتغال
            return seat.Parent, seat
        end
    end
    return nil, nil
end

local function ApplyHandling(fric, steer, lift)
    local car, seat = GetVehicle()
    if not car then 
        warn("ركب سيارة أول يا أبو يوسف!")
        return 
    end
    
    -- تنظيف آمن للمؤثرات
    for _, v in pairs(car:GetDescendants()) do
        if v:IsA("BodyGyro") or v.Name == "Yusuf_Gyro" then v:Destroy() end
    end

    -- تطبيق الترفيع (إذا وجد)
    if lift ~= 0 then
        local g = Instance.new("BodyGyro")
        g.Name = "Yusuf_Gyro"
        g.P = 4500
        g.MaxTorque = Vector3.new(500000, 0, 500000)
        g.CFrame = car.PrimaryPart.CFrame * CFrame.Angles(0, 0, math.rad(lift))
        g.Parent = car.PrimaryPart or car:FindFirstChildWhichIsA("BasePart")
    end

    -- تطبيق الهجولة
    if seat then
        seat.MaxSteerAngle = steer
        for _, p in pairs(car:GetDescendants()) do
            if p:IsA("BasePart") and (p.Name:find("Wheel") or p:IsA("WheelInstance")) then
                p.Friction = fric
            end
        end
    end
end

-- واجهة الأزرار
local function ShowScript()
    Cont:ClearAllChildren()
    local function AddB(t, c, f)
        local b = Instance.new("TextButton", Cont)
        b.Size, b.Text, b.BackgroundColor3 = UDim2.new(1, 0, 0, 40), t, c
        b.TextColor3, b.Font = Color3.new(1, 1, 1), Enum.Font.GothamBold
        Instance.new("UICorner", b)
        b.MouseButton1Click:Connect(f)
    end
    
    AddB("🔥 هجولة كينق (قوية)", Color3.fromRGB(150, 0, 0), function() ApplyHandling(0.3, 65, 0) end)
    AddB("🏎️ هجولة طرب (ناعمة)", Color3.fromRGB(0, 120, 120), function() ApplyHandling(0.45, 55, 0) end)
    AddB("📐 ترفيع يسار", Color3.fromRGB(0, 80, 150), function() ApplyHandling(0.8, 35, 36) end)
    AddB("📐 ترفيع يمين", Color3.fromRGB(0, 80, 150), function() ApplyHandling(0.8, 35, -36) end)
    AddB("🔄 تصفية الوكالة", Color3.fromRGB(60, 60, 60), function() ApplyHandling(1, 35, 0) end)
end

-- [ واجهة الأدمن والدخول - نفس النظام اللي تحبه ]
local function ShowAdmin()
    Cont:ClearAllChildren()
    local function Inp(p)
        local t = Instance.new("TextBox", Cont)
        t.Size, t.PlaceholderText, t.BackgroundColor3, t.TextColor3 = UDim2.new(1,0,0,35), p, Color3.fromRGB(25,25,25), Color3.new(1,1,1)
        Instance.new("UICorner", t) return t
    end
    local n, h, d = Inp("الكود"), Inp("الساعات"), Inp("الأجهزة")
    local s = Instance.new("TextButton", Cont)
    s.Size, s.Text, s.BackgroundColor3 = UDim2.new(1,0,0,40), "حفظ", Color3.new(0, 0.4, 0)
    Instance.new("UICorner", s)
    s.MouseButton1Click:Connect(function()
        Codes[n.Text] = {Exp = os.time() + (tonumber(h.Text) or 1) * 3600, MaxDev = tonumber(d.Text) or 1, UsedDevs = {}}
        writefile(File, HttpService:JSONEncode(Codes)) n.Text = "تم الحفظ"
    end)
    local b = Instance.new("TextButton", Cont)
    b.Size, b.Text, b.BackgroundColor3 = UDim2.new(1,0,0,40), "🔙 عودة", Color3.fromRGB(40,40,40)
    Instance.new("UICorner", b) b.MouseButton1Click:Connect(function() MainUI() end)
end

function MainUI()
    Cont:ClearAllChildren()
    local inp = Instance.new("TextBox", Cont)
    inp.Size, inp.PlaceholderText = UDim2.new(1,0,0,50), "أدخل الكود هنا..."
    inp.BackgroundColor3, inp.TextColor3 = Color3.fromRGB(20,20,20), Color3.new(1,1,1)
    Instance.new("UICorner", inp)
    local ent = Instance.new("TextButton", Cont)
    ent.Size, ent.Text, ent.BackgroundColor3 = UDim2.new(1,0,0,45), "دخول", Color3.fromRGB(0, 100, 0)
    Instance.new("UICorner", ent)
    ent.MouseButton1Click:Connect(function()
        if isfile and isfile(File) then Codes = HttpService:JSONDecode(readfile(File)) end
        if inp.Text == "IFC" then ShowAdmin()
        elseif Codes[inp.Text] and os.time() < Codes[inp.Text].Exp then
            local id = game:GetService("RbxAnalyticsService"):GetClientId()
            local data = Codes[inp.Text]
            local used = false
            for _, v in pairs(data.UsedDevs) do if v == id then used = true end end
            if used or #data.UsedDevs < data.MaxDev then
                if not used then table.insert(data.UsedDevs, id) writefile(File, HttpService:JSONEncode(Codes)) end
                ShowScript()
            else inp.Text = "الجهاز محظور!" end
        else inp.Text = "خطأ!" end
    end)
end

MainUI()
MiniBtn.MouseButton1Click:Connect(function() Main.Visible = true MiniBtn.Visible = false end)
Main:FindFirstChildWhichIsA("TextButton", true).MouseButton1Click:Connect(function() Main.Visible = false MiniBtn.Visible = true end)
 
