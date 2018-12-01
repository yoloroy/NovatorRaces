settings = {}  -- it's not a class, it's a simple object (not one can expect this)

width, height = love.graphics.getDimensions()

settings.monitor = button:new(width/2-200, height/2 - 250, "bb_fulloff.png")
settings.menu = button:new(width/2-200, 
                         love.graphics.getHeight() + 200, "bb_menu.png")

settings.buttons = {
  settings.monitor, settings.menu}

function settings.draw()
    for _, item in pairs(settings.buttons) do
        item:draw()
    end
end

function settings.update(dt)
    for _, item in pairs(settings.buttons) do
        item:update(dt)
    end
end

function settings.mpress(x, y)
    if settings.monitor:mpress(x, y) then
        if love.window.getFullscreen() then
            love.window.setFullscreen(false)
            settings.monitor.image = love.graphics.newImage('bb_fulloff.png')
        else
            love.window.setFullscreen(true)
            settings.monitor.image = love.graphics.newImage('bb_fullon.png')
        end
    elseif settings.menu:mpress(x, y) then
        scene = "menu"
    end
end