void renderMenu()
{
    randomStartButton.update();
    gosperGliderGun.update();
    singleGlider.update();
    readFromFile.update();
}
void renderGUI()
{ // Render process for the GUI will go in here
}

void renderGame()
{
    int gridX = screenXPos / CELL_SIZE;
    int gridY = screenYPos / CELL_SIZE;
    // This renders the current part of the matrix that is viewed (Also it renders one cell either side of the boarders to make sure scrolling is smooth)
    for(int i = gridX - 1; i < gridX + SCREEN_GRID_WIDTH + 1; i++) // Goes through the 2d matrix and draws the cell if it is alive
    {
        for(int j = gridY - 1; j < gridY + SCREEN_GRID_HEIGHT + 1; j++)
        {
            if(i < 0 || j < 0 || i == SCREEN_GRID_WIDTH || j == SCREEN_GRID_HEIGHT)
            {
                continue;
            }
            if(board[i][j] == 1) // 1 means that it is alive
            {
                stroke(0, 255, 0);
                fill(0, 255, 0);
                rect(i*10 - screenXPos, j*10 - screenYPos, 10, 10); // Multiplies the index by 10 because each one is a 10 by 10 pixel
            }
        }
    }
}