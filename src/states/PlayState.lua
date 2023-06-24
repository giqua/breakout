PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.paddle = Paddle()
    self.ball = Ball(1)

    self.ball.dx = math.random(-200, 200)
    self.ball.dy = math.random(-50,-60)

    self.ball.x = V_WIDTH / 2 - 4
    self.ball.y = V_HEIGTH - 42
    self.paused = false

    self.bricks = LevelMaker.createMap()
end

function PlayState:update(dt)
    if self.paused then
        if love.keyboard.wasPressed('p') then
            self.paused = false
            gSounds['pause']:play()
        else 
            return
        end
    elseif love.keyboard.wasPressed('p') then
        self.paused = true
        gSounds['pause']:play()
        return
    end

    self.paddle:update(dt)
    self.ball:update(dt)

    if self.ball:collides(self.paddle) then
        self.ball.dy = -self.ball.dy
        gSounds['paddle-hit']:play()
    end
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    for k, brick in pairs(self.bricks) do
        if brick.inPlay and self.ball:collides(brick) then
            self.ball.dy = -self.ball.dy
            brick:hit()
        end
    end
end

function PlayState:render()
    self.paddle:render()
    self.ball:render()

    for k,brick in pairs(self.bricks) do
        if brick.inPlay then
            brick:render()
        end
    end
    
    if self.paused then
        love.graphics.setFont(gFonts['large'])
        love.graphics.printf("GAME PAUSED", 0, V_HEIGTH / 2 -16, V_WIDTH, 'center')
    end
end