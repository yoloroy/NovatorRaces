player = {}

player.image = nil
player.x1 = nil
player.y1 = nil
player.size = {nil, nil}
player.u = 100
player.color = {150, 150, 150, 255}

function player:setImage(link)
    self.image = love.graphics.newImage(link)
end

function player:render()
    print(self.image)
    love.graphics.setColor(self.color[1]/255,
                           self.color[2]/255, 
                           self.color[3]/255, 
                           self.color[4]/255)
    love.graphics.draw(self.image,self.x1,self.y1,0,
                       self.size[1], self.size[2],64,32)
end

function player:update(dir, dt)
    print("update")
    if dir == -1 then
        self.x1 = self.x1 - self.u*dt
    elseif dir == 1 then
        self.x1 = self.x1 + self.u*dt
    end
end



return player
