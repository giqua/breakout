SelectPaddleState = Class{__includes = BaseState}


function SelectPaddleState:enter(params)
    self.highScores = params.highScores
end

function  SelectPaddleState:init()
    self.currentPaddle = 1
end

function SelectPaddleState:update(dt)
    if love.keyboard.wasPressed('left') then
        if self.currentPaddle == 1 then
            gSounds['no-select']:play()
        else
            gSounds['select']:play()
            self.currentPaddle = self.currentPaddle - 1
        end
    elseif love.keyboard.wasPressed('right') then
        if self.currentPaddle == 4 then
            gSounds['no-select']:play()
        else
            gSounds['select']:play()
            self.currentPaddle = self.currentPaddle + 1
        end
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gSounds['confirm']:play()
        gStateMachine:change('serve',{
            paddle = Paddle(self.currentPaddle),
            bricks = LevelMaker.createMap(1),
            health = MAX_HEALTH,
            score = 0,
            maxHealth = MAX_HEALTH,
            level = 1,
            highScores = self.highScores
        })
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function SelectPaddleState:render()
    --instructions
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Select your paddle with left and right!', 0, V_HEIGTH / 4, V_WIDTH, 'center')

    love.graphics.setFont(gFonts['small'])
    love.graphics.printf('Press Enter to continue!', 0, V_HEIGTH / 3, V_WIDTH, 'center')

    if self.currentPaddle == 1 then
        love.graphics.setColor(40/255, 40/255, 40/255, 128/255)
    end

    love.graphics.draw(gTextures['arrows'], gFrames['arrows'][1], V_WIDTH/4 - 24, V_HEIGTH - V_HEIGTH / 3)

    love.graphics.setColor(1, 1, 1, 1)

    if self.currentPaddle == 4 then
        love.graphics.setColor(40/255,40/255, 40/255, 128/255)
    end

    love.graphics.draw(gTextures['arrows'], gFrames['arrows'][2], V_WIDTH - V_WIDTH / 4, V_HEIGTH - V_HEIGTH / 3)

    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.draw(gTextures['main'], gFrames['paddles'][2 + 4 * (self.currentPaddle - 1)], V_WIDTH / 2 - 32, V_HEIGTH - V_HEIGTH / 3)
end