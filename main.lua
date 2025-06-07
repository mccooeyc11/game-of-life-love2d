function love.load()
    -- Declare and initialise variables
    cellSize = 64 -- Default cell size
    genTime = 10 -- Number of frames for each generation

    love.graphics.setBackgroundColor(1,1,1,1)
    love.graphics.setColor(0,0,0,1)

    map = {
        {0, 0, 0, 0, 0},
        {0, 1, 0, 0, 0},
        {0, 0, 0, 0, 0},
        {0, 0, 0, 1, 0},
        {0, 0, 0, 0, 0}
    }
end

function love.update(dt)
    -- Update cells every generation
end

function love.draw()

    -- Draw grid
    for y=1, #map do
        for x=1, #map[y] do
            if map[y][x] == 1 then
                love.graphics.rectangle("fill", x * cellSize, y * cellSize, cellSize, cellSize)
            end
        end
    end
end
