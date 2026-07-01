local fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local autoSellRemote = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SellCrates")
local autoRollRemote = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("RollSeeds")
local buySeedRemote = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("BuySeed")
local selectedSeeds = {}
local autoRollOption = false
local autoSellOption = false

local window = fluent:CreateWindow({
    Title = "Build a ring farm",
    SubTitle = "~ yedgk",
    TabWidth = 160,
    Size = UDim2.fromOffset(500, 350),
    Acrylic = true,
    Theme = "Rose",
    MinimizeKey = Enum.KeyCode.RightControl
})

local mainSection = window:AddTab({
    Title = "Auto sell",
    Icon = "package"
})
local autoRollSection = window:AddTab({
    Title = "Auto roll",
    Icon = "dice-6"
})

mainSection:AddToggle("autoSell", {
    Title = "Auto sell",
    Description = "Automatically sell crates every 120 seconds.",
    Default = false
}):OnChanged(function(Value)
    autoSellOption = Value

    if autoSellOption then
        task.spawn(function()
            while autoSellOption do
                autoSellRemote:FireServer()
                task.wait(120)
            end
        end)
        fluent:Notify({
            Title = "Auto sell",
            Content = "Enabled.",
            Duration = 2
        })
    else
        fluent:Notify({
            Title = "Auto sell",
            Content = "Disabled.",
            Duration = 2
        })
    end
end)


autoRollSection:AddDropdown("seedList", {
    Title = "Seeds",
    Multi = true,
    Values = {
        "Eclipse Bellflower",
        "Aethercoil",
        "Seraphim Spire",
        "Starlight Camellia",
        "Soulpair Sapling",
        "Galaxia Rose",
        "Sundrop Seraphina",
        "Godspore"
    },
    Default = {}
}):OnChanged(function(values)
    selectedSeeds = values
end)

autoRollRemote.OnClientEvent:Connect(function(dataTable)
    if not autoSellOption then return end
    for index, slot in ipairs(dataTable.Slots) do
        local seedName = slot.Seed
        if table.find(selectedSeeds, seedName) then
            buySeedRemote:FireServer(index, true)
            task.wait(1)
        end
    end
end)

autoRollSection:AddToggle("autoRoll", {
    Title = "Auto roll",
    Description = "Rolls and buys seeds from the list above.",
    Default = false
}):OnChanged(function(value)
    autoRollOption = value

    if autoRollOption then
        task.spawn(function ()
            while autoRollOption do
                autoRollRemote:FireServer()
                task.wait(5)
            end
        end)
        fluent:Notify({
            Title = "Auto roll",
            Content = "Enabled.",
            Duration = 2
        })
    else
        fluent:Notify({
            Title = "Auto roll",
            Content = "Disabled.",
            Duration = 2
        })
    end
end)

window:SelectTab(1)