ending = {}

ending.car1 = nil
ending.time1 = nil
ending.car2 = nil
ending.time2 = nil

ending.menu = button:new(width - 400, 
                         love.graphics.getHeight() + 200, "bb_menu.png")

function ending:options(car1, time1, car2, time2)
    car1.u = 0
    car2.u = 0
    self.car1 = car1
    self.time1 = time1
    self.car2 = car2
    self.time2 = time2
end

function ending:draw()
    love.graphics.setColor(1,1,1,1)
    love.graphics.setFont(love.graphics.newFont('fonts/11520_0.ttf', 40))
    
    
    love.graphics.print(time_format(self.time1)..' секунд', 100, 100)
    love.graphics.print(time_format(self.time2)..' секунд', 100 + width/2, 100)
    self.car1:render(-200, -300)
    self.car2:render(width/2 - 200, -300)
    self.menu:draw()
end

function ending:update(dt)
    self.menu:update(dt)
end

function ending:mpress(x, y)
    if self.menu:mpress(x, y) then
        scene = 'menu'
    end
end

return ending