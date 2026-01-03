-- BagahHub Main Loader
-- Universal game detection and auto-loading system

-- First, create a custom loading UI
local function createLoadingUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "BagahHubLoader"
    ScreenGui.DisplayOrder = 999
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    -- Main container
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 400, 0, 300)
    MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    MainFrame.BackgroundTransparency = 0.1
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true

    -- Corner rounding
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = MainFrame

    -- Shadow effect
    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = "Shadow"
    Shadow.Size = UDim2.new(1, 20, 1, 20)
    Shadow.Position = UDim2.new(0, -10, 0, -10)
    Shadow.BackgroundTransparency = 1
    Shadow.Image = "rbxassetid://5554237731"
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.ImageTransparency = 0.8
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(23, 23, 277, 277)
    Shadow.Parent = MainFrame

    -- Title bar
    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Size = UDim2.new(1, 0, 0, 40)
    TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    TitleBar.BorderSizePixel = 0

    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(1, -20, 1, 0)
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "BagahHub is loading... | Made by Bagah"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 18
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TitleBar

    TitleBar.Parent = MainFrame

    -- Game info section
    local GameInfo = Instance.new("Frame")
    GameInfo.Name = "GameInfo"
    GameInfo.Size = UDim2.new(1, -20, 0, 60)
    GameInfo.Position = UDim2.new(0, 10, 0, 50)
    GameInfo.BackgroundTransparency = 1

    local GameIcon = Instance.new("ImageLabel")
    GameIcon.Name = "GameIcon"
    GameIcon.Size = UDim2.new(0, 50, 0, 50)
    GameIcon.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    GameIcon.BorderSizePixel = 0
    local IconCorner = Instance.new("UICorner")
    IconCorner.CornerRadius = UDim.new(0, 8)
    IconCorner.Parent = GameIcon

    local GameName = Instance.new("TextLabel")
    GameName.Name = "GameName"
    GameName.Size = UDim2.new(1, -60, 0, 25)
    GameName.Position = UDim2.new(0, 60, 0, 0)
    GameName.BackgroundTransparency = 1
    GameName.Text = "Game: Loading..."
    GameName.TextColor3 = Color3.fromRGB(255, 255, 255)
    GameName.TextSize = 16
    GameName.Font = Enum.Font.Gotham
    GameName.TextXAlignment = Enum.TextXAlignment.Left

    local GamePlaceId = Instance.new("TextLabel")
    GamePlaceId.Name = "GamePlaceId"
    GamePlaceId.Size = UDim2.new(1, -60, 0, 25)
    GamePlaceId.Position = UDim2.new(0, 60, 0, 25)
    GamePlaceId.BackgroundTransparency = 1
    GamePlaceId.Text = "Place ID: " .. tostring(game.PlaceId)
    GamePlaceId.TextColor3 = Color3.fromRGB(200, 200, 200)
    GamePlaceId.TextSize = 14
    GamePlaceId.Font = Enum.Font.Gotham
    GamePlaceId.TextXAlignment = Enum.TextXAlignment.Left

    GameIcon.Parent = GameInfo
    GameName.Parent = GameInfo
    GamePlaceId.Parent = GameInfo
    GameInfo.Parent = MainFrame

    -- Console output
    local ConsoleFrame = Instance.new("Frame")
    ConsoleFrame.Name = "ConsoleFrame"
    ConsoleFrame.Size = UDim2.new(1, -20, 0, 140)
    ConsoleFrame.Position = UDim2.new(0, 10, 0, 120)
    ConsoleFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    ConsoleFrame.BorderSizePixel = 0
    local ConsoleCorner = Instance.new("UICorner")
    ConsoleCorner.CornerRadius = UDim.new(0, 6)
    ConsoleCorner.Parent = ConsoleFrame

    local ConsoleTitle = Instance.new("TextLabel")
    ConsoleTitle.Name = "ConsoleTitle"
    ConsoleTitle.Size = UDim2.new(1, 0, 0, 25)
    ConsoleTitle.BackgroundTransparency = 1
    ConsoleTitle.Text = "Loading Console"
    ConsoleTitle.TextColor3 = Color3.fromRGB(220, 220, 220)
    ConsoleTitle.TextSize = 14
    ConsoleTitle.Font = Enum.Font.GothamBold
    ConsoleTitle.Parent = ConsoleFrame

    local ConsoleOutput = Instance.new("ScrollingFrame")
    ConsoleOutput.Name = "ConsoleOutput"
    ConsoleOutput.Size = UDim2.new(1, -10, 1, -35)
    ConsoleOutput.Position = UDim2.new(0, 5, 0, 30)
    ConsoleOutput.BackgroundTransparency = 1
    ConsoleOutput.BorderSizePixel = 0
    ConsoleOutput.ScrollBarThickness = 4
    ConsoleOutput.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
    ConsoleOutput.AutomaticCanvasSize = Enum.AutomaticSize.Y

    local ConsoleContent = Instance.new("UIListLayout")
    ConsoleContent.Name = "ConsoleContent"
    ConsoleContent.Padding = UDim.new(0, 2)
    ConsoleContent.Parent = ConsoleOutput

    ConsoleOutput.Parent = ConsoleFrame
    ConsoleFrame.Parent = MainFrame

    -- Status bar
    local StatusBar = Instance.new("Frame")
    StatusBar.Name = "StatusBar"
    StatusBar.Size = UDim2.new(1, -20, 0, 4)
    StatusBar.Position = UDim2.new(0, 10, 1, -30)
    StatusBar.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    StatusBar.BorderSizePixel = 0
    local StatusCorner = Instance.new("UICorner")
    StatusCorner.CornerRadius = UDim.new(0, 2)
    StatusCorner.Parent = StatusBar

    local ProgressFill = Instance.new("Frame")
    ProgressFill.Name = "ProgressFill"
    ProgressFill.Size = UDim2.new(0, 0, 1, 0)
    ProgressFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    ProgressFill.BorderSizePixel = 0
    local ProgressCorner = Instance.new("UICorner")
    ProgressCorner.CornerRadius = UDim.new(0, 2)
    ProgressCorner.Parent = ProgressFill
    ProgressFill.Parent = StatusBar

    local StatusText = Instance.new("TextLabel")
    StatusText.Name = "StatusText"
    StatusText.Size = UDim2.new(1, 0, 0, 20)
    StatusText.Position = UDim2.new(0, 0, 0, -24)
    StatusText.BackgroundTransparency = 1
    StatusText.Text = "Initializing..."
    StatusText.TextColor3 = Color3.fromRGB(220, 220, 220)
    StatusText.TextSize = 12
    StatusText.Font = Enum.Font.Gotham
    StatusText.TextXAlignment = Enum.TextXAlignment.Left
    StatusText.Parent = StatusBar

    StatusBar.Parent = MainFrame

    -- Close button
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Size = UDim2.new(0, 80, 0, 30)
    CloseButton.Position = UDim2.new(0.5, -40, 1, 10)
    CloseButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    CloseButton.BorderSizePixel = 0
    CloseButton.Text = "Close"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextSize = 14
    CloseButton.Font = Enum.Font.Gotham
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 4)
    CloseCorner.Parent = CloseButton

    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    CloseButton.Parent = MainFrame
    MainFrame.Parent = ScreenGui
    ScreenGui.Parent = game:GetService("CoreGui") or game:WaitForChild("Players").LocalPlayer:WaitForChild("PlayerGui")

    -- Function to add log messages
    local function addLog(message, color)
        color = color or Color3.fromRGB(220, 220, 220)

        local LogEntry = Instance.new("TextLabel")
        LogEntry.Size = UDim2.new(1, 0, 0, 20)
        LogEntry.BackgroundTransparency = 1
        LogEntry.Text = "[" .. os.date("%H:%M:%S") .. "] " .. tostring(message)
        LogEntry.TextColor3 = color
        LogEntry.TextSize = 12
        LogEntry.Font = Enum.Font.Gotham
        LogEntry.TextXAlignment = Enum.TextXAlignment.Left
        LogEntry.TextWrapped = true
        LogEntry.AutomaticSize = Enum.AutomaticSize.Y

        LogEntry.Parent = ConsoleOutput
        ConsoleOutput.CanvasPosition = Vector2.new(0, ConsoleOutput.AbsoluteCanvasSize.Y)
    end

    -- Function to update status
    local function updateStatus(text, progress)
        if StatusText then
            StatusText.Text = tostring(text)
        end
        if ProgressFill and progress then
            ProgressFill:TweenSize(UDim2.new(progress, 0, 1, 0), "Out", "Quad", 0.3, true)
        end
    end

    -- Function to update game info
    local function updateGameInfo(name)
        if GameName then
            GameName.Text = "Game: " .. tostring(name or "Unknown")
        end
        -- Try to get game thumbnail
        pcall(function()
            GameIcon.Image = "rbxgameasset://Thumbs/" .. tostring(game.PlaceId)
        end)
    end

    return {
        ScreenGui = ScreenGui,
        addLog = addLog,
        updateStatus = updateStatus,
        updateGameInfo = updateGameInfo
    }
end

-- Function to fetch script with better error handling
local function fetchScript(url, ui)
    ui.addLog("Fetching: " .. tostring(url), Color3.fromRGB(180, 180, 255))

    local startTime = tick()
    local success, response = pcall(function()
        return game:HttpGetAsync(url)
    end)
    local endTime = tick()
    local fetchTime = math.floor((endTime - startTime) * 1000) / 1000

    if success then
        ui.addLog(string.format("✓ Fetched successfully (%s KB, %ss)",
                math.floor(#response / 1024 * 100) / 100, fetchTime),
            Color3.fromRGB(100, 255, 100))
        return response
    else
        ui.addLog("✗ Fetch failed: " .. tostring(response), Color3.fromRGB(255, 100, 100))
        return nil, response
    end
end

-- Function to load script with proper execution
local function loadScript(content, scriptName, ui)
    ui.addLog("Loading " .. tostring(scriptName) .. "...", Color3.fromRGB(255, 255, 100))

    local startTime = tick()
    local success, result = pcall(function()
        local func, err = loadstring(content)
        if not func then
            error(err)
        end
        return func()
    end)
    local endTime = tick()
    local loadTime = math.floor((endTime - startTime) * 1000) / 1000

    if success then
        ui.addLog(string.format("✓ %s loaded successfully (%ss)", tostring(scriptName), tostring(loadTime)),
            Color3.fromRGB(100, 255, 100))
        return true
    else
        ui.addLog(string.format("✗ %s failed to load: %s", tostring(scriptName), tostring(result)),
            Color3.fromRGB(255, 100, 100))
        return false, result
    end
end

-- Main execution
local loadingUI = createLoadingUI()

-- Update initial game info
loadingUI.updateGameInfo("Loading...")
loadingUI.updateStatus("Starting BagahHub Loader", 0)

-- Define script groups with GitHub raw URLs
local GITHUB_BASE = "https://raw.githubusercontent.com/Bagah-Project/bagah-hub-public/main"

local ScriptGroups = {
    [GITHUB_BASE .. "/games/evade/main.lua"] = {
        name = "Evade",
        placeIds = {
            10324346056,     -- Big Team
            9872472334,      -- Evade
            10662542523,     -- Casual
            10324347967,     -- Social Space
            121271605799901, -- Player Nextbots
            10808838353,     -- VC Only
            11353528705,     -- Pro
            99214917572799,  -- Custom Servers
        }
    },
}

local UniversalScript = {
    name = "Universal Script",
    url = GITHUB_BASE .. "/universal/main.lua"
}

-- Find appropriate script for current game
loadingUI.updateStatus("Detecting game...", 0.2)
loadingUI.addLog("Current Place ID: " .. tostring(game.PlaceId))

local currentGameId = game.PlaceId
local selectedUrl = nil
local scriptName = ""

for url, group in pairs(ScriptGroups) do
    for _, placeId in ipairs(group.placeIds) do
        if currentGameId == placeId then
            selectedUrl = url
            scriptName = group.name
            loadingUI.addLog("Detected game: " .. tostring(group.name))
            loadingUI.updateGameInfo(tostring(group.name))
            break
        end
    end
    if selectedUrl then break end
end

if not selectedUrl then
    loadingUI.addLog("Game not in supported list, loading Universal script")
    loadingUI.updateGameInfo("Universal Support")
    scriptName = UniversalScript.name
    selectedUrl = UniversalScript.url
end

-- Load main script
loadingUI.updateStatus("Loading " .. tostring(scriptName) .. "...", 0.3)
local scriptContent, fetchError = fetchScript(selectedUrl, loadingUI)

if scriptContent then
    loadingUI.updateStatus("Executing " .. tostring(scriptName) .. "...", 0.6)
    local success, errorMsg = loadScript(scriptContent, scriptName, loadingUI)

    if success then
        loadingUI.updateStatus(tostring(scriptName) .. " loaded successfully!", 0.8)
    else
        loadingUI.updateStatus("Failed to load " .. tostring(scriptName), 0.8)
    end
else
    loadingUI.updateStatus("Failed to fetch " .. tostring(scriptName), 0.8)
end

-- Setup auto-reexecute on teleport
loadingUI.updateStatus("Setting up auto-reexecute...", 0.95)
loadingUI.addLog("Setting up teleport queue...")

local queueonteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (BagahHub and BagahHub.queue_on_teleport)
if queueonteleport then
    queueonteleport("loadstring(game:HttpGet('" .. GITHUB_BASE .. "/mainloader.lua'))()")
    loadingUI.addLog("✓ Auto-reexecute configured", Color3.fromRGB(100, 255, 100))
else
    loadingUI.addLog("⚠ Auto-reexecute not available", Color3.fromRGB(255, 200, 100))
end

-- Finalize
loadingUI.updateStatus("BagahHub loaded successfully!", 1)
loadingUI.addLog("=== BagahHub initialization complete ===", Color3.fromRGB(0, 170, 255))

-- Auto-close after delay
delay(5, function()
    if loadingUI.ScreenGui and loadingUI.ScreenGui.Parent then
        loadingUI.ScreenGui:Destroy()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "BagahHub",
            Text = tostring(scriptName) .. " has been loaded successfully!",
            Duration = 5
        })
    end
end)
