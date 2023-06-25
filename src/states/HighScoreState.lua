HighScoreState = Class{__includes = BaseState}

function HighScoreState:enter(params)
    self.highScores = params.highScores
end

function HighScoreState:update(dt)

    if love.keyboard.wasPressed('escape') then
        gSounds['wall-hit']:play()

        gStateMachine:change('start', {
            highScores = self.highScores
        })
    end
end

function HighScoreState:render()
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('High Scores', 0, 20, V_WIDTH, 'center')

    love.graphics.setFont(gFonts['medium'])

    for i = 1, 10 do
        local name = self.highScores[i].name or '---'
        local score = self.highScores[i].score or '---'

        love.graphics.printf(tostring(i) .. '.', V_WIDTH/4,60+i*13, 50, 'left')
        love.graphics.printf(name, V_WIDTH/4 + 38,60+i*13, 50, 'right')
        love.graphics.printf(tostring(score), V_WIDTH/2,60+i*13, 50, 'right')
    end

    love.graphics.setFont(gFonts['small'])
    love.graphics.printf("Press Escape to return to the main menu!", 0, V_HEIGTH - 18, V_WIDTH, 'center')
end