void renderBoard()
{
    boolean notDrawnStructuresLines = true; // This makes sure that we don't draw the lines around the structure multiple times
    int gridX = screenXPos / cellSize;
    int gridY = screenYPos / cellSize;
    // This renders the current part of the matrix that is viewed (Also it renders one cell either side of the boarders to make sure scrolling is smooth)
    for(int i = gridX - 1; i < gridX + screenGridWidth + 1; i++) // Goes through the 2d matrix and draws the cell if it is alive
    {
        for(int j = gridY - 1; j < gridY + screenGridHeight + 1; j++)
        {
            if(i < 0 || j < 0 || i >= BOARD_WIDTH || j >= BOARD_HEIGHT) // This is just safe guards just so it doesn't through an error
            {
                continue;
            }
            // This renders a structure, if the user is trying to place one (and also checks if things are in the right place)
            if(currentStructureActive != -1
                && renderStructure
                && i >= structures.get(currentStructureActive).getX()
                && i < structures.get(currentStructureActive).getX() + structures.get(currentStructureActive).getWidth()
                && j >= structures.get(currentStructureActive).getY()
                && j < structures.get(currentStructureActive).getY() + structures.get(currentStructureActive).getHeight())
            {
                if (notDrawnStructuresLines)
                { // This draws the lines around the structure
                    stroke(0);
                    int structScreenX = structures.get(currentStructureActive).getX() * cellSize - screenXPos;
                    int structScreenY = structures.get(currentStructureActive).getY() * cellSize - screenYPos;
                    line(structScreenX,
                         structScreenY,
                         structScreenX + structures.get(currentStructureActive).getWidth() * cellSize,
                         structScreenY
                    );
                    line(structScreenX,
                         structScreenY,
                         structScreenX,
                         structScreenY + structures.get(currentStructureActive).getHeight() * cellSize
                    );
                    line(structScreenX,
                         structScreenY + structures.get(currentStructureActive).getHeight() * cellSize,
                         structScreenX + structures.get(currentStructureActive).getWidth() * cellSize,
                         structScreenY + structures.get(currentStructureActive).getHeight() * cellSize
                    );
                    line(structScreenX + structures.get(currentStructureActive).getWidth() * cellSize,
                         structScreenY,
                         structScreenX + structures.get(currentStructureActive).getWidth() * cellSize,
                         structScreenY + structures.get(currentStructureActive).getHeight() * cellSize
                    );
                    notDrawnStructuresLines = false;
                }
                int structX = i - structures.get(currentStructureActive).getX(); // This gets the x and y value for which section it is looking at for the structure
                int structY = j - structures.get(currentStructureActive).getY();
                if(structures.get(currentStructureActive).get(structX, structY))
                { // This renders the squares as blue (as they will be created when the structure is placed)
                    stroke(0, 0, 255);
                    fill(0, 0, 255);
                    rect(i*cellSize - screenXPos, j*cellSize - screenYPos, cellSize, cellSize);
                } else if(board[i][j])
                { // This renders the squares as red (as they will be destroyed when the structure is placed)
                    stroke(255, 0, 0);
                    fill(255, 0, 0);
                    rect(i*cellSize - screenXPos, j*cellSize - screenYPos, cellSize, cellSize);
                }
            } else if(board[i][j]) // 1 means that it is alive
            {
                stroke(0, 255, 0);
                fill(0, 255, 0);
                rect(i*cellSize - screenXPos, j*cellSize - screenYPos, cellSize, cellSize); // Multiplies the index by 10 because each one is a 10 by 10 pixel
            }
        }
    }
}

void render()
{ // This renders the background and then the other things
    background(backgroundColour);
    renderBoard();
    if(currentStructureActive != -1)
    {
        structures.get(currentStructureActive).update();
    }
    menus[currentMenu].render();
}
