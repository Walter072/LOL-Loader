local uiLoader = loadstring(game:HttpGet('https://raw.githubusercontent.com/topitbopit/dollarware/main/library.lua'))
local ui = uiLoader({
    rounding = false,
    theme = 'lime', 
    smoothDragging = false
})
local size = Vector2.new(550, 376)
local viewport = workspace.CurrentCamera.ViewportSize

local window = ui.newWindow({
    text = 'LOL HUB / Universal',
    resize = true,
    size = size,
    position = Vector2.new(
        (viewport.X - size.X) / 2,  
        (viewport.Y - size.Y) / 2   
    )
})
local mainMenu = window:addMenu({
    text = "Main"
})
local section1 = mainMenu:addSection({
    text = "Player"
})

local Players = game:GetService('Players')
local RunService = game:GetService('RunService')
local UserInputService = game:GetService('UserInputService')
local LocalPlayer = Players.LocalPlayer

local flyEnabled = false
local flySpeed = 50
local flyConn = nil
local bodyGyro, bodyVel
local FLY_KEY = Enum.KeyCode.F

local function getHRP()
    local char = LocalPlayer.Character
    if not char then return nil, nil end
    return char:FindFirstChild('HumanoidRootPart'), char:FindFirstChildOfClass('Humanoid')
end

local function stopFly()
    flyEnabled = false
    if flyConn then
        flyConn:Disconnect()
        flyConn = nil
    end
    if bodyGyro then pcall(function() bodyGyro:Destroy() end) bodyGyro = nil end
    if bodyVel then pcall(function() bodyVel:Destroy() end) bodyVel = nil end
    local _, hum = getHRP()
    if hum then hum.PlatformStand = false end
end

local function startFly()
    local hrp, hum = getHRP()
    if not hrp or not hum then return end

    stopFly()
    flyEnabled = true
    hum.PlatformStand = true

    bodyGyro = Instance.new('BodyGyro')
    bodyGyro.P = 9e4
    bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    bodyGyro.CFrame = hrp.CFrame
    bodyGyro.Parent = hrp

    bodyVel = Instance.new('BodyVelocity')
    bodyVel.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    bodyVel.Velocity = Vector3.zero
    bodyVel.Parent = hrp

    flyConn = RunService.RenderStepped:Connect(function()
        if not flyEnabled or not hrp.Parent then
            stopFly()
            return
        end

        local cam = workspace.CurrentCamera
        local dir = Vector3.zero
        local look = cam.CFrame.LookVector
        local right = cam.CFrame.RightVector

        if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir += look end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir -= look end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir += right end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir -= right end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.yAxis end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then dir -= Vector3.yAxis end

        if dir.Magnitude > 0 then
            dir = dir.Unit * flySpeed
        end

        bodyVel.Velocity = dir
        bodyGyro.CFrame = cam.CFrame
    end)
end

local flyToggle = section1:addToggle({
    text = 'Fly (use key F)',
    state = false
})

flyToggle:bindToEvent('onToggle', function(state)
    if state then
        startFly()
        ui.notify({ title = 'Fly', message = 'ON', duration = 2 })
    else
        stopFly()
        ui.notify({ title = 'Fly', message = 'OFF', duration = 2 })
    end
end)

section1:addSlider({
    text = 'Fly Speed',
    min = 10,
    max = 200,
    step = 5,
    val = 50
}, function(val)
    flySpeed = val
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode ~= FLY_KEY then return end

    if flyEnabled then
        stopFly()
        pcall(function() flyToggle:setState(false) end)
        ui.notify({ title = 'Fly', message = 'OFF', duration = 2 })
    else
        startFly()
        pcall(function() flyToggle:setState(true) end)
        ui.notify({ title = 'Fly', message = 'ON', duration = 2 })
    end
end)

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.5)
    if flyEnabled then
        startFly()
    end
end)

local slider = section1:addSlider({
    text = "WalkSpeed",
    min = 16,
    max = 500,
    value = 16,
    callback = function(value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
    end
})

ui.notify({
    title = 'Universal Script',
    message = 'loader loaded successfully',
    duration = 3
})