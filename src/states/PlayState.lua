PlayState = Class{__includes = BaseState}

function PlayState:enter(params)
    self.paddle = params.paddle
    self.ball = params.ball

    self.ball.dx = math.random(-200, 200)
    self.ball.dy = math.random(-50,-60)

    self.paused = false

    self.bricks = params.bricks
    self.score = params.score
    self.maxHealth = params.maxHealth
    self.health = params.health
    self.level = params.level
end

function PlayState:update(dt)
    print(self.level)
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

    CollisionManager.processCollision(self.ball, self.paddle, "PADDLE")

    
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    if self.ball.y >= V_HEIGTH then
        self.health = self.health - 1
        gSounds['hurt']:play()

        if self.health == 0 then
            gStateMachine:change('game-over',{
                score = self.score
            })
            else
                gStateMachine:change('serve',{
                    paddle = self.paddle,
                    bricks = self.bricks,
                    health = self.health,
                    maxHealth = self.maxHealth,
                    score = self.score,
                    level = self.level
                })
        end
    end
    local numInPlay = #self.bricks
    for k, brick in pairs(self.bricks) do
        if brick.inPlay then
            local collision = CollisionManager.processCollision(self.ball, brick, "BRICK")
            if collision then
                self.score = self.score + 100
            end
        else
            numInPlay = numInPlay - 1
        end
    end
    if numInPlay == 0 then
        if self.health < self.maxHealth then
            self.health = self.health + 1
        end
        gStateMachine:change('serve', {
            paddle = self.paddle,
            bricks = LevelMaker.createMap(self.level + 1),
            health = self.health,
            maxHealth = self.maxHealth,
            score = self.score,
            level = self.level + 1
        })
    end

    CollisionManager.processCollision(self.ball, self.ball, "WALL")
end

function PlayState:render()
    self.paddle:render()
    self.ball:render()

    for k,brick in pairs(self.bricks) do
        if brick.inPlay then
            brick:render()
        end
    end

    renderScore(self.score)
    renderHealth(self.health, self.maxHealth)
    
    if self.paused then
        love.graphics.setFont(gFonts['large'])
        love.graphics.printf("GAME PAUSED", 0, V_HEIGTH / 2 -16, V_WIDTH, 'center')
    end
end