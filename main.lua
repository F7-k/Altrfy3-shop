-- [[ Altrfy3 shop - Super Response Edition ]]
local SGui = Instance.new("ScreenGui", game.CoreGui)
local Main = Instance.new("Frame", SGui)
local MiniBtn = Instance.new("ImageButton", SGui)
local HttpService = game:GetService("HttpService")
local File = "Altrfy3_Data.json"
local Codes = {}

-- إعدادات زر الإخفاء
MiniBtn.Size = UDim2.new(0, 55, 0, 55)
MiniBtn.Position = UDim2.new(0, 10, 0, 10)
MiniBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
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
Title.Text = "Altrfy3 shop 🇸🇦"
Title.TextColor3, Title.TextSize = Color3.new(1, 1, 1), 18
Title.Font = Enum.Font.GothamBold
Instance.new("UICorner", Title).CornerRadius = UDim.new(0, 15)
spawn(function() while wait() do Title.BackgroundColor3 = Color3.fromHSV(tick() % 5 / 5, 0.7, 0.8) end end)

local Cont = Instance.new("ScrollingFrame", Main)
Cont.Size, Cont.Position, Cont.BackgroundTransparency = UDim2.new(1, -20, 1, -70), UDim2.new(0, 10, 0, 60), 1
local List = Instance.new("UIListLayout", Cont)
List.Padding = UDim.new(0, 8)

-- [[ نظام اكتشاف السيارة والوزنيات الجديد ]]
local function GetVehicle()
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        local seat = char.Humanoid.SeatPart
        if seat and seat:IsA("VehicleSeat") then
            -- يبحث عن موديل السيارة بالصعود للأب (Parent)
            return seat:FindFirstAncestorOfClass("Model")
        end
    end
    return nil
end

local function SetHandling(type)
    local car = GetVehicle()
    if not car then return end
    
    -- محرك البحث عن القطع الأساسية
    local body = car:FindFirstChild("DriveSeat") or car.PrimaryPart or car:FindFirstChildWhichIsA("BasePart")
    
    if type == "reset" then
        if body then body.CenterOfMassOffset = Vector3.new(0,0,0) end
        if car:FindFirstChildWhichIsA("VehicleSeat") then car:FindFirstChildWhichIsA("VehicleSeat").MaxSteerAngle = 35 end
    elseif type == "drift" then
        local seat = car:FindFirstChildWhichIsA("VehicleSeat")
        if seat then seat.MaxSteerAngle = 65 seat.TurnSpeed = 1.5 end
    elseif type == "right" then
        if body then body.CenterOfMassOffset = Vector3.new(3.5, 1.5, 0) end
    elseif type == "left" then
        if body then body.CenterOfMassOffset = Vector3.new(-3.5, 1.5, 0) end
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
    B("🏎️ تفعيل هجولة (قوي)", Color3.fromRGB(40, 40, 40), function() SetHandling("drift") end)
    B("📐 ترفيع يمين (كفرين)", Color3.fromRGB(0, 100, 200), function() SetHandling("right") end)
    B("📐 ترفيع يسار (كفرين)", Color3.fromRGB(0, 100, 200), function() SetHandling("left") end)
    B("🔄 تصفية الوزنيات", Color3.fromRGB(150, 120, 0), function() SetHandling("reset") end)
end

-- واجهة الأدمن
local function ShowAdmin()
    Cont:ClearAllChildren()
    Instance.new("UIListLayout", Cont).Padding = UDim.new(0, 8)
    local nm = Instance.new("TextBox", Cont) nm.Size, nm.PlaceholderText = UDim2.new(1,0,0,35), "اسم الكود الجديد"
    local hr = Instance.new("TextBox", Cont) hr.Size, hr.PlaceholderText = UDim2.new(1,0,0,35), "الساعات"
    local btn = Instance.new("TextButton", Cont)
    btn.Size, btn.Text, btn.BackgroundColor3 = UDim2.new(1,0,0,40), "إنشاء وحفظ الكود", Color3.new(0,0.5,0)
    btn.MouseButton1Click:Connect(function()
        Codes[nm.Text] = {Exp = os.time() + (tonumber(hr.Text) or 1) * 3600}
        if writefile then writefile(File, HttpService:JSONEncode(Codes)) end
        nm.Text = "تم الحفظ!" wait(1) nm.Text = ""
    end)
    local b = Instance.new("TextButton", Cont)
    b.Size, b.Text, b.BackgroundColor3 = UDim2.new(1,0,0,40), "🔙 عودة", Color3.fromRGB(60, 60, 60)
    b.MouseButton1Click:Connect(function() MainUI() end)
end

-- الواجهة الرئيسية
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
        else inp.Text = "" inp.PlaceholderText = "الكود خطأ!" end
    end)
end

MainUI()
Instance.new("UICorner", MinBtn)

MinBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
    MiniBtn.Visible = true
end)

MiniBtn.MouseButton1Click:Connect(function()
    Main.Visible = true
    MiniBtn.Visible = false
end)

-- العنوان RGB
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 45)
Title.Text = "Altrfy3 shop 🇸🇦"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Instance.new("UICorner", Title).CornerRadius = UDim.new(0, 15)
spawn(function()
    while wait() do Title.BackgroundColor3 = Color3.fromHSV(tick() % 5 / 5, 0.7, 0.8) end
end)

local Cont = Instance.new("ScrollingFrame", Main)
Cont.Size = UDim2.new(1, -20, 1, -70)
Cont.Position = UDim2.new(0, 10, 0, 60)
Cont.BackgroundTransparency = 1
local List = Instance.new("UIListLayout", Cont)
List.Padding = UDim.new(0, 8)

-- وظائف الوزنيات
local function ApplyHandling(side)
    local p = game.Players.LocalPlayer
    local car = p.Character and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.SeatPart and p.Character.Humanoid.SeatPart.Parent
    if car and car:FindFirstChild("PrimaryPart") then
        if side == "reset" then
            car.PrimaryPart.CenterOfMassOffset = Vector3.new(0,0,0)
            if car:FindFirstChild("DriveSeat") then car.DriveSeat.MaxSteerAngle = 35 end
        elseif side == "right" then
            car.PrimaryPart.CenterOfMassOffset = Vector3.new(2.8, 1.2, 0)
        elseif side == "left" then
            car.PrimaryPart.CenterOfMassOffset = Vector3.new(-2.8, 1.2, 0)
        elseif side == "drift" then
            if car:FindFirstChild("DriveSeat") then car.DriveSeat.MaxSteerAngle = 60 end
        end
    end
end

-- واجهة الوزنيات
local function ShowScript()
    Cont:ClearAllChildren()
    local L = Instance.new("UIListLayout", Cont)
    L.Padding = UDim.new(0, 8)
    local function B(t, c, f)
        local btn = Instance.new("TextButton", Cont)
        btn.Size = UDim2.new(1, 0, 0, 40)
        btn.Text, btn.BackgroundColor3, btn.TextColor3 = t, c, Color3.new(1,1,1)
        Instance.new("UICorner", btn)
        btn.MouseButton1Click:Connect(f)
    end
    B("🏎️ تفعيل هجولة (60°)", Color3.fromRGB(40, 40, 40), function() ApplyHandling("drift") end)
    B("📐 ترفيع يمين (قوي)", Color3.fromRGB(0, 100, 200), function() ApplyHandling("right") end)
    B("📐 ترفيع يسار (قوي)", Color3.fromRGB(0, 100, 200), function() ApplyHandling("left") end)
    B("🔄 تصفية الوزنيات", Color3.fromRGB(150, 120, 0), function() ApplyHandling("reset") end)
end

-- واجهة الأدمن
local function ShowAdmin()
    Cont:ClearAllChildren()
    local L = Instance.new("UIListLayout", Cont)
    L.Padding = UDim.new(0, 8)
    local nm = Instance.new("TextBox", Cont) nm.Size, nm.PlaceholderText = UDim2.new(1,0,0,35), "اسم الكود الجديد"
    local hr = Instance.new("TextBox", Cont) hr.Size, hr.PlaceholderText = UDim2.new(1,0,0,35), "الساعات"
    local btn = Instance.new("TextButton", Cont)
    btn.Size, btn.Text, btn.BackgroundColor3 = UDim2.new(1,0,0,40), "إنشاء وحفظ الكود", Color3.new(0,0.5,0)
    btn.MouseButton1Click:Connect(function()
        Codes[nm.Text] = {Exp = os.time() + (tonumber(hr.Text) or 1) * 3600, MaxUses = 100, Used = 0}
        if writefile then writefile(File, HttpService:JSONEncode(Codes)) end
        nm.Text = "تم الحفظ!" wait(1) nm.Text = ""
    end)
    local b = Instance.new("TextButton", Cont)
    b.Size, b.Text, b.BackgroundColor3 = UDim2.new(1,0,0,40), "🔙 عودة", Color3.fromRGB(60, 60, 60)
    b.MouseButton1Click:Connect(function() MainUI() end)
end

-- الواجهة الرئيسية
function MainUI()
    Cont:ClearAllChildren()
    local L = Instance.new("UIListLayout", Cont)
    L.Padding = UDim.new(0, 8)
    local inp = Instance.new("TextBox", Cont)
    inp.Size = UDim2.new(1, 0, 0, 50)
    inp.PlaceholderText = "أدخل الكود هنا..." -- الآن النص مخفي حتى تكتب
    inp.Text = "" -- الخانة فاضية تماماً
    inp.BackgroundColor3, inp.TextColor3 = Color3.fromRGB(30, 30, 30), Color3.new(1, 1, 1)
    Instance.new("UICorner", inp)
    
    local ent = Instance.new("TextButton", Cont)
    ent.Size, ent.Text, ent.BackgroundColor3 = UDim2.new(1,0,0,45), "تفعيل 🔓", Color3.new(0, 0.4, 0)
    Instance.new("UICorner", ent)
    
    ent.MouseButton1Click:Connect(function()
        if isfile and isfile(File) then Codes = HttpService:JSONDecode(readfile(File)) end
        if inp.Text == "IFC" then 
            ShowAdmin()
        elseif Codes[inp.Text] and os.time() < Codes[inp.Text].Exp then 
            ShowScript()
        else 
            inp.Text = "" 
            inp.PlaceholderText = "الكود غير صحيح!"
            wait(1.5)
            inp.PlaceholderText = "أدخل الكود هنا..."
        end
    end)
end

MainUI()
