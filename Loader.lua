local Players = game:GetService("Players")

local KEYS_URL = "https://raw.githubusercontent.com/Walter072/LOL-Loader/main/keys.lua"

local Routes = {
    hub = "https://raw.githubusercontent.com/Walter072/LOL-Hub/refs/heads/main/hub.lua",
    Universal_allgames = "https://raw.githubusercontent.com/Walter072/LOL-Loader/main/scripts/Universal_allgames.lua",
    hub2 = "https://raw.githubusercontent.com/Walter072/LOL-Hub/refs/heads/main/hub2.lua",
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

local function b64(s)
    if crypt and crypt.base64encode then
        return crypt.base64encode(s)
    end
    if base64_encode then
        return base64_encode(s)
    end
    -- fallback: sin ofuscar (solo keys en claro)
    return s
end

local key = norm(getgenv().Key)
if key == "" then
    return warn("[LOL Hub] Missing getgenv().Key")
end

local ok, list = pcall(function()
    return game:HttpGet(KEYS_URL)
end)
if not ok or not list then
    return warn("[LOL Hub] Failed to load keys.txt")
end

local targetObf = b64(key)
local allowed = false
for line in string.gmatch(list, "[^\r\n]+") do
    local lineTrim = line:match("^%s*(.-)%s*$") or ""
    if lineTrim ~= "" and not lineTrim:match("^#") then
        local upper = norm(lineTrim)
        if upper == key or lineTrim == targetObf then
            allowed = true
            break
        end
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