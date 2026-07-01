local placeId = game.PlaceId
local url = "https://raw.githubusercontent.com/yedgk001/roblox-lua/refs/heads/main/src/place/" .. placeId .. ".lua"

task.defer(function()
    local success, err = pcall(function()
        loadstring(game:HttpGet(url))()
    end)

    if not success then
        warn("Failed to load script for placeId " .. placeId .. ": " .. err)
    end
end)