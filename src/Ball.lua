Ball = Class{}

function Ball:init(skin)
    self.width = 8
    self.height = 8

    self.dy = 0
    self.dx = 0

    self.skin = skin

end

function Ball:rebound(shift_ball_x,shift_ball_y)
    local min_shift = math.min(math.abs(shift_ball_x),math.abs(shift_ball_y))
    if math.abs(shift_ball_x)== min_shift then
        shift_ball_y = 0
    else
        shift_ball_x = 0
    end
    self.x = self.x + shift_ball_x
    self.y = self.y + shift_ball_y

    if shift_ball_x ~= 0 then
        self.dx = -self.dx
    end
    if shift_ball_y ~= 0 then
        self.dy = -self.dy
    end
end

function Ball:reset()
    self.x = V_WIDTH / 2 - 2
    self.y = V_HEIGTH / 2 - 2    
    self.dx = 0
    self.dy = 0
end

function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt 
end

function Ball:render()
    love.graphics.draw(gTextures['main'], gFrames['balls'][self.skin], self.x, self.y)    
end