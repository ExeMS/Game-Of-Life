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
            boolean anythingClicked = false;
            anythingClicked = menus[currentMenu].checkMousePressed();
            if(!anythingClicked && currentStructureActive != -1)
            {
                structures.get(currentStructureActive).place();
                if(shiftPressed)
                {
                    currentStructureActive = -1;
                }
            }
            mousePressedDelay = 20;
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
    if(key == '\n')
    {
        if(currentMenu == 2)
        {
            openSavedGame(menus[currentMenu].getInput());
            menus[currentMenu].reset();
        }else if(currentMenu == 3)
        {
            saveGame(menus[currentMenu].getInput());
        }
    }else if(menus[currentMenu].isTextBoxFocused())
    {
        menus[currentMenu].getTextBox().inputKey(key);
    }else if(key == ESC)
    {
        if(currentMenu == 0)
        {
            changeMenu(3);
        }else if(currentMenu == 1)
        {
            exit();
        } else if(currentMenu == 2)
        {
            resetToDefaults();
        } else if(currentMenu == 3)
        {
            changeMenu(0);
            menus[currentMenu].reset();
        } else if(currentMenu == 4)
        {
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
    String[] lines = loadStrings(filename);
    int structureWidth = 0;
    for (int i = 0 ; i < lines.length; i++) {
        if(lines[i].length() > structureWidth)
        {
            structureWidth = lines[i].length();
        }
    }
    boolean[][] struct = new boolean[structureWidth][lines.length];
    for (int i = 0 ; i < structureWidth; i++) {
        for(int j = 0; j < lines.length; j++)
        {
            struct[i][j] = false;
        }
    }
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
    saveStrings(filename, lines);
}

void openSavedGame(String filename)
{
    File file = new File(sketchPath("Saves/"+filename+".gol"));
    if(file.exists())
    {
        currentFilename = filename;
        changeMenu(0);
        setBoardToStruct(readFromFile("Saves/"+filename+".gol"));
    }else
    {
        menus[currentMenu].setString("Save does not exist!");
    }
}

void saveGame(String filename)
{
    saveToFile("Saves/"+filename, board);
    resetToDefaults();
}