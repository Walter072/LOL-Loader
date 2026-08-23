if not game:IsLoaded() then
    game.Loaded:Wait()
end

local BASE = "https://raw.githubusercontent.com/Walter072/LOL/main/games/" -- here your github repo link, make sure to add the / at the end of the link

local games = {
    [5088137] = "Da-Backrooms.lua",
    [490911723] = "+1-pickaxe.lua",
    [476287845] = "Be-a-youtuber.lua",
    [1917531509] = "Crash-or-land.lua", -- here add the name of the file you want to load,and in the numbers put the game creator id.
}                                        -- use this code for you own loader, just add the game creator id and the file name to the table

local file = games[game.CreatorId] or places[game.PlaceId]

if not file then
    file = "universal.lua"
end

print("[Loader] Loading:", file, "CreatorId:", game.CreatorId, "PlaceId:", game.PlaceId)

local ok, src = pcall(function()
    return game:HttpGet(BASE .. file)
end)

if ok and src then
    local runOk, err = pcall(function()
        loadstring(src)()
    end)
    if not runOk then
        warn("Loader Error running:", err)
    end
else
    warn("Loader cannot load ", file)
end