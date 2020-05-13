PImage img;

void renderMenu()
{ // Renders all the videos
    randomStartButton.render();
    readFromFile.render();
    sandbox.render();
    exitButton.render();
    image(img, (SCREEN_WIDTH / 2) - (width / 4), 60, width / 2, height / 3);
}
void renderGUI()
{ // Render process for the GUI will go in here
    if(mode != 1){ // checks what mode you are in
        if(inStructureMenu)
        { // If in the structure menu it renders the structures
            for(int i = 0; i < structures.size(); i++)
            {
                structures.get(i).render(i * 102 + 50, 50);
            }
        } else
        { // Otherwise it renders the structure button
            spawnStructureButton.render();
        }
        if(currentStructureActive != -1)
        { // If the user is placing a structure, it updates the structure and renders the cancel button
            cancelButton.render();
            structures.get(currentStructureActive).update();
        }
    }
    menuButton.render(); // Always renders the menuButton
    if(mode != 0){ // Checks the right mode
      if(paused == false){ // Renders the pause and play button
        pauseButton.render();
      }
      if(paused == true){
        playButton.render();
      }
    }
}

void renderBoard()
{
    boolean notDrawnStructuresLines = true; // This makes sure that we don't draw the lines around the structure multiple times
    int gridX = screenXPos / CELL_SIZE;
    int gridY = screenYPos / CELL_SIZE;
    // This renders the current part of the matrix that is viewed (Also it renders one cell either side of the boarders to make sure scrolling is smooth)
    for(int i = gridX - 1; i < gridX + SCREEN_GRID_WIDTH + 1; i++) // Goes through the 2d matrix and draws the cell if it is alive
    {
        for(int j = gridY - 1; j < gridY + SCREEN_GRID_HEIGHT + 1; j++)
        {
            if(i < 0 || j < 0 || i >= BOARD_WIDTH || j >= BOARD_HEIGHT) // This is just safe guards just so it doesn't through an error
            {
                continue;
            }
            // This renders a structure, if the user is trying to place one (and also checks if things are in the right place)
            if(currentStructureActive != -1
                && i >= structures.get(currentStructureActive).getX()
                && i < structures.get(currentStructureActive).getX() + structures.get(currentStructureActive).getWidth()
                && j >= structures.get(currentStructureActive).getY()
                && j < structures.get(currentStructureActive).getY() + structures.get(currentStructureActive).getHeight())
            {
                if (notDrawnStructuresLines)
                { // This draws the lines around the structure
                    stroke(0);
                    int structScreenX = structures.get(currentStructureActive).getX() * CELL_SIZE - screenXPos;
                    int structScreenY = structures.get(currentStructureActive).getY() * CELL_SIZE - screenYPos;
                    line(structScreenX,
                         structScreenY,
                         structScreenX + structures.get(currentStructureActive).getWidth() * CELL_SIZE,
                         structScreenY
                    );
                    line(structScreenX,
                         structScreenY,
                         structScreenX,
                         structScreenY + structures.get(currentStructureActive).getHeight() * CELL_SIZE
                    );
                    line(structScreenX,
                         structScreenY + structures.get(currentStructureActive).getHeight() * CELL_SIZE,
                         structScreenX + structures.get(currentStructureActive).getWidth() * CELL_SIZE,
                         structScreenY + structures.get(currentStructureActive).getHeight() * CELL_SIZE
                    );
                    line(structScreenX + structures.get(currentStructureActive).getWidth() * CELL_SIZE,
                         structScreenY,
                         structScreenX + structures.get(currentStructureActive).getWidth() * CELL_SIZE,
                         structScreenY + structures.get(currentStructureActive).getHeight() * CELL_SIZE
                    );
                    notDrawnStructuresLines = false;
                }
                int structX = i - structures.get(currentStructureActive).getX(); // This gets the x and y value for which section it is looking at for the structure
                int structY = j - structures.get(currentStructureActive).getY();
                if(structures.get(currentStructureActive).get(structX, structY))
                { // This renders the squares as blue (as they will be created when the structure is placed)
                    stroke(0, 0, 255);
                    fill(0, 0, 255);
                    rect(i*CELL_SIZE - screenXPos, j*CELL_SIZE - screenYPos, CELL_SIZE, CELL_SIZE);
                } else if(board[i][j])
                { // This renders the squares as red (as they will be destroyed when the structure is placed)
                    stroke(255, 0, 0);
                    fill(255, 0, 0);
                    rect(i*CELL_SIZE - screenXPos, j*CELL_SIZE - screenYPos, CELL_SIZE, CELL_SIZE);
                }
            } else if(board[i][j]) // 1 means that it is alive
            {
                stroke(0, 255, 0);
                fill(0, 255, 0);
                rect(i*CELL_SIZE - screenXPos, j*CELL_SIZE - screenYPos, CELL_SIZE, CELL_SIZE); // Multiplies the index by 10 because each one is a 10 by 10 pixel
            }
        }
    }
}

void render()
{ // This renders the background and then the other things
    background(backgroundColour);
    renderBoard();
    if(currentMenu == 1) // Chooses the run the board or...
    {
        renderMenu();
    }else {
        renderGUI();
    }
    //testBox.render();
}
