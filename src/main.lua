local placeId = game.PlaceId
local url = "https://github.com/yedgk001/roblox-lua/blob/main/src/place/" .. placeId .. ".lua"

if not game.Loaded then game.Loaded:Wait() end

local success, err = pcall(function()
    loadstring(game:HttpGet(url))()
end)