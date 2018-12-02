screen = {}

function screen:new(objects)
    local obj = {}
    obj.objects = objects
    
    function screen:draw()
        for _, item in pairs(self.objects) do
            item:draw()
        end
    end
    
    function screen:update()
        for _, item in pairs(self.objects) do
            item:update()
        end
    end
    
    function screen:mech(event) -- keyboard and other events
        for _, item in pairs(self.objects) do
            item:mech(event)
        end
    end
    
    setmetatable(obj, self)
    self.__index = self
    return obj
end

return screen