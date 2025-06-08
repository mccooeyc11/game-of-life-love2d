function love.load()
    -- Set colours
    love.graphics.setBackgroundColor(1,1,1,1)
    love.graphics.setColor(0,0,0,1)

    -- Declare and initialise game variables
    cellSize = 64 -- Default cell size
    genTime = 10 -- Number of frames for each generation
    currentGen = 0 -- Current generation

    map = {
        {0, 0, 0, 0, 0},
        {0, 0, 1, 0, 0},
        {0, 1, 1, 0, 0},
        {0, 0, 1, 1, 0},
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

    -- Draw generation counter below grid
    love.graphics.print("Generation "..currentGen, 0, cellSize*(gridSize + 1))
    -- Draw grid
    for y=1, #map do
        for x=1, #map[y] do
            if map[y][x] == 1 then
                love.graphics.rectangle("fill", x * cellSize, y * cellSize, cellSize, cellSize)
            else
                love.graphics.rectangle("line", x * cellSize, y * cellSize, cellSize, cellSize)
            end
        end
    end
end

--FOR TESTING --
function love.mousepressed( x, y, button, istouch, presses )
    updateGrid(map)
end
-- FOR TESTING --

function updateGrid(map)
    -- Initialise buffer
    buffer = {}
    for i=1, gridSize do
        table.insert(buffer, {})
        for j=1, gridSize do
            table.insert(buffer[i],2)
        end
    end

    -- Update cells
    for y=1, #map do
        for x=1, #map[y] do
            print("Updating cell ("..x..","..y..")...")
            updateCell(map, buffer, x, y)
            printGrid(buffer)
        end
    end

    -- Move buffer to display map
    for y=1, #map do
        for x=1, #map[y] do
            map[y][x] = buffer[y][x]
        end
    end
    -- Increment generation
    currentGen = currentGen + 1
end

function updateCell(map, buffer, x, y)
    print("\tInitial value: "..map[y][x])

    -- Get number of alive neighbours
    aliveNeighbours = 0

    if y-1 >= 1 then
        if x-1 >= 1 then aliveNeighbours = aliveNeighbours + map[y-1][x-1] end                     -- Top left neighbour
        aliveNeighbours = aliveNeighbours + map[y-1][x]                                            -- Top centre
        if x+1 <= gridSize and y-1 >= 1 then aliveNeighbours = aliveNeighbours + map[y-1][x+1] end -- Top right
    end


    if x-1 >= 1 then aliveNeighbours = aliveNeighbours + map[y][x-1] end                           -- Centre left
    if x+1 <= gridSize then aliveNeighbours = aliveNeighbours + map[y][x+1] end                    -- Centre right

    if y+1 <= gridSize then
        if x-1 >= 1 then aliveNeighbours = aliveNeighbours + map[y+1][x-1] end                     -- Top left neighbour
        aliveNeighbours = aliveNeighbours + map[y+1][x]                                            -- Top centre
        if x+1 <= gridSize then aliveNeighbours = aliveNeighbours + map[y+1][x+1] end              -- Top right
    end

    print("\tLiving neighbours: "..aliveNeighbours)

    if aliveNeighbours == 3 then -- If 3 alive neighbours, cell stays/becomes alive
        buffer[y][x] = 1
    elseif aliveNeighbours == 2 and map[y][x] == 1 then -- If 2 alive neighbours AND cell is already alive, stay that way
        buffer[y][x] = 1
    else -- Otherwise, cell is dead :(
        buffer[y][x] = 0
    end

    print("\tNew value: "..buffer[y][x])
end

function printGrid(grid) -- FOR TESTING
    for y=1, #grid do
        row = "{"
        for x=1, #grid[y] do
            row = row..grid[y][x]..","
        end
        row = row.."},"
        print(row)
    end
end
