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

    if aliveNeighbours == 3 then -- If 3 alive neighbours, cell stays/becomes alive
        map[x][y] = 1
    elseif aliveNeighbours == 2 and map[x][y] == 1 then -- If 2 alive neighbours AND cell is already alive, stay that way
        map[x][y] = 1
    else -- Otherwise, cell is dead :(
        map[x][y] = 0
    end

    print("\tNew value: "..map[x][y])
end

