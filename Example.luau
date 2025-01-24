  loadstring(game:HttpGet("https://raw.githubusercontent.com/Darkmoonxhubscript/DarkLibV3/refs/heads/main/Source.luau"))()
  
  local Window = MakeWindow({
    Title = "DarkLib V3",
    SubTitle = "By DarkMoonHub",
    Theme = "Purple",
    Acrylic = true,
    KeySystem = {
    Active = false,
    KeyTitle = "Key System",
    KeyDescription = "Key System Description",
    Keys = {"Key1", "Key2", "Key3"},
    KeyLink = "pastebin.com/"
    }
  })

AddMinimizeButton({
  Icon = GetIcon("moon")
})
  
  local Notify = NewNotify({
    Title = "Notification",
    Description = "Script Loaded!.",
    Time = 10
  })
  
  local Tab1 = NewTab({Name = "My Tab 1", Icon = "home"})
  local Tab2 = NewTab({Name = "My Long Tab 2", Icon = "sword"})
  local Tab3 = NewTab({Name = "My Very Extreme Long Tab 3", Icon = "swords"})
  
  local Image1 = AddImageLabel(Tab1, {
    Icon = "",
    Style = "Square"
  })

  local Section1 = AddSection(Tab1, {Text = "Old Section Text"})
  
  local TextLabel1 = AddTextLabel(Tab1, {Text = "TextLabel"})
  
  local Paragraph1 = AddParagraph(Tab1, {
    Title = "My Super Hyper Mega Big Paragraph",
    Description = "My Hyper Mega Super Giant Gigantic Big Description To My Beautiful and Beautiful Big Paragraph That Must Be Beautifully Beautiful Like Me!"
  })
  
  local Button1 = AddButton(Tab1, {
    Name = "Button 1",
    Callback = function()
      EditSectionText(Section1, "New Section Text")
    end
    })
  
  local Toggle1 = AddToggle(Tab1, {
    Name = "Toggle Test",
    Default = false,
    Callback = function(Value)
    print(Value)
    end
  })
  
  local TextBox1 = AddTextBox(Tab1, {
    Name = "TextBox Test",
    NumberOnly = true,
    Default = "",
    AutoClear = false,
    PlaceHolder = "Input",
    Callback = function(Value)
      print(Value)
      end
  })
  
  local Slider1 = AddSlider(Tab1, {
    Name = "Slider Test",
    Min = 0,
    Max = 1,
    Increase = 0.1,
    Default = 0.5,
    Callback = function(Value)
      local Notify2 = NewNotify({
    Title = "Notification",
    Description = "Slider Value Changed: " .. Value,
    Time = 10
  })
      end
  })

local Dropdown1 = AddDropDown(Tab1, {
  Name = "Dropdown Test",
  Options = {"Option1", "Option2", "Option3", "Option4", "Option5", "Option6", "Option7", "Option8", "Option9", "Option10"},
  MultiSelect = true,
  Default = "Option2",
  Callback = function(Value)
    print(Value)
    end
})

local ServerInvite1 = AddDiscordInvite(Tab1, {
  Name = "DarkMoonHub Community",
  Description = "Join our discord community to receive information about the next update",
  Logo = GetIcon("moon"),
  Invite = "https://discord.gg/YDXM43cBU6",
})
