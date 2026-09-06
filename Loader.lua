local Players = game:GetService("Players")

local KEYS_URL = "https://raw.githubusercontent.com/Walter072/LOL-Loader/main/keys.txt"

local Routes = {
    hub = "https://raw.githubusercontent.com/Walter072/LOL-Hub/refs/heads/main/Hub",
    Universal_allgames = "https://raw.githubusercontent.com/Walter072/LOL-Loader/main/scripts/Universal_allgames.lua",
    -- DaBackrooms = "https://raw.githubusercontent.com/Walter072/LOL-Hub/main/DaBackrooms.lua",
}

local function norm(s)
    return (tostring(s or ""):gsub("%s+", ""):upper())
end

local routeName = getgenv().Route or getgenv().LOL_ROUTE
if not routeName or tostring(routeName) == "" then
    local p = Players.LocalPlayer
    if p then p:Kick("[LOL Hub] Falta getgenv().Route") end
    return
end

routeName = tostring(routeName):gsub("[^%w%-%_]", "")
local scriptUrl = Routes[routeName]

if not scriptUrl then
    return warn("[LOL Hub] Route desconocida:", routeName, "| Rutas:", table.concat((function()
        local t = {}
        for k in pairs(Routes) do table.insert(t, k) end
        return t
    end)(), ", "))
end

local key = norm(getgenv().Key)
if key == "" then
    return warn("[LOL Hub] Falta getgenv().Key")
end

local ok, list = pcall(function()
    return game:HttpGet(KEYS_URL)
end)
if not ok or not list then
    return warn("[LOL Hub] No se pudo cargar keys.txt")
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
    return warn("[LOL Hub] Key invalida")
end

print("[LOL Hub] Key OK | Route:", routeName)

local ok2, src = pcall(function()
    return game:HttpGet(scriptUrl)
end)
if not ok2 or not src then
    return warn("[LOL Hub] No se pudo cargar:", scriptUrl)
end

local fn, err = loadstring(src)
if not fn then
    return warn("[LOL Hub] Error loadstring:", err)
end
return fn()