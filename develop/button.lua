button = {}

function button:new(x, y, image)
    local t = {}
    t.toch = false
    t.image = love.graphics.newImage(image)
      local ox, oy = t.image:getDimensions()
    t.x = x-ox/2*gratio[1]
    t.y = y-oy/2*gratio[2]
    
    
    setmetatable(t, self)
    self.__index = self
    return t
end

  function button:update(dt)
        local width = love.graphics.getWidth()
        local height = love.graphics.getHeight()
  
        local ratio = {width/1980/gratio[1], height/1040/gratio[2]}
        
        self.toch = false
        local x = love.mouse.getX(); local y = love.mouse.getY()
        if x > self.x*ratio[1] and x < (self.x*ratio[1] + self.image:getWidth()*gratio[1]*ratio[1]) and 
           y > self.y*ratio[2] and y < (self.y*ratio[2] + self.image:getHeight()*gratio[2]*ratio[2]) then
            self.toch = true
        end
    end
    
    function button:draw()
        local width = love.graphics.getWidth()
        local height = love.graphics.getHeight()
  
        local ratio = {width/1980/gratio[1], height/1040/gratio[2]}
        
        love.graphics.setColor(1,1,1,1)
          local x = love.mouse.getX(); local y = love.mouse.getY()
        
        if self.toch then
            love.graphics.draw(self.image, self.x*ratio[1], (self.y+5)*ratio[2], 0.03, ratio[1]*gratio[1], ratio[2]*gratio[2])
        else
            love.graphics.draw(self.image, self.x*ratio[1], self.y*ratio[2], 0, ratio[1]*gratio[1], ratio[2]*gratio[2])
        end
    end
    
    function button:mpress(x,y)
        if self.toch then
            self.toch = false
            return true
        end
        return false
    end

