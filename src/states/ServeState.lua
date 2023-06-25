ServeState = Class{__includes = BaseState}

function ServeState:enter(params)
    self.paddle = params.paddle
    self.bricks = params.bricks
    self.health = params.health
    self.score = params.score
    self.maxHealth = params.maxHealth
    self.level = params.level

    self.ball = Ball()
    self.ball.skin = math.random(7)
end

function ServeState:update(dt)

    self.paddle:update(dt)

    self.ball.x = self.paddle.x + (self.paddle.width / 2) - 4
    self.ball.y = self.paddle.y - 8

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play', {
            paddle = self.paddle,
            bricks = self.bricks,
            health = self.health,
            score = self.score,
            ball = self.ball,
            maxHealth = self.maxHealth,
            level = self.level
        })
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function ServeState:render()
    self.paddle:render()
    self.ball:render()

    for k, brick in pairs(self.bricks) do
        brick:render()
    end

    renderScore(self.score)
    renderHealth(self.health, self.maxHealth)

    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Level ' .. tostring(self.level), 0, V_HEIGTH / 2 - 20,V_WIDTH,'center')
    love.graphics.printf('Press Enter to serve!', 0, V_HEIGTH / 2,V_WIDTH,'center')
    
end