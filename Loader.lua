if not game:IsLoaded() then
    game.Loaded:Wait()
end

if identifyexecutor then
    local ok, execName = pcall(function()
        return tostring(identifyexecutor()):lower()
    end)

    if ok and execName then
        if execName:find("xeno") then
            local lp = game:GetService("Players").LocalPlayer
            lp:Kick(
                "EXECUTOR NOT SUPPORTED\n" ..
                "Xeno / are not supported.\n" ..
                "Please don't get mad — this is due to their UNC/SUNC limits."
            )
            return
        end
    end
end

local BASE = "https://raw.githubusercontent.com/Walter072/LOL/main/games/"

local games = {
    [5088137] = "Da-Backrooms.lua",
    [490911723] = "+1-pickaxe.lua",
    [476287845] = "Be-a-youtuber.lua",
    [1917531509] = "Crash-or-land.lua",
}

local places = {
    -- [1234567890] = ".lua",
}

local file = games[game.CreatorId] or places[game.PlaceId]

if not file then
    file = "universal.lua"
end

print("[Loader] Loading:", file, "CreatorId:", game.CreatorId, "PlaceId:", game.PlaceId)

local ok, src = pcall(function()
    return game:HttpGet(BASE .. file)
end)

if ok and src and #src > 0 then
    local runOk, err = pcall(function()
        loadstring(src)()
    end)
    if not runOk then
        warn("[Loader] Error running:", err)
    end
else
    warn("[Loader] Cannot load:", file)
end
