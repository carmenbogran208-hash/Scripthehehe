local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Dandy's World Hub",
   Icon = 0,
   LoadingTitle = "Dandy's Interface Suite",
   LoadingSubtitle = "by You",
   Theme = "Default", 
   ToggleUIKeybind = "K",      
   ShowText = "Tap to Open",

   ConfigurationSaving = {
      Enabled = true,
      FileName = "DandysWorldConfig"
   },
   KeySystem = false,
})

local Tab = Window:CreateTab("Main", 4483362458)
local Section = Tab:CreateSection("Character Tweaks")

local player = game.Players.LocalPlayer
local hipHeightEnabled = false
local characterConnection = nil

local function applyHeight(char)
   local hum = char:WaitForChild("Humanoid", 5)
   if hum and hipHeightEnabled then
      hum.HipHeight = 10
      print("Dandy's World: HipHeight set to 10")
   end
end

local Toggle = Tab:CreateToggle({
   Name = "Enable Tall HipHeight",
   CurrentValue = false,
   Flag = "DandysHeight", 
   Callback = function(Value)
      hipHeightEnabled = Value
      
      if hipHeightEnabled then
         if player.Character then
            applyHeight(player.Character)
         end
         
         characterConnection = player.CharacterAdded:Connect(function(newChar)
            applyHeight(newChar)
         end)
      else
         if characterConnection then
            characterConnection:Disconnect()
            characterConnection = nil
         end
         
         if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.HipHeight = 0
            print("HipHeight reset to normal")
         end
      end
   end,
})

Rayfield:LoadConfiguration()
/rayfield
