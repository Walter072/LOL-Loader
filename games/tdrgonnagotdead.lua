local uiLoader = loadstring(game:HttpGet('https://raw.githubusercontent.com/topitbopit/dollarware/main/library.lua'))
local ui = uiLoader({
    rounding = false,
    theme = 'lime', 
    smoothDragging = false
})
local size = Vector2.new(550, 376)
local viewport = workspace.CurrentCamera.ViewportSize

local window = ui.newWindow({
    text = 'LOL HUB',
    resize = true,
    size = size,
    position = Vector2.new(
        (viewport.X - size.X) / 2,  
        (viewport.Y - size.Y) / 2   
    )
})
local mainMenu = window:addMenu({
    text = "Main"
})