background = {}

function background:new(x, y, size, color, image_size, image_link, u)
    local obj = {}
    obj.x = x or 0
    obj.y = y or 0
    obj.size = size or {1, 1}
    obj.color = color or {255, 255, 255, 255}
    obj.image_size = image_size or {300, 300}
    obj.image = love.graphics.newImage(image_link)
    obj.offset = {size[1] / image_size[1], size[2] / image_size[2]}
    obj.u = u or 30
   
    function background:render(x, y)
        local width = love.graphics.getWidth()/2
        local height = love.graphics.getHeight()*2
        
        love.graphics.setColor(self.color[1]/255,
                               self.color[2]/255, 
                               self.color[3]/255, 
                               self.color[4]/255)
        local quad = love.graphics.newQuad(self.x, self.y, width, height, self.image:getDimensions())
        love.graphics.draw(self.image, quad, 
                           x, y, 0,
                           1, 
                           1, 0, 0)
    end
    
    function background:update(dt, u)
        self.x = self.x + u*dt*self.u 
        if self.x > self.image_size[1]/2 then
            self.x = 0
        end
    end
    
    setmetatable(obj, self)
    self.__index = self
    return obj
end

return background
