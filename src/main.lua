local placeId = game.PlaceId
local url = "https://raw.githubusercontent.com/yedgk001/roblox-lua/refs/heads/main/src/place/" .. placeId .. ".lua"

task.spawn(function()
    loadstring(game:HttpGet(url))()
end)