-- [[ Altrfy3 shop - Super Fixed Edition ]]
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local File = "Altrfy3_Data.json"

-- مسح أي نسخة قديمة عشان ما تتداخل القوائم
if CoreGui:FindFirstChild("Altrfy3_Menu") then
    CoreGui.Altrfy3_Menu:Destroy()
end

local SGui = Instance.new("ScreenGui", CoreGui)
SGui.Name = "Altrfy3_Menu"
SGui.ResetOnSpawn = false

local Main = Instance.new("Frame", SGui)
Main.Size = UDim2.new(0, 310, 0, 400)
Main.Position = UDim2.new(0.5, -155, 0.5, -200)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true -- تقدر تحرك القائمة
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 15)

-- العنوان البنفسجي (نفس الصورة)
local Header = Instance.new("Frame", Main)
Header.Size = UDim2.new(1, 0, 0, 70)
Header.BackgroundColor3 = Color3.fromRGB(150, 70, 200)
Header.BorderSizePixel = 0
Header.ZIndex = 2
local HeaderCorner = Instance.new("UICorner", Header)
HeaderCorner.CornerRadius = UDim.new(0, 15)

local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(1, 0, 1, 0)
Title.Text = "أبو يوسف - Altrfy3 shop 🇸🇦"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.BackgroundTransparency = 1
Title.ZIndex = 3

-- منطقة الإدخال (ضمان الظهور)
local Content = Instance.new("Frame", Main)
Content.Size = UDim2.new(1, 0, 1, -70)
Content.Position = UDim2.new(0, 0, 0, 70)
Content.BackgroundTransparency = 1
Content.ZIndex = 2

-- خانة الكود (TextBox)
local CodeInput = Instance.new("TextBox", Content)
CodeInput.Size = UDim2.new(0, 260, 0, 50)
CodeInput.Position = UDim2.new(0.5, -130, 0.2, 0)
CodeInput.PlaceholderText = "أدخل الكود أو IFC"
CodeInput.Text = ""
CodeInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
CodeInput.TextColor3 = Color3.new(1, 1, 1)
CodeInput.Font = Enum.Font.Gotham
CodeInput.TextSize = 16
CodeInput.ZIndex = 4
Instance.new("UICorner", CodeInput)

-- زر الدخول الأخضر (نفس الصورة)
local EnterBtn = Instance.new("TextButton", Content)
EnterBtn.Size = UDim2.new(0, 260, 0, 60)
EnterBtn.Position = UDim2.new(0.5, -130, 0.45, 0)
EnterBtn.Text
 
