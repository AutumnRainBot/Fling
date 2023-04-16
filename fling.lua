
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/kav"))()
local Window = Library.CreateLib("Rain", "DarkTheme")
local Tab = Window:NewTab("Main")
local Section = Tab:NewSection("Rainbot >>> Billbert (dong sucks)")
local run_service = game:GetService("RunService")
local super_stepped = Instance.new("BindableEvent") do
    local events = {
        run_service.RenderStepped,
        run_service.Heartbeat,
        run_service.Stepped,
        run_service.PreSimulation,
        run_service.PostSimulation
    }
    for i, v in pairs(events) do
        v:Connect(function()
            super_stepped.Fire(super_stepped, tick())
        end)
    end
end
victime = ""
list = {}

for i,v in pairs(game.Players:GetChildren())do
    table.insert(list,v.Name)
end


local dropdown = Section:NewDropdown("Victims","Info", list, function(element)
    victime = element
end)
game.Players.PlayerAdded:Connect(function()
    list = {}
    for i,v in pairs(game.Players:GetChildren())do
        table.insert(list,v.Name)
    end
    dropdown:Refresh(list)
end)

game.Players.PlayerRemoving:Connect(function()
    list = {}
    for i,v in pairs(game.Players:GetChildren())do
        table.insert(list,v.Name)
    end
    dropdown:Refresh(list)
end)
function flingpart(part)
    local BodyAngularVelocity = Instance.new("BodyAngularVelocity")
    BodyAngularVelocity.AngularVelocity = Vector3.new(10^6, 10^6, 10^6)
    BodyAngularVelocity.MaxTorque = Vector3.new(10^6, 10^6, 10^6)
    BodyAngularVelocity.P = 10^6
    BodyAngularVelocity.Parent = part
end

game:GetService("Workspace").Thrown.ChildAdded:Connect(function(v)
    if v.Name == "Orion"  then
        repeat wait() until v:FindFirstChild("HumanoidRootPart")
        flingpart(v.HumanoidRootPart)
        flingpart(v.Head)
        flingpart(v.Torso)
        v.HumanoidRootPart.Holder:Destroy()
    end
end)
function claim_part(part)
    part.Velocity = Vector3.new(14.465,14.465,14.465)
    sethiddenproperty(part,"NetworkIsSleeping",false)
    game.Players.LocalPlayer.ReplicationFocus = part
end
super_connection = super_stepped.Event:Connect(function() -- so super
    sethiddenproperty(game:GetService("Players").LocalPlayer, "MaxSimulationRadius", math.huge)
    sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
    for i,v in pairs(game:GetService("Workspace").Thrown:GetChildren()) do
        if v:IsA("Model") and v:FindFirstChildOfClass("Humanoid") and v:FindFirstChildOfClass("Humanoid").Health > 0  then
            if v:FindFirstChild("HumanoidRootPart")then
                if isnetworkowner(v.HumanoidRootPart) then
                    v.HumanoidRootPart.CFrame = (game.Players:FindFirstChild(victime).Character.Torso.CFrame) * v.HumanoidRootPart.CFrame.Rotation
                    v.Torso.CFrame = (game.Players:FindFirstChild(victime).Character.Torso.CFrame) * v.Torso.CFrame.Rotation
                    v.HumanoidRootPart.Velocity = Vector3.new()
                    v.Torso.Velocity = Vector3.new()
                else
                    claim_part(v.HumanoidRootPart)
                    claim_part(v.Torso)
                end
            else
                v:Destroy()
            end
        end
    end
end)
