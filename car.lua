require("animation")
car = {}

function car:new(x, y, w, h, size, color, image_link, tatoos, tatoocolors, duration, dial, keys)
    local obj = {}
    obj.x = x or 0
    obj.y = y or 0
    obj.color = color or {255, 255, 255, 255}
    obj.image = animation:new(love.graphics.newImage(image_link), w, h, size, duration)
    obj.tatoos = {}; obj.tatoocolor = {}
    for i, item in pairs(tatoos) do
        obj.tatoos[i] = animation:new(love.graphics.newImage(item), w, h, size, duration)
    end
    for i, item in pairs(tatoocolors) do
        obj.tatoocolor[i] = item
    end
    
    obj.whip = love.graphics.newImage('whip1.png')
    
    obj.maxu = 60
    obj.u = 0
    obj.dt = 0
    obj.path = 0
    obj.offset = {size[1] / width, size[2] / height}
    
    obj.stress = 0
    obj.dial = dial or nil
    obj.strength = 50
    obj.bite = 0
   
    obj.q = keys[1]
    obj.e = keys[2]
    obj.z = keys[3]
    
    function car:UpdateTatoo(tatoos, tatoocolors)
       for i, item in pairs(tatoos) do
          obj.tatoos[i] = animation:new(love.graphics.newImage(item), w, h, size, duration)
       end
       for i, item in pairs(tatoocolors) do
         obj.tatoocolor[i] = item
       end   
    end
    
    function car:render(x, y)
        love.graphics.setColor(self.color[1]/255,
                               self.color[2]/255, 
                               self.color[3]/255, 
                               self.color[4]/255)
                             
        self.image:draw(self.x + x, self.y + y, self.u)
        for i, item in pairs(self.tatoos) do
            love.graphics.setColor(self.tatoocolor[i][1]/255,
                                   self.tatoocolor[i][2]/255, 
                                   self.tatoocolor[i][3]/255, 
                                   self.tatoocolor[i][4]/255)
            item:draw(self.x + x, self.y + y, self.u)
        end
        love.graphics.setColor(self.color[1]/255,
                               self.color[2]/255, 
                               self.color[3]/255, 
                               self.color[4]/255)
        if self.bite >= 0 then
            self:draw_whip(self.x + x, self.y + y)
        end
        love.graphics.setLineWidth(1)
        love.graphics.setColor(1,1,1,1)
    end
    
    function car:update(dt)
        if love.keyboard.isDown(self.q) then
            self.strength = self.strength - 270*dt
        elseif love.keyboard.isDown(self.e) then
            self.strength = self.strength + 270*dt
        end
        
        self.image:update(dt, self.u)
        for _, item in pairs(self.tatoos) do
            item:update(dt, self.u)
        end
        
        if self.bite > 0 then
          self.bite = self.bite - dt
        else
          self.bite = 0
        end
          
        self.dt = self.dt + dt
        self.path = self.path + self.u*dt*30
        --self.x = self.x + self.u*dt
        if self.u > 0 then
            self.u = self.u - 0.001*dt
            if self.stress < 50 then
                self.u = self.u - (50 - self.stress)*0.02
            elseif self.stress > 50 then
                self.u = self.u - (self.stress - 50)*0.02
            end
        end
        
        do
        if self.strength > 100 then
            self.strength = 100
        end
        if self.strength < 0 then
            self.strength = 0
        end
        end
        
        do
        if self.u < 0 then
            self.u = 0
        end
        if self.u > self.maxu then
            self.u = self.maxu
        end
        if self.stress > 0 then
            self.stress = self.stress - 0.40*(120 - self.stress)*dt
        end
        if self.stress < 0 then
            self.stress = 0
        end
        if self.stress > 100 then
            self.stress = 100
        end
        end
    end
    
    
    function car:draw_dial(x, y)
        dv = math.pi/3/100
        --                   stress
        love.graphics.setLineWidth(12)
        local r = 0
        local g = 0
        local b = 0
        if self.stress > 50 then
            r = self.stress - 50
        end
        --if self.stress > 25 and self.stress < 75 then
            g = 50 - math.abs(self.stress - 50)
        --end
        if self.stress < 50 then
            b = 50 - self.stress
        end
        
        love.graphics.setColor(r/50,g/50,b/50,0.5)
        love.graphics.arc("line", "open", width/16+6 + x, height/2 + y, 800, 
                          math.pi/6 - dv*self.stress, math.pi/6)
        
        
        --                   strength
        r = 0
        g = 0
        b = 0
        if self.strength > 50 then
            r = self.strength - 50
        end
        --if self.stress > 25 and self.stress < 75 then
            g = 50 - math.abs(self.strength - 50)
        --end
        if self.stress < 50 then
            b = 50 - self.strength
        end
        
        love.graphics.setColor(r/50,g/50,b/50,0.5)
        love.graphics.arc("line", "open", width/16-28 + x, height/2 + y, 800, 
                          math.pi/6-dv*self.strength/2, math.pi/6)
        
        -- dials
        
        love.graphics.setColor(0,0,0,0.7)
        love.graphics.draw(self.dial, x, y)
    end
    
    function car:mech(key)
        if key == self.z then
            self.bite = 0.7
            if self.stress < 80 then
                self.u = self.u + (self.stress-(self.u/30)^2)*
                  self.strength/80
            elseif self.u > 3 then
                self.u = self.u + (50 - self.stress-(self.u/30)^2)*
                  self.strength/80
            else
                self.u = 0
            end
            if self.stress <= 100 then
                self.stress = self.stress + self.strength/2
            end
            if self.stress >= 100 then
                self.stress = 100
            end
        end
    end
    
    function car:draw_whip(x, y)
       
    if self.bite <= 0 then
      num = -1
    elseif self.bite <= 0.1 then
      self.bite = 0
        num = 6
    elseif self.bite <= 0.2 then
        num = 5
    elseif self.bite <= 0.3 then
        num = 4
    elseif self.bite <= 0.4 then
        num = 3
    elseif self.bite <= 0.5 then
        num = 2
    elseif self.bite <= 0.6 then
        num = 1
    elseif self.bite <= 0.7 then
        num = 0
    end
   
    whip_width = math.floor(self.whip:getWidth()/7)
    
    if num >=0 then
      local quad = love.graphics.newQuad(num * whip_width, 0, 
                                               whip_width,
                                               self.whip:getHeight(),
                                               self.whip:getDimensions())
            love.graphics.draw(self.whip,  quad, x+40, y, 0, self.offset[1],self.offset[2], 64,32)
                             
        end
    end
    
    setmetatable(obj, self)
    self.__index = self
    return obj
end

return car
