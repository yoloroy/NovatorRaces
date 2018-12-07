extra = {}

function extra:deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[extra.deepcopy(orig_key)] = extra.deepcopy(orig_value)
        end
        setmetatable(copy, extra.deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function extra:find_point_on_circle(radius, angle, ox, oy)
    x = ox + radius*math.cos(angle)
    y = oy + radius*math.sin(angle)
    
    return {x, y}
end

function extra:draw_dial(width, height)
    love.graphics.setColor(0, 0, 0, 0.65)
    local canvas = love.graphics.newCanvas(1200, 1200)
    
    do
    love.graphics.setCanvas(canvas)
    love.graphics.setLineWidth(2)
      do
        -- Stress-dial
        love.graphics.arc("line", "open", width/16, height/2, 
          800, -math.pi/6, math.pi/6)
        love.graphics.arc("line", "open", width/16+12, height/2, 
          800, -math.pi/6, math.pi/6)
        dv = math.pi/3/20
        for i = 0, 20 do
            coords = extra:find_point_on_circle(800, -math.pi/6 + dv*i, 
              width/16, height/2)
            love.graphics.line(coords[1], coords[2], 
                               coords[1]+18, coords[2])
            love.graphics.print((20-i)*5, 
                               coords[1]+10+(20-i),
                               coords[2]+3)
        end
      end
      do
        -- Strength-dial
        love.graphics.arc("line", "open", width/16-22, height/2, 
          800, math.pi/6, 0)
        love.graphics.arc("line", "open", width/16-34, height/2, 
          800, math.pi/6, 0)
        dv = math.pi/6/10
        for i = 0, 10 do
            coords = extra:find_point_on_circle(800, dv*i, width/16-22, height/2)
            love.graphics.line(coords[1]-10, coords[2], 
                               coords[1]+12, coords[2])
            love.graphics.print((10-i)*10, 
                               coords[1]-28-(10-i),
                               coords[2]-9)
        end
      end
    end
    love.graphics.setCanvas()
    return canvas
end

function extra:draw_path(width, height)
    local canvas = love.graphics.newCanvas(width, height)
    love.graphics.setCanvas(canvas)
      love.graphics.setColor(0,0,0,1)
      love.graphics.setLineWidth(2)
      love.graphics.line(width/200, height/200, 
                 width - width/200, height/200)
      love.graphics.line(width/200, height/200+20, 
                 width - width/200, height/200+20)
    love.graphics.setCanvas()
    return canvas
end

return extra
