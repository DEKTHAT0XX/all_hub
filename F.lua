
local _ENV = getgenv()

if _ENV.Ox then return nil end
_ENV.Ox = true

local Library = {}

local Players = game:GetService('Players')
local RunService = game:GetService('RunService')
local UserInputService = game:GetService('UserInputService')
local ContentProvider = game:GetService('ContentProvider')
local TweenService = game:GetService('TweenService')
local CoreGui = game:GetService('CoreGui')

local Junkie = loadstring(game:HttpGet("https://jnkie.com/sdk/library.lua"))() do
    Junkie.service = "GG"
    Junkie.identifier = "1064541" 
    Junkie.provider = "BF"
end

local Mobile = if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then true else false

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui

function Library:Parent()
    if not RunService:IsStudio() then
        return (gethui and gethui()) or CoreGui
    end

    return PlayerGui
end

function Library:Draggable(a)
    local Dragging = nil
    local DragInput = nil
    local DragStart = nil
    local StartPosition = nil

    local function Update(input)
        local Delta = input.Position - DragStart
        local pos = UDim2.new(StartPosition.X.Scale, StartPosition.X.Offset + Delta.X, StartPosition.Y.Scale, StartPosition.Y.Offset + Delta.Y)
        local Tween = TweenService:Create(a, TweenInfo.new(0.3), {Position = pos})
        Tween:Play()
    end

    a.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            DragStart = input.Position
            StartPosition = a.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    Dragging = false
                end
            end)
        end
    end)

    a.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            DragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == DragInput and Dragging then
            Update(input)
        end
    end)
end

function Library:Tween(info)
    return TweenService:Create(info.v, TweenInfo.new(info.t, Enum.EasingStyle[info.s], Enum.EasingDirection[info.d]), info.g)
end

if not RunService:IsStudio() then
    Library.SaveKey = (function()
        local Save = {}

        local FolderName = "Xova shield"
        local FileName = FolderName .. "/key.txt"

        if not isfolder(FolderName) then
            makefolder(FolderName)
        end

        function Save:Save(key)
            if type(key) ~= "string" then
                return false
            end

            writefile(FileName, key)
            return true
        end

        function Save:Load()
            if not isfile(FileName) then
                return nil
            end

            return readfile(FileName)
        end

        function Save:Clear()
            if isfile(FileName) then
                delfile(FileName)
            end
        end

        return Save
    end)() 
end

function Library:Window()
    -- UI from UIแปลงแล้ว.txt
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = Library:Parent()
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Enabled = true
    ScreenGui.Name = "Secret"
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.IgnoreGuiInset = true

    local Frame = Instance.new("Frame")
    Frame.Parent = ScreenGui
    Frame.Visible = true
    Frame.Active = true
    Frame.Selectable = true
    Frame.AnchorPoint = Vector2.new(0.5, 0.5)
    Frame.BorderSizePixel = 0
    Frame.Size = UDim2.new(0, 350, 0, 110) -- Start small for check
    Frame.Name = "Background"
    Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
    Frame.BackgroundColor3 = Color3.fromRGB(15, 17, 21)
    
    Library:Draggable(Frame)

    local UICorner = Instance.new("UICorner")
    UICorner.Parent = Frame
    UICorner.CornerRadius = UDim.new(0, 8)

    local UIStroke = Instance.new("UIStroke")
    UIStroke.Parent = Frame
    UIStroke.Thickness = 1
    UIStroke.Color = Color3.fromRGB(201, 169, 110)
    UIStroke.Transparency = 0.5

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Parent = Frame
    TitleLabel.Size = UDim2.new(1, 0, 0, 40)
    TitleLabel.Text = "DEKTHAI"
    TitleLabel.TextColor3 = Color3.fromRGB(229, 192, 123)
    TitleLabel.TextSize = 30
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Position = UDim2.new(0, 0, 0, 0)

    local MainText = Instance.new("TextLabel")
    MainText.Parent = Frame
    MainText.Size = UDim2.new(1, 0, 0, 20)
    MainText.Text = "100% Undetect"
    MainText.TextColor3 = Color3.fromRGB(160, 164, 174)
    MainText.TextSize = 14
    MainText.Font = Enum.Font.Gotham
    MainText.BackgroundTransparency = 1
    MainText.Position = UDim2.new(0, 0, 0, 40)

    local TextBox = Instance.new("TextBox")
    TextBox.Parent = Frame
    TextBox.BackgroundColor3 = Color3.fromRGB(10, 11, 14)
    TextBox.PlaceholderText = "Paste your license key here"
    TextBox.TextSize = 11
    TextBox.Size = UDim2.new(0.7, 0, 0, 35)
    TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextBox.Font = Enum.Font.Gotham
    TextBox.Position = UDim2.new(0.05, 0, 0.45, 0)
    TextBox.Visible = false
    
    local TextBoxCorner = Instance.new("UICorner")
    TextBoxCorner.Parent = TextBox
    TextBoxCorner.CornerRadius = UDim.new(0, 8)

    local Click = Instance.new("TextButton")
    Click.Parent = Frame
    Click.BackgroundColor3 = Color3.fromRGB(229, 192, 123)
    Click.Size = UDim2.new(0, 40, 0, 35)
    Click.Text = "→"
    Click.TextColor3 = Color3.fromRGB(27, 42, 53)
    Click.Font = Enum.Font.GothamBold
    Click.Position = UDim2.new(0.78, 0, 0.45, 0)
    Click.Visible = false

    local ClickCorner = Instance.new("UICorner")
    ClickCorner.Parent = Click
    ClickCorner.CornerRadius = UDim.new(0, 8)

    local ClickGetkey = Instance.new("TextButton")
    ClickGetkey.Parent = Frame
    ClickGetkey.BackgroundColor3 = Color3.fromRGB(229, 192, 123)
    ClickGetkey.Size = UDim2.new(0, 100, 0, 30)
    ClickGetkey.Text = "คัดลอกลิ้ง"
    ClickGetkey.TextColor3 = Color3.fromRGB(27, 42, 53)
    ClickGetkey.Font = Enum.Font.GothamBold
    ClickGetkey.Position = UDim2.new(0.65, 0, 0.75, 0)
    ClickGetkey.Visible = false

    local ClickGetkeyCorner = Instance.new("UICorner")
    ClickGetkeyCorner.Parent = ClickGetkey
    ClickGetkeyCorner.CornerRadius = UDim.new(0, 8)

    -- Logic
    local function Colors(text, color)
        if type(text) == "string" and typeof(color) == "Color3" then
            local r, g, b = math.floor(color.R * 255), math.floor(color.G * 255), math.floor(color.B * 255)
            return string.format('<font color="rgb(%d, %d, %d)">%s</font>', r, g, b, text)
        end
        return text
    end

    local function ValidateAndLaunch(key)
        local validation = Junkie.check_key(key)
        
        if validation then
            print("Junkie Status: " .. tostring(validation.valid) .. " | Message: " .. tostring(validation.message))
        end

        if validation and validation.valid then
            if validation.message == "KEYLESS" then
                getgenv().SCRIPT_KEY = "KEYLESS"
                MainText.Text = "Keyless Mode"
                print("Junkie System: Keyless Mode Activated")
            else
                Library.SaveKey:Save(key)
                getgenv().SCRIPT_KEY = key
                MainText.Text = "Welcome"
                print("Junkie System: Key Verified")
            end

            TextBox.Visible = false
            Click.Visible = false
            ClickGetkey.Visible = false

            local function Finalize()
                delay(2.5, function()
                    ScreenGui:Destroy()
                    task.wait(0.5)
                    loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/67ef9920240b097d7d45d88f7490beb8f4e6b49136eaef7805ac8710f2be0c98/download"))()
                end)
            end

            if Frame.Size.Y.Offset > 110 then
                local ExpandSize_VALID = Library:Tween({
                    v = Frame,
                    t = 0.5,
                    s = "Exponential",
                    d = "Out",
                    g = {
                        Size = UDim2.new(0, 350, 0, 110)
                    }
                })
                ExpandSize_VALID.Completed:Connect(Finalize)
                ExpandSize_VALID:Play()
            else
                Finalize()
            end
            return true
        else
            if key and key ~= "" then
                Library.SaveKey:Clear()
                TextBox.Text = ""
                TextBox.PlaceholderText = "Invalid license key."
            end
            return false
        end
    end

    local initialKey = Library.SaveKey:Load() or getgenv().SCRIPT_KEY
    if ValidateAndLaunch(initialKey) then
        return
    end

    delay(2.5, function()
        local ExpandSize = Library:Tween({
            v = Frame,
            t = 0.5,
            s = "Exponential",
            d = "Out",
            g = {
                Size = UDim2.new(0, 350, 0, 200)
            }
        })

        ExpandSize.Completed:Connect(function()
            task.wait(0.1)
            TextBox.Visible = true
            Click.Visible = true
            ClickGetkey.Visible = true

            TextBox.Text = initialKey or ""
            TextBox:GetPropertyChangedSignal("Text"):Connect(function()
                getgenv().SCRIPT_KEY = TextBox.Text
            end)

            Click.MouseButton1Click:Connect(function()
                ValidateAndLaunch(getgenv().SCRIPT_KEY)
            end)

            ClickGetkey.MouseButton1Click:Connect(function()
                local link = Junkie.get_key_link()
                if link then
                    setclipboard(link)
                end
            end)
        end)

        ExpandSize:Play()
    end)
end

Library:Window()

return nil
