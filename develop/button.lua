button = {}

function button:new(x, y, image)
    local t = {}
    t.toch = false
    t.image = love.graphics.newImage(image)
      local ox, oy = t.image:getDimensions()
    t.x = x+ox/2
    t.y = y-oy/2
    
    
    setmetatable(t, self)
    self.__index = self
    return t
end

  function button:update(dt)
        self.toch = false
        local x = love.mouse.getX(); local y = love.mouse.getY()
        if x > self.x and x < (self.x + self.image:getWidth()*gratio[1]) and 
           y < (self.y + self.image:getHeight()*gratio[2]) and y > self.y then
            self.toch = true
        end
    end
    
    function button:draw()
        love.graphics.setColor(1,1,1,1)
          local x = love.mouse.getX(); local y = love.mouse.getY()
        
        if self.toch then
            love.graphics.draw(self.image, self.x-5, self.y-5, -0.03, gratio[1], gratio[2])
        else
            love.graphics.draw(self.image, self.x, self.y, 0, gratio[1], gratio[2])
        end
    end
    
    function button:mpress(x,y)
        if self.toch then
            self.toch = false
            return true
        end
        return false
    end

