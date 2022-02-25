io.stdout:setvbuf('no')


-- Création du vaisseau

local Lander = {}
Lander.x = 0
Lander.y = 0
Lander.angle = 270
Lander.vx = 0
Lander.vy = 0
Lander.speed = 3
Lander.img = love.graphics.newImage("ship.png")
Lander.imgEngine = love.graphics.newImage("engine.png")
Lander.engineFire = false

local forceX = 0
local forceY = 0

function love.load()
    screenWidth = love.graphics.getWidth()
    screenHeight = love.graphics.getHeight()

    Lander.x = screenWidth / 2
    Lander.y = screenHeight / 2


end

function love.update(dt)
    -- Lander.vy = Lander.vy + (0.6 * dt)

    Lander.x = Lander.x + Lander.vx
    Lander.y = Lander.y + Lander.vy

    if love.keyboard.isDown("right") then
        Lander.angle = Lander.angle + 90 * dt

        if Lander.angle > 360 then Lander.angle = 0 end
    end
    if love.keyboard.isDown("left") then
        Lander.angle = Lander.angle - 90 * dt
        if Lander.angle < 0 then Lander.angle = 360 end
    end
    if love.keyboard.isDown("up") then
        local angleRad = math.rad(Lander.angle)
        forceX = math.cos(angleRad) * (Lander.speed * dt)
        forceY = math.sin(angleRad) * (Lander.speed * dt)
        
        if math.abs(Lander.vx) < 2 then
            -- Lander.vx = Lander.vx + forceX
        end
        
        if math.abs(Lander.vy) < 2 then
            -- Lander.vy = Lander.vy + forceY
        end

        Lander.engineFire = true
    else 
        Lander.engineFire = false
    end

    if love.keyboard.isDown("space") then
        Lander.fire = true
        -- love.sound.play("")
    end
end
-- Quand je relache le up je fait retomber la vitesse à 0 de façon décroissante.

function love.draw()
    love.graphics.draw(Lander.img, Lander.x, Lander.y,math.rad(Lander.angle), 1, 1, Lander.img:getWidth() / 2, Lander.img:getHeight() / 2)

    if Lander.engineFire then
    love.graphics.draw(Lander.imgEngine, Lander.x, Lander.y,math.rad(Lander.angle), 1, 1, Lander.imgEngine:getWidth() / 2, Lander.imgEngine:getHeight() / 2)
    end

    local sdebug = ""
    sdebug = sdebug.."Angle : "..Lander.angle
    sdebug = sdebug.." vx : "..Lander.vx
    sdebug = sdebug.." vy : "..Lander.vy
    sdebug = sdebug.." speed : "..Lander.speed
    sdebug = sdebug.." forceX : "..forceX
    sdebug = sdebug.." forceY : "..forceY

    love.graphics.print(sdebug,0,0)
end