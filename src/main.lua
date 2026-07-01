local placeId = game.PlaceId
local url = "https://raw.githubusercontent.com/yedgk001/roblox-lua/refs/heads/main/src/place/" .. placeId .. ".lua"

if not game.Loaded then game.Loaded:Wait() end

local success, err = pcall(function()
    loadstring(game:HttpGet(url))()
end)