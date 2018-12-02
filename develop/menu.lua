menu = {}  -- it's not a class, it's a simple object (not one can expect this)

width, height = love.graphics.getDimensions()

menu.play = button:new(width/2-200, height/2 - 250, "/png/bb_play.png")
menu.tuning = button:new(width/2-200, height/2 - 50, "/png/bb_tuning.png")
menu.settings = button:new(width/2-200, height/2 + 150, "/png/bb_settings.png")
menu.exit = button:new(width/2-200, height/2 + 350, "/png/bb_exit.png")

menu.buttons = {
  menu.play, menu.tuning, menu.settings, menu.exit}

function menu.draw()
    for _, item in pairs(menu.buttons) do
        item:draw()
    end
end

function menu.update(dt)
    for _, item in pairs(menu.buttons) do
        item:update(dt)
    end
end

function menu.mpress(x, y)
    if menu.play:mpress(x, y) then
        scene = "race"
        --car1 = car:new(width/4-188, height/2-100, 1600, 1000, {600, 375}, {255, 255, 255, 255}, "loshadka1.png", sets['carsprites1'], sets['carcolors1'], 1, dial, {'q','e','space'})
        --car2 = car:new(width/4-188, height/2-35, 1600, 1000, {600, 375}, {255, 255, 255, 255}, "loshadka2.png", sets['carsprites2'], sets['carcolors2'], 1, dial, {'[',']','ralt'})
      
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
    elseif menu.tuning:mpress(x, y) then
        scene = "tuning"
    elseif menu.settings:mpress(x, y) then
        scene = "settings"
    elseif menu.exit:mpress(x, y) then
        love.event.quit()
    end
end