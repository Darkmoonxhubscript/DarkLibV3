# DarkLib V3 Tutorial
Introducing the DarkLib UI Library, a Roblox Exploit UI Library created just for fun! Feel free to modify it as you wish, and using our library has already helped us a lot! You can check out an example code **[Here](https://github.com/Darkmoonxhubscript/DarkLibV3/blob/main/Example.luau)**
# Getting Started
To begin, you need to declare a loadstring to access the library.
```luau
loadstring(game:HttpGet("https://raw.githubusercontent.com/Darkmoonxhubscript/DarkLibV3/refs/heads/main/Source.luau"))()
```
## Make a Window
```luau
local Window = MakeWindow({
    Title = "DarkLib V3",
    SubTitle = "By DarkMoonHub",
    Theme = "Dark",
    Acrylic = true,
    KeySystem = {
    Active = false,
    KeyTitle = "Key System",
    KeyDescription = "Key System Description",
    Keys = {"Key1", "Key2", "Key3"},
    KeyLink = "pastebin.com/"
    }
  })
```
**Argument 1: UI Title (type: string)**

**Argument 2: UI SubTitle (type: string)**

**Argument 3: UI Theme (type: string);** **Avaliable Themes:** **__Dark, Darker & Purple__**

**Argument 4: UI Acrylic (type: bool)**

**Argument 5: UI KeySystem Configs (type: table)**

**SubArgument 1: Key System Active (type: bool)**

**SubArgument 2: Key System Title (type: string)**

**SubArgument 3: Key System Description (type: string)**

**SubArgument 4: Key System Keys (type: table)**

**SubArgument 5: Key System Link To Key (type: string)**

## Create Notification
```luau
local Notify = NewNotify({
Title = "Notification Title",
Description = "Notification Description.",
Time = 10
})
```
**Argument 1: Notification Title (type: string)**

**Argument 2: Notification Description (type: string)**

**Argument 3: Notification Duration (type: number)**
## Create Tab
```luau
local Tab1 = NewTab({Name = "Tab", Icon = "Home"})
```
**Argument 1: Tab Name (type: string)**

**Argument 2: Tab Icon Name (type: string)**

**----------------------------------------------------------------------**

**__'Tab1' is Name of Obj Tab that will be created!__**
## Add a Section
```luau
local Section1 = AddSection(Tab1, {Name = "Section"})
```
**Argument 1: Section Text (type: string)**
## Add a TextLabel
```luau
local TextLabel1 = AddTextLabel(Tab1, Name = "My Text"})
```
**Argument 1: TextLabel Text (type: string)**
## Add a Paragraph
```luau
local Paragraph1 = AddParagraph(Tab1, {
  Name = "My Title",
  SubText = "My Paragraph"
})
```
**Argument 1: Paragraph Title (type: string)**

**Argument 2: Paragraph Content(Description) (type: string)**
## Add a Button
```luau
local Button1 = AddButton(Tab1, {
  Name = "Button",
  Callback = function()
  print("Clicked")
  end
})
```
**Argument 1: Button Text (type: string)**

**Argument 2: Button Function On Clicked (type: func)**
## Add a Toggle
```luau
local Toggle1 = AddToggle(Tab1, {
  Name = "Toggle",
  Default = false,
  Callback = function(Value)
  print(Value)
  end
})
```
**Argument 1: Toggle Text (type: string)**

**Argument 2: Toggle State (type: bool)**

**Argument 3: Toggle Function (type: func)**
## Add a TextBox
```luau
local TextBox1 = AddTextBox(Tab1, {
  Name = "TextBox",
  Default = "Default Text",
  AutoClear = false,
  PlaceHolder = "Input Text Here",
  Callback = function(Value)
    print(Value)
    end
})
```
**Argument 1: TextBox Text(Title) (type: string)**

**Argument 2: TextBox Default Text (type: string)**

**Argument 3: TextBox AutoClear (type: bool)**

**Argument 4: TextBox PlaceHolder Text (type: string)**

**Argument 5: TextBox Function (type: func)**
## Add a Slider
```luau
local Slider1 = AddSlider(Tab1, {
  Name = "Slider",
  Min = 0,
  Max = 100,
  Increase = 10,
  Default = 20,
  Callback = function(Value)
    print(Value)
    end
})
```
**Argument 1: Slider Text (type: string)**

**Argument 2: Slider Min Value (type: number)**

**Argument 3: Slider Max Value (type: number)**

**Argument 4: Slider Increase Value (type: number)**

**Argument 5: Slider Default Value (type: string)**

**Argument 6: Slider Function (type: func)**
## Add a Dropdown
```luau
local Dropdown1 = AddDropDown(Tab1, {
  Name = "Dropdown",
  Options = {"1", "2", "3", "4", "5", "6", "7"},
  MultiSelect = false,
  Default = "1",
  Callback = function(Value)
    print(Value)
    end
})
```
**Argument 1: Dropdown Text (type: string)**

**Argument 2: Dropdown Options (type: table)**

**Argument 3: Dropdown MultiSelect Actived (type: bool)**

**Argument 4: Dropdown Default Option (type: string)**

**Argument 5: Dropdown Function (type: function)**
## Add a ImageLabel
```luau
local Image1 = AddImageLabel(Tab1, {
    Icon = "",
    Style = "Square"
  })
```
**Argument 1: Image Icon (type: string)**
**Argument 2: Image Style; Styles: "Big", "Banner", "Square" (type: string)**
# EXTRA
Extra Functions, Just for increment ;)
## Add a Minimize Button
```luau
AddMinimizeButton({Icon = "10734897102"})
```
**Argument 1: MinimizeButton Icon; Id, you can use 'GetIcon("IconName")' Too! (type: string)**
## Add a Server Invite
```luau
local ServerInvite = AddDiscordInvite(Tab1, {
  Name = "You Server Community",
  Description = "Join our discord community to receive information about the next update",
  Logo = "Id",
  Invite = "https://discord.gg/ServerCode",
})
```
**Argument 1: Server Name (type: string)**

**Argument 2: Server Description (type: string)**

**Argument 3: Server Icon (type: string)**

**Argument 4: Server Invite (type: string)**
## Add A Float Toggle
```luau
AddFloatToggle({
    Name = "Toggle Name",
    Callback = function(Value)
      print(Value)
      end
  })
```
**Argument 1: FloatToggle Text (type: string)**

**Argument 2: FloatToggle Function (type: func)**
# Functions
All Library Functions!

## Elements
1. DestroyButton(Button)
2. EditButtonText(Button, Text)
3. DestroySection(Section)
4. EditSectionText(Section, Text)
5. DestroyTextLabel(TextLabel)
6. EditTextLabelText(TextLabel, Text)
7. DestroyParagraph(TextLabel)
8. EditParagraphTitle(Paragraph, Text)
9. EditParagraphDescription(Paragraph, Text)
10. DestroyToggle(Toggle)
11. EditToggleText(Toggle, Text)
12. DestroyTextBox(TextBox)
13. EditTextBoxText(TextBox, Text)
14. EditTextBoxInputText(TextBox, Text
15. EditTextBoxPlaceholder(TextBox, Text)
16. DestroySlider(Slider)
17. EditSliderText(Slider, Text)
18. EditSliderValue(Slider, Value)
19. RefreshDropdown(Dropdown, NewOptions)
20. KeySystemSet(Value)
## Library
1. GetLibVersion()
2. GetLibTheme()
3. GetPlaceName()
4. SetVisible(Object, Value)
5. CloseLibrary()
6. CloseDialog()

**----------------------------------------------------------------------**

Thats All ;)
