menu = {}  -- it's not a class, it's a simple object (not one can expect this)

width = love.graphics.getWidth()
height = love.graphics.getHeight()

menu.play = button:new(width/2, height/30*4, "/png/bb_play.png")
menu.play.func = function ()
                     scene = 'race'
                 end
menu.tuning = button:new(width/2, height/30*10, "/png/bb_tuning.png")
menu.tuning.func = function ()
                     scene = 'tuning'
                 end
menu.settings = button:new(width/2, height/30*16, "/png/bb_settings.png")
menu.settings.func = function ()
                     scene = 'settings'
                 end
menu.exit = button:new(width/2, height/30*26, "/png/bb_exit.png")
menu.exit.func = function ()
                     love.event.quit()
                 end

menu.buttons = {
  menu.play, menu.tuning, menu.settings, menu.exit}

function menu.draw()
    for _, button in pairs(menu.buttons) do
        button:draw()
    end
end

function menu.update(dt)
    for _, button in pairs(menu.buttons) do
        button:update(dt)
    end
end

function menu.mpress(x, y)
    for _, button in pairs(menu.buttons) do
        if button:mpress(x, y) then
            button.func()
        end
    end
    
    if scene == "race" then
        background11 = background:new(0, 0, {width, height}, {255, 255, 255, 255}, 
                                           {11520, 1048}, "/png/track.png")
        background12 = background:new(0, 0, {width, height}, {255, 155, 155, 255}, 
                                           {7680, 493}, "/png/forest.png", 15)
        background21 = background:new(0, 0, {width, height}, {255, 255, 255, 255}, 
                                           {11520, 1048}, "/png/track.png")
        background22 = background:new(0, 0, {width, height}, {255, 155, 155, 255}, 
                                           {7680, 493}, "/png/forest.png", 15)
    
        session1 = session:new(0,       0, car1, car2, background11, background12, "/png/satrt.png", 1000*24, 0)
        session2 = session:new(width/2, 0, car2, car1, background21, background22, "/png/satrt.png", 1000*24, 1)
    end
end