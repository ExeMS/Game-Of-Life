void mouseWheel(MouseEvent event)
{ // This is called when the user uses the scroll wheel
    float temp = round(event.getCount()); // This gets what direction the scroll wheel was used
    int e = 1;
    if(temp < 0)
    {
        e = -1;
    }
    if(currentStructureActive != -1)
    {
        structures.get(currentStructureActive).rotate(e); // This rotates the active structure
    } else if (currentMenu == 0)
    {
        // This recalculates the cellSize - for the zooming effect also recalculates the x and y coordinates of the screen
        if(e == 1 && cellSize != 3)
        {
            screenXPos = screenXPos * (cellSize - 1) / cellSize;
            screenYPos = screenYPos * (cellSize - 1) / cellSize;
            cellSize -= 1;
        }else if (e == -1 && cellSize != SCREEN_WIDTH)
        {
            screenXPos = screenXPos * (cellSize + 1) / cellSize;
            screenYPos = screenYPos * (cellSize + 1) / cellSize;
            cellSize += 1;
        }
        // This repositions the board to make sure that is not out-of-bounds
        if((screenXPos + SCREEN_WIDTH)/cellSize >= 1000)
        {
            screenXPos = 1000*cellSize - SCREEN_WIDTH;
        }
        if((screenYPos + SCREEN_HEIGHT)/cellSize >= 1000)
        {
            screenYPos = 1000*cellSize - SCREEN_HEIGHT;
        }
        screenGridHeight = SCREEN_HEIGHT / cellSize;
        screenGridWidth = SCREEN_WIDTH / cellSize;
    }
}

// Checks if mouse is pressed and is over any button
void checkMousePressed()
{
    if(mousePressed)
    {
        if(mousePressedDelay == 0)
        {
            mousePressedDelay = 20;
            boolean anythingClicked = false;
            anythingClicked = menus[currentMenu].checkMousePressed(); // Runs the menu's checkMousePressed
            if(!anythingClicked && currentStructureActive != -1)
            { // If nothing clicked and the user is placing a structure - it places the structure on the board
                structures.get(currentStructureActive).place();
                if((currentStructureActive == 0 && shiftPressed)
                    || (currentStructureActive != 0 && !shiftPressed))
                {
                    currentStructureActive = -1;
                } else if(currentStructureActive == 0 && paused)
                {
                    mousePressedDelay = 0;
                }
            }
        }
    }else
    { // If the mouse is not pressed the mousePressedDelay is set to 0
        mousePressedDelay = 0;
    }
    if(mousePressedDelay != 0)
    { // This is the count down for the mousePressedDelay
        mousePressedDelay -= 1;
    }
}

void keyPressed()
{ // This is run when a key is pressed
    if(menus[currentMenu].isTextBoxFocused())
    {
        menus[currentMenu].getTextBox().inputKey(key); // Passes the keys onto the TextBox - to be handled there
        key = 0; // Makes sure the program doesn't do anything else
    }else if(key == ESC)
    { // If esc is pressed, it changes the menu
        if(currentMenu == 0)
        {
            if(currentStructureActive != -1)
            { // Cancels structure placement
                currentStructureActive = -1;
            } else
            { // Goes to the save game menu
                changeMenu(3);
            }
        }else if(currentMenu == 1)
        {
            exit(); // Exits the program
        } else if(currentMenu == 2)
        {
            resetToDefaults(); // Resets the defaults (Goes back to main menu)
        } else if(currentMenu == 3)
        {
            changeMenu(0); // Goes back to game and resets the current menu
            menus[currentMenu].reset();
        } else if(currentMenu == 4)
        { // Goes into the game
            changeMenu(0);
        }
        key = 0;
    } else if (key == CODED && currentMenu == 0) {
        if (keyCode == UP) { // When a key is pressed, it sets the given variable
            upPressed = true;
        }
        if (keyCode == LEFT) {
            leftPressed = true;
        }
        if (keyCode == DOWN) {
            downPressed = true;
        }
        if (keyCode == RIGHT) {
            rightPressed = true;
        }
        if(keyCode == SHIFT) // This allows you to keep placing things if you press shift
        {
            shiftPressed = true;
        }
    }
}

void keyReleased()
{ // This is run when a key is released
    if (key == CODED) {
        if (keyCode == UP) { // When a key is released, it sets the given variable
            upPressed = false;
        }
        if (keyCode == LEFT) {
            leftPressed = false;
        }
        if (keyCode == DOWN) {
            downPressed = false;
        }
        if (keyCode == RIGHT) {
            rightPressed = false;
        }
        if(keyCode == SHIFT) // This allows you to keep placing things if you press shift
        {
            shiftPressed = false;
            mousePressedDelay = 0;
        }
    }
}

// Checks if any of the keys are pressed
void checkKeys()
{
    if (currentMenu == 0) {
        if (upPressed && screenYPos - screenSpeed >= 0) { // When a key is pressed, it checks to see if a the screen can more more in that direction
            screenYPos -= screenSpeed;
        }
        if (leftPressed && screenXPos - screenSpeed >= 0) {
            screenXPos -= screenSpeed;
        }
        if (downPressed && screenYPos + screenSpeed <= (BOARD_HEIGHT - 1) * cellSize - SCREEN_HEIGHT) {
            screenYPos += screenSpeed;
        }
        if (rightPressed && screenXPos + screenSpeed <= (BOARD_WIDTH - 1) * cellSize - SCREEN_WIDTH) {
            screenXPos += screenSpeed;
        }
    }
}

boolean[][] readFromFile(String filename)
{
    // Reads the lines from each file
    String[] lines = loadStrings(filename);

    // Gets the longest line width in the file
    int structureWidth = 0;
    for (int i = 0 ; i < lines.length; i++) {
        if(lines[i].length() > structureWidth)
        {
            structureWidth = lines[i].length();
        }
    }

    // Creates the structure and sets everything to false
    boolean[][] struct = new boolean[structureWidth][lines.length];
    for (int i = 0 ; i < structureWidth; i++) {
        for(int j = 0; j < lines.length; j++)
        {
            struct[i][j] = false;
        }
    }

    // If there is an X in a spot, it is placed in that location
    for (int j = 0; j < lines.length; j++)
    {
        for(int i = 0; i < lines[j].length(); i++)
        {
            if(lines[j].charAt(i) == 'X')
            {
                struct[i][j] = true;
            }
        }
    }
    return struct;
}

void saveToFile(String filename, boolean[][] struct)
{
    // Creates lines from the struct
    String[] lines = new String[struct[0].length];
    for(int i = 0; i < struct.length; i++)
    {
        for(int j = 0; j < struct[i].length; j++)
        {
            if(struct[i][j])
            {
                lines[j] += 'X';
            }else {
                lines[j] += ' ';
            }
        }
    }
    // Saves it to the filename
    saveStrings(filename, lines);
}

void openSavedGame(String filename)
{
    // Checks if the file exists
    File file = new File(sketchPath("Saves/"+filename+".gol"));
    if(file.exists())
    {
        // Sets the file to the board
        currentFilename = filename;
        changeMenu(0);
        setBoardToStruct(readFromFile("Saves/"+filename+".gol"));
    }else
    {
        // Changes the menu text to say the file does not exist
        menus[currentMenu].setString("Save does not exist!");
    }
}

void saveGame(String filename)
{
    // Checks if it is a new save - if so it adds it to the gameSaves array and updates the "Game Saves.txt" file
    boolean newSave = true;
    for(String s : gameSaves)
    {
        if(s == filename)
        {
            newSave = false;
            break;
        }
    }
    if(newSave)
    {
        gameSaves.add(filename);
        String[] lines = gameSaves.toArray(new String[gameSaves.size()]);
        saveStrings(GAME_SAVES_FILENAME, lines);
    }
    // Saves the game to the file and goes back to the main menu
    saveToFile("Saves/"+filename+".gol", board);
    resetToDefaults();
}