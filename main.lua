-- [[ Altrfy3 shop - OFFICIAL SCRIPT ]]
local SGui = Instance.new("ScreenGui", game.CoreGui)
local Main = Instance.new("Frame", SGui)
local HttpService = game:GetService("HttpService")
local File = "Altrfy3_Data.json"
local Codes = {}

-- إعدادات الواجهة
Main.Size = UDim2.new(0, 320, 0, 400)
Main.Position = UDim2.new(0.4, 0, 0.3, 0)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 15)

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 45)
Title.Text = "Altrfy3 shop 🇸🇦"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold
Instance.new("UICorner", Title).CornerRadius = UDim.new(0, 15)

-- نظام RGB للعنوان
spawn(function()
    while wait() do
        Title.BackgroundColor3 = Color3.fromHSV(tick() % 5 / 5, 0.7, 0.8)
    end
end)

local Cont = Instance.new("ScrollingFrame", Main)
Cont.Size = UDim2.new(1, -20, 1, -60)
Cont.Position = UDim2.new(0, 10, 0, 55)
Cont.BackgroundTransparency = 1
Cont.ScrollBarThickness = 2
local List = Instance.new("UIListLayout", Cont)
List.Padding = UDim.new(0, 8)

-- وظائف الحفظ
local function Save() if writefile then writefile(File, HttpService:JSONEncode(Codes)) end end
if isfile and isfile(File) then Codes = HttpService:JSONDecode(readfile(File)) end

-- وظيفة صنع الأزرار
local function NewBtn(txt, clr, func)
    local b = Instance.new("TextButton", Cont)
    b.Size = UDim2.new(1, 0, 0, 40)
    b.Text = txt
    b.BackgroundColor3 = clr
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.GothamSemibold
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(func)
end

local function GetCar()
    return game.Players.LocalPlayer.Character.Humanoid.SeatPart.Parent
end

-- واجهة الوزنيات (بعد التفعيل)
local function ShowScript()
    Cont:ClearAllChildren()
    Instance.new("UIListLayout", Cont).Padding = UDim.new(0, 8)
    
    NewBtn("🏎️ وزنية التفحيط", Color3.fromRGB(40, 40, 40), function()
        GetCar().DriveSeat.MaxSteerAngle = 60
    end)
    
    NewBtn("📐 ترفيع يمين (ثابت)", Color3.fromRGB(0, 120, 200), function()
        GetCar().PrimaryPart.CenterOfMassOffset = Vector3.new(2.4, 0.8, 0)
    end)
    
    NewBtn("📐 ترفيع يسار (ثابت)", Color3.fromRGB(0, 120, 200), function()
        GetCar().PrimaryPart.CenterOfMassOffset = Vector3.new(-2.4, 0.8, 0)
    end)
    
    NewBtn("🔄 تصفية الوزنيات", Color3.fromRGB(180, 150, 0), function()
        local c = GetCar()
        c.PrimaryPart.CenterOfMassOffset = Vector3.new(0, 0, 0)
        c.DriveSeat.MaxSteerAngle = 35
    end)
    
    NewBtn("❌ إغلاق السكريبت", Color3.fromRGB(150, 0, 0), function() SGui:Destroy() end)
end

-- واجهة الأدمن (IFC)
local function ShowAdmin()
    Cont:ClearAllChildren()
    Instance.new("UIListLayout", Cont).Padding = UDim.new(0, 8)
    
    local nm = Instance.new("TextBox", Cont) nm.Size, nm.PlaceholderText = UDim2.new(1,0,0,35), "اسم الكود"
    local us = Instance.new("TextBox", Cont) us.Size, us.PlaceholderText = UDim2.new(1,0,0,35), "عدد الأشخاص"
    local hr = Instance.new("TextBox", Cont) hr.Size, hr.PlaceholderText = UDim2.new(1,0,0,35), "المدة بالساعات"
    
    NewBtn("✅ إنشاء وحفظ الكود", Color3.fromRGB(0, 150, 0), function()
        if nm.Text ~= "" then
            Codes[nm.Text] = {
                Exp = os.time() + (tonumber(hr.Text) or 1) * 3600,
                MaxUses = tonumber(us.Text) or 1,
                Used = 0
            }
            Save()
            nm.Text = "تم الحفظ بنجاح!"
            wait(1) nm.Text = ""
        end
    end)
    
    NewBtn("🔙 عودة", Color3.fromRGB(60, 60, 60), function() MainUI() end)
end

-- الواجهة الرئيسية
function MainUI()
    Cont:ClearAllChildren()
    Instance.new("UIListLayout", Cont).Padding = UDim.new(0, 8)
    
    local inp = Instance.new("TextBox", Cont)
    inp.Size, inp.PlaceholderText = UDim2.new(1,0,0,45), "أدخل الكود أو IFC"
    inp.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    inp.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", inp)
    
    NewBtn("🔓 دخول", Color3.fromRGB(0, 120, 0), function()
        local txt = inp.Text
        if txt == "IFC" then
            ShowAdmin()
        elseif Codes[txt] then
            local data = Codes[txt]
            if os.time() < data.Exp and data.Used < data.MaxUses then
                data.Used = data.Used + 1
                Save()
                ShowScript()
            else
                inp.Text = "منتهي أو مستخدم!"
            end
        else
            inp.Text = "الكود خطأ!"
        end
    end)
end

MainUI()
