local GITHUB_BASE = "https://raw.githubusercontent.com/Bagah-Project/bagah-hub-public/main"

local SUPPORTED_GAMES = {
    ["Evade"] = {
        full = "/games/evade/main.lua",
        farmOnly = "/games/evade/farmonly.lua",
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
        farmOnly = nil,
        placeIds = { 96537472072550 }
    },
}

local UNIVERSAL_SCRIPT = "/universal/main.lua"

local function createLoaderUI()
    local Players = game:GetService("Players")
    local TweenService = game:GetService("TweenService")
    local UserInputService = game:GetService("UserInputService")
    local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

    -- Theme colors
    local THEME = {
        bg       = Color3.fromRGB(16, 17, 23),
        surface  = Color3.fromRGB(22, 24, 32),
        surface2 = Color3.fromRGB(28, 30, 40),
        stroke   = Color3.fromRGB(45, 48, 62),
        text     = Color3.fromRGB(240, 240, 245),
        subtext  = Color3.fromRGB(140, 142, 160),
        muted    = Color3.fromRGB(95, 97, 115),
        primary  = Color3.fromRGB(140, 90, 245),
        primary2 = Color3.fromRGB(90, 60, 210),
        accent   = Color3.fromRGB(70, 170, 255),
        accent2  = Color3.fromRGB(40, 110, 220),
        danger   = Color3.fromRGB(240, 90, 100),
    }

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "BagahHubLoader"
    ScreenGui.DisplayOrder = 999
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.Parent = PlayerGui

    local function corner(parent, radius)
        local c = Instance.new("UICorner")
        c.CornerRadius = UDim.new(0, radius or 10)
        c.Parent = parent
        return c
    end

    local function stroke(parent, color, thickness, transparency)
        local s = Instance.new("UIStroke")
        s.Color = color or THEME.stroke
        s.Thickness = thickness or 1
        s.Transparency = transparency or 0
        s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        s.Parent = parent
        return s
    end

    local function padding(parent, all)
        local p = Instance.new("UIPadding")
        p.PaddingTop = UDim.new(0, all)
        p.PaddingBottom = UDim.new(0, all)
        p.PaddingLeft = UDim.new(0, all)
        p.PaddingRight = UDim.new(0, all)
        p.Parent = parent
        return p
    end

    local Backdrop = Instance.new("Frame")
    Backdrop.Name = "Backdrop"
    Backdrop.Size = UDim2.new(1, 0, 1, 0)
    Backdrop.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Backdrop.BackgroundTransparency = 1
    Backdrop.BorderSizePixel = 0
    Backdrop.Parent = ScreenGui

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.Size = UDim2.new(0, 320, 0, 260)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.BackgroundColor3 = THEME.bg
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    corner(MainFrame, 14)
    stroke(MainFrame, THEME.stroke, 1, 0.2)


    local BgGradient = Instance.new("UIGradient")
    BgGradient.Color = ColorSequence.new {
        ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 22, 48)),
        ColorSequenceKeypoint.new(0.5, THEME.bg),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(18, 24, 38))
    }
    BgGradient.Rotation = 135
    BgGradient.Parent = MainFrame


    local Header = Instance.new("Frame")
    Header.Name = "Header"
    Header.Size = UDim2.new(1, -24, 0, 40)
    Header.Position = UDim2.new(0, 12, 0, 12)
    Header.BackgroundTransparency = 1
    Header.Parent = MainFrame

    local LogoHolder = Instance.new("Frame")
    LogoHolder.Size = UDim2.new(0, 32, 0, 32)
    LogoHolder.Position = UDim2.new(0, 0, 0.5, -16)
    LogoHolder.BackgroundColor3 = THEME.primary
    LogoHolder.BorderSizePixel = 0
    LogoHolder.Parent = Header
    corner(LogoHolder, 8)

    local LogoGradient = Instance.new("UIGradient")
    LogoGradient.Color = ColorSequence.new {
        ColorSequenceKeypoint.new(0, THEME.primary),
        ColorSequenceKeypoint.new(1, THEME.accent)
    }
    LogoGradient.Rotation = 135
    LogoGradient.Parent = LogoHolder

    local LogoIcon = Instance.new("TextLabel")
    LogoIcon.Size = UDim2.new(1, 0, 1, 0)
    LogoIcon.BackgroundTransparency = 1
    LogoIcon.Text = "B"
    LogoIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
    LogoIcon.TextSize = 18
    LogoIcon.Font = Enum.Font.GothamBold
    LogoIcon.Parent = LogoHolder

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -80, 0, 18)
    TitleLabel.Position = UDim2.new(0, 42, 0, 2)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = "BagahHub"
    TitleLabel.TextColor3 = THEME.text
    TitleLabel.TextSize = 15
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = Header

    local SubtitleLabel = Instance.new("TextLabel")
    SubtitleLabel.Size = UDim2.new(1, -80, 0, 14)
    SubtitleLabel.Position = UDim2.new(0, 42, 0, 20)
    SubtitleLabel.BackgroundTransparency = 1
    SubtitleLabel.Text = "Select version"
    SubtitleLabel.TextColor3 = THEME.subtext
    SubtitleLabel.TextSize = 11
    SubtitleLabel.Font = Enum.Font.Gotham
    SubtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    SubtitleLabel.Parent = Header


    local CloseButton = Instance.new("TextButton")
    CloseButton.Size = UDim2.new(0, 26, 0, 26)
    CloseButton.Position = UDim2.new(1, -26, 0.5, -13)
    CloseButton.BackgroundColor3 = THEME.surface
    CloseButton.BorderSizePixel = 0
    CloseButton.AutoButtonColor = false
    CloseButton.Text = "X"
    CloseButton.TextColor3 = THEME.subtext
    CloseButton.TextSize = 13
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Parent = Header
    corner(CloseButton, 7)

    CloseButton.MouseEnter:Connect(function()
        TweenService:Create(CloseButton, TweenInfo.new(0.12), {
            BackgroundColor3 = THEME.danger,
            TextColor3 = Color3.fromRGB(255, 255, 255)
        }):Play()
    end)
    CloseButton.MouseLeave:Connect(function()
        TweenService:Create(CloseButton, TweenInfo.new(0.12), {
            BackgroundColor3 = THEME.surface,
            TextColor3 = THEME.subtext
        }):Play()
    end)


    local Divider = Instance.new("Frame")
    Divider.Size = UDim2.new(1, -24, 0, 1)
    Divider.Position = UDim2.new(0, 12, 0, 58)
    Divider.BackgroundColor3 = THEME.stroke
    Divider.BackgroundTransparency = 0.4
    Divider.BorderSizePixel = 0
    Divider.Parent = MainFrame


    local GameInfo = Instance.new("Frame")
    GameInfo.Name = "GameInfo"
    GameInfo.Size = UDim2.new(1, -24, 0, 28)
    GameInfo.Position = UDim2.new(0, 12, 0, 68)
    GameInfo.BackgroundColor3 = THEME.surface
    GameInfo.BorderSizePixel = 0
    GameInfo.Parent = MainFrame
    corner(GameInfo, 7)

    local GameDot = Instance.new("Frame")
    GameDot.Size = UDim2.new(0, 6, 0, 6)
    GameDot.Position = UDim2.new(0, 10, 0.5, -3)
    GameDot.BackgroundColor3 = Color3.fromRGB(80, 220, 120)
    GameDot.BorderSizePixel = 0
    GameDot.Parent = GameInfo
    corner(GameDot, 3)

    local GameLabel = Instance.new("TextLabel")
    GameLabel.Size = UDim2.new(1, -28, 1, 0)
    GameLabel.Position = UDim2.new(0, 22, 0, 0)
    GameLabel.BackgroundTransparency = 1
    GameLabel.Text = "Detecting game..."
    GameLabel.TextColor3 = THEME.subtext
    GameLabel.TextSize = 11
    GameLabel.Font = Enum.Font.GothamMedium
    GameLabel.TextXAlignment = Enum.TextXAlignment.Left
    GameLabel.Parent = GameInfo


    local SelectionContainer = Instance.new("Frame")
    SelectionContainer.Name = "SelectionContainer"
    SelectionContainer.Size = UDim2.new(1, -24, 0, 136)
    SelectionContainer.Position = UDim2.new(0, 12, 0, 104)
    SelectionContainer.BackgroundTransparency = 1
    SelectionContainer.Parent = MainFrame

    local function createCard(props)
        local card = Instance.new("TextButton")
        card.Name = props.name
        card.Size = UDim2.new(0.5, -4, 1, 0)
        card.Position = props.position
        card.BackgroundColor3 = THEME.surface
        card.BorderSizePixel = 0
        card.AutoButtonColor = false
        card.Text = ""
        card.Parent = SelectionContainer
        corner(card, 10)
        local cardStroke = stroke(card, THEME.stroke, 1, 0.3)


        local iconHolder = Instance.new("Frame")
        iconHolder.Size = UDim2.new(0, 34, 0, 34)
        iconHolder.Position = UDim2.new(0.5, -17, 0, 14)
        iconHolder.BackgroundColor3 = props.color1
        iconHolder.BorderSizePixel = 0
        iconHolder.Parent = card
        corner(iconHolder, 9)

        local grad = Instance.new("UIGradient")
        grad.Color = ColorSequence.new {
            ColorSequenceKeypoint.new(0, props.color1),
            ColorSequenceKeypoint.new(1, props.color2)
        }
        grad.Rotation = 135
        grad.Parent = iconHolder

        local icon = Instance.new("TextLabel")
        icon.Size = UDim2.new(1, -8, 1, -8)
        icon.Position = UDim2.new(0, 4, 0, 4)
        icon.BackgroundTransparency = 1
        icon.Text = props.iconText
        icon.TextColor3 = Color3.fromRGB(255, 255, 255)
        icon.TextScaled = true
        icon.Font = Enum.Font.GothamBold
        icon.Parent = iconHolder

        local iconConstraint = Instance.new("UITextSizeConstraint")
        iconConstraint.MaxTextSize = 18
        iconConstraint.MinTextSize = 10
        iconConstraint.Parent = icon

        -- Title
        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, -12, 0, 16)
        title.Position = UDim2.new(0, 6, 0, 54)
        title.BackgroundTransparency = 1
        title.Text = props.title
        title.TextColor3 = THEME.text
        title.TextSize = 12
        title.Font = Enum.Font.GothamBold
        title.Parent = card

        -- Description
        local desc = Instance.new("TextLabel")
        desc.Name = "Desc"
        desc.Size = UDim2.new(1, -12, 0, 44)
        desc.Position = UDim2.new(0, 6, 0, 74)
        desc.BackgroundTransparency = 1
        desc.Text = props.desc
        desc.TextColor3 = THEME.muted
        desc.TextSize = 10
        desc.Font = Enum.Font.Gotham
        desc.TextWrapped = true
        desc.Parent = card

        -- Hover effects
        card.MouseEnter:Connect(function()
            TweenService:Create(card, TweenInfo.new(0.15), {
                BackgroundColor3 = THEME.surface2
            }):Play()
            TweenService:Create(cardStroke, TweenInfo.new(0.15), {
                Color = props.color1,
                Transparency = 0
            }):Play()
        end)
        card.MouseLeave:Connect(function()
            TweenService:Create(card, TweenInfo.new(0.15), {
                BackgroundColor3 = THEME.surface
            }):Play()
            TweenService:Create(cardStroke, TweenInfo.new(0.15), {
                Color = THEME.stroke,
                Transparency = 0.3
            }):Play()
        end)

        return {
            button = card,
            icon = icon,
            iconHolder = iconHolder,
            title = title,
            desc = desc,
            stroke = cardStroke,
        }
    end

    local FullCardData = createCard({
        name = "FullCard",
        position = UDim2.new(0, 0, 0, 0),
        color1 = THEME.primary,
        color2 = THEME.primary2,
        iconText = "★",
        title = "Full Feature",
        desc = "ESP, Auto Farm,\nVisuals, Teleport",
    })

    local TpCardData = createCard({
        name = "TpCard",
        position = UDim2.new(0.5, 4, 0, 0),
        color1 = THEME.accent,
        color2 = THEME.accent2,
        iconText = "F",
        title = "Farm Only",
        desc = "Lightweight,\nAuto Farm, Vote, VIP",
    })


    local LoadingOverlay = Instance.new("Frame")
    LoadingOverlay.Name = "LoadingOverlay"
    LoadingOverlay.Size = UDim2.new(1, -24, 0, 136)
    LoadingOverlay.Position = UDim2.new(0, 12, 0, 104)
    LoadingOverlay.BackgroundColor3 = THEME.surface
    LoadingOverlay.BorderSizePixel = 0
    LoadingOverlay.Visible = false
    LoadingOverlay.Parent = MainFrame
    corner(LoadingOverlay, 10)

    -- Spinner
    local SpinnerHolder = Instance.new("Frame")
    SpinnerHolder.Size = UDim2.new(0, 36, 0, 36)
    SpinnerHolder.Position = UDim2.new(0.5, -18, 0, 22)
    SpinnerHolder.BackgroundTransparency = 1
    SpinnerHolder.Parent = LoadingOverlay

    local Spinner = Instance.new("ImageLabel")
    Spinner.Size = UDim2.new(1, 0, 1, 0)
    Spinner.BackgroundTransparency = 1
    Spinner.Image = "rbxassetid://4965945816" 
    Spinner.ImageColor3 = THEME.primary
    Spinner.Parent = SpinnerHolder


    local SpinnerRing = Instance.new("Frame")
    SpinnerRing.Size = UDim2.new(1, 0, 1, 0)
    SpinnerRing.BackgroundTransparency = 1
    SpinnerRing.Parent = SpinnerHolder
    corner(SpinnerRing, 18)
    local ringStroke = Instance.new("UIStroke")
    ringStroke.Thickness = 3
    ringStroke.Color = THEME.primary
    ringStroke.Transparency = 0
    ringStroke.Parent = SpinnerRing
    local ringGradient = Instance.new("UIGradient")
    ringGradient.Transparency = NumberSequence.new {
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(0.5, 0.5),
        NumberSequenceKeypoint.new(1, 1),
    }
    ringGradient.Parent = ringStroke
    Spinner.Visible = false 

    task.spawn(function()
        while SpinnerHolder.Parent do
            ringGradient.Rotation = (ringGradient.Rotation + 8) % 360
            task.wait(0.02)
        end
    end)

    local LoadingStatus = Instance.new("TextLabel")
    LoadingStatus.Name = "LoadingStatus"
    LoadingStatus.Size = UDim2.new(1, -20, 0, 16)
    LoadingStatus.Position = UDim2.new(0, 10, 0, 70)
    LoadingStatus.BackgroundTransparency = 1
    LoadingStatus.Text = "Loading..."
    LoadingStatus.TextColor3 = THEME.text
    LoadingStatus.TextSize = 12
    LoadingStatus.Font = Enum.Font.GothamMedium
    LoadingStatus.TextXAlignment = Enum.TextXAlignment.Center
    LoadingStatus.Parent = LoadingOverlay

    local LoadingHint = Instance.new("TextLabel")
    LoadingHint.Size = UDim2.new(1, -20, 0, 14)
    LoadingHint.Position = UDim2.new(0, 10, 0, 88)
    LoadingHint.BackgroundTransparency = 1
    LoadingHint.Text = "Please wait..."
    LoadingHint.TextColor3 = THEME.subtext
    LoadingHint.TextSize = 10
    LoadingHint.Font = Enum.Font.Gotham
    LoadingHint.TextXAlignment = Enum.TextXAlignment.Center
    LoadingHint.Parent = LoadingOverlay

    local ProgressBG = Instance.new("Frame")
    ProgressBG.Name = "ProgressBG"
    ProgressBG.Size = UDim2.new(1, -24, 0, 3)
    ProgressBG.Position = UDim2.new(0, 12, 1, -14)
    ProgressBG.BackgroundColor3 = THEME.stroke
    ProgressBG.BorderSizePixel = 0
    ProgressBG.Parent = LoadingOverlay
    corner(ProgressBG, 2)

    local ProgressFill = Instance.new("Frame")
    ProgressFill.Name = "ProgressFill"
    ProgressFill.Size = UDim2.new(0, 0, 1, 0)
    ProgressFill.BackgroundColor3 = THEME.primary
    ProgressFill.BorderSizePixel = 0
    ProgressFill.Parent = ProgressBG
    corner(ProgressFill, 2)

    local FillGradient = Instance.new("UIGradient")
    FillGradient.Color = ColorSequence.new {
        ColorSequenceKeypoint.new(0, THEME.primary),
        ColorSequenceKeypoint.new(1, THEME.accent)
    }
    FillGradient.Parent = ProgressFill


    local Footer = Instance.new("TextLabel")
    Footer.Size = UDim2.new(1, -24, 0, 12)
    Footer.Position = UDim2.new(0, 12, 1, -18)
    Footer.BackgroundTransparency = 1
    Footer.Text = "v2.0  •  bagah-hub"
    Footer.TextColor3 = THEME.muted
    Footer.TextSize = 9
    Footer.Font = Enum.Font.Gotham
    Footer.TextXAlignment = Enum.TextXAlignment.Right
    Footer.Parent = MainFrame


    local dragging, dragStart, startPos
    local function beginDrag(input)
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end

    Header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            beginDrag(input)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)


    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    MainFrame.BackgroundTransparency = 1
    TweenService:Create(Backdrop, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0.5
    }):Play()
    TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 320, 0, 260),
        BackgroundTransparency = 0
    }):Play()


    local function updateProgress(percent)
        TweenService:Create(ProgressFill, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(percent, 0, 1, 0)
        }):Play()
    end

    local function setStatus(text, hint)
        LoadingStatus.Text = text
        if hint then LoadingHint.Text = hint end
    end

    local function showLoading()
        SelectionContainer.Visible = false
        LoadingOverlay.Visible = true
        CloseButton.Visible = false
    end

    local close
    close = function()
        local fadeTween = TweenService:Create(MainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 1
        })
        TweenService:Create(Backdrop, TweenInfo.new(0.2), {
            BackgroundTransparency = 1
        }):Play()
        fadeTween:Play()
        fadeTween.Completed:Connect(function()
            ScreenGui:Destroy()
        end)
    end

    CloseButton.MouseButton1Click:Connect(close)

    return {
        FullCard = FullCardData.button,
        TpCard = TpCardData.button,
        TpIcon = TpCardData.icon,
        TpIconHolder = TpCardData.iconHolder,
        TpDesc = TpCardData.desc,
        TpTitle = TpCardData.title,
        GameLabel = GameLabel,
        GameDot = GameDot,
        setStatus = setStatus,
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
        gameData = { full = UNIVERSAL_SCRIPT, farmOnly = nil }
    end

    ui.GameLabel.Text = selectedGame

    local hasFarmOnly = gameData.farmOnly ~= nil
    if not hasFarmOnly then
        ui.TpCard.BackgroundTransparency = 0.4
        ui.TpCard.Active = false
        ui.TpDesc.Text = "Not available"
        ui.TpDesc.TextColor3 = Color3.fromRGB(70, 72, 90)
        ui.TpTitle.TextColor3 = Color3.fromRGB(120, 122, 140)
        ui.TpIconHolder.BackgroundTransparency = 0.6
        ui.TpIcon.ImageTransparency = 0.5
    end

    local function loadScript(version)
        if not gameData then return end
        local scriptPath = version == "full" and gameData.full or gameData.farmOnly
        if not scriptPath then return end

        ui.showLoading()
        ui.setStatus("Fetching script...", "Connecting to GitHub")
        ui.updateProgress(0.25)
        task.wait(0.2)

        local scriptUrl = "https://raw.githubusercontent.com/Bagah-Project/bagah-hub-public/main" .. scriptPath
        local scriptContent = fetchScript(scriptUrl)

        if not scriptContent then
            ui.setStatus("Fetch failed", "Check your connection")
            ui.updateProgress(0)
            task.wait(3)
            ui.close()
            return
        end

        ui.setStatus("Loading " .. selectedGame, version == "full" and "Full feature script" or "Farm only script")
        ui.updateProgress(0.75)
        task.wait(0.2)

        local success, err = pcall(function()
            loadstring(scriptContent)()
        end)

        if success then
            ui.setStatus("Loaded successfully!", "Have fun")
            ui.updateProgress(1)
            task.wait(1.2)
            ui.close()
        else
            ui.setStatus("Error", tostring(err))
            ui.updateProgress(0)
            task.wait(5)
            ui.close()
        end
    end

    ui.FullCard.MouseButton1Click:Connect(function()
        loadScript("full")
    end)

    ui.TpCard.MouseButton1Click:Connect(function()
        if hasFarmOnly then
            loadScript("farmOnly")
        end
    end)
end

main()
