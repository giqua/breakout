PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.paddle = Paddle()
    self.paused = false
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
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function PlayState:render()
    self.paddle:render()
    
    if self.paused then
        love.graphics.setFont(gFonts['large'])
        love.graphics.printf("GAME PAUSED", 0, V_HEIGTH / 2 -16, V_WIDTH, 'center')
    end
end