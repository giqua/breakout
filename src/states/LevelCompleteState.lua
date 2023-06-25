LevelCompleteState = Class{__includes = BaseState}

function LevelCompleteState:enter(params)
    self.paddle = params.paddle
    self.bricks = params.bricks
    self.health = params.health
    self.score = params.score
    self.maxHealth = params.maxHealth
    self.level = params.level

    self.ball = params.ball
end

function LevelCompleteState:update(dt)

    self.paddle:update(dt)

    self.ball.x = self.paddle.x + (self.paddle.width / 2) - 4
    self.ball.y = self.paddle.y - 8

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('serve', {
            paddle = self.paddle,
            bricks = LevelMaker.createMap(self.level + 1),
            health = self.health,
            score = self.score,
            ball = self.ball,
            maxHealth = self.maxHealth,
            level = self.level + 1
        })
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function LevelCompleteState:render()
    self.paddle:render()
    self.ball:render()

    for k, brick in pairs(self.bricks) do
        brick:render()
    end

    renderScore(self.score)
    renderHealth(self.health, self.maxHealth)

    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('Level ' .. tostring(self.level) .. ' completed !', 0, V_HEIGTH / 2 - 30,V_WIDTH,'center')
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Press Enter to serve!', 0, V_HEIGTH / 2,V_WIDTH,'center')
    
end