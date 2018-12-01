tuning = {}  -- it's not a class, it's a simple object (not one can expect this)

local _, _, flags = love.window.getMode()
width, height = love.graphics.getDimensions(flags.display)
sprites = 2
sprite1 = 0
sprite2 = 0

tuning.menu = button:new(width/2-200, 
                         height + 200, "bb_menu.png")

tuning.left1 = button:new(400, 
                         120, "left.png")
tuning.right1 = button:new(600, 
                         120, "right.png")

tuning.left2 = button:new(width/2+200, 
                         150, "left.png")
tuning.right2 = button:new(width/2+400, 
                         150, "right.png")

tuning.buttons = {
  tuning.menu, tuning.left1, tuning.left2, tuning.right1, tuning.right2}


function tuning.draw()
    for _, item in pairs(tuning.buttons) do
        item:draw()
    end
    
    
    car1:render(0, -height*0.25)
    car2:render(800, -height*0.25)
end

function tuning.update(dt)
    for _, item in pairs(tuning.buttons) do
        item:update(dt)
    end
end

function tuning.mpress(x, y)
    if tuning.menu:mpress(x, y) then
        scene = "menu"
    elseif tuning.left1:mpress(x, y) and sprite1 > 0 then
        sprite1 = sprite1 - 1
        sets['carsprites1'][2] = 'tatoos/'..tostring(sprite1)..'.png'
        sets['carcolors1'][2] = {255,255,255,255}
        im1 = love.graphics.newImage('tatoos/'..tostring(sprite1)..'.png')
    elseif tuning.right1:mpress(x, y) and sprite1 < sprites then
        sprite1 = sprite1 + 1
        sets['carsprites1'][2] = 'tatoos/'..tostring(sprite1)..'.png'
        sets['carcolors1'][2] = {255,255,255,255}
        im1 = love.graphics.newImage('tatoos/'..tostring(sprite1)..'.png')
    elseif tuning.left2:mpress(x, y) and sprite2 > 0 then
        sprite2 = sprite2 - 1
        sets['carsprites2'][2] = 'tatoos/'..tostring(sprite2)..'.png'
        sets['carcolors2'][2] = {255,255,255,255}
        im2 = love.graphics.newImage('tatoos/'..tostring(sprite2)..'.png')
    elseif tuning.right2:mpress(x, y) and sprite2 < sprites then
        sprite2 = sprite2 + 1
        sets['carsprites2'][2] = 'tatoos/'..tostring(sprite2)..'.png'
        sets['carcolors2'][2] = {255,255,255,255}
        im2 = love.graphics.newImage('tatoos/'..tostring(sprite2)..'.png')
    end
    car1 = car:new(width/4-188, height/2-100, 1600, 1000, {600, 375}, {255, 255, 255, 255}, "loshadka1.png", sets['carsprites1'], sets['carcolors1'], 1, dial, {'q','e','space'})
    
    car2 = car:new(width/4-188, height/2-35, 1600, 1000, {600, 375}, {255, 255, 255, 255}, "loshadka2.png", sets['carsprites2'], sets['carcolors2'], 1, dial, {'[',']','ralt'})
end











--[[]]--