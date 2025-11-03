-- Universal Fly Script
-- Controls: Z (fly), X (reset speed), C (increase speed), V (decrease speed)

local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()

local flying = false
local speed = 50

function Fly()
    flying = not flying
    
    if flying then
        local BodyGyro = Instance.new("BodyGyro")
        local BodyVelocity = Instance.new("BodyVelocity")
        
        BodyGyro.Parent = Player.Character.HumanoidRootPart
        BodyVelocity.Parent = Player.Character.HumanoidRootPart
        
        BodyGyro.MaxTorque = Vector3.new(9000, 9000, 9000)
        BodyGyro.P = 9000
        BodyGyro.D = 500
        
        BodyVelocity.MaxForce = Vector3.new(9000, 9000, 9000)
        BodyVelocity.Velocity = Vector3.new(0, 0, 0)
        
        while flying and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") do
            Player.Character.HumanoidRootPart.BodyVelocity.Velocity = Vector3.new(0, 0, 0)
            wait(0.1)
        end
        
        BodyGyro:Destroy()
        BodyVelocity:Destroy()
    end
end

Mouse.KeyDown:Connect(function(key)
    if key == "z" then
        Fly()
    elseif key == "x" then
        speed = 50
    elseif key == "c" then
        speed = speed + 10
    elseif key == "v" then
        speed = math.max(10, speed - 10)
    end
end)