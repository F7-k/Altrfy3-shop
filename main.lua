-- [[ Altrfy3 shop - Fixed Input Box Edition ]]
local SGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local Main = Instance.new("Frame", SGui)
local MiniBtn = Instance.new("ImageButton", SGui)
local HttpService = game:GetService("HttpService")
local File = "Altrfy3_Data.json"
local Codes = {}

-- إعدادات الواجهة (نفس اللي في الصورة 1000113224_2.jpg)
SGui.Name = "Altrfy3_Secure_" .. math.random(100, 999)
Main.Size = UDim2.new(0, 310, 0, 400)
Main.Position = UDim2.new(0.5, -155, 0.5, -200)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.Active, Main.Draggable = true, true
Instance.new("UICorner", Main)

-- العنوان البنفسجي
local Header = Instance.new("Frame", Main)
Header.Size = UDim2.new(1, 0, 0, 80)
Header.BackgroundColor3 = Color3.fromRGB(150, 70, 200) -- اللون البنفسجي الموضح بالصورة
Instance.new("UICorner", Header)

local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(1, 0, 1, 0)
Title.Text = "أبو يوسف - Altrfy3 shop 🇸🇦"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.BackgroundTransparency = 1

-- حاوية العناصر (عشان تظهر الخانات مرتبة)
local Cont = Instance.new("Frame", Main)
Cont.Size = UDim2.new(1, -40, 1, -100)
Cont.Position = UDim2.new(0, 20, 0, 90)
Cont.BackgroundTransparency = 1
local List = Instance.new("UIListLayout", Cont)
List.Padding = UDim.new(0, 15)
List.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- [[ خانة كتابة الكود - تم إصلاح الظهور ]]
local CodeInput = Instance.new("TextBox", Cont)
CodeInput.Name = "CodeField"
CodeInput.Size = UDim2.new(1, 0, 0, 50)
CodeInput.PlaceholderText = "اكتب الكود هنا..."
CodeInput.Text = ""
CodeInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
CodeInput.TextColor3 = Color3.new(1, 1, 1)
CodeInput.Font = Enum.Font.Gotham
CodeInput.TextSize = 18
Instance.new("UICorner", CodeInput)

-- زر الدخول الأخضر (كما في الصورة 1000113224_2.jpg)
local EnterBtn = Instance.new("TextButton", Cont)
EnterBtn.Size = UDim2.new(1, 0, 0, 60)
EnterBtn.Text = "دخول"
EnterBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 0) -- الأخضر الغامق
EnterBtn.TextColor3 = Color3.new(1, 1, 1)
EnterBtn.Font = Enum.Font.GothamBold
EnterBtn.TextSize = 20
Instance.new("UICorner", EnterBtn)

-- [[ وظيفة الوزنيات ]]
local function ApplySettings(fric, steer)
    local p = game.Players.LocalPlayer
    local car = p.Character and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.SeatPart
    if car and car.Parent then
        car.MaxSteerAngle = steer
        for _, v in pairs(car.Parent:GetDescendants()) do
            if v:IsA("BasePart") and (v.Name:find("Wheel") or v:IsA("WheelInstance")) then
                v.Friction = fric
            end
        end
    end
end

-- واجهة الوزنيات بعد الدخول
local function ShowOptions()
    CodeInput.Visible = false
    EnterBtn.Visible = false
    
    local function AddDrift(txt, f, s)
        local b = Instance.new("TextButton", Cont)
        b.Size = UDim2.new(1, 0, 0, 45)
        b.Text = txt
        b.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        b.TextColor3 = Color3.new(1, 1, 1)
        Instance.new("UICorner", b)
        b.MouseButton1Click:Connect(function() ApplySettings(f, s) end)
    end
    
    AddDrift("🔥 هجولة كينق", 0.3, 65)
    AddDrift("🏎️ هجولة طرب", 0.45, 55)
    AddDrift("🔄 تصفية الوكالة", 1, 35)
end

-- برمجة زر الدخول
EnterBtn.MouseButton1Click:Connect(function()
    if isfile and isfile(File) then Codes = HttpService:JSONDecode(readfile(File)) end
    
    if CodeInput.Text == "IFC" then
        CodeInput.PlaceholderText = "وضع الإدارة مفعل"
        CodeInput.Text = ""
        -- هنا يمكنك إضافة وظائف الإدارة
    elseif Codes[CodeInput.Text] or CodeInput.Text == "yousef" then -- كود تجريبي "yousef"
        ShowOptions()
    else
        CodeInput.Text = ""
        CodeInput.PlaceholderText = "الكود غير صحيح!"
    end
end)
 
