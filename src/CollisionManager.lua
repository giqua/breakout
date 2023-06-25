CollisionManager = Class{}

function CollisionManager.processBrickCollision(ball, brick)
    local overlap = false
    local shift_ball_x, shift_ball_y = 0,0
    if not(ball.x > brick.x + brick.width or brick.x > ball.x + ball.width
    or ball.y > brick.y + brick.height or brick.y > ball.y + ball.height) then
        overlap = true
        if (brick.x + brick.width / 2) < (ball.x + ball.width / 2) then
            shift_ball_x = (brick.x + brick.width) - ball.x          
        else
            shift_ball_x = brick.x - (ball.x + ball.width)
        end
        if (brick.y + brick.height / 2) < (ball.y + ball.height / 2) then
            shift_ball_y = (brick.y + brick.height) - ball.y         
        else
            shift_ball_y = brick.y - (ball.y + ball.height)
        end
    end
    return overlap, shift_ball_x, shift_ball_y
end

function CollisionManager.processPaddleCollision(ball, paddle)
    local overlap = false
    local shift_ball_x, shift_ball_y = 0,0
    if not(ball.x > paddle.x + paddle.width or paddle.x > ball.x + ball.width
    or ball.y > paddle.y + paddle.height or paddle.y > ball.y + ball.height) then
        overlap = true
        if (paddle.x + paddle.width / 2) < (ball.x + ball.width / 2) then
            shift_ball_x = (paddle.x + paddle.width) - ball.x          
        else
            shift_ball_x = paddle.x - (ball.x + ball.width)
        end
        if (paddle.y + paddle.height / 2) < (ball.y + ball.height / 2) then
            shift_ball_y = (paddle.y + paddle.height) - ball.y         
        else
            shift_ball_y = paddle.y - (ball.y + ball.height)
        end
    end
    return overlap, shift_ball_x, shift_ball_y
end

function CollisionManager.processWallCollision(ball)
    local overlap = false
    if ball.x <= 0 then
        ball.x = 0
        ball.dx = -ball.dx
        overlap = true
    end

    if ball.x >= V_WIDTH - 8 then
        ball.x = V_WIDTH - 8
        ball.dx = -ball.dx
        overlap = true
    end
    if ball.y <= 0 then
        ball.y = 0
        ball.dy = -ball.dy
        overlap = true
    end
    return overlap
end

function CollisionManager.processCollision(ball, target, targetType)
    local overlap, shift_ball_x, shift_ball_y = false, 0, 0
    if targetType == "BRICK" then
        overlap, shift_ball_x, shift_ball_y =CollisionManager.processBrickCollision(ball, target)
        if overlap then
            ball:rebound(shift_ball_x,shift_ball_y)
            target:hit()
        end
    end
    if targetType == "PADDLE" then
        overlap, shift_ball_x, shift_ball_y = CollisionManager.processPaddleCollision(ball, target)
        if overlap then
            ball:rebound(shift_ball_x,shift_ball_y)
            gSounds['paddle-hit']:play()
        end
    end
    if targetType == "WALL" then
        overlap = CollisionManager.processWallCollision(ball)
        if overlap then
            gSounds['wall-hit']:play()
        end
    end
end