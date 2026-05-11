local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Configuration
local DRAG_KEY = Enum.UserInputType.MouseButton1
local UPDATE_RATE = 0.5

-- State
local isDragging = false
local dragStart = nil
local startPos = nil

-- UI Creation
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BagahHub_FPSDisplay"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Name = "Main"
mainFrame.Size = UDim2.new(0, 160, 0, 140)
mainFrame.Position = UDim2.new(1, -180, 0, 20)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
mainFrame.BackgroundTransparency = 0.15
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(255, 255, 255)
stroke.Thickness = 1
stroke.Transparency = 0.85
stroke.Parent = mainFrame

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 8)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = mainFrame

local padding = Instance.new("UIPadding")
padding.PaddingTop = UDim.new(0, 12)
padding.PaddingBottom = UDim.new(0, 12)
padding.PaddingLeft = UDim.new(0, 12)
padding.PaddingRight = UDim.new(0, 12)
padding.Parent = mainFrame


local function createStatRow(title, icon, value, color)
    local row = Instance.new("Frame")
    row.Name = title .. "Row"
    row.Size = UDim2.new(1, 0, 0, 24)
    row.BackgroundTransparency = 1
    row.Parent = mainFrame

    local iconLabel = Instance.new("ImageLabel")
    iconLabel.Name = "Icon"
    iconLabel.Size = UDim2.new(0, 18, 0, 18)
    iconLabel.Position = UDim2.new(0, 0, 0.5, -9)
    iconLabel.AnchorPoint = Vector2.new(0, 0.5)
    iconLabel.BackgroundTransparency = 1
    iconLabel.Image = icon
    iconLabel.ImageColor3 = color or Color3.fromRGB(200, 200, 210)
    iconLabel.Parent = row

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(0, 60, 1, 0)
    titleLabel.Position = UDim2.new(0, 24, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(150, 150, 160)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 12
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = row

    local valueLabel = Instance.new("TextLabel")
    valueLabel.Name = "Value"
    valueLabel.Size = UDim2.new(0, 60, 1, 0)
    valueLabel.Position = UDim2.new(1, -60, 0, 0)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = value
    valueLabel.TextColor3 = color or Color3.fromRGB(255, 255, 255)
    valueLabel.Font = Enum.Font.GothamBold
    valueLabel.TextSize = 13
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.Parent = row

    return valueLabel
end

-- Stats Rows
local fpsValueLabel = createStatRow("FPS", "rbxassetid://10709791479", "0", Color3.fromRGB(100, 255, 100))
local pingValueLabel = createStatRow("Ping", "rbxassetid://10709791653", "0ms", Color3.fromRGB(100, 200, 255))
local memValueLabel = createStatRow("Mem", "rbxassetid://10709791821", "0MB", Color3.fromRGB(255, 200, 100))
local cpuValueLabel = createStatRow("CPU", "rbxassetid://10709792012", "0ms", Color3.fromRGB(255, 150, 100))

-- Dragging Logic
mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

mainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- Update Loop
local lastTime = tick()
local frameCount = 0
local currentFps = 0
local currentPing = 0


local frameTimes = {}
RunService.RenderStepped:Connect(function(dt)
    table.insert(frameTimes, dt * 1000) -- Convert to ms
    if #frameTimes > 60 then table.remove(frameTimes, 1) end
end)

RunService.RenderStepped:Connect(function()
    frameCount = frameCount + 1
    local now = tick()
    if now - lastTime >= UPDATE_RATE then
        currentFps = math.floor(frameCount / (now - lastTime))
        frameCount = 0
        lastTime = now

        fpsValueLabel.Text = tostring(currentFps)
        if currentFps >= 50 then
            fpsValueLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        elseif currentFps >= 30 then
            fpsValueLabel.TextColor3 = Color3.fromRGB(255, 255, 100)
        else
            fpsValueLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
    end
end)


task.spawn(function()
    while task.wait(1) do
        local stats = game:GetService("Stats")
        local network = stats:FindFirstChild("Network")
        if network then
            local serverStats = network:FindFirstChild("ServerStatsItem")
            if serverStats then
                local pingObj = serverStats:FindFirstChild("Data Ping")
                if pingObj then
                    currentPing = math.floor(pingObj:GetValue())
                end
            end
        end
        pingValueLabel.Text = currentPing .. "ms"

        if currentPing < 100 then
            pingValueLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
        elseif currentPing < 200 then
            pingValueLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
        else
            pingValueLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
    end
end)


task.spawn(function()
    while task.wait(2) do
        local stats = game:GetService("Stats")
        local memory = stats:FindFirstChild("Memory")
        if memory then
            local used = memory:GetAttribute("Used")
            if used then
                memValueLabel.Text = string.format("%.1fMB", used / 1048576)
            else
                memValueLabel.Text = string.format("%.1fMB", collectgarbage("count") / 1024)
            end
        else
            memValueLabel.Text = string.format("%.1fMB", collectgarbage("count") / 1024)
        end
    end
end)


task.spawn(function()
    while task.wait(1) do
        if #frameTimes > 0 then
            local sum = 0
            for _, t in ipairs(frameTimes) do
                sum += t
            end
            local avg = sum / #frameTimes
            cpuValueLabel.Text = string.format("%.1f ms", avg)
        else
            cpuValueLabel.Text = "0.0 ms"
        end
    end
end)
