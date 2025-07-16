--[[ Roblox Universal GUI Library (Executor-Compatible) ]]--

-- Initialization
local lib = {}
local sections = {}
local workareas = {}
local notifs = {}
local visible = true
local dbcooper = false

-- Tween utility
local function tp(ins, pos, time)
    game:GetService("TweenService"):Create(ins, TweenInfo.new(time, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {Position = pos}):Play()
end

-- UI Initialization
function lib:init(titleText, showSplash, toggleKey, removeOld)
    local player = game.Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")

    if removeOld and playerGui:FindFirstChild("ScreenGui") then
        tp(playerGui.ScreenGui.main, playerGui.ScreenGui.main.Position + UDim2.new(0, 0, 2, 0), 0.5)
        game:GetService("Debris"):AddItem(playerGui.ScreenGui, 1)
    end

    local scrgui = Instance.new("ScreenGui")
    scrgui.ResetOnSpawn = false
    scrgui.Name = "ScreenGui"
    scrgui.Parent = playerGui

    -- Main GUI container
    local main = Instance.new("Frame")
    main.Name = "main"
    main.Size = UDim2.new(0, 600, 0, 400)
    main.Position = UDim2.new(0.5, 0, 0.5, 0)
    main.AnchorPoint = Vector2.new(0.5, 0.5)
    main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    main.BorderSizePixel = 0
    main.Parent = scrgui

    local uicorner = Instance.new("UICorner", main)
    uicorner.CornerRadius = UDim.new(0, 12)

    local title = Instance.new("TextLabel", main)
    title.Size = UDim2.new(1, 0, 0, 50)
    title.BackgroundTransparency = 1
    title.Text = titleText or "GUI Library"
    title.TextColor3 = Color3.fromRGB(0, 0, 0)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 24

    -- Toggle visibility keybind
    local window = {}
    function window:ToggleVisible()
        if dbcooper then return end
        visible = not visible
        dbcooper = true
        if visible then
            tp(main, UDim2.new(0.5, 0, 0.5, 0), 0.5)
        else
            tp(main, main.Position + UDim2.new(0, 0, 2, 0), 0.5)
        end
        task.wait(0.5)
        dbcooper = false
    end

    if toggleKey then
        game:GetService("UserInputService").InputBegan:Connect(function(input, gp)
            if not gp and input.KeyCode == toggleKey then
                window:ToggleVisible()
            end
        end)
    end

    return window
end

-- Example usage
local myGUI = lib:init("My Universal GUI", true, Enum.KeyCode.RightShift, true)
