love.window.setMode(1066, 528, {resizable = true})
  width = love.graphics.getWidth()
  height = love.graphics.getHeight()
  
gratio = {width/1980, height/1040} -- global ratio, need for update position of objects

require("extra_functions")
require("car")
require("background")
require("session")
require("screen")
require("button")
require("menu")
require("ending")
require('settings')
require('tuning')

function time_format (time) 
    str_time1 = tostring(math.floor(time*100)/100)
    if string.sub(str_time1,-2,-2)=="." then
        str_time1 = str_time1 .. "0"
    end
    return str_time1
end


function draw_path()
    love.graphics.draw(path, 0, 0)
    love.graphics.setColor(0,
                           0, 
                           1, 
                           1)
    love.graphics.circle('fill', 
      width/200+
      (session1.path.traveled/session1.path.length)*
      (width-width/100), height/200, 3)
    
    love.graphics.setColor(1,
                           0, 
                           0, 
                           1)
    love.graphics.circle('fill', 
      width/200+
      (session2.path.traveled/session2.path.length)*
      (width-width/100), height/200+22, 3)
end

function love.load(arg)
    scene = "menu"
    -- Window
    
    
-- !!!!!!!!!!!!!!!!!!!!!!!!!!
    
    
    -- Game objects
    dial = extra:draw_dial(width, height)
    path = extra:draw_path(width, height)
    
     --objects = {}
    sets = {}
      sets['carsprites1'] = {'/png/loshadkamask.png'}
      sets['carsprites2'] = {'/png/loshadkamask.png'}
      sets['carcolors1'] = {{255,255,255,255}}
      sets['carcolors2'] = {{255,255,255,255}}
    
    --game = screen:new({session1, session2})
      car1 = car:new(width/4-188, height/2-100, 1600, 1000, {600*gratio[1], 375*gratio[2]}, {255, 255, 255, 255}, "/png/loshadka1.png", sets['carsprites1'], sets['carcolors1'], 1, dial, {'q','e','space'})
      car2 = car:new(width/4-188, height/2-35, 1600, 1000, {600*gratio[1], 375*gratio[2]}, {255, 255, 255, 255}, "/png/loshadka2.png", sets['carsprites2'], sets['carcolors2'], 1, dial, {'[',']','ralt'})
  
    dir = 0
    
end

function love.draw()
    if scene == "menu" then
        back_color = {r = 255, g = 50, b = 120}
        menu.draw()
    elseif scene == 'tuning' then
        back_color = {r = 170, g = 0, b = 210}
        tuning.draw()
    elseif scene == 'settings' then
        back_color = {r = 100, g = 110, b = 120}
        settings.draw()
    elseif scene == 'ending' then
        back_color = {r = 0, g = 0, b = 0}
        ending:draw()
    elseif scene == "race" then
        back_color = {r = 255, g = 155, b = 120}
        session1:draw()
        session2:draw()
        draw_path()
      --  love.graphics.setLineWidth(5)
    --    love.graphics.setColor(230/255, 200/255, 170/255, 1)
        love.graphics.line(width/2,0,width/2,height)
    end
    love.graphics.setBackgroundColor(back_color.r/255,                                      back_color.g/255,                                     back_color.b/255)
end

function love.keypressed(key, unicode)
    if scene == 'race' then
        session1:mech(key, unicode)
        session2:mech(key, unicode)
    end
end

function love.mousepressed(x, y)
    if scene == 'menu' then 
        menu.mpress(x, y)
    elseif scene == 'tuning' then
        tuning.mpress(x, y)
    elseif scene == 'settings' then
        settings.mpress(x, y)
    elseif scene == 'ending' then
        ending:mpress(x, y)
    end
end

function love.update(dt)
    if scene == 'menu' then
        menu.update(dt)
    elseif scene == 'tuning' then
        tuning.update(dt)
    elseif scene == 'settings' then
        settings.update(dt)
    elseif scene == 'race' then
        session1:update(dt)
        session2:update(dt)
        if session1.path.traveled >= session1.path.length and
           session2.path.traveled >= session1.path.length then
            ending:options(car1, session1.time, car2, session2.time)
            scene = 'ending'
        end
    elseif scene == 'ending' then
        ending:update(dt)
    end
end
