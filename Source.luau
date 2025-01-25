local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local MarketplaceService = game:GetService("MarketplaceService")

local darklib = {
  Themes = {
    Dark = {
      ["Color Hub 1"] = ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(40, 40, 40)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(47.5, 47.5, 47.5)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(40, 40, 40))
      }),
      ["Color Hub 2"] = Color3.fromRGB(30, 30, 30),
      ["Color Hub 3"] = Color3.fromRGB(0, 170, 255),
      ["Color Hub 4"] = Color3.fromRGB(45, 45, 45),
      ["Color Hub 5"] = Color3.fromRGB(80, 80, 80),
      ["Color Hub 6"] = Color3.fromRGB(70, 70, 70),
      ["Color Hub 7"] = Color3.fromRGB(120, 120, 120),
      ["Color Stroke"] = Color3.fromRGB(40, 40, 40),
      ["Color Theme"] = Color3.fromRGB(88, 101, 0),
      ["Color Text"] = Color3.fromRGB(243, 243, 243),
      ["Color Dark Text"] = Color3.fromRGB(180, 180, 180),
      ["Color Effect"] = Color3.fromRGB(0, 170, 215)
    },
    Darker = {
      ["Color Hub 1"] = ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(20, 20, 20)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(27.5, 27.5, 27.5)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(20, 20, 20))
      }),
      ["Color Hub 2"] = Color3.fromRGB(15, 15, 15),
      ["Color Hub 3"] = Color3.fromRGB(0, 100, 200),
      ["Color Hub 4"] = Color3.fromRGB(35, 35, 35),
      ["Color Hub 5"] = Color3.fromRGB(60, 60, 60),
      ["Color Hub 6"] = Color3.fromRGB(50, 50, 50),
      ["Color Hub 7"] = Color3.fromRGB(100, 100, 100),
      ["Color Stroke"] = Color3.fromRGB(30, 30, 30),
      ["Color Theme"] = Color3.fromRGB(68, 81, 0),
      ["Color Text"] = Color3.fromRGB(220, 220, 220),
      ["Color Dark Text"] = Color3.fromRGB(150, 150, 150),
      ["Color Effect"] = Color3.fromRGB(0, 100, 180)
    },
    Purple = {
      ["Color Hub 1"] = ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(60, 0, 100)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(80, 0, 120)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(60, 0, 100))
      }),
      ["Color Hub 2"] = Color3.fromRGB(50, 0, 80),
      ["Color Hub 3"] = Color3.fromRGB(180, 0, 255),
      ["Color Hub 4"] = Color3.fromRGB(75, 0, 130),
      ["Color Hub 5"] = Color3.fromRGB(110, 0, 180),
      ["Color Hub 6"] = Color3.fromRGB(90, 0, 160),
      ["Color Hub 7"] = Color3.fromRGB(150, 50, 200),
      ["Color Stroke"] = Color3.fromRGB(70, 0, 120),
      ["Color Theme"] = Color3.fromRGB(128, 0, 255),
      ["Color Text"] = Color3.fromRGB(255, 200, 255),
      ["Color Dark Text"] = Color3.fromRGB(200, 150, 200),
      ["Color Effect"] = Color3.fromRGB(200, 0, 255)
    }
  },
  Info = {
    Version = "1.2.7",
    Theme = "Darker",
    PlaceName = MarketplaceService:GetProductInfo(game.PlaceId).Name
  },
  Icons = loadstring(game:HttpGet("https://raw.githubusercontent.com/Darkmoonxhubscript/DarkLibV3/refs/heads/main/Icons.luau"))(),
  Tabs = {}
}

function GetLibVersion()
  return darklib.Info.Version
  end

function GetLibTheme()
  return darklib.Info.Theme
end

function GetPlaceName()
  return darklib.Info.PlaceName
  end

local function SetProps(Instance, Props)
    if Props then
        for prop, value in pairs(Props) do
            Instance[prop] = value
        end
    end
    return Instance
end

local function Create(...)
    local args = {...}
    local new = Instance.new(args[1])
    local parent = args[2]
    local props = args[3]
    
    if parent then
        new.Parent = parent
    end
    if props then
        SetProps(new, props)
    end
    return new
end

local function Corner(parent, radius)
    return Create("UICorner", parent, {
        CornerRadius = radius or UDim.new(0, 5)
    })
end

local function Stroke(parent, Colorstk, Thickness)
    local new = Create("UIStroke", parent, {
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Color = Colorstk or Color3.fromRGB(120, 120, 120),
        Thickness = Thickness or 0.1
    })
    return new
end

local ViewportSize = workspace.CurrentCamera.ViewportSize
local UIScale = ViewportSize.Y / 660

function GetIcon(IconName)
  if IconName:find("rbxassetid://") or IconName:len() < 1 then return IconName end
  IconName = IconName:lower():gsub("lucide", ""):gsub("-", "")
  
  for Name, Icon in pairs(darklib.Icons) do
    Name = Name:gsub("lucide", ""):gsub("-", "")
    if Name == IconName then
      return Icon
    end
  end
  for Name, Icon in pairs(darklib.Icons) do
    Name = Name:gsub("lucide", ""):gsub("-", "")
    if Name:find(IconName) then
      return Icon
    end
  end
  return IconName
end

local function MakeDrag(Instance)
    local Dragging, DragInput, DragStart, StartPosition

    local function Update(input)
        local Delta = input.Position - DragStart
        Instance.Position = UDim2.new(
            StartPosition.X.Scale,
            StartPosition.X.Offset + Delta.X,
            StartPosition.Y.Scale,
            StartPosition.Y.Offset + Delta.Y
        )
    end

    Instance.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            DragStart = input.Position
            StartPosition = Instance.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    Dragging = false
                end
            end)
        end
    end)

    Instance.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            DragInput = input
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if input == DragInput and Dragging then
            Update(input)
        end
    end)
end

function MakeWindow(WindowConfig)
local Title = WindowConfig[1] or WindowConfig.Title or "DarkLib V3"
local SubTitle = WindowConfig[2] or WindowConfig.SubTitle or "By DarkMoonHub"
local Theme = WindowConfig[3] or WindowConfig.Theme or "Dark"
local Acrylic = WindowConfig[4] or WindowConfig.Acrylic or true
local KeySystem = WindowConfig.KeySystem.Active or false
local KeyTitle = WindowConfig.KeySystem.KeyTitle or "Key System"
local KeyDescription = WindowConfig.KeySystem.KeyDescription or "Description Of Key System"
local Keys = WindowConfig.KeySystem.Keys or {"Key1", "Key2"}
local KeyLink = WindowConfig.KeySystem.KeyLink or "No Link Provided"
  
  local GetTheme = darklib.Themes[darklib.Info.Theme]
  
  darklib.Info.Theme = tostring(Theme)
  GetTheme = darklib.Themes[darklib.Info.Theme]
  
local ScreenGui = Create("ScreenGui", CoreGui, {
    Name = "DarkLibraryV3",
    ResetOnSpawn = false
})
  Create("UIScale", ScreenGui, {
    Scale = UIScale
})

local NotifyMenu = Create("Frame", ScreenGui, {
    Size = UDim2.new(0, 300, 1, 0),
    Position = UDim2.new(1, 0, 0, 0),
    AnchorPoint = Vector2.new(1, 0),
    BackgroundTransparency = 1
})

Create("UIPadding", NotifyMenu, {
    PaddingLeft = UDim.new(0, 25),
    PaddingTop = UDim.new(0, 25),
    PaddingBottom = UDim.new(0, 50)
})

Create("UIListLayout", NotifyMenu, {
    Padding = UDim.new(0, 15),
    VerticalAlignment = Enum.VerticalAlignment.Bottom
})

------------- NOTIFICATIONS -------------

function NewNotify(Configs)
    local Title = Configs.Title or Configs.Name or Configs.Text or "Notification"
    local Description = Configs.Description or "Description"
    local Time = Configs.Time or 5

    local Frame1 = Create("Frame", NotifyMenu, {
        Size = UDim2.new(1, 0, 0, 75),
        BackgroundTransparency = 1
    })

    local Frame2 = Create("Frame", Frame1, {
        Size = UDim2.new(1, -50, 0, 75),
        BackgroundColor3 = GetTheme["Color Hub 6"],
        AutomaticSize = Enum.AutomaticSize.Y
    })
    Stroke(Frame2, GetTheme["Color Hub 5"], 3)
    Corner(Frame2, UDim.new(0, 5))

    local Title = Create("TextLabel", Frame2, {
        Size = UDim2.new(1, -38, 0, 25),
        Font = Enum.Font.GothamBold,
        BackgroundTransparency = 1,
        Text = Title,
        TextSize = 20,
        Position = UDim2.new(0, 10, 0, 5),
        TextTruncate = "SplitWord",
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = Color3.fromRGB(255, 255, 255)
    })

    local CloseButton = Create("TextButton", Frame2, {
        Text = "X",
        Font = Enum.Font.GothamBold,
        TextSize = 20,
        BackgroundTransparency = 1,
        TextTruncate = "SplitWord",
        TextColor3 = Color3.fromRGB(200, 200, 200),
        Position = UDim2.new(1, -5, 0, 5),
        AnchorPoint = Vector2.new(1, 0),
        Size = UDim2.new(0, 25, 0, 25)
    })

    CloseButton.MouseButton1Click:Connect(function()
        Frame1:Destroy()
    end)

    local Description = Create("TextLabel", Frame2, {
        Size = UDim2.new(1, -20, 0, 35),
        Position = UDim2.new(0, 10, 0, 35),
        TextSize = 15,
        TextTruncate = "SplitWord",
        TextColor3 = Color3.fromRGB(200, 200, 200),
        TextXAlignment = Enum.TextXAlignment.Left,
        Text = Description,
        Font = Enum.Font.GothamBold,
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.Y,
        TextXAlignment = "Left",
        TextYAlignment = "Top",
        TextWrapped = true
    })

    local Separator = Create("Frame", Frame2, {
        Size = UDim2.new(1, -20, 0, 2),
        BackgroundColor3 = GetTheme["Color Hub 5"],
        Position = UDim2.new(0, 10, 1, -45),
        BorderSizePixel = 0
    })
    
task.spawn(function()
    task.wait(Time)
    Frame1:Destroy()
    end)
end

------------- MAIN FRAME ------------- 

local KeyVerify = false
if KeySystem then
  local KeySystemFrame = Create("Frame", ScreenGui, {
    Name = "KeyFrame",
    BackgroundColor3 = GetTheme["Color Hub 2"],
    Size = UDim2.new(0, 400, 0, 230),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    AnchorPoint = Vector2.new(0.5, 0.5),
    Active = true,
    BackgroundTransparency = 0
  })Corner(KeySystemFrame, UDim.new(0, 10))MakeDrag(KeySystemFrame)Stroke(KeySystemFrame, GetTheme["Color Stroke"], 2)
  
  local Title = Create("TextLabel", KeySystemFrame, {
    Text = KeyTitle,
    Size = UDim2.new(0, 370, 0, 25),
    Position = UDim2.new(0, 10, 0, 5),
    TextSize = 20,
    Font = Enum.Font.GothamBold,
    BackgroundTransparency = 1,
    TextWrapped = false,
    TextTruncate = "SplitWord",
    TextColor3 = GetTheme["Color Text"],
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Center
  })
   
   local Description = Create("TextLabel", KeySystemFrame, {
    Text = KeyDescription,
    Size = UDim2.new(0, 380, 0, 70),
    Position = UDim2.new(0, 10, 0, 30),
    TextSize = 15,
    Font = Enum.Font.GothamMedium,
    BackgroundTransparency = 1,
    TextWrapped = true,
    TextTruncate = "SplitWord",
    TextColor3 = GetTheme["Color Dark Text"],
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top
  })

  local TextBox = Create("TextBox", KeySystemFrame, {
    Size = UDim2.new(0, 170, 1, -195),
    Position = UDim2.new(1, -275, 0, 100),
    ClearTextOnFocus = false,
    BackgroundColor3 = GetTheme["Color Hub 4"],
    BackgroundTransparency = 0,
    Text = "",
    TextColor3 = GetTheme["Color Text"],
    Font = Enum.Font.GothamBold,
    PlaceholderColor3 = GetTheme["Color Dark Text"],
    PlaceholderText = "Enter Key Here",
    TextScaled = true
  })
  Stroke(TextBox, GetTheme["Color Hub 5"], 2)
  Corner(TextBox)
  
  local Image = Create("ImageLabel", KeySystemFrame, {
        Image = "rbxassetid://15637081879",
        Size = UDim2.new(0, 28, 0, 28),
        Position = UDim2.new(1, -320, 0, 103),
        BackgroundTransparency = 1
    })
  
  TextBox.Focused:Connect(function()
  local tween2 = TweenService:Create(Image, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {ImageColor3 = GetTheme["Color Effect"]})
  tween2:Play()
  end)
  local ActualKey = ""
  TextBox.FocusLost:Connect(function()
    local tween4 = TweenService:Create(Image, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {ImageColor3 = Color3.fromRGB(255, 255, 255)})
  tween4:Play()
  ActualKey = TextBox.Text
  end)
  
  local CopyLink = Create("TextButton", KeySystemFrame, {
    Name = "GetKeyButton",
    Size = UDim2.new(0, 150, 0, 40),
    Position = UDim2.new(0, 30, 0, 150),
    Text = "Get Key",
    Font = Enum.Font.GothamBold,
    TextSize = 25,
    TextScaled = false,
    TextColor3 = GetTheme["Color Text"],
    BackgroundColor3 = GetTheme["Color Hub 4"],
  })Corner(CopyLink, UDim.new(0, 6))
Stroke(CopyLink, GetTheme["Color Hub 5"], 2)
  
  CopyLink.MouseButton1Click:Connect(function()
    setclipboard(tostring(KeyLink))
    end)
  
  function KeySystemSet(Value)
    KeyVerify = Value
    end
  
  local SendKey = Create("TextButton", KeySystemFrame, {
    Name = "SendKeyButton",
    Size = UDim2.new(0, 150, 0, 40),
    Position = UDim2.new(0, 220, 0, 150),
    Text = "Send Key",
    Font = Enum.Font.GothamBold,
    TextSize = 25,
    TextScaled = false,
    TextColor3 = GetTheme["Color Text"],
    BackgroundColor3 = GetTheme["Color Hub 4"],
  })Corner(SendKey, UDim.new(0, 6))
Stroke(SendKey, GetTheme["Color Hub 5"], 2)
  
  SendKey.MouseButton1Click:Connect(function()
    for _, key in pairs(Keys) do
      if key == ActualKey then
        KeySystemSet(true)
        break
        end
      end
    end)
  
  repeat task.wait() until KeyVerify
  local tween = TweenService:Create(KeySystemFrame, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {Size = UDim2.new(0, 400, 0, 10000)})
  tween:Play()
  tween.Completed:Wait()
  KeySystemFrame:Destroy()
  end


local AcrylicTrans = Acrylic and 0.1 or 0 -- Acrylic is Tranesxual Lollllllllll

local MainFrame = Create("Frame", ScreenGui, {
    Name = "MainFrame",
    BackgroundColor3 = GetTheme["Color Hub 2"],
    Size = UDim2.new(0.5, 0, 0.6, 0),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundTransparency = AcrylicTrans
})

Corner(MainFrame, UDim.new(0, 10))
MakeDrag(MainFrame)

local TopBar = Create("Frame", MainFrame, {
    Name = "TopBar",
    BackgroundColor3 = GetTheme["Color Stroke"],
    Size = UDim2.new(1, 0, 0, 36),
    BackgroundTransparency = 0.5,
    Position = UDim2.new(0, 0, 0, 0)
})
Corner(TopBar, UDim.new(0.2, 0))

local HubTitle = Create("TextLabel", TopBar, {
    Name = "Title",
    Text = Title,
    TextColor3 = GetTheme["Color Text"],
    Font = Enum.Font.GothamBold,
    TextSize = 20,
    TextXAlignment = Enum.TextXAlignment.Left,
    --Size = UDim2.new(0, 0, 1, 0),
    Position = UDim2.new(0, 15, 0.5),
    AnchorPoint = Vector2.new(0, 0.5),
    AutomaticSize = "XY",
    TextWrapped = false,
    BackgroundTransparency = 1
})

local HubSubTitle = Create("TextLabel", HubTitle, {
      Size = UDim2.fromScale(0, 1),
      AutomaticSize = "X",
      AnchorPoint = Vector2.new(0, 1),
      Position = UDim2.new(1, 5, 0.9, 5),
      Text = SubTitle,
      TextColor3 = GetTheme["Color Dark Text"],
      BackgroundTransparency = 1,
      TextXAlignment = "Left",
      TextYAlignment = "Center",
      TextSize = 11,
      Font = Enum.Font.Gotham,
      Name = "SubTitle"
})

------------- DIALOG -------------

local DialogOn = false
function MakeDialog(Configs)
  if DialogOn then
    return
    else
  local Title = Configs[1] or Configs.Title or Configs.Name or Configs.Text or " Title"
  local Description = Configs[2] or Configs.Description or "Description"
  local DialogConfigs = Configs.DialogConfigs
  local Button1Configs = DialogConfigs.Button1
  local Button2Configs = DialogConfigs.Button2
  local ButtonText1 = Button1Configs.Text or "Confirm"
  local ButtonText2 = Button2Configs.Text or "Cancel"
  local ButtonColor1 = Button1Configs.Color or Color3.fromRGB(0, 255, 0)
  local ButtonColor2 = Button2Configs.Color or Color3.fromRGB(255, 0, 0)
  local Callback1 = Button1Configs.Callback or function() print("Done") end
  local Callback2 = Button2Configs.Callback or function() CloseDialog() end
  
  local DialogBackground = Create("Frame", ScreenGui, {
    Name = "Dialog",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Size = UDim2.new(0, 0, 0, 0),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
  })Corner(DialogBackground, UDim.new(0, 20))
Create("UIGradient", DialogBackground, {
  Color = GetTheme["Color Hub 1"],
  Rotation = 260
})

local TweenOpen = TweenService:Create(DialogBackground, TweenInfo.new(0.15, Enum.EasingStyle.Linear), {Size = UDim2.new(0.3, 0, 0.5, 0)})
  TweenOpen:Play()
  TweenOpen.Completed:Wait()
  DialogOn = true

  local Title = Create("TextLabel", DialogBackground, {
    Text = Title,
    Size = UDim2.new(0, 370, 0, 25),
    Position = UDim2.new(0, 10, 0, 5),
    TextSize = 32,
    Font = Enum.Font.GothamBold,
    BackgroundTransparency = 1,
    TextWrapped = false,
    TextColor3 = GetTheme["Color Text"],
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Center
  })
   
   local Description = Create("TextLabel", DialogBackground, {
    Text = Description,
    Size = UDim2.new(0, 380, 0, 200),
    Position = UDim2.new(0, 5, 0, 30),
    TextSize = 28,
    Font = Enum.Font.GothamMedium,
    BackgroundTransparency = 1,
    TextWrapped = true,
    TextColor3 = GetTheme["Color Dark Text"],
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top
  })
   
   local YesButton = Create("TextButton", DialogBackground, {
    Text = ButtonText1,
    Size = UDim2.new(0, 150, 0, 50),
    Position = UDim2.new(0, 215, 0, 240),
    TextSize = 25,
    Font = Enum.Font.GothamBold,
    BackgroundColor3 = ButtonColor1,
    BackgroundTransparency = 0,
    TextScaled = true,
    TextColor3 = GetTheme["Color Text"],
    TextXAlignment = Enum.TextXAlignment.Center,
    TextYAlignment = Enum.TextYAlignment.Center
  })
   Corner(YesButton, UDim.new(0, 10))
   
   local NoButton = Create("TextButton", DialogBackground, {
    Text = ButtonText2,
    Size = UDim2.new(0, 150, 0, 50),
    Position = UDim2.new(0, 25, 0, 240),
    TextSize = 25,
    Font = Enum.Font.GothamBold,
    BackgroundColor3 = ButtonColor2,
    BackgroundTransparency = 0,
    TextScaled = true,
    TextColor3 = GetTheme["Color Text"],
    TextXAlignment = Enum.TextXAlignment.Center,
    TextYAlignment = Enum.TextYAlignment.Center
  })
Corner(NoButton, UDim.new(0, 10))
   
   YesButton.MouseButton1Click:Connect(function()
     Callback1()
end)

NoButton.MouseButton1Click:Connect(function()
     Callback2()
end)
   
   function CloseDialog()
     DialogOn = false
     Title:Destroy()
     Description:Destroy()
     YesButton:Destroy()
     NoButton:Destroy()
     task.wait(0.1)
  local Tween1 = TweenService:Create(DialogBackground, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {BackgroundTransparency = 1})
  Tween1:Play()
  Tween1.Completed:Wait()
  DialogBackground:Destroy()
   end
   end
end

local CloseButton = Create("TextButton", TopBar, {
    Name = "Close",
    Text = "×",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    Font = Enum.Font.GothamBold,
    TextSize = 35,
    BackgroundTransparency = 1,
    Size = UDim2.new(0, 30, 0, 30),
    Position = UDim2.new(1, -35, 0, 5)
})
CloseButton.MouseButton1Click:Connect(function()
  local CloseDialog = MakeDialog({
    Title = "Close",
    Description = "You Really Want Close This Script??",
    DialogConfigs = {
      Button1 = {
        Text = "Confirm",
        Color = GetTheme["Color Hub 2"],
        Callback = function()
          for _, Comp in pairs(MainFrame:GetChildren()) do
        if Comp.Name ~= "UICorner" then
          Comp.Visible = false
          end
      end
  local tween = TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {Position = UDim2.new(0, 10000, 0, 10000)})
  tween:Play()
  tween.Completed:Wait()
  CloseLibrary()
          end
      },
    Button2 = {
      Text = "Cancel",
      Color = GetTheme["Color Hub 2"],
      Callback = function()
          CloseDialog()
          end
    }
    }
  })
end)

local Minimized = false
local MinimizeButton = Create("TextButton", TopBar, {
    Name = "Minimize",
    Text = "-",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    Font = Enum.Font.GothamBold,
    TextSize = 30,
    BackgroundTransparency = 1,
    Size = UDim2.new(0, 30, 0, 30),
    Position = UDim2.new(1, -65, 0, 5)
})
MinimizeButton.MouseButton1Click:Connect(function()
  if Minimized then
    for _, Comp in pairs(MainFrame:GetChildren()) do
        if Comp.Name ~= "UICorner" and Comp.Name ~= "TopBar" then
          Comp.Visible = true
          end
      end
      local tween1 = TweenService:Create(MainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {Size = UDim2.new(0.5, 0, 0.6, 0)})
  tween1:Play()
  MinimizeButton.Text = "-"
  Minimized = false
    elseif not Minimized then
      for _, Comp in pairs(MainFrame:GetChildren()) do
        if Comp.Name ~= "UICorner" and Comp.Name ~= "TopBar" then
          Comp.Visible = false
          end
      end
      local tween = TweenService:Create(MainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {Size = UDim2.new(0.5, 0, 0, 36)})
  tween:Play()
  MinimizeButton.Text = "+"
  Minimized = true
    end
end)

local LeftBar = Create("Frame", MainFrame, {
    Name = "TabsBar",
    BackgroundColor3 = Color3.fromRGB(30, 30, 30),
    Size = UDim2.new(0, 176, 0.9, 0),
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 0, 0.1, 0)
})
Corner(LeftBar, UDim.new(0.05, 0))

local LeftScrollFrame = Create("ScrollingFrame", LeftBar, {
    Name = "TabsScrollFrame",
    BackgroundColor3 = Color3.fromRGB(30, 30, 30),
    BorderSizePixel = 0,
    Size = UDim2.new(1, 0, 1, 0),
    ScrollBarThickness = 0,
    BackgroundTransparency = 1,
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    CanvasSize = UDim2.new(),
    ElasticBehavior = Enum.ElasticBehavior.Never
})
Create("UIListLayout", LeftScrollFrame, {
  Padding = UDim.new(0, 8),
})

local RightScrollFrame = Create("Frame", MainFrame, {
    Name = "Containers",
    BackgroundColor3 = Color3.fromRGB(28, 28, 28),
    BorderSizePixel = 0,
    BackgroundTransparency = 0.5,
    Size = UDim2.new(0, 470, 0.9, 0),
    Position = UDim2.new(0.3, -17, 0.1, 0)
})
Corner(RightScrollFrame)

local Padding = Create("UIPadding", RightScrollFrame, {
        PaddingLeft = UDim.new(0, 7),
        PaddingRight = UDim.new(0, 7),
        PaddingTop = UDim.new(0, 7),
        PaddingBottom = UDim.new(0, 7)
    })


------------- TABS -------------

local SelectedTab = "" 
local FirstTab = nil 

function NewTab(Configs)
    local TabName = Configs.Name or Configs.Text or "Tab Name"
    local TabIcon = Configs.Icon or "Home"
    local TabButton
    local TabFrame
     
     TabIcon = GetIcon(TabIcon)
    if not TabIcon:find("rbxassetid://") or TabIcon:gsub("rbxassetid://", ""):len() < 6 then
      TabIcon = false
    end
     
    if not FirstTab then
        FirstTab = TabName
        SelectedTab = TabName  
    end
 
    TabButton = Create("TextButton", LeftScrollFrame, {
        Name = "TabButton",
        Text = "",
        TextColor3 = Color3.fromRGB(240, 240, 240),
        Font = Enum.Font.GothamMedium,
        TextSize = 14,
        BackgroundColor3 = GetTheme["Color Stroke"],
        Size = UDim2.new(1, -10, 0, 30),
        TextWrapped = false,
        ClipsDescendants = true,
        TextXAlignment = Enum.TextXAlignment.Center,
        TextTruncate = "SplitWord",
        AutomaticSize = Enum.AutomaticSize.X,
        Position = UDim2.new(0, 0, 0, 0),
        AutoButtonColor = false
    })
    Corner(TabButton, UDim.new(0.3, 0))  
    
    local BagulhoAzul = Create("Frame", TabButton, {
        Position = UDim2.new(0, 3, 0, 5),
        BackgroundColor3 = GetTheme["Color Hub 3"],
        Size = UDim2.new(0, 6, 0, 20),
        BackgroundTransparency = 0.8
    })
    Corner(BagulhoAzul, UDim.new(1, 0))  
    
    local TabNameLabel = Create("TextLabel", TabButton,{
        Text = TabName,
        BackgroundTransparency = 1,
        TextColor3 = Color3.fromRGB(200, 200, 200),
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        TextDirection = "LeftToRight",
        TextTruncate = "SplitWord",
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
        Size = UDim2.new(0, 140, 0, 20),
        Position = UDim2.new(0, 35, 0, 5)
    })
  
    local TabIcon = Create("ImageLabel", TabButton, {
        Image = TabIcon or GetIcon(Home),
        Size = UDim2.new(0, 20, 0, 20),
        Position = UDim2.new(0, 11, 0, 5),
        ImageColor3 = Color3.fromRGB(200, 200, 200),
        BackgroundTransparency = 1
    })

    TabFrame = Create("ScrollingFrame", RightScrollFrame, {
        Name = TabName,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Visible = false,  
        ScrollBarThickness = 0,
        ElasticBehavior = Enum.ElasticBehavior.Never,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        CanvasSize = UDim2.new()
    })

    Create("UIListLayout", TabFrame, {
        Padding = UDim.new(0, 8),
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder
    })

    darklib.Tabs[TabName] = TabFrame

    if SelectedTab == TabName then
      SetProps(TabNameLabel, {
        TextColor3 = Color3.fromRGB(240, 240, 240)
      })
        TabFrame.Visible = true
        local tween = TweenService:Create(BagulhoAzul, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {BackgroundTransparency = 0})
        tween:Play()
        TabButton.BackgroundColor3 = GetTheme["Color Hub 5"]
        TabIcon.ImageColor3 = GetTheme["Color Text"]
    end

    TabButton.MouseButton1Click:Connect(function()
        for _, button in pairs(LeftScrollFrame:GetChildren()) do
            if button:IsA("TextButton") then

                local azul = button:FindFirstChild("Frame")
                if azul then
                    local tween = TweenService:Create(azul, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {BackgroundTransparency = 0.8})
                    tween:Play()
                end
                
                button.BackgroundColor3 = GetTheme["Color Hub 4"]
                TabIcon.ImageColor3 = GetTheme["Color Dark Text"]
            end
        end
        
        for _, Text in pairs(LeftScrollFrame:GetDescendants()) do
            if Text:IsA("TextLabel") then
              SetProps(Text, {
        TextColor3 = GetTheme["Color Dark Text"],
      })
            end
        end
          
          for _, Img in pairs(LeftScrollFrame:GetDescendants()) do
            if Img:IsA("ImageLabel") then
              SetProps(Img, {
        ImageColor3 = GetTheme["Color Dark Text"],
      })
            end
            end
        
        local tween = TweenService:Create(BagulhoAzul, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {BackgroundTransparency = 0})
        tween:Play()
        SetProps(TabNameLabel, {
        TextColor3 = GetTheme["Color Text"]
      })
        TabButton.BackgroundColor3 = GetTheme["Color Hub 5"]
        TabIcon.ImageColor3 = GetTheme["Color Text"]

        for _, frame in pairs(darklib.Tabs) do
            frame.Visible = false
        end
        
        TabFrame.Visible = true
        SelectedTab = TabName 
    end)
    return TabFrame
end

------------- BUTTON -------------

function AddButton(Parent, Configs)
    local Name = Configs[1] or Configs.Name or Configs.Text or "Button"
    local Callback = Configs.Callback or function() print("Clicked") end
    
    local Button = Create("TextButton", Parent, {
        Name = "Button",
        Text = "",
        TextColor3 = Color3.fromRGB(240, 240, 240),
        Font = Enum.Font.GothamMedium,
        TextSize = 20,
        BackgroundColor3 = GetTheme["Color Hub 4"],
        Size = UDim2.new(0, 455, 0, 40),
        TextWrapped = false,
        Position = UDim2.new(0, 10, 0, 0),
        BorderSizePixel = 0,
        ClipsDescendants = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
        AutoButtonColor = false
    })
    Corner(Button, UDim.new(0.2, 0)) 

    local TextLabel = Create("TextLabel", Button, {
      Text = Name,
      TextColor3 = GetTheme["Color Text"],
      Font = Enum.Font.GothamBold,
      TextSize = 20,
      Size = UDim2.new(0, 408, 0, 40),
      TextWrapped = false,
      BackgroundTransparency = 1,
      Position = UDim2.new(0, 10, 0, 0),
      TextXAlignment = Enum.TextXAlignment.Left,
      TextYAlignment = Enum.TextYAlignment.Center
    })

    local Image = Create("ImageLabel", Button, {
        Image = "rbxassetid://10734898355",
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(1, -35, 0, 5),
        BackgroundTransparency = 1
    })

    Button.MouseButton1Click:Connect(function()
      Callback()
  local tween1 = TweenService:Create(TextLabel, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {TextColor3 = GetTheme["Color Effect"]})
  local tween2 = TweenService:Create(Image, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {ImageColor3 = GetTheme["Color Effect"]})
  tween1:Play()
  tween2:Play()
  tween1.Completed:Wait()
  local tween3 = TweenService:Create(TextLabel, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {TextColor3 = Color3.fromRGB(240, 240, 240)})
  local tween4 = TweenService:Create(Image, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {ImageColor3 = Color3.fromRGB(255, 255, 255)})
  tween3:Play()
  tween4:Play()
    end)

    return {
      Button = Button,
      TextLabel = TextLabel
    }
end

function DestroyButton(Button)
  local Button = Button
  Button.Button:Destroy()
  end

function EditButtonText(Button, Text)
  SetProps(Button.TextLabel, {
    Text = tostring(Text)
  })
end

------------- SECTION -------------

function AddSection(Parent, Configs)
    local Name = Configs[1] or Configs.Name or Configs.Text or Configs.Title or "Section"
    
    local SectionLabel = Create("TextLabel", Parent, {
        Name = "Section",
        Size = UDim2.new(0, 455, 0, 20),
        Position = UDim2.new(0, 0, 0, 0),
        Text = Name,
        Font = Enum.Font.GothamBold,
        TextColor3 = GetTheme["Color Text"],
        TextSize = 22,
        BackgroundTransparency = 1,
        TextWrapped = false,
        TextTruncate = "SplitWord",
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center
    })

    return {
      SectionLabel = SectionLabel
    }
end

function DestroySection(Section)
  local Section = Section
Section.SectionLabel:Destroy()
end

function EditSectionText(Section, Text)
  local Section = Section
    SetProps(Section.SectionLabel, {
      Text = tostring(Text)
    })
end

------------- TEXTLABEL -------------

function AddTextLabel(Parent, Configs)
    local Name = Configs[1] or Configs.Name or Configs.Text or Configs.Title or "TextLabel"
    
    local TextFrame = Create("Frame", Parent, {
        Name = "TextLabel",
        Size = UDim2.new(0, 455, 0, 30),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = GetTheme["Color Hub 4"],
        BackgroundTransparency = 0
    })
    Corner(TextFrame, UDim.new(0.2, 0)) 

    local TextLabel = Create("TextLabel", TextFrame, {
        Size = UDim2.new(0, 440, 0, 30),
        Position = UDim2.new(0, 10, 0, 0),
        Text = Name,
        Font = Enum.Font.GothamBold,
        TextColor3 = GetTheme["Color Text"],
        TextSize = 20,
        BackgroundTransparency = 1,
        TextWrapped = false,
        TextTruncate = "SplitWord",
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center
    })

    return {
      TextFrame = TextFrame,
      TextLabel = TextLabel
    }
end

function DestroyTextLabel(TextLabel)
  local TextLabel = TextLabel
TextLabel.TextFrame:Destroy()
end

function EditTextLabelText(TextLabel, Text)
  local TextLabel = TextLabel
  SetProps(TextLabel.TextLabel, {
    Text = tostring(Text)
  })
end

------------- PARAGRAPH -------------

function AddParagraph(Parent, Configs)
    local Name = Configs[1] or Configs.Name or Configs.Text or Configs.Title or "My Title"
    local Description = Configs[2] or Configs.Description or Configs.SubText or Configs.SubName or Configs.SubTitle or "My Paragraph"
    
    local ParagraphFrame = Create("Frame", Parent, {
        Name = "Paragraph",
        Size = UDim2.new(0, 455, 0, 80),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = GetTheme["Color Hub 4"],
        BackgroundTransparency = 0
    })
    Corner(ParagraphFrame, UDim.new(0.1, 0)) 

    local ParagraphLabel1 = Create("TextLabel", ParagraphFrame, {
        Size = UDim2.new(0, 435, 0, 20),
        Position = UDim2.new(0, 10, 0, 5),
        Text = Name,
        Font = Enum.Font.GothamBold,
        TextColor3 = GetTheme["Color Text"],
        TextSize = 20,
        BackgroundTransparency = 1,
        TextWrapped = false,
        TextTruncate = "SplitWord",
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top
    })
  
  local ParagraphLabel2 = Create("TextLabel", ParagraphFrame, {
        Size = UDim2.new(0, 435, 0, 50),
        Position = UDim2.new(0, 10, 0, 25),
        Text = Description,
        Font = Enum.Font.GothamMedium,
        TextColor3 = GetTheme["Color Dark Text"],
        TextSize = 17,
        BackgroundTransparency = 1,
        TextWrapped = true,
        TextTruncate = "SplitWord",
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center
    })

    return {
      ParagraphFrame = ParagraphFrame,
      ParagraphLabel1 = ParagraphLabel1,
      ParagraphLabel2 = ParagraphLabel2
    }
end

function DestroyParagraph(TextLabel)
  local TextLabel = TextLabel
TextLabel.TextFrame:Destroy()
end

function EditParagraphTitle(Paragraph, Text)
  local Paragraph = Paragraph
  SetProps(Paragraph.ParagraphLabel1, {
    Text = tostring(Text)
  })
end

function EditParagraphDescription(Paragraph, Text)
  local Paragraph = Paragraph
  SetProps(Paragraph.ParagraphLabel2, {
    Text = tostring(Text)
  })
end

------------- TOGGLE -------------

function AddToggle(Parent, Configs)
    local Name = Configs[1] or Configs.Name or Configs.Text or Configs.Title or "Toggle"
    local Default = Configs[2] or Configs.Default or false
    local Callback = Configs[3] or Configs.Callback or function() end

if Default == nil or Default == "nil" then
  Default = false
end

    local ToggleFrame1 = Create("Frame", Parent, {
        Name = "Toggle",
        Size = UDim2.new(0, 455, 0, 40),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = GetTheme["Color Hub 4"],
        BackgroundTransparency = 0
    })
    Corner(ToggleFrame1, UDim.new(0.2, 0))

    
    local ToggleFrame2 = Create("Frame", ToggleFrame1, {
        Size = UDim2.new(0, 60, 0, 28),
        Position = UDim2.new(1, -70, 0, 6),
        BackgroundColor3 = GetTheme["Color Hub 6"],
        BackgroundTransparency = 1
    })
    local Stroke1 = Stroke(ToggleFrame2, GetTheme["Color Hub 6"], 3)
    Corner(ToggleFrame2, UDim.new(2, 0))

    local ToggleActive = Create("Frame", ToggleFrame1, {
        Size = UDim2.new(0, 18, 0, 18),
        Position = UDim2.new(0.1, 345, 1, -11),
        AnchorPoint = Vector2.new(0, 1),
        BackgroundColor3 = GetTheme["Color Hub 5"],
        BackgroundTransparency = 0,
        BorderMode = "Middle",
        BorderSizePixel = 1
        
    })
    local Stroke2 = Stroke(ToggleActive, GetTheme["Color Hub 5"], 2.8)
    Corner(ToggleActive, UDim.new(5, 0))

local TextToggle = Create("TextLabel", ToggleFrame1, {
        Text = Name,
        TextColor3 = GetTheme["Color Text"],
        Font = Enum.Font.GothamBold,
        TextSize = 20,
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 350, 0, 40),
        Position = UDim2.new(0, 10, 0, 0),
        BorderSizePixel = 0,
        ClipsDescendants = true,
        TextTruncate = "SplitWord",
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center
    })

    local ToggleButtonArea = Create("TextButton", ToggleFrame1, {
        Text = "",
        Size = UDim2.new(0, 60, 0, 28),
        Position = UDim2.new(1, -70, 0, 6),
        BackgroundTransparency = 1
    })

    local ToggleState = false

    ToggleButtonArea.MouseButton1Click:Connect(function()
        if ToggleState then
          SetProps(Stroke1, {
        Color = GetTheme["Color Hub 6"]
      })
    SetProps(Stroke2, {
        Color = GetTheme["Color Hub 5"]
      })
    SetProps(ToggleActive, {
      BackgroundColor3 = GetTheme["Color Hub 5"]
    })
          local tween = TweenService:Create(ToggleActive, TweenInfo.new(0.15, Enum.EasingStyle.Linear), {Position = UDim2.new(0.1, 345, 1, -11)})
          tween:Play()
          tween.Completed:Wait()
            ToggleState = false
        elseif not ToggleState then
          SetProps(Stroke1, {
        Color = GetTheme["Color Hub 3"]
      })
    SetProps(Stroke2, {
        Color = GetTheme["Color Hub 3"]
      })
    SetProps(ToggleActive, {
      BackgroundColor3 = GetTheme["Color Hub 3"]
    })
          local tween = TweenService:Create(ToggleActive, TweenInfo.new(0.15, Enum.EasingStyle.Linear), {Position = UDim2.new(1, -33, 1, -11)})
          tween:Play()
          tween.Completed:Wait()
            ToggleState = true
        end
        Callback(ToggleState)
    end)

if Default then
      SetProps(Stroke1, {
        Color = GetTheme["Color Hub 3"]
      })
    SetProps(Stroke2, {
        Color = GetTheme["Color Hub 3"]
      })
    SetProps(ToggleActive, {
      BackgroundColor3 = GetTheme["Color Hub 3"]
    })
      local tween = TweenService:Create(ToggleActive, TweenInfo.new(0.15, Enum.EasingStyle.Linear), {Position = UDim2.new(1, -33, 1, -11)})
          tween:Play()
          tween.Completed:Wait()
        ToggleState = true
        Callback(ToggleState)
    end

    return {
      ToggleFrame1 = ToggleFrame1,
      TextToggle = TextToggle
    }
end

function DestroyToggle(Toggle)
  local Toggle = Toggle
Toggle.ToggleFrame1:Destroy()
end

function EditToggleText(Toggle, Text)
  local Toggle = Toggle
  SetProps(Toggle.TextToggle, {
    Text = tostring(Text)
  })
end

------------- TEXT BOX -------------

function AddTextBox(Parent, Configs)
  local Name = Configs[1] or Configs.Name or Configs.Text or "TextBox"
  local Default = Configs[2] or Configs.Default or ""
  local AutoClear = Configs[3] or Configs.AutoClear or false
  local PlaceHolder = Configs[4] or Configs.PlaceHolder or "Input"
  local Callback = Configs[5] or Configs.Callback or function() end
  
  if Default == nil or Default == "nil" then
  Default = ""
end

  local TextBoxFrame = Create("Frame", Parent, {
        Name = "TextBox",
        Size = UDim2.new(0, 455, 0, 40),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = GetTheme["Color Hub 4"],
        BackgroundTransparency = 0
    })
    Corner(TextBoxFrame, UDim.new(0.2, 0))
     
     local TextBoxText = Create("TextLabel", TextBoxFrame, {
        Text = Name,
        TextColor3 = Color3.fromRGB(240, 240, 240),
        Font = Enum.Font.GothamBold,
        TextSize = 20,
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 250, 0, 25),
        Position = UDim2.new(0, 10, 0, 8),
        BorderSizePixel = 0,
        ClipsDescendants = true,
        TextTruncate = "SplitWord",
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center
    })
  
  local TextBox = Create("TextBox", TextBoxFrame, {
    Size = UDim2.new(0, 120, 1, -10),
    Position = UDim2.new(1, -130, 0, 5),
    ClearTextOnFocus = AutoClear,
    BackgroundColor3 = GetTheme["Color Hub 5"],
    BackgroundTransparency = 0,
    Text = Default,
    TextColor3 = GetTheme["Color Text"],
    Font = Enum.Font.GothamBold,
    PlaceholderColor3 = GetTheme["Color Dark Text"],
    PlaceholderText = PlaceHolder,
    TextScaled = true
  })
  Stroke(TextBox, GetTheme["Color Stroke"], 2)
  Corner(TextBox)
  
  local Image = Create("ImageLabel", TextBoxFrame, {
        Image = "rbxassetid://15637081879",
        Size = UDim2.new(0, 25, 0, 25),
        Position = UDim2.new(1, -165, 0, 8),
        BackgroundTransparency = 1
    })
  
  Callback(Default)
  TextBox.Focused:Connect(function()
  local tween2 = TweenService:Create(Image, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {ImageColor3 = GetTheme["Color Effect"]})
  tween2:Play()
  end)
  
  TextBox.FocusLost:Connect(function()
    local tween4 = TweenService:Create(Image, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {ImageColor3 = Color3.fromRGB(255, 255, 255)})
  tween4:Play()
    Callback(TextBox.Text)
  end)
     return {
       TextBoxFrame = TextBoxFrame,
       TextBoxText = TextBoxText,
       TextBox = TextBox
     }
  end

function DestroyTextBox(TextBox)
  local TextBox = TextBox
TextBox.TextBoxFrame:Destroy()
end

function EditTextBoxText(TextBox, Text)
  local TextBox = TextBox
  SetProps(TextBox.TextBoxText, {
    Text = tostring(Text)
  })
end

function EditTextBoxInputText(TextBox, Text)
  local TextBox = TextBox
  SetProps(TextBox.TextBox, {
    Text = tostring(Text)
  })
end

function EditTextBoxPlaceholder(TextBox, Text)
  local TextBox = TextBox
  SetProps(TextBox.TextBox, {
    PlaceholderText = tostring(Text)
  })
end

------------- SLIDER -------------

function AddSlider(Parent, Configs)
    local Name = Configs[1] or Configs.Name or Configs.Text or "Slider"
    local Min = Configs[2] or Configs.Min or 0
    local Max = Configs[3] or Configs.Max or 100
    local Increase = Configs[4] or Configs.Increase or 1
    local Default = Configs[5] or Configs.Default or 20
    local Callback = Configs[6] or Configs.Callback or function() end

if Default == nil or Default == "nil" then
  Default = 20
end

    local function SnapToIncrease(value)
        return math.floor(value / Increase + 0.5) * Increase
    end

    Default = math.clamp(SnapToIncrease(Default), Min, Max)
   local defaultPosition = (Default - Min) / (Max - Min)

   Min, Max = Min / Increase, Max / Increase

    local SliderFrame = Create("Frame", Parent, {
        Name = "Slider",
        Size = UDim2.new(0, 455, 0, 40),
        BackgroundColor3 = GetTheme["Color Hub 4"]
    })
    Corner(SliderFrame, UDim.new(0.2, 0))

    local SliderLabel = Create("TextLabel", SliderFrame, {
        Text = Name,
        Size = UDim2.new(1, -230, 0, 25),
        Position = UDim2.new(0, 10, 0, 8),
        Font = Enum.Font.GothamBold,
        TextColor3 = GetTheme["Color Text"],
        BackgroundTransparency = 1,
        TextSize = 20,
        TextTruncate = "SplitWord",
        TextXAlignment = Enum.TextXAlignment.Left,
    })
  
  local SliderValueLabelFrameBackground = Create("Frame", SliderFrame, {
    Size = UDim2.new(1, -410, 0, 25),
    Position = UDim2.new(0, 240, 0, 8),
    BorderSizePixel = 0,
    BackgroundColor3 = GetTheme["Color Stroke"]
  })Corner(SliderValueLabelFrameBackground, UDim.new(0, 7))
Stroke(SliderValueLabelFrameBackground, GetTheme["Color Hub 5"], 2)

    local SliderValueLabel = Create("TextLabel", SliderValueLabelFrameBackground, {
        Text = tostring(Default),
        Size = UDim2.new(1, -90, 0, 25),
        Position = UDim2.new(0, 46, 0, 0),
        Font = Enum.Font.Gotham,
        TextColor3 = GetTheme["Color Text"],
        BackgroundTransparency = 1,
        TextSize = 20,
        TextScaled = true,
        TextTruncate = "SplitWord",
        TextDirection = "RightToLeft"
    })

    local SliderBarBackground = Create("Frame", SliderFrame, {
        Size = UDim2.new(1, -305, 0, 8),
        Position = UDim2.new(0, 295, 0, 16),
        BackgroundColor3 = GetTheme["Color Hub 5"]
    })
    Corner(SliderBarBackground)

    local SliderBar = Create("Frame", SliderBarBackground, {
        Size = UDim2.fromScale((Default - Min) / (Max - Min), 1),
        BackgroundColor3 = GetTheme["Color Hub 3"]
    })
    Corner(SliderBar)

    local SliderButton = Create("Frame", SliderBarBackground, {
        Size = UDim2.new(0, 10, 0, 24),
        Position = UDim2.fromScale((Default - Min) / (Max - Min), 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    })
    Corner(SliderButton)

    local function UpdateSliderValue(position)
        local scaledValue = math.clamp(position, 0, 1)
        local newValue = math.floor((scaledValue * (Max - Min)) + Min)
        newValue = SnapToIncrease(newValue)

        SliderButton.Position = UDim2.new(scaledValue, 0, 0.5, 0)
        SliderBar.Size = UDim2.new(scaledValue, 0, 1, 0)
        SliderValueLabel.Text = tostring(newValue * Increase)
        Callback(newValue * Increase)
    end

    local defaultPosition = (Default - Min) / (Max - Min)
    UpdateSliderValue(defaultPosition)

local dragging = false

    SliderButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            local connection
            connection = UIS.InputChanged:Connect(function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    local relativePosition = (input.Position.X - SliderBarBackground.AbsolutePosition.X) / SliderBarBackground.AbsoluteSize.X
                    UpdateSliderValue(relativePosition)
                    local tween1 = TweenService:Create(SliderValueLabel, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {Rotation = math.random(-15, 15)})
                    tween1:Play()
                    tween1.Completed:Wait()
                    local tween2 = TweenService:Create(SliderValueLabel, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {Rotation = 0})
                    tween2:Play()
                end
            end)
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                    connection:Disconnect()
                end
            end)
        end
    end)

    return {
        SliderFrame = SliderFrame,
        SliderLabel = SliderLabel,
        SliderValueLabel = SliderValueLabel,
        Min = Min,
        Max = Max,
        Increase = Increase,
        Func = UpdateSliderValue
    }
end


function DestroySlider(Slider)
  local Slider = Slider
Slider.SliderFrame:Destroy()
end

function EditSliderText(Slider, Text)
  local Slider = Slider
  SetProps(Slider.SliderLabel, {
    Text = tostring(Text)
  })
end

function EditSliderValue(Slider, Value)
  local Slider = Slider
  local Min = Slider.Min
  local Max = Slider.Max
  local NewValue = (Value - Min) / (Max - Min)
  
  Slider.Func(NewValue)
  SetProps(Slider.SliderValueLabel, {
    Text = tostring(Value)
  })
end

------------- DROPDOWN -------------

function AddDropDown(Parent, Configs)
    local Name = Configs[1] or Configs.Name or Configs.Text or Configs.Title or "Dropdown"
    local Options = Configs[2] or Configs.Options or {"1", "2"}
    local MultiSelect = Configs[3] or Configs.MultiSelect or false
    local Default = Configs[4] or Configs.Default or "1"
    local Callback = Configs[5] or Configs.Callback or function() end
   
   local OpcoesAtuais = {}
   
   local OpcoesClicadas = {}
   
   if Default == nil or Default == "nil" then
  Default = "1"
end
   
    local DropdownFrame = Create("Frame", Parent, {
        Name = "Dropdown",
        Size = UDim2.new(0, 455, 0, 40),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = GetTheme["Color Hub 4"],
        BackgroundTransparency = 0
    })
    Corner(DropdownFrame, UDim.new(0, 10))
    
    local DropButton = Create("TextButton", DropdownFrame, {
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(1, -40, 0, 5),
        BackgroundColor3 = GetTheme["Color Hub 4"],
        BackgroundTransparency = 1,
        Text = ""
    })
    
    local DropDownText1 = Create("TextLabel", DropdownFrame, {
        Size = UDim2.new(1, -210, 0, 25),
        Position = UDim2.new(0, 10, 0, 8),
        Text = Name,
        Font = Enum.Font.GothamBold,
        TextColor3 = GetTheme["Color Text"],
        TextSize = 20,
        BackgroundTransparency = 1,
        TextWrapped = false,
        TextTruncate = "SplitWord",
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center
    })
  
  local DropDownText2Frame = Create("Frame", DropdownFrame, {
        Size = UDim2.new(0, 150, 0, 30),
        Position = UDim2.new(0, 260, 0, 5),
        BackgroundColor3 = GetTheme["Color Hub 5"],
        BackgroundTransparency = 0
    })Corner(DropDownText2Frame)
  
    local DropDownText2 = Create("TextLabel", DropdownFrame, {
        Size = UDim2.new(0, 150, 0, 30),
        Position = UDim2.new(0, 260, 0, 5),
        Text = Default,
        Font = Enum.Font.GothamMedium,
        TextColor3 = GetTheme["Color Text"],
        TextSize = 15,
        BackgroundTransparency = 1,
        TextScaled = true,
        TextDirection = "RightToLeft",
        TextXAlignment = Enum.TextXAlignment.Center,
        TextYAlignment = Enum.TextYAlignment.Center
    })
    
    --[[local Bagulho1 = Create("Frame", DropdownFrame, {
    Size = UDim2.new(1, 0, 0, 0),
    Position = UDim2.new(0, 0, 0, 37),
    Visible = false
  })Stroke(Bagulho1, Color3.fromRGB(120, 120, 120), 1)]]
  
  local ListDrop = Create("ScrollingFrame", DropdownFrame, {
    Name = "listdrop",
    Size = UDim2.new(1, -4, 1, -41),
    Position = UDim2.new(0, 2, 1, 0),
    AnchorPoint = Vector2.new(0, 1),
    Visible = false,
    BackgroundTransparency = 1,
    BackgroundColor3 = Color3.fromRGB(100, 100, 100),
    ScrollingDirection = "Y",
    ElasticBehavior = "Never",
    ScrollBarThickness = 0,
    AutomaticCanvasSize = "Y",
    CanvasSize = UDim2.new(0, 0, 0, 0)
  })
    
   local Setinha = Create("ImageLabel", DropdownFrame, {
     Image = "rbxassetid://6031090990",
     Size = UDim2.new(0, 30, 0, 30),
     Position = UDim2.new(1, -40, 0, 5),
     BackgroundTransparency = 1
   })
 
 local Padding = Create("UIPadding", ListDrop, {
    PaddingLeft = UDim.new(0, 10),
    PaddingRight = UDim.new(0, 10),
    PaddingTop = UDim.new(0, 5),
    PaddingBottom = UDim.new(0, 0)
  })
 
 local ListLayout = Create("UIListLayout", ListDrop, {
    Padding = UDim.new(0, 5)
  })
 
   local function AddOption(Name)
    local NewOption = Create("TextButton", ListDrop, {
        Name = "Option",
        Size = UDim2.new(1, 0, 0, 20),
        Text = "",
        TextSize = 15,
        Font = Enum.Font.GothamBold,
        TextColor3 = GetTheme["Color Text"],
        BackgroundTransparency = 0.5,
        TextXAlignment = "Left",
        AutoButtonColor = false,
        BackgroundColor3 = GetTheme["Color Hub 6"],
    })
    Corner(NewOption)
    
    local TextLabel = Create("TextLabel", NewOption, {
        Name = "OptionTextLabel",
        Size = UDim2.new(0, 415, 0, 20),
        Position = UDim2.new(0, 12, 0, 0),
        Text = Name,
        TextSize = 15,
        Font = Enum.Font.GothamBold,
        TextColor3 = GetTheme["Color Dark Text"],
        BackgroundTransparency = 1,
        TextXAlignment = "Left",
        TextWrapped = false,
        TextTruncate = "SplitWord"
    })
    
    local BagulhoAzul = Create("Frame", NewOption, {
        Name = "BagulhoAzul",
        Position = UDim2.new(0, 3, 0, 2),
        BackgroundColor3 = GetTheme["Color Hub 3"],
        Size = UDim2.new(0, 5, 0, 16),
        BackgroundTransparency = 0.7
    })
    Corner(BagulhoAzul)
    
    if TextLabel.Text == Default then
      if MultiSelect then
        table.insert(OpcoesClicadas, NewOption)
        print(OpcoesClicadas)
        end
        local tween5 = TweenService:Create(BagulhoAzul, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {BackgroundTransparency = 0})
        tween5:Play()
        TextLabel.TextColor3 = GetTheme["Color Text"]
        NewOption.BackgroundColor3 = GetTheme["Color Hub 7"]
        Callback(Default)
        TextLabel.Text = Default
    end
    
    NewOption.MouseButton1Click:Connect(function()
      if not MultiSelect then
        for _, v in pairs(ListDrop:GetChildren()) do
            if v.Name == "Option" then
                local tween1 = TweenService:Create(v.BagulhoAzul, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {BackgroundTransparency = 0.7})
                tween1:Play()
                v.OptionTextLabel.TextColor3 = GetTheme["Color Dark Text"]
                v.BackgroundColor3 = GetTheme["Color Hub 6"]
            end
        end

        local tween2 = TweenService:Create(BagulhoAzul, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {BackgroundTransparency = 0})
        tween2:Play()

        Callback(TextLabel.Text)
        TextLabel.TextColor3 = GetTheme["Color Text"]
        NewOption.BackgroundColor3 = GetTheme["Color Hub 7"]
        DropDownText2.Text = TextLabel.Text
        
      elseif MultiSelect then
        print(OpcoesClicadas)
    if table.find(OpcoesClicadas, NewOption) then
        if #OpcoesClicadas > 1 then
            for i, option in ipairs(OpcoesClicadas) do
                if option == NewOption then
                    table.remove(OpcoesClicadas, i)
                    break
                end
            end
            
            local tween1 = TweenService:Create(NewOption.BagulhoAzul, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {BackgroundTransparency = 0.7})
            tween1:Play()
            TextLabel.TextColor3 = GetTheme["Color Dark Text"]
            NewOption.BackgroundColor3 = GetTheme["Color Hub 6"]
        end
    else
        table.insert(OpcoesClicadas, NewOption)
        local tween2 = TweenService:Create(NewOption.BagulhoAzul, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {BackgroundTransparency = 0})
        tween2:Play()
        TextLabel.TextColor3 = GetTheme["Color Text"]
        NewOption.BackgroundColor3 = GetTheme["Color Hub 7"]
    end
    
    local selectedText = ""
    if #OpcoesClicadas < 1 and MultiSelect then
        selectedText = "None"
        DropDownText2.Text = selectedText
    else
        for _, option in ipairs(OpcoesClicadas) do
            selectedText = selectedText .. option:FindFirstChild("OptionTextLabel").Text .. ", "
        end
        DropDownText2.Text = string.sub(selectedText, 1, -3)
    end
    Callback(DropDownText2.Text)
end

    end)

    local isUnique = true
    for _, V in pairs(OpcoesAtuais) do
        if Name == V then
            isUnique = false
            break
        end
    end

    if isUnique then
        table.insert(OpcoesAtuais, Name)
        ListDrop.CanvasSize = ListDrop.CanvasSize + UDim2.new(0, 0, 0, 25)
    end
end

 
   for i = 1, #Options do
     AddOption(Options[i])
     end
    
    local DropdownOn = false
   DropButton.MouseButton1Click:Connect(function()
     local frameSize = UDim2.new(0, 455, 0, 100)
    for i,v in pairs(ListDrop:GetChildren()) do
      if v.Name == "Option" and i <= 7 then
        FrameSizeNew = frameSize + UDim2.new(0, 0, 0, 35)
      end
    end
    if DropdownOn == false then
      DropdownOn = true
      --Bagulho1.Visible = DropdownOn
      ListDrop.Visible = DropdownOn
      local tween1 = TweenService:Create(DropdownFrame, TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {Size = FrameSizeNew})
      local tween2 = TweenService:Create(Setinha, TweenInfo.new(0.2), {Rotation = 180})
      tween1:Play()tween2:Play()
    else
      DropdownOn = false
      local tween1 = TweenService:Create(DropdownFrame, TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {Size = UDim2.new(0, 455, 0, 40)})
      local tween2 = TweenService:Create(Setinha, TweenInfo.new(0.2), {Rotation = 0})
      tween1:Play()tween2:Play()tween1.Completed:Wait()
      --Bagulho1.Visible = DropdownOn
      ListDrop.Visible = DropdownOn
    end
  end)
  ListDrop.CanvasSize = ListDrop.CanvasSize + UDim2.new(0, 0, 0, 10)
  
  function RefreshDropdown(Dropdown, NewOptions)
    for _, v in pairs(Dropdown.listdrop:GetChildren()) do
        if v.Name == "Option" then
            v:Destroy()
        end
    end
    
    OpcoesAtuais = {}
    ListDrop.CanvasSize = UDim2.new(0, 0, 0, 0)

    for i = 1, #NewOptions do
        AddOption(NewOptions[i])  
        table.insert(OpcoesAtuais, NewOptions[i])
    end
    
end

   return DropdownFrame
end


------------- EXTRA FUNCTIONS -------------

function AddMinimizeButton(Configs)
  local ImageId = Configs[1] or Configs.Icon or Configs.Logo or "10734897102"
  
  if ImageId == nil or ImageId == "nil" then
  ImageId = "10734897102"
end
  
  if not ImageId:find("rbxassetid://") then
       ImageId = "rbxassetid://" .. ImageId
       end
  
  local MinimizeButton = Create("ImageButton", ScreenGui, {
    Image = ImageId,
    AnchorPoint = Vector2.new(0, 0),
    Size = UDim2.new(0, 50, 0, 50),
    Position = UDim2.new(0, 117, 0, 68),
    BackgroundTransparency = 0.1,
    BackgroundColor3 = GetTheme["Color Hub 5"],
    Visible = true,
    AutoButtonColor = false
  })Stroke(MinimizeButton)
Corner(MinimizeButton, UDim.new(0, 9))
MakeDrag(MinimizeButton)
  
  local MinimizeButtonState = true
  MinimizeButton.MouseButton1Click:Connect(function()
    if MinimizeButtonState then
      local tweenClose = TweenService:Create(MainFrame, TweenInfo.new(0.15, Enum.EasingStyle.Linear), {Size = UDim2.new(0, 0, 0, 0)})
  tweenClose:Play()
  tweenClose.Completed:Wait()
      SetProps(MainFrame, {
        Visible = false
      })
      MinimizeButtonState = false
      else
        SetProps(MainFrame, {
        Visible = true
      })
        MinimizeButtonState = true
        local tweenOpen = TweenService:Create(MainFrame, TweenInfo.new(0.15, Enum.EasingStyle.Linear), {Size = UDim2.new(0.5, 0, 0.6, 0)})
  tweenOpen:Play()
  tweenOpen.Completed:Wait()
end
end)
  return MinimizeButton
end

function AddFloatToggle(Configs)
  local Name = Configs[1] or Configs.Name or Configs.Text or "Toggle"
  local Callback = Configs[2] or Configs.Callback or function() end
  
  local FloatToggle = Create("Frame", ScreenGui, {
    Size = UDim2.new(0, 100, 0, 60),
    Position = UDim2.new(0.8, 0, 0.8, 0),
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = GetTheme["Color Hub 5"],
    Draggable = true,
    Active = true,
    Visible = true,
  })Corner(FloatToggle)
   MakeDrag(FloatToggle)
  
  local TextLabel = Create("TextLabel", FloatToggle, {
    Size = UDim2.new(1, 0, 0, 20),
    TextSize = 20,
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.fromRGB(240, 240, 240),
    Text = Name,
    BackgroundTransparency = 1,
    TextScaled = true,
  })
  
  local Button = Create("TextButton", FloatToggle, {
    Size = UDim2.new(1, 0, 0, 40),
    Position = UDim2.new(0, 0, 0, 20),
    BackgroundTransparency = 1,
    Text = ""
  })
  
  local Frame = Create("Frame", Button, {
    Position = UDim2.new(0.5, 0, 0.5, 0),
    AnchorPoint = Vector2.new(0.5, 0.5),
    Size = UDim2.new(1, -40, 1, -15),
    BackgroundTransparency = 1
  })Corner(Frame, UDim.new(2, 0))
  
  local Frame2 = Create("Frame", Frame, {
    Position = UDim2.new(0, 5, 0.5, 0),
    AnchorPoint = Vector2.new(0, 0.5),
    Size = UDim2.new(0, 17, 0, 17),
    BackgroundTransparency = 1
  })Corner(Frame2, UDim.new(5, 0))
  
  Stroke(Frame, GetTheme["Color Hub 6"], 1)
  Stroke(Frame2, GetTheme["Color Hub 5"], 1)
  
  local OnOff = false
  Callback(OnOff)
  Button.MouseButton1Click:Connect(function()
    if OnOff == false then
      TweenService:Create(Frame2, TweenInfo.new(0.2, Enum.EasingStyle.Linear),
      {Position = UDim2.new(1, -22, 0.5, 0)}):Play()
    else
      TweenService:Create(Frame2, TweenInfo.new(0.2, Enum.EasingStyle.Linear),
      {Position = UDim2.new(0, 5, 0.5, 0)}):Play()
    end
    OnOff = not OnOff
    Callback(OnOff)
  end)
  
  return FloatToggle
end

function AddDiscordInvite(Parent, Configs)
  local Name = Configs[1] or Configs.Name or Configs.Text or "DarkMoonHub Community"
  local Description = Configs[2] or Configs.Description or "Join our discord community to receive information about the next update"
  local Logo = Configs[3] or Configs.Logo or Configs.Icon or "10734897102"
  local Invite = Configs[4] or Configs.Invite or "https://discord.gg/YDXM43cBU6"
  
  if not Logo:find("rbxassetid://") then
       Logo = "rbxassetid://" .. Logo
       end
  
  local DiscordInviteFrame = Create("Frame", Parent, {
        Name = "DiscordInvite",
        Size = UDim2.new(0, 455, 0, 120),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = GetTheme["Color Hub 4"],
        BackgroundTransparency = 0,
    })
    Corner(DiscordInviteFrame, UDim.new(0, 10))

    local ServerName = Create("TextLabel", DiscordInviteFrame, {
        Name = "ServerName",
        Size = UDim2.new(0, 380, 0, 20),
        Position = UDim2.new(0, 10, 0, 1),
        Text = Name,
        Font = Enum.Font.GothamBold,
        TextColor3 = Color3.fromRGB(243, 243, 243),
        TextSize = 20,
        BackgroundTransparency = 1,
        TextTruncate = "SplitWord",
        TextWrapped = false,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center
    })
  
  local Description = Create("TextLabel", DiscordInviteFrame, {
        Name = "Description",
        Size = UDim2.new(0, 370, 0, 40),
        Position = UDim2.new(0, 80, 0, 20),
        Text = Description,
        Font = Enum.Font.Gotham,
        TextTruncate = "SplitWord",
        TextColor3 = Color3.fromRGB(180, 180, 180),
        TextSize = 20,
        BackgroundTransparency = 1,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center
    })
  
  local ServerInviteLink = Create("TextLabel", DiscordInviteFrame, {
        Name = "ServerInviteLink",
        Size = UDim2.new(0, 370, 0, 20),
        Position = UDim2.new(0, 80, 0, 60),
        Text = Invite,
        TextTruncate = "SplitWord",
        Font = Enum.Font.FredokaOne,
        TextColor3 = Color3.fromRGB(40, 150, 255),
        TextSize = 20,
        BackgroundTransparency = 1,
        TextWrapped = false,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center
    })
  
  local ServerIcon = Create("ImageLabel", DiscordInviteFrame, {
     Name = "ServerIcon",
     Image = Logo,
     Size = UDim2.new(0, 55, 0, 55),
     Position = UDim2.new(1, -440, 0, 23),
     BackgroundTransparency = 1
   })Corner(ServerIcon, UDim.new(0, 4))Stroke(ServerIcon, GetTheme["Color Hub 5"], 2)
  
  local JoinButton = Create("TextButton", DiscordInviteFrame, {
    Name = "JoinButton",
    Size = UDim2.new(1, -14, 0, 30),
    AnchorPoint = Vector2.new(0.5, 1),
    Position = UDim2.new(0.5, 0, 1, -7),
    Text = "Join Server",
    Font = Enum.Font.Gotham,
    TextSize = 12,
    TextScaled = true,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundColor3 = Color3.fromRGB(50, 150, 50),
    AutoButtonColor = false
  })Corner(JoinButton, UDim.new(0, 6))
  
  local ClickDelay
      JoinButton.Activated:Connect(function()
        setclipboard(Invite)
        if ClickDelay then return end
        
        ClickDelay = true
        SetProps(JoinButton, {
          Text = "Copied to Clipboard!",
          BackgroundColor3 = Color3.fromRGB(100, 100, 100),
          TextColor3 = Color3.fromRGB(150, 150, 150)
        })task.wait(5)
        SetProps(JoinButton, {
          Text = "Join Server",
          BackgroundColor3 = Color3.fromRGB(50, 150, 50),
          TextColor3 = Color3.fromRGB(255, 255, 225)
        })ClickDelay = false
      end)
      
      return DiscordInviteFrame
end

function AddImageLabel(Parent, Configs)
    local Icon = Configs[1] or Configs.Logo or Configs.Icon or "10734897102"
    local Style = Configs[2] or Configs.Style or "Square"

    local Styles = {
        Big = UDim2.new(0, 450, 0, 110),
        Banner = UDim2.new(0, 450, 0, 50),
        Square = UDim2.new(0, 227, 0, 227)
    }

    if not Icon:find("rbxassetid://") then
        Icon = "rbxassetid://" .. Icon
    end

    local Mode = Styles[Style] or Styles.Square

    local ImageLabel = Create("ImageLabel", Parent, {
        Name = "ImageLabel",
        Image = Icon,
        Size = Mode,
        Position = UDim2.new(1, -440, 0, 23),
        BackgroundTransparency = 1
    })

    Corner(ImageLabel, UDim.new(0, 4))
    Stroke(ImageLabel, GetTheme["Color Hub 5"], 2)

    return ImageLabel
end

function SetVisible(Object, Value)
  SetProps(Object, {
    Visible = Value
  })
end

function CloseLibrary()
  ScreenGui:Destroy()
end

end -- Window Close



-- RETURN DARKLIB TABLE (DON'T REMOVE)
return darklib
