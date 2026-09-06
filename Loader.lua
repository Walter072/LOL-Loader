local Players = game:GetService("Players")

local KEYS_URL = "https://raw.githubusercontent.com/Walter072/LOL-Loader/main/keys.lua"

local Routes = {
    hub = "https://raw.githubusercontent.com/Walter072/LOL-Hub/refs/heads/main/Hub",
    Universal_allgames = "https://raw.githubusercontent.com/Walter072/LOL-Loader/main/scripts/Universal_allgames.lua",
}

local function norm(s)
    return (tostring(s or ""):gsub("%s+", ""):upper())
end

local routeName = getgenv().Route or getgenv().LOL_ROUTE
if not routeName or tostring(routeName) == "" then
    local p = Players.LocalPlayer
    if p then p:Kick("[LOL Hub] Missing getgenv().Route") end
    return
end

routeName = tostring(routeName):gsub("[^%w%-%_]", "")
local scriptUrl = Routes[routeName]

if not scriptUrl then
    local names = {}
    for k in pairs(Routes) do
        table.insert(names, k)
    end
    return warn("[LOL Hub] Unknown route:", routeName, "| Available:", table.concat(names, ", "))
end

local key = norm(getgenv().Key)
if key == "" then
    return warn("[LOL Hub] Missing getgenv().Key")
end

local ok, list = pcall(function()
    return game:HttpGet(KEYS_URL)
end)
if not ok or not list then
    return warn("[LOL Hub] Failed to load keys.lua")
end

local allowed = false
for line in string.gmatch(list, "[^\r\n]+") do
    local k = norm(line)
    if k ~= "" and not k:match("^#") and k == key then
        allowed = true
        break
    end
end

if not allowed then
    return warn("[LOL Hub] Invalid key")
end

print("[LOL Hub] Key OK | Route:", routeName)

local ok2, src = pcall(function()
    return game:HttpGet(scriptUrl)
end)
if not ok2 or not src then
    return warn("[LOL Hub] Failed to load:", scriptUrl)
end

local fn, err = loadstring(src)
if not fn then
    return warn("[LOL Hub] loadstring error:", err)
end
return fn()