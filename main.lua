function love.load()
    -- Declare and initialise variables
    cellSize = 64 -- Default cell size
    genTime = 10 -- Number of frames for each generation

    love.graphics.setBackgroundColor(1,1,1,1)
    love.graphics.setColor(0,0,0,1)

    map = {
        {0, 1, 1, 0, 0},
        {1, 1, 0, 0, 0},
        {0, 0, 0, 0, 0},
        {0, 0, 0, 1, 0},
        {0, 0, 0, 0, 0}
    }

    -- Get size of grid
    gridSize = 0
    for y=1, #map do
        gridSize = gridSize + 1
    end
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

--FOR TESTING --
function love.mousepressed( x, y, button, istouch, presses )
    -- Update all cells on mouse click
    for y=1, #map do
        for x=1, #map[y] do
            print("Updating cell ("..x..","..y..")...")
            updateCell(map, x, y)
        end
    end
end
-- FOR TESTING --

function updateCell(map, x, y)
    print("\tInitial value: "..map[x][y])

    -- Get number of alive neighbours
    aliveNeighbours = 0

    if x-1 >= 1 and y-1 >= 1 then aliveNeighbours = aliveNeighbours + map[x-1][y-1] end               -- Top left neighbour
    if y-1 >= 1 then aliveNeighbours = aliveNeighbours + map[x][y-1] end                              -- Top centre
    if x+1 <= gridSize and y-1 >= 1 then aliveNeighbours = aliveNeighbours + map[x+1][y-1] end        -- Top right

    if x-1 >= 1 then aliveNeighbours = aliveNeighbours + map[x-1][y] end                              -- Centre left
    if x+1 <= gridSize then aliveNeighbours = aliveNeighbours + map[x+1][y] end                       -- Centre right

    if x-1 >= 1 and y+1 <= gridSize then aliveNeighbours = aliveNeighbours + map[x-1][y+1] end        -- Top left neighbour
    if y+1 <= gridSize then aliveNeighbours = aliveNeighbours + map[x][y+1] end                       -- Top centre
    if x+1 <= gridSize and y+1 <= gridSize then aliveNeighbours = aliveNeighbours + map[x+1][y+1] end -- Top right


--     if x == 1 and y == 1 then
--         aliveNeighbours = map[x+1][y] + map[x][y+1] + map[x+1][y+1]
--     elseif x == 1 then
--         aliveNeighbours = map[x][y-1] + map[x+1][y-1] + map[x+1][y] + map[x][y+1] + map[x+1][y+1]
--     elseif y == 1 then
--         aliveNeighbours = map[x-1][y] + map[x+1][y] + map[x-1][y+1] + map[x][y+1] + map[x+1][y+1]
--     else
--         aliveNeighbours = map[x-1][y-1] + map[x][y-1] + map[x+1][y-1]
--                         + map[x-1][y]   +               map[x+1][y]
--                         + map[x-1][y+1] + map[x][y+1] + map[x+1][y+1]
--     end

    -- Lua has no conditional ternary operator, using that 'and or' method to approximate functionality
    -- It's messy, but less messy than trying to do this with if statements
--     aliveNeighbours = (((x-1 ~= nil) and (y-1 ~= nil)) and map[x-1][y-1] or 0) -- Top left neighbour
--                     + ((y-1 ~= nil) and map[x][y-1] or 0)                      -- Top centre
--                     + (((x+1 ~= nil) and (y-1 ~= nil)) and map[x+1][y-1] or 0) -- Top right
--                     + ((x-1 ~= nil) and map[x-1][y] or 0)                      -- Centre left
--                     + ((x+1 ~= nil) and map[x+1][y] or 0)                      -- Centre right
--                     + (((x-1 ~= nil) and (y+1 ~= nil)) and map[x-1][y+1] or 0) -- Bottom left
--                     + ((y+1 ~= nil) and map[x][y+1] or 0)                      -- Bottom centre
--                     + (((x+1 ~= nil) and (y+1 ~= nil)) and map[x+1][y+1] or 0) -- Bottom right

--         aliveNeighbours = ternary(not (x-1) or (y-1), map[x-1][y-1], 0) -- Top left neighbour
--                         + ((y-1 ~= nil) and map[x][y-1] or 0)                      -- Top centre
--                         + (((x+1 ~= nil) and (y-1 ~= nil)) and map[x+1][y-1] or 0) -- Top right
--                         + ((x-1 ~= nil) and map[x-1][y] or 0)                      -- Centre left
--                         + ((x+1 ~= nil) and map[x+1][y] or 0)                      -- Centre right
--                         + (((x-1 ~= nil) and (y+1 ~= nil)) and map[x-1][y+1] or 0) -- Bottom left
--                         + ((y+1 ~= nil) and map[x][y+1] or 0)                      -- Bottom centre
--                         + (((x+1 ~= nil) and (y+1 ~= nil)) and map[x+1][y+1] or 0) -- Bottom right

--     aliveNeighbours = ((not x-1 or y-1) and {map[x-1][y-1]} or {0})[1] -- Top left neighbour
--                     + ((y-1 ~= nil) and {map[x][y-1]} or {0})[1]                      -- Top centre
--                     + (((x+1 ~= nil) and (y-1 ~= nil)) and {map[x+1][y-1]} or {0})[1] -- Top right
--                     + ((x-1 ~= nil) and {map[x-1][y]} or {0})[1]                      -- Centre left
--                     + ((x+1 ~= nil) and {map[x+1][y]} or {0})[1]                      -- Centre right
--                     + (((x-1 ~= nil) and (y+1 ~= nil)) and {map[x-1][y+1]} or {0})[1] -- Bottom left
--                     + ((y+1 ~= nil) and {map[x][y+1]} or {0})[1]                      -- Bottom centre
--                     + (((x+1 ~= nil) and (y+1 ~= nil)) and {map[x+1][y+1]} or {0})[1] -- Bottom right


    if aliveNeighbours == 3 then -- If 3 alive neighbours, cell stays/becomes alive
        map[x][y] = 1
    elseif aliveNeighbours == 2 and map[x][y] == 1 then -- If 2 alive neighbours AND cell is already alive, stay that way
        map[x][y] = 1
    else -- Otherwise, cell is dead :(
        map[x][y] = 0
    end

    print("\tNew value: "..map[x][y])
end

-- from https://stackoverflow.com/a/5529577
function ternary ( cond , T , F )
    if cond then return T else return F end
end
