local GITHUB_BASE = "https://raw.githubusercontent.com/Bagah-Project/bagah-hub-public/main"

local SUPPORTED_GAMES = {
    ["Evade"] = {
        full = "/games/evade/main.lua",
        tpOnly = "/games/evade/tponly.lua",
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
    ["Evade Legacy"] = {
        full = "/games/evadelegacy/main.lua",
        tpOnly = nil,
        placeIds = { 96537472072550 }
    },
}

local UNIVERSAL_SCRIPT = "/universal/main.lua"

local function createLoaderUI()
    local Players = game:GetService("Players")
    local TweenService = game:GetService("TweenService")
    local UserInputService = game:GetService("UserInputService")
    local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "BagahHubLoader"
    ScreenGui.DisplayOrder = 999
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = PlayerGui

    local function createCorner(radius)
        local c = Instance.new("UICorner")
        c.CornerRadius = UDim.new(0, radius or 12)
        return c
    end

    local function createStroke(color, thickness)
        local s = Instance.new("UIStroke")
        s.Color = color or Color3.fromRGB(255, 255, 255)
        s.Thickness = thickness or 1
        s.Transparency = 0.85
        return s
    end

    -- Main container
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 420, 0, 340)
    MainFrame.Position = UDim2.new(0.5, -210, 0.5, -170)
    MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
    MainFrame.BorderSizePixel = 0
    MainFrame.BackgroundTransparency = 0.05
    MainFrame.Parent = ScreenGui
    createCorner(16).Parent = MainFrame
    createStroke(Color3.fromRGB(60, 60, 80), 1.2).Parent = MainFrame

    -- Header section
    local Header = Instance.new("Frame")
    Header.Name = "Header"
    Header.Size = UDim2.new(1, -40, 0, 70)
    Header.Position = UDim2.new(0, 20, 0, 20)
    Header.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    Header.BorderSizePixel = 0
    Header.Parent = MainFrame
    createCorner(12).Parent = Header

    local LogoIcon = Instance.new("ImageLabel")
    LogoIcon.Name = "LogoIcon"
    LogoIcon.Size = UDim2.new(0, 36, 0, 36)
    LogoIcon.Position = UDim2.new(0, 16, 0, 17)
    LogoIcon.BackgroundTransparency = 1
    LogoIcon.Image = "rbxassetid://5107166345"
    LogoIcon.ImageColor3 = Color3.fromRGB(138, 43, 226)
    LogoIcon.Parent = Header

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Name = "TitleLabel"
    TitleLabel.Size = UDim2.new(1, -70, 0, 24)
    TitleLabel.Position = UDim2.new(0, 62, 0, 20)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = "BagahHub"
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextSize = 20
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = Header

    local SubtitleLabel = Instance.new("TextLabel")
    SubtitleLabel.Name = "SubtitleLabel"
    SubtitleLabel.Size = UDim2.new(1, -70, 0, 16)
    SubtitleLabel.Position = UDim2.new(0, 62, 0, 44)
    SubtitleLabel.BackgroundTransparency = 1
    SubtitleLabel.Text = "Select your preferred version"
    SubtitleLabel.TextColor3 = Color3.fromRGB(140, 140, 160)
    SubtitleLabel.TextSize = 12
    SubtitleLabel.Font = Enum.Font.Gotham
    SubtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    SubtitleLabel.Parent = Header

    -- Game info bar
    local GameInfo = Instance.new("Frame")
    GameInfo.Name = "GameInfo"
    GameInfo.Size = UDim2.new(1, -40, 0, 32)
    GameInfo.Position = UDim2.new(0, 20, 0, 100)
    GameInfo.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
    GameInfo.BorderSizePixel = 0
    GameInfo.Parent = MainFrame
    createCorner(8).Parent = GameInfo

    local GameIcon = Instance.new("ImageLabel")
    GameIcon.Name = "GameIcon"
    GameIcon.Size = UDim2.new(0, 18, 0, 18)
    GameIcon.Position = UDim2.new(0, 10, 0, 7)
    GameIcon.BackgroundTransparency = 1
    GameIcon.Image = "rbxassetid://7737708774"
    GameIcon.ImageColor3 = Color3.fromRGB(100, 100, 120)
    GameIcon.Parent = GameInfo

    local GameLabel = Instance.new("TextLabel")
    GameLabel.Name = "GameLabel"
    GameLabel.Size = UDim2.new(1, -36, 0, 18)
    GameLabel.Position = UDim2.new(0, 34, 0, 7)
    GameLabel.BackgroundTransparency = 1
    GameLabel.Text = "Detecting game..."
    GameLabel.TextColor3 = Color3.fromRGB(160, 160, 180)
    GameLabel.TextSize = 12
    GameLabel.Font = Enum.Font.Gotham
    GameLabel.TextXAlignment = Enum.TextXAlignment.Left
    GameLabel.Parent = GameInfo

    -- Selection cards container
    local SelectionContainer = Instance.new("Frame")
    SelectionContainer.Name = "SelectionContainer"
    SelectionContainer.Size = UDim2.new(1, -40, 0, 160)
    SelectionContainer.Position = UDim2.new(0, 20, 0, 142)
    SelectionContainer.BackgroundTransparency = 1
    SelectionContainer.Parent = MainFrame

    -- Full Feature card
    local FullCard = Instance.new("TextButton")
    FullCard.Name = "FullCard"
    FullCard.Size = UDim2.new(0.48, 0, 1, 0)
    FullCard.Position = UDim2.new(0, 0, 0, 0)
    FullCard.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    FullCard.BorderSizePixel = 0
    FullCard.AutoButtonColor = false
    FullCard.Text = ""
    FullCard.Parent = SelectionContainer
    createCorner(12).Parent = FullCard
    createStroke(Color3.fromRGB(50, 50, 65), 1).Parent = FullCard

    local FullIcon = Instance.new("ImageLabel")
    FullIcon.Name = "FullIcon"
    FullIcon.Size = UDim2.new(0, 32, 0, 32)
    FullIcon.Position = UDim2.new(0.5, -16, 0, 20)
    FullIcon.AnchorPoint = Vector2.new(0.5, 0)
    FullIcon.BackgroundTransparency = 1
    FullIcon.Image = "rbxassetid://7737710682"
    FullIcon.ImageColor3 = Color3.fromRGB(138, 43, 226)
    FullIcon.Parent = FullCard

    local FullTitle = Instance.new("TextLabel")
    FullTitle.Name = "FullTitle"
    FullTitle.Size = UDim2.new(1, -16, 0, 18)
    FullTitle.Position = UDim2.new(0, 8, 0, 62)
    FullTitle.BackgroundTransparency = 1
    FullTitle.Text = "Full Feature"
    FullTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    FullTitle.TextSize = 14
    FullTitle.Font = Enum.Font.GothamBold
    FullTitle.Parent = FullCard

    local FullDesc = Instance.new("TextLabel")
    FullDesc.Name = "FullDesc"
    FullDesc.Size = UDim2.new(1, -16, 0, 36)
    FullDesc.Position = UDim2.new(0, 8, 0, 84)
    FullDesc.BackgroundTransparency = 1
    FullDesc.Text = "All features:\nESP, Auto Farm, Visuals, Teleport, Server Utils"
    FullDesc.TextColor3 = Color3.fromRGB(120, 120, 140)
    FullDesc.TextSize = 11
    FullDesc.Font = Enum.Font.Gotham
    FullDesc.TextWrapped = true
    FullDesc.Parent = FullCard

    local FullGradient = Instance.new("UIGradient")
    FullGradient.Color = ColorSequence.new {
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(138, 43, 226)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(75, 0, 130))
    }
    FullGradient.Rotation = 135
    FullGradient.Parent = FullCard

    -- TP Only card
    local TpCard = Instance.new("TextButton")
    TpCard.Name = "TpCard"
    TpCard.Size = UDim2.new(0.48, 0, 1, 0)
    TpCard.Position = UDim2.new(0.52, 0, 0, 0)
    TpCard.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    TpCard.BorderSizePixel = 0
    TpCard.AutoButtonColor = false
    TpCard.Text = ""
    TpCard.Parent = SelectionContainer
    createCorner(12).Parent = TpCard
    createStroke(Color3.fromRGB(50, 50, 65), 1).Parent = TpCard

    local TpIcon = Instance.new("ImageLabel")
    TpIcon.Name = "TpIcon"
    TpIcon.Size = UDim2.new(0, 32, 0, 32)
    TpIcon.Position = UDim2.new(0.5, -16, 0, 20)
    TpIcon.AnchorPoint = Vector2.new(0.5, 0)
    TpIcon.BackgroundTransparency = 1
    TpIcon.Image = "rbxassetid://7737708774"
    TpIcon.ImageColor3 = Color3.fromRGB(0, 162, 255)
    TpIcon.Parent = TpCard

    local TpTitle = Instance.new("TextLabel")
    TpTitle.Name = "TpTitle"
    TpTitle.Size = UDim2.new(1, -16, 0, 18)
    TpTitle.Position = UDim2.new(0, 8, 0, 62)
    TpTitle.BackgroundTransparency = 1
    TpTitle.Text = "Teleport Only"
    TpTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    TpTitle.TextSize = 14
    TpTitle.Font = Enum.Font.GothamBold
    TpTitle.Parent = TpCard

    local TpDesc = Instance.new("TextLabel")
    TpDesc.Name = "TpDesc"
    TpDesc.Size = UDim2.new(1, -16, 0, 36)
    TpDesc.Position = UDim2.new(0, 8, 0, 84)
    TpDesc.BackgroundTransparency = 1
    TpDesc.Text = "Lightweight:\nAuto Place, Teleport, Server Hop, Anti-AFK"
    TpDesc.TextColor3 = Color3.fromRGB(120, 120, 140)
    TpDesc.TextSize = 11
    TpDesc.Font = Enum.Font.Gotham
    TpDesc.TextWrapped = true
    TpDesc.Parent = TpCard

    local TpGradient = Instance.new("UIGradient")
    TpGradient.Color = ColorSequence.new {
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 162, 255)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 80, 180))
    }
    TpGradient.Rotation = 135
    TpGradient.Parent = TpCard

    -- Loading overlay (hidden by default)
    local LoadingOverlay = Instance.new("Frame")
    LoadingOverlay.Name = "LoadingOverlay"
    LoadingOverlay.Size = UDim2.new(1, -40, 0, 50)
    LoadingOverlay.Position = UDim2.new(0, 20, 0, 270)
    LoadingOverlay.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
    LoadingOverlay.BorderSizePixel = 0
    LoadingOverlay.Visible = false
    LoadingOverlay.Parent = MainFrame
    createCorner(10).Parent = LoadingOverlay

    local LoadingStatus = Instance.new("TextLabel")
    LoadingStatus.Name = "LoadingStatus"
    LoadingStatus.Size = UDim2.new(1, -20, 0, 16)
    LoadingStatus.Position = UDim2.new(0, 10, 0, 8)
    LoadingStatus.BackgroundTransparency = 1
    LoadingStatus.Text = "Loading..."
    LoadingStatus.TextColor3 = Color3.fromRGB(200, 200, 220)
    LoadingStatus.TextSize = 12
    LoadingStatus.Font = Enum.Font.Gotham
    LoadingStatus.TextXAlignment = Enum.TextXAlignment.Left
    LoadingStatus.Parent = LoadingOverlay

    local ProgressBG = Instance.new("Frame")
    ProgressBG.Name = "ProgressBG"
    ProgressBG.Size = UDim2.new(1, -20, 0, 4)
    ProgressBG.Position = UDim2.new(0, 10, 0, 32)
    ProgressBG.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    ProgressBG.BorderSizePixel = 0
    createCorner(2).Parent = ProgressBG

    local ProgressFill = Instance.new("Frame")
    ProgressFill.Name = "ProgressFill"
    ProgressFill.Size = UDim2.new(0, 0, 1, 0)
    ProgressFill.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    ProgressFill.BorderSizePixel = 0
    createCorner(2).Parent = ProgressFill
    ProgressFill.Parent = ProgressBG

    -- Hover animations
    local function setupCardHover(card, icon, gradient)
        local hoverTween = TweenService:Create(card, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundTransparency = 0.1
        })
        local iconTween = TweenService:Create(icon, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ImageTransparency = 0
        })

        card.MouseEnter:Connect(function()
            hoverTween:Play()
        end)
        card.MouseLeave:Connect(function()
            hoverTween:Cancel()
            TweenService:Create(card, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundTransparency = 0.05
            }):Play()
        end)
    end

    setupCardHover(FullCard, FullIcon, FullGradient)
    setupCardHover(TpCard, TpIcon, TpGradient)

    local function updateProgress(percent)
        TweenService:Create(ProgressFill, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(percent, 0, 1, 0)
        }):Play()
    end

    local function showLoading()
        LoadingOverlay.Visible = true
        SelectionContainer.Visible = false
        MainFrame.Size = UDim2.new(0, 420, 0, 230)
        MainFrame.Position = UDim2.new(0.5, -210, 0.5, -115)
    end

    local function close()
        local fadeTween = TweenService:Create(MainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        })
        fadeTween:Play()
        fadeTween.Completed:Connect(function()
            ScreenGui:Destroy()
        end)
    end

    return {
        FullCard = FullCard,
        TpCard = TpCard,
        LoadingStatus = LoadingStatus,
        updateProgress = updateProgress,
        showLoading = showLoading,
        close = close
    }
end

local function fetchScript(url)
    local cacheBuster = string.format("?v=%d&r=%d&t=%d",
        tick() * 1000,
        math.random(100000, 999999),
        os.time()
    )
    local success, result = pcall(function()
        return game:HttpGet(url .. cacheBuster, true)
    end)
    return success and result or nil
end

local function main()
    local ui = createLoaderUI()
    task.wait(0.2)

    local currentPlaceId = game.PlaceId
    local selectedGame = nil
    local gameData = nil

    for gameName, data in pairs(SUPPORTED_GAMES) do
        for _, placeId in ipairs(data.placeIds) do
            if currentPlaceId == placeId then
                selectedGame = gameName
                gameData = data
                break
            end
        end
        if selectedGame then break end
    end

    if not selectedGame then
        selectedGame = "Universal"
        gameData = { full = UNIVERSAL_SCRIPT, tpOnly = nil }
    end

    ui.LoadingStatus.Text = "Game: " .. selectedGame

    local hasTpOnly = gameData.tpOnly ~= nil
    if not hasTpOnly then
        ui.TpCard.BackgroundTransparency = 0.6
        ui.TpCard.Active = false
        ui.TpDesc.Text = "Not available for this game"
        ui.TpDesc.TextColor3 = Color3.fromRGB(80, 80, 100)
        ui.TpIcon.ImageTransparency = 0.6
    end

    local function loadScript(version)
        local scriptPath = version == "full" and gameData.full or gameData.tpOnly
        if not scriptPath then return end

        ui.showLoading()
        ui.LoadingStatus.Text = "Fetching " .. version .. " script..."
        ui.updateProgress(0.2)
        task.wait(0.2)

        local scriptUrl = GITHUB_BASE .. scriptPath
        local scriptContent = fetchScript(scriptUrl)

        if not scriptContent then
            ui.LoadingStatus.Text = "Failed to fetch script. Check connection."
            ui.updateProgress(0)
            task.wait(3)
            ui.close()
            return
        end

        ui.LoadingStatus.Text = "Loading " .. selectedGame .. " (" .. version .. ")..."
        ui.updateProgress(0.7)
        task.wait(0.2)

        local success, err = pcall(function()
            loadstring(scriptContent)()
        end)

        if success then
            ui.LoadingStatus.Text = "Loaded successfully!"
            ui.updateProgress(1)
            task.wait(1.5)
            ui.close()
        else
            ui.LoadingStatus.Text = "Error: " .. tostring(err)
            ui.updateProgress(0)
            task.wait(5)
            ui.close()
        end
    end

    ui.FullCard.MouseButton1Click:Connect(function()
        loadScript("full")
    end)

    ui.TpCard.MouseButton1Click:Connect(function()
        if hasTpOnly then
            loadScript("tpOnly")
        end
    end)
end

main()
