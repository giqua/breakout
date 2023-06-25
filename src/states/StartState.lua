StartState = Class{__includes = BaseState}

local highlighted = 1

function StartState:update(dt)
    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then
        highlighted = highlighted == 1 and 2 or 1
        gSounds['paddle-hit']:play()
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gSounds['confirm']:play()

        if highlighted == 1 then
            gStateMachine:change('serve',{
                paddle = Paddle(1),
                bricks = LevelMaker.createMap(1),
                health = MAX_HEALTH,
                score = 0,
                maxHealth = MAX_HEALTH,
                level = 1
            })
        end
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function StartState:render()
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('BREAKOUT', 0, V_HEIGTH / 3, V_WIDTH, 'center')

    love.graphics.setFont(gFonts['medium'])

    if highlighted == 1 then
        love.graphics.setColor(103/255, 1,1,1)
    end

    love.graphics.printf("START", 0, V_HEIGTH / 2 + 70, V_WIDTH, 'center')
    love.graphics.setColor(1,1,1,1)

    if highlighted == 2 then
        love.graphics.setColor(103/255, 1,1,1)
    end

    love.graphics.printf("HIGH SCORES", 0, V_HEIGTH / 2 + 90, V_WIDTH, 'center')
    love.graphics.setColor(1,1,1,1)
end