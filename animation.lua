animation = {}

function animation:new(image, width, height, size, duration)
    local obj = {}
    obj.spriteSheet = image;
    obj.quads = {};
    obj.offset = {size[1] / width, size[2] / height}
 
    for y = 0, image:getHeight() - height, height do
        for x = 0, image:getWidth() - width, width do
            table.insert(obj.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
        end
    end
 
    obj.duration = duration or 1
    obj.currentTime = 0
    
    function animation:update(dt, u)
        if self.u ~= 0 then
            self.duration = 10/u
        else
            self.duration = nil
        end
        self.currentTime = self.currentTime + dt
        if self.currentTime >= self.duration then
            self.currentTime = self.currentTime - self.duration
        end
    end
 
    function animation:draw(x, y, u)
        local spriteNum = 1
        if u < 1.0 then
            spriteNum = 3
            self.currentTime = 0
        elseif type(self.duration) == "number" and self.duration == self.duration then
            spriteNum = math.floor(self.currentTime / 
              self.duration * #self.quads) % 7 + 1
        end
        love.graphics.draw(self.spriteSheet, self.quads[spriteNum], 
                           x, y, 0,
                           self.offset[1], 
                           self.offset[2], 64, 32)
        
    end
    
    setmetatable(obj, self)
    self.__index = self
    return obj
end

return animation