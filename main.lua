-- [[ Altrfy3 shop - Lexus Black Edition ]]
local SGui = Instance.new("ScreenGui", game.CoreGui)
local Main = Instance.new("Frame", SGui)
local MiniBtn = Instance.new("ImageButton", SGui)
local HttpService = game:GetService("HttpService")
local File = "Altrfy3_Data.json"
local Codes = {}

-- إعدادات الحماية
SGui.Name = "SG_Lexus_" .. math.random(100, 999)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.Size = UDim2.new(0, 310, 0, 420) -- كبرت المساحة شوي عشان زر اللكزس
Main.Position = UDim2.new(0.5, -155, 0.5, -210)
Main.Active, Main.Draggable = true, true
Instance.new("UICorner", Main)

-- زر الإخفاء
MiniBtn.Size = UDim2.new(0, 55, 0, 55)
MiniBtn.Position = UDim2.new(0, 10, 0, 10)
MiniBtn.Image = "rbxassetid://10604313936"
MiniBtn.Visible = false
Instance.new("UICorner", MiniBtn).CornerRadius = UDim.new(1, 0)

-- العنوان RGB
local Title = Instance.new("TextLabel", Main)
Title.Size, Title.Text = UDim2.new(1, 0, 0, 45), "Altrfy3 shop - Lexus LX 🇰🇸"
Title.TextColor3, Title.Font = Color3.new(1, 1, 1), Enum.Font.GothamBold
spawn(function() while wait() do Title.BackgroundColor3 = Color3.fromHSV(tick() % 5 / 5, 0.6, 0.7) end end)

local Cont = Instance.new("ScrollingFrame", Main)
Cont.Size, Cont.Position, Cont.BackgroundTransparency = UDim2.new(1, -20, 1, -80), UDim2.new(0, 10, 0, 60), 1
Instance.new("UIListLayout", Cont).Padding = UDim.new(0, 8)

-- [[ وظيفة رسبنة اللكزس والوزنيات ]]
local function GetCar()
    local p = game.Players.LocalPlayer
    local seat = p.Character and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.SeatPart
    return seat and seat.Parent, seat
end

-- وظيفة الرسبنة (تعتمد على وجود موديل في الماب)
local function SpawnLexus()
    -- ملاحظة: هذه الوظيفة تحاول البحث عن موديل اللكزس في الماب ورسبنته لك
    -- إذا كان الماب يدعم الرسبنة بالأوامر ستعمل فوراً
    print("محاولة رسبنة لكزس بلاك إديشن - أبو يوسف")
    -- هنا نضع الكود المعتاد لرسبنة السيارات في مابات الهجولة
    game:GetService("ReplicatedStorage").VehicleEvents.SpawnVehicle:FireServer("Lexus_LX_Black") 
end

local function SetWeight(mode)
    local car, seat = GetCar()
    if not car or not seat then return end
    for _, v in pairs(car.PrimaryPart:GetChildren()) do if v:IsA("BodyGyro") then v:Destroy() end end

    if mode == "drift" then
        seat.MaxSteerAngle = 58
        for _, p in pairs(car:GetDescendants()) do if p:IsA("WheelInstance") or p.Name:find("Wheel") then p.Friction = 0.4 end end
    elseif mode == "L" or mode == "R" then
        local g = Instance.new("BodyGyro", car.PrimaryPart)
        g.P, g.MaxTorque = 4500, Vector3.new(500000, 0, 500000)
        local ang = mode == "L" and 38 or -38
        g.CFrame = car.PrimaryPart.CFrame * CFrame.Angles(0, 0, math.rad(ang))
    elseif mode == "reset" then
        seat.MaxSteerAngle = 35
        for _, p in pairs(car:GetDescendants()) do if p:IsA("WheelInstance") or p.Name:find("Wheel") then p.Friction = 1 end end
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
    -- زر اللكزس الجديد
    AddB("🇯🇵 رسبن لكزس بلاك إديشن", Color3.fromRGB(20, 20, 20), SpawnLexus)
    AddB("🏎️ هجولة كنق (معدلة)", Color3.fromRGB(40, 40, 40), function() SetWeight("drift") end)
    AddB("📐 ترفيع يسار (لف حر)", Color3.fromRGB(0, 100, 150), function() SetWeight("L") end)
    AddB("📐 ترفيع يمين (لف حر)", Color3.fromRGB(0, 100, 150), function() SetWeight("R") end)
    AddB("🔄 تصفية الوزنية", Color3.fromRGB(150, 0, 0), function() SetWeight("reset") end)
end

-- واجهة الدخول (نفس الأكواد السابقة لضمان الخصوصية)
function MainUI()
    Cont:ClearAllChildren()
    local inp = Instance.new("TextBox", Cont)
    inp.Size, inp.PlaceholderText, inp.Text = UDim2.new(1, 0, 0, 50), "أدخل الكود...", ""
    inp.BackgroundColor3, inp.TextColor3 = Color3.fromRGB(25, 25, 25), Color3.new(1, 1, 1)
    Instance.new("UICorner", inp)
    local ent = Instance.new("TextButton", Cont)
    ent.Size, ent.Text, ent.BackgroundColor3 = UDim2.new(1,0,0,45), "تفعيل 🔓", Color3.fromRGB(0, 120, 0)
    Instance.new("UICorner", ent)
    ent.MouseButton1Click:Connect(function()
        if isfile and isfile(File) then Codes = HttpService:JSONDecode(readfile(File)) end
        if inp.Text == "IFC" then -- لوحة الأدمن
            Cont:ClearAllChildren()
            local nm = Instance.new("TextBox", Cont) nm.Size, nm.PlaceholderText = UDim2.new(1,0,0,40), "اسم الكود"
            local hr = Instance.new("TextBox", Cont) hr.Size, hr.PlaceholderText = UDim2.new(1,0,0,40), "الساعات"
            local s = Instance.new("TextButton", Cont) s.Size, s.Text, s.BackgroundColor3 = UDim2.new(1,0,0,40), "حفظ", Color3.new(0, 0.5, 0)
            s.MouseButton1Click:Connect(function()
                Codes[nm.Text] = {Exp = os.time() + (tonumber(hr.Text) or 1) * 3600}
                writefile(File, HttpService:JSONEncode(Codes)) MainUI()
            end)
        elseif Codes[inp.Text] and os.time() < Codes[inp.Text].Exp then ShowScript()
        else inp.Text = "خطأ!" end
    end)
end

MainUI()
