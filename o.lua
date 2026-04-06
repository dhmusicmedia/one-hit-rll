--[[
    ONE HIT TOGGLE MENU
    Hướng dẫn: Chạy bằng executor hoặc gắn vào StarterPlayerScripts
--]]

local Player = game.Players.LocalPlayer
local CoreGui = game:GetService("CoreGui") -- Dùng CoreGui để menu không mất khi chết (nếu dùng executor)

-- Xóa Menu cũ nếu có để tránh trùng lặp
if CoreGui:FindFirstChild("OneHitGui") then
    CoreGui.OneHitGui:Destroy()
end

-- TẠO GIAO DIỆN
local sg = Instance.new("ScreenGui")
sg.Name = "OneHitGui"
sg.Parent = CoreGui 
sg.IgnoreGuiInset = true

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 140, 0, 45)
main.Position = UDim2.new(0.5, -70, 0.05, 0) -- Giữa phía trên màn hình
main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true -- Bạn có thể kéo menu đi khắp màn hình
main.Parent = sg

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = main

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(1, -10, 1, -10)
btn.Position = UDim2.new(0, 5, 0, 5)
btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
btn.Text = "One Hit: OFF"
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 14
btn.Parent = main

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = btn

-- LOGIC ONE HIT
local enabled = false

local function kill(hit)
    if enabled and hit and hit.Parent then
        local hum = hit.Parent:FindFirstChildOfClass("Humanoid")
        if hum and hit.Parent.Name ~= Player.Name then
            hum.Health = 0
        end
    end
end

-- Gắn sự kiện vào tay/chân nhân vật
local function setupCharacter(char)
    for _, part in pairs(char:GetChildren()) do
        if part:IsA("BasePart") then
            part.Touched:Connect(kill)
        end
    end
end

Player.CharacterAdded:Connect(setupCharacter)
if Player.Character then setupCharacter(Player.Character) end

-- SỰ KIỆN BẬT/TẮT
btn.MouseButton1Click:Connect(function()
    enabled = not enabled
    if enabled then
        btn.Text = "One Hit: ON"
        btn.TextColor3 = Color3.fromRGB(0, 255, 127) -- Màu xanh lá
        btn.BackgroundColor3 = Color3.fromRGB(40, 60, 40)
    else
        btn.Text = "One Hit: OFF"
        btn.TextColor3 = Color3.fromRGB(255, 80, 80) -- Màu đỏ
        btn.BackgroundColor3 = Color3.fromRGB(60, 40, 40)
    end
end)
