-- Advanced Fly Script
local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

local Flying = false
local FlySpeed = 50
local ToggleKey = Enum.KeyCode.F

-- Функция для полета
local function ToggleFlight()
    Flying = not Flying
    
    if Flying then
        -- Включаем полет
        Humanoid.PlatformStand = true
        
        local BodyGyro = Instance.new("BodyGyro")
        local BodyVelocity = Instance.new("BodyVelocity")
        
        BodyGyro.Name = "FlightGyro"
        BodyVelocity.Name = "FlightVelocity"
        
        BodyGyro.Parent = RootPart
        BodyVelocity.Parent = RootPart
        
        BodyGyro.MaxTorque = Vector3.new(40000, 40000, 40000)
        BodyGyro.P = 1000
        BodyGyro.CFrame = RootPart.CFrame
        
        BodyVelocity.MaxForce = Vector3.new(40000, 40000, 40000)
        BodyVelocity.Velocity = Vector3.new(0, 0, 0)
        
        -- Анимация полета
        spawn(function()
            while Flying and RootPart and RootPart.Parent do
                BodyGyro.CFrame = RootPart.CFrame
                wait()
            end
        end)
        
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Fly Enabled",
            Text = "WASD - Move | Space/Shift - Up/Down | F - Disable",
            Duration = 5
        })
        
    else
        -- Выключаем полет
        Humanoid.PlatformStand = false
        
        if RootPart:FindFirstChild("FlightGyro") then
            RootPart.FlightGyro:Destroy()
        end
        if RootPart:FindFirstChild("FlightVelocity") then
            RootPart.FlightVelocity:Destroy()
        end
        
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Fly Disabled",
            Text = "Press F to enable flight",
            Duration = 3
        })
    end
end

-- Обработчик клавиш
game:GetService("UserInputService").InputBegan:Connect(function(Input)
    if Input.KeyCode == ToggleKey then
        ToggleFlight()
    end
end)

-- Управление в полете
game:GetService("RunService").Heartbeat:Connect(function()
    if Flying and RootPart and RootPart:FindFirstChild("FlightVelocity") then
        local Camera = workspace.CurrentCamera
        local LV = Vector3.new(0, 0, 0)
        
        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then
            LV = LV + (Camera.CFrame.LookVector * FlySpeed)
        end
        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then
            LV = LV + (Camera.CFrame.LookVector * -FlySpeed)
        end
        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A) then
            LV = LV + (Camera.CFrame.RightVector * -FlySpeed)
        end
        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D) then
            LV = LV + (Camera.CFrame.RightVector * FlySpeed)
        end
        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then
            LV = LV + Vector3.new(0, FlySpeed, 0)
        end
        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftShift) then
            LV = LV + Vector3.new(0, -FlySpeed, 0)
        end
        
        RootPart.FlightVelocity.Velocity = LV
    end
end)

-- Изменение скорости полета
game:GetService("UserInputService").InputBegan:Connect(function(Input)
    if Flying then
        if Input.KeyCode == Enum.KeyCode.E then
            FlySpeed = FlySpeed + 10
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Speed Increased",
                Text = "Current Speed: " .. FlySpeed,
                Duration = 2
            })
        elseif Input.KeyCode == Enum.KeyCode.Q then
            FlySpeed = math.max(10, FlySpeed - 10)
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Speed Decreased",
                Text = "Current Speed: " .. FlySpeed,
                Duration = 2
            })
        end
    end
end)

print("🚀 Advanced Fly Script Loaded!")
print("✅ F - Toggle Flight")
print("✅ WASD - Move")
print("✅ Space - Up | Shift - Down")
print("✅ E - Speed+ | Q - Speed-")
print("✅ Current Speed: " .. FlySpeed)
