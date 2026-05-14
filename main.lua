-- [[ Altrfy3 shop - Safe Loading Edition ]]
local CoreGui = game:GetService("CoreGui")

-- تنظيف النسخ القديمة
if CoreGui:FindFirstChild("Altrfy3_Final") then CoreGui.Altrfy3_Final:Destroy() end

local SGui = Instance.new("ScreenGui", CoreGui)
SGui.Name = "Altrfy3_Final"
SGui.DisplayOrder = 100 -- ضمان الظهور فوق كل شيء

local Main = Instance.new("Frame", SGui)
Main.Size = UDim2.new(0, 300, 0, 400)
Main.Position = UDim2.new(0.5, -150, 0.5, -200)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main)

-- الجزء البنفسجي (العنوان)
local Header = Instance.new("Frame", Main)
Header.Size = UDim2.new(1, 0, 0, 60)
Header.BackgroundColor3 = Color3.fromRGB(150, 70, 200)
Instance.new("UICorner", Header)

local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(1, 0, 1, 0)
Title.Text = "Altrfy3 shop - أبو يوسف 🇸🇦"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.BackgroundTransparency = 1

-- حاوية العناصر
local Body = Instance.new("Frame", Main)
Body.Size = UDim2.new(1, -20, 1, -70)
Body.Position = UDim2.new(0, 10, 0, 70)
Body.BackgroundTransparency = 1
local Layout = Instance.new("UIListLayout", Body)
Layout.Padding = UDim.new(0, 10)

-- [[ 1. مكان وضع الكود ]]
local CodeBox = Instance.new("TextBox", Body)
CodeBox.Size = UDim2.new(1, 0, 0, 45)
CodeBox.PlaceholderText = "أدخل الكود هنا..."
CodeBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
CodeBox.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", CodeBox)

-- [[ 2. زر الدخول وتفعيل الوزنيات ]]
local EnterBtn = Instance.new("TextButton", Body)
EnterBtn.Size = UDim2.new(1, 0, 0, 50)
EnterBtn.Text = "تفعيل السكريبت"
EnterBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
EnterBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", EnterBtn)

-- [[ 3. قائمة الوزنيات (تظهر بعد الدخول) ]]
local function ShowDrifts()
    CodeBox.Visible = false
    EnterBtn.Visible = false
    
    local function AddBtn(txt, color, fric, steer)
        local b = Instance.new("TextButton", Body)
        b.Size = UDim2.new(1, 0, 0, 45)
        b.Text = txt
        b.BackgroundColor3 = color
        b.TextColor3 = Color3.new(1, 1, 1)
        Instance.new("UICorner", b)
        b.MouseButton1Click:Connect(function()
            local p = game.Players.LocalPlayer
            local car = p.Character and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.SeatPart
            if car then
                car.MaxSteerAngle = steer
                for _, v in pairs(car.Parent:GetDescendants()) do
                    if v:IsA("BasePart") and (v.Name:find("Wheel") or v:IsA("WheelInstance")) then
                        v.Friction = fric
                    end
                end
            end
        end)
    end

    AddBtn("🔥 هجولة كينق", Color3.fromRGB(150, 0, 0), 0.3, 65)
    AddBtn("🏎️ هجولة طرب", Color3.fromRGB(0, 100, 150), 0.45, 55)
    AddBtn("🔄 تصفية الوكالة", Color3.fromRGB(60, 60, 60), 1, 35)
end

EnterBtn.MouseButton1Click:Connect(function()
    if CodeBox.Text == "yousef" or CodeBox.Text == "IFC" then
        ShowDrifts()
    else
        CodeBox.Text = ""
        CodeBox.PlaceholderText = "الكود خطأ!"
    end
end)
 
