button = {}

function button:new(x, y, image)
    local t = {}
    t.toch = false
    t.x = x
    t.y = y
    t.image = love.graphics.newImage(image)
    
    setmetatable(t, self)
    self.__index = self
    return t
end

  function button:update(dt)
        self.toch = false
        local x = love.mouse.getX(); local y = love.mouse.getY()
        if x > self.x and x < (self.x + self.image:getWidth() )and 
           y < (self.y + self.image:getHeight()) and y > self.y then
            self.toch = true
        end
    end
    
    function button:draw()
        love.graphics.setColor(1,1,1,1)
          local x = love.mouse.getX(); local y = love.mouse.getY()
        nx = -(x-self.x)/40
        ny = -(y-self.y)/40
        
        if self.toch then
            love.graphics.draw(self.image, self.x-5, self.y-5,-0.03)
        else
            love.graphics.draw(self.image, self.x, self.y)
        end
    end
    
    function button:mpress(x,y)
        if self.toch then
            self.toch = false
            return true
        end
        return false
    end

