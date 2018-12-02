session = {}

function session:new(x, y, car1, car2, background, backback, startend, length, num)
    local obj = {}
    
    obj.x = x
    obj.y = y
    obj.main_car = car1
    obj.enem_car = car2
    obj.background1 = background
    obj.background2 = backback
    obj.startend = love.graphics.newImage(startend)
    obj.screen = {love.graphics.getWidth()/2, love.graphics.getHeight()}
    obj.path = {traveled = 0, 
                length = length}
    obj.num = num
    obj.time = 0
    
    function session:draw()
        
        local c = love.graphics.newCanvas(love.graphics.getWidth()/2,
                                          love.graphics.getHeight())
        love.graphics.setCanvas(c)
        self.background2:render(0, 0)
        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(self.startend, self.path.length - self.path.traveled, 
                           self.y-love.graphics.getHeight()/2)
        love.graphics.draw(self.startend, -self.path.traveled, 
          self.y-love.graphics.getHeight()/2)
        self.background1:render(0, 0)
        if self.num == 1 then
            self.enem_car:render(self.enem_car.path - self.main_car.path + 0, 
              0)
            self.main_car:render(0, (1 - self.num)*150 + self.num*150 + 0)
        else
            self.main_car:render(0, 0)
            self.enem_car:render(self.enem_car.path - self.main_car.path + 0, 
              (1 - self.num)*150 - self.num*150 + 0)
        end
        love.graphics.setCanvas()
        love.graphics.draw(c,self.x,self.y)
        self.main_car:draw_dial(self.x, self.y)
        love.graphics.setColor(1,1,1,1)
        love.graphics.setFont(love.graphics.newFont("fonts/ariblk.ttf", 40))
        love.graphics.print(tostring(math.floor(self.main_car.u)).." км/ч", 750+self.x, 
                                                                      40+self.y)
        love.graphics.print(time_format(self.time) .. " секунд", 100+self.x, 
                                                                      40+self.y)
        
        
    end
    
    function session:update(dt)
        self.main_car:update(dt)
        self.background2:update(dt, 
          self.main_car.u)
        self.background1:update(dt, 
          self.main_car.u)
        self.path.traveled = self.main_car.path
        if self.path.traveled < self.path.length then
            self.time = self.time + dt
        end
    end
    
    function session:keypressed(key, unicode)
        
        --self.enem_car:mech(key)
    end
    
    function session:mech(event)
        local key = event
        if self.path.traveled < self.path.length then
            self.main_car:mech(key)
        end
    end
    
    setmetatable(obj, self)
    self.__index = self
    return obj
end

return session
