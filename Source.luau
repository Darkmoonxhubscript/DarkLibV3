local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local darklib = {
  Icons = loadstring(game:HttpGet("https://raw.githubusercontent.com/Darkmoonxhubscript/DarkLibV3/refs/heads/main/Icons.luau"))()
}

local Tabs = {}

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
local KeySystem = WindowConfig.KeySystem or false
local KeyTitle = WindowConfig.KeyTitle or "Key System"
local KeyDescription = WindowConfig.KeyDescription or "Description Of Key System"
local Keys = WindowConfig.Keys or {"Key1", "Key2"}
local KeyLink = WindowConfig.KeyLink or "No Link Provided"
  
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
        BackgroundColor3 = Color3.fromRGB(45, 45, 45),
        AutomaticSize = Enum.AutomaticSize.Y
    })
    Stroke(Frame2, Color3.fromRGB(200, 200, 200), 1)
    Corner(Frame2, UDim.new(0, 5))

    Create("TextLabel", Frame2, {
        Size = UDim2.new(1, -30, 0, 25),
        Font = Enum.Font.FredokaOne,
        BackgroundTransparency = 1,
        Text = Title,
        TextSize = 20,
        Position = UDim2.new(0, 10, 0, 5),
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = Color3.fromRGB(255, 255, 255)
    })

    local CloseButton = Create("TextButton", Frame2, {
        Text = "X",
        Font = Enum.Font.FredokaOne,
        TextSize = 20,
        BackgroundTransparency = 1,
        TextColor3 = Color3.fromRGB(200, 200, 200),
        Position = UDim2.new(1, -5, 0, 5),
        AnchorPoint = Vector2.new(1, 0),
        Size = UDim2.new(0, 25, 0, 25)
    })

    CloseButton.MouseButton1Click:Connect(function()
        Frame1:Destroy()
    end)

    Create("TextLabel", Frame2, {
        Size = UDim2.new(1, -30, 0, 0),
        Position = UDim2.new(0, 10, 0, 35),
        TextSize = 15,
        TextColor3 = Color3.fromRGB(200, 200, 200),
        TextXAlignment = Enum.TextXAlignment.Left,
        Text = Description,
        Font = Enum.Font.FredokaOne,
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.Y,
        TextWrapped = true
    })

    local Separator = Create("Frame", Frame2, {
        Size = UDim2.new(1, -4, 0, 2),
        BackgroundColor3 = Color3.fromRGB(55, 55, 55),
        Position = UDim2.new(0, 2, 1, -4)
    })
    Stroke(Separator, Color3.fromRGB(255, 255, 255), 0.1)
    
    Corner(Frame2, UDim.new(0, 0))
task.spawn(function()
    task.wait(Time)
    Frame1:Destroy()
    end)
end


local MainFrame = Create("Frame", ScreenGui, {
    Name = "MainFrame",
    BackgroundColor3 = Color3.fromRGB(28, 28, 28),
    Size = UDim2.new(0.5, 0, 0.6, 0),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    AnchorPoint = Vector2.new(0.5, 0.5),
    Active = true,
    BackgroundTransparency = 0
})
Corner(MainFrame, UDim.new(0.05, 0))
MakeDrag(MainFrame)

local TopBar = Create("Frame", MainFrame, {
    Name = "TopBar",
    BackgroundColor3 = Color3.fromRGB(35, 35, 35),
    Size = UDim2.new(1, 0, 0.1, 0),
    Position = UDim2.new(0, 0, 0, 0)
})
Corner(TopBar, UDim.new(0.2, 0))

local HubTitle = Create("TextLabel", TopBar, {
    Name = "Title",
    Text = Title,
    TextColor3 = Color3.new(1, 1, 1),
    Font = Enum.Font.FredokaOne,
    TextSize = 22,
    TextXAlignment = Enum.TextXAlignment.Left,
    Size = UDim2.new(0.8, 0, 1, 0),
    Position = UDim2.new(0, 10, 0, 0),
    TextWrapped = false,
    BackgroundTransparency = 1
})

local CloseButton = Create("TextButton", TopBar, {
    Name = "Close",
    Text = "X",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    Font = Enum.Font.FredokaOne,
    TextSize = 20,
    BackgroundTransparency = 1,
    Size = UDim2.new(0, 30, 0, 30),
    Position = UDim2.new(1, -30, 0, 5)
})
CloseButton.MouseButton1Click:Connect(function()
  local tween = TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {Position = UDim2.new(0, 10000, 0, 10000)})
  tween:Play()
  tween.Completed:Wait()
  ScreenGui:Destroy()
end)

local Minimized = false
local MinimizeButton = Create("TextButton", TopBar, {
    Name = "Close",
    Text = "-",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    Font = Enum.Font.FredokaOne,
    TextSize = 30,
    BackgroundTransparency = 1,
    Size = UDim2.new(0, 30, 0, 30),
    Position = UDim2.new(1, -60, 0, 2)
})
MinimizeButton.MouseButton1Click:Connect(function()
  if Minimized then
    for _, Comp in pairs(MainFrame:GetChildren()) do
        if not Comp.Name == "UICorner" and not Comp.Name == "TopBar" then
          Comp.Visible = true
          end
      end
      local tween = TweenService:Create(MainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {Size = UDim2.new(0.5, 0, 0.6, 0)})
  tween:Play()
  tween.Completed:Wait()
  MinimizeButton.Text = "-"
  local Minimized = false
    else
      for _, Comp in pairs(MainFrame:GetChildren()) do
        if not Comp.Name == "UICorner" and not Comp.Name == "TopBar" then
          Comp.Visible = false
          end
      end
      local tween = TweenService:Create(MainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {Size = UDim2.new(0.5, 0, 0, 36)})
  tween:Play()
  tween.Completed:Wait()
  MinimizeButton.Text = "+"
  local Minimized = true
    end
end)

local LeftBar = Create("Frame", MainFrame, {
    Name = "TabsBar",
    BackgroundColor3 = Color3.fromRGB(30, 30, 30),
    Size = UDim2.new(0, 176, 0.9, 0),
    Position = UDim2.new(0, 0, 0.1, 0)
})
Corner(LeftBar, UDim.new(0.05, 0))

local LeftScrollFrame = Create("ScrollingFrame", LeftBar, {
    Name = "TabsScrollFrame",
    BackgroundColor3 = Color3.fromRGB(30, 30, 30),
    BorderSizePixel = 0,
    Size = UDim2.new(1, 0, 1, 0),
    ScrollBarThickness = 0,
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
        Font = Enum.Font.FredokaOne,
        TextSize = 14,
        BackgroundColor3 = Color3.fromRGB(45, 45, 45),
        Size = UDim2.new(1, -10, 0, 30),
        TextWrapped = false,
        ClipsDescendants = true,
        TextXAlignment = Enum.TextXAlignment.Center,
        TextTruncate = "AtEnd",
        AutomaticSize = Enum.AutomaticSize.X,
        Position = UDim2.new(0, 0, 0, 0),
        AutoButtonColor = false
    })
    Corner(TabButton, UDim.new(0.3, 0))  
    
    local BagulhoAzul = Create("Frame", TabButton, {
        Position = UDim2.new(0, 3, 0, 5),
        BackgroundColor3 = Color3.fromRGB(0, 170, 255),
        Size = UDim2.new(0, 6, 0, 20),
        BackgroundTransparency = 0.8
    })
    Corner(BagulhoAzul, UDim.new(1, 0))  
    
    local TabNameLabel = Create("TextLabel", TabButton,{
        Text = TabName,
        BackgroundTransparency = 1,
        TextColor3 = Color3.fromRGB(200, 200, 200),
        Font = Enum.Font.FredokaOne,
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
        Padding = UDim.new(0, 7),
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder
    })

    Tabs[TabName] = TabFrame

    if SelectedTab == TabName then
      SetProps(TabNameLabel, {
        TextColor3 = Color3.fromRGB(240, 240, 240)
      })
        TabFrame.Visible = true
        local tween = TweenService:Create(BagulhoAzul, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {BackgroundTransparency = 0})
        tween:Play()
        TabButton.BackgroundColor3 = Color3.fromRGB(81, 81, 81)
    end

    TabButton.MouseButton1Click:Connect(function()
        for _, button in pairs(LeftScrollFrame:GetChildren()) do
            if button:IsA("TextButton") then

                local azul = button:FindFirstChild("Frame")
                if azul then
                    local tween = TweenService:Create(azul, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {BackgroundTransparency = 0.8})
                    tween:Play()
                end
                
                button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            end
        end
        
        for _, Text in pairs(LeftScrollFrame:GetDescendants()) do
            if Text:IsA("TextLabel") then
              SetProps(Text, {
        TextColor3 = Color3.fromRGB(200, 200, 200)
      })
            end
            end
        
        local tween = TweenService:Create(BagulhoAzul, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {BackgroundTransparency = 0})
        tween:Play()
        SetProps(TabNameLabel, {
        TextColor3 = Color3.fromRGB(240, 240, 240)
      })
        TabButton.BackgroundColor3 = Color3.fromRGB(81, 81, 81)

        for _, frame in pairs(Tabs) do
            frame.Visible = false
        end
        
        TabFrame.Visible = true
        SelectedTab = TabName 
    end)

    return TabFrame
end

end

return darklib
