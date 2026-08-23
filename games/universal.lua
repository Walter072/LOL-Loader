local uiLoader = loadstring(game:HttpGet('https://raw.githubusercontent.com/topitbopit/dollarware/main/library.lua'))
local ui = uiLoader({
    rounding = false,
    theme = 'lime',
    smoothDragging = false
})

local Players = game:GetService('Players')
local RunService = game:GetService('RunService')
local UserInputService = game:GetService('UserInputService')
local LocalPlayer = Players.LocalPlayer

local size = Vector2.new(550, 376)
local cam = workspace.CurrentCamera
local viewport = (cam and cam.ViewportSize) or Vector2.new(1920, 1080)

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
     text = 'Main' 
    })

local vulnerabilitiesMenu = window:addMenu({
     text = 'Vulnerabilities' 
    })

local section1 = mainMenu:addSection({
    text = 'Player',
    side = 'left'
})

local section2 = vulnerabilitiesMenu:addSection({
    text = 'Bugs',
    side = 'left'
})

section1:addSlider({
    text = 'WalkSpeed',
    min = 16,
    max = 135,
    step = 1,
    val = 16
}, function(val)
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass('Humanoid')
    if hum then
        hum.WalkSpeed = val
    end
end)

section1:addButton({
    text = 'Open Fly GUI',
    style = 'large'
}, function()
    pcall(function()
        local PlayerGui = LocalPlayer:WaitForChild('PlayerGui')

        for _, n in ipairs({ 'Closed Fly Gui', 'Fly gui' }) do
            local old = PlayerGui:FindFirstChild(n)
            if old then old:Destroy() end
        end

        local function makeDraggable(frame)
            local dragging = false
            local dragStart, startPos

            frame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1
                    or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    dragStart = input.Position
                    startPos = frame.Position
                    input.Changed:Connect(function()
                        if input.UserInputState == Enum.UserInputState.End then
                            dragging = false
                        end
                    end)
                end
            end)

            UserInputService.InputChanged:Connect(function(input)
                if not dragging then return end
                if input.UserInputType == Enum.UserInputType.MouseMovement
                    or input.UserInputType == Enum.UserInputType.Touch then
                    local delta = input.Position - dragStart
                    frame.Position = UDim2.new(
                        startPos.X.Scale, startPos.X.Offset + delta.X,
                        startPos.Y.Scale, startPos.Y.Offset + delta.Y
                    )
                end
            end)
        end

        local ClosedGui = Instance.new('ScreenGui')
        ClosedGui.Name = 'Closed Fly Gui'
        ClosedGui.ResetOnSpawn = false
        ClosedGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        ClosedGui.Parent = PlayerGui

        local ClosedFrame = Instance.new('Frame')
        ClosedFrame.Size = UDim2.new(0, 100, 0, 100)
        ClosedFrame.Position = UDim2.new(0.44, 0, 0.32, 0)
        ClosedFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        ClosedFrame.BorderSizePixel = 0
        ClosedFrame.Parent = ClosedGui
        Instance.new('UICorner', ClosedFrame)

        local OpenBtn = Instance.new('TextButton')
        OpenBtn.Size = UDim2.new(0, 70, 0, 47)
        OpenBtn.Position = UDim2.new(0.15, 0, 0.26, 0)
        OpenBtn.BackgroundColor3 = Color3.fromRGB(72, 174, 145)
        OpenBtn.Text = 'Open Gui'
        OpenBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        OpenBtn.TextSize = 14
        OpenBtn.Font = Enum.Font.SourceSans
        OpenBtn.BorderSizePixel = 0
        OpenBtn.Parent = ClosedFrame
        Instance.new('UICorner', OpenBtn)

        makeDraggable(ClosedFrame)

        local FlyGui = Instance.new('ScreenGui')
        FlyGui.Name = 'Fly gui'
        FlyGui.ResetOnSpawn = false
        FlyGui.Enabled = false
        FlyGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        FlyGui.Parent = PlayerGui

        local FlyFrame = Instance.new('Frame')
        FlyFrame.Size = UDim2.new(0, 322, 0, 258)
        FlyFrame.Position = UDim2.new(0.28, 0, 0.18, 0)
        FlyFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        FlyFrame.BorderSizePixel = 0
        FlyFrame.Parent = FlyGui
        Instance.new('UICorner', FlyFrame)

        local SpeedBox = Instance.new('TextBox')
        SpeedBox.Size = UDim2.new(0, 157, 0, 67)
        SpeedBox.Position = UDim2.new(0.25, 0, 0.13, 0)
        SpeedBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        SpeedBox.BackgroundTransparency = 0.3
        SpeedBox.Text = '50'
        SpeedBox.PlaceholderText = 'Fly Speed'
        SpeedBox.TextColor3 = Color3.fromRGB(0, 0, 0)
        SpeedBox.TextSize = 14
        SpeedBox.Font = Enum.Font.SourceSans
        SpeedBox.BorderSizePixel = 0
        SpeedBox.Parent = FlyFrame
        Instance.new('UICorner', SpeedBox)

        local OnBtn = Instance.new('TextButton')
        OnBtn.Size = UDim2.new(0, 67, 0, 51)
        OnBtn.Position = UDim2.new(0.04, 0, 0.59, 0)
        OnBtn.BackgroundColor3 = Color3.fromRGB(0, 171, 0)
        OnBtn.Text = 'Turn Fly ON'
        OnBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        OnBtn.TextSize = 12
        OnBtn.Font = Enum.Font.SourceSans
        OnBtn.BorderSizePixel = 0
        OnBtn.Parent = FlyFrame
        Instance.new('UICorner', OnBtn)

        local OffBtn = Instance.new('TextButton')
        OffBtn.Size = UDim2.new(0, 67, 0, 51)
        OffBtn.Position = UDim2.new(0.30, 0, 0.59, 0)
        OffBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        OffBtn.Text = 'Turn Fly OFF'
        OffBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        OffBtn.TextSize = 12
        OffBtn.Font = Enum.Font.SourceSans
        OffBtn.BorderSizePixel = 0
        OffBtn.Parent = FlyFrame
        Instance.new('UICorner', OffBtn)

        local KeyBtn = Instance.new('TextButton')
        KeyBtn.Size = UDim2.new(0, 120, 0, 30)
        KeyBtn.Position = UDim2.new(0.08, 0, 0.83, 0)
        KeyBtn.BackgroundColor3 = Color3.fromRGB(0, 171, 0)
        KeyBtn.Text = 'Keybind: P'
        KeyBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        KeyBtn.TextSize = 14
        KeyBtn.Font = Enum.Font.SourceSans
        KeyBtn.BorderSizePixel = 0
        KeyBtn.Parent = FlyFrame
        Instance.new('UICorner', KeyBtn)

        local CloseBtn = Instance.new('TextButton')
        CloseBtn.Size = UDim2.new(0, 32, 0, 34)
        CloseBtn.Position = UDim2.new(0.90, 0, 0, 0)
        CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        CloseBtn.Text = 'X'
        CloseBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        CloseBtn.TextSize = 14
        CloseBtn.Font = Enum.Font.SourceSans
        CloseBtn.BorderSizePixel = 0
        CloseBtn.Parent = FlyFrame
        Instance.new('UICorner', CloseBtn)

        makeDraggable(FlyFrame)

        local flyEnabled = false
        local flySpeed = 50
        local flyConn = nil
        local bodyGyro, bodyVel
        local flyKey = Enum.KeyCode.P
        local waitingForKey = false

        local function getHRP()
            local char = LocalPlayer.Character
            if not char then return nil, nil end
            return char:FindFirstChild('HumanoidRootPart'), char:FindFirstChildOfClass('Humanoid')
        end

        local function stopFly()
            flyEnabled = false
            if flyConn then flyConn:Disconnect() flyConn = nil end
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
                local camera = workspace.CurrentCamera
                if not camera then return end

                local dir = Vector3.zero
                local look = camera.CFrame.LookVector
                local right = camera.CFrame.RightVector

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
                bodyGyro.CFrame = camera.CFrame
            end)
        end

        local function toggleFly()
            if flyEnabled then stopFly() else startFly() end
        end

        OpenBtn.MouseButton1Click:Connect(function()
            ClosedGui.Enabled = false
            FlyGui.Enabled = true
        end)

        CloseBtn.MouseButton1Click:Connect(function()
            FlyGui.Enabled = false
            ClosedGui.Enabled = true
        end)

        OnBtn.MouseButton1Click:Connect(function()
            local n = tonumber(SpeedBox.Text)
            if n then flySpeed = n end
            startFly()
        end)

        OffBtn.MouseButton1Click:Connect(function()
            stopFly()
        end)

        SpeedBox.FocusLost:Connect(function()
            local n = tonumber(SpeedBox.Text)
            if n and n > 0 then
                flySpeed = n
            else
                SpeedBox.Text = tostring(flySpeed)
            end
        end)

        KeyBtn.MouseButton1Click:Connect(function()
            waitingForKey = true
            KeyBtn.Text = 'Press a key...'
        end)

        UserInputService.InputBegan:Connect(function(input, gp)
            if waitingForKey and input.UserInputType == Enum.UserInputType.Keyboard then
                flyKey = input.KeyCode
                KeyBtn.Text = 'Keybind: ' .. input.KeyCode.Name
                waitingForKey = false
                return
            end
            if gp then return end
            if input.KeyCode == flyKey then
                toggleFly()
            end
        end)

        LocalPlayer.CharacterAdded:Connect(function()
            task.wait(0.5)
            if flyEnabled then startFly() end
        end)

        ClosedGui.Enabled = true
        FlyGui.Enabled = false
    end)

    pcall(function()
        ui.notify({ title = 'Fly GUI', message = 'Cargado', duration = 3 })
    end)
end)

local TARGET_NAMES = { 'Barries' }
local MATCH_PARTIAL = true
local autoDelete = false
local addedConn = nil

local function parseNames(text)
    local list = {}
    if not text or text == '' then return list end
    for name in string.gmatch(text, '[^,]+') do
        name = name:match('^%s*(.-)%s*$')
        if name ~= '' then
            table.insert(list, name)
        end
    end
    return list
end

local function nameMatches(objName)
    local lower = objName:lower()
    for _, target in ipairs(TARGET_NAMES) do
        local t = target:lower()
        if MATCH_PARTIAL then
            if lower:find(t, 1, true) then
                return true
            end
        else
            if lower == t then
                return true
            end
        end
    end
    return false
end

local function isTargetType(obj)
    return obj:IsA('BasePart') or obj:IsA('Model') or obj:IsA('Folder')
end

local function tryDelete(obj)
    if not autoDelete then return end
    if not obj or not obj.Parent then return end
    if not isTargetType(obj) then return end
    if not nameMatches(obj.Name) then return end

    print('[AutoDelete]', obj:GetFullName())
    pcall(function()
        obj:Destroy()
    end)
end

local function scanAll()
    for _, obj in ipairs(workspace:GetDescendants()) do
        tryDelete(obj)
    end
end

local function startAutoDelete()
    autoDelete = true
    scanAll()
    if addedConn then
        addedConn:Disconnect()
        addedConn = nil
    end
    addedConn = workspace.DescendantAdded:Connect(function(obj)
        task.defer(function()
            tryDelete(obj)
        end)
    end)
    ui.notify({
        title = 'AutoDelete',
        message = 'ON: ' .. table.concat(TARGET_NAMES, ', '),
        duration = 3
    })
end

local function stopAutoDelete()
    autoDelete = false
    if addedConn then
        addedConn:Disconnect()
        addedConn = nil
    end
    ui.notify({ title = 'AutoDelete', message = 'OFF', duration = 2 })
end

section2:addLabel({ text = 'Names separated by comma' })

section2:addTextbox({
    text = 'Barries'
}):bindToEvent('onFocusLost', function(text)
    local list = parseNames(text)
    if #list > 0 then
        TARGET_NAMES = list
        ui.notify({
            title = 'Names',
            message = table.concat(TARGET_NAMES, ', '),
            duration = 3
        })
        if autoDelete then
            scanAll()
        end
    end
end)

section2:addToggle({
    text = 'Auto Deleter',
    state = false
}):bindToEvent('onToggle', function(state)
    if state then
        startAutoDelete()
    else
        stopAutoDelete()
    end
end)