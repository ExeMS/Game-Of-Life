void mouseWheel(MouseEvent event) { // This is called when the user uses the scroll wheel
    if(currentStructureActive != -1)
    {
        int e = int(event.getCount()); // This gets what direction the scroll wheel was used
        structures.get(currentStructureActive).rotate(e); // This rotates the active structure
    }
}

// Checks if mouse is pressed and is over any button
void checkMousePressed()
{
    if(mousePressed)
    {
        /*if(testBox.isMouseOver() && !testBox.getIsFocused())
        {
            testBox.setFocused(true);
        } else if (testBox.getIsFocused() && !testBox.isMouseOver())
        {
            testBox.setFocused(false);
        }*/
        if(inMenu) // Checks if in the main menu
        {
            if (randomStartButton.isMouseOver()) { // If we are it checks what button the mouse is over and runs the function
                startGame_Explore();
            }
            if (gosperGliderGun.isMouseOver()) {
                startGame_gun();
            }
            if (singleGlider.isMouseOver()) {
                startGame_glider();
            }
            if (readFromFile.isMouseOver()) {
                startGame_file();
            }
            if (sandbox.isMouseOver()) {
                startGame_sandbox();
            }
            if (exitButton.isMouseOver())
            {
                exit(); // This just closes the window
            }
        } else { // This means that the GUI is active, so we need to check if any of those buttons have been pressed

            if(menuButton.isMouseOver())
            { // If the menu button is pressed it runs the given function
                if(currentStructureActive != -1)
                { // This sets the rotation, if the user is placing down a structure
                    structures.get(currentStructureActive).resetRotated();
                    currentStructureActive = -1;
                }
                backToMenu();
            }
            if(pauseButton.isMouseOver() && paused == false && mousePressedDelay == 0) { // This checks if play/pause was pressed and pauses the game
                paused = true;
                mousePressedDelay = 20;
                if(currentStructureActive != -1)
                { // This sets the rotation, if the user is placing down a structure
                    structures.get(currentStructureActive).resetRotated();
                    currentStructureActive = -1;
                }
            } else if(playButton.isMouseOver() && paused == true && mousePressedDelay == 0) {
                paused = false;
                mousePressedDelay = 20;
                if(currentStructureActive != -1)
                { // This sets the rotation, if the user is placing down a structure
                    structures.get(currentStructureActive).resetRotated();
                    currentStructureActive = -1;
                }
            }

            if (spawnStructureButton.isMouseOver() && !inStructureMenu && mousePressedDelay == 0) {
                inStructureMenu = true; // This opens the structure menu
                mousePressedDelay = 20; // The mousePressedDelay is set to stop causing some bugs
                if(currentStructureActive != -1)
                { // This sets the rotation, if the user is placing down a structure
                    structures.get(currentStructureActive).resetRotated();
                    currentStructureActive = -1;
                }
            } else if(inStructureMenu && mousePressedDelay == 0)
            { // This checks if any of the structures were pressed (in the structure menu)
                for(int i = 0; i < structures.size(); i++) // This goes through every structure in the list and checks its location
                {
                    if(structures.get(i).isMouseOver((i) * 102 + 50, 50))
                    {
                        currentStructureActive = i;
                        break;
                    }
                }
                inStructureMenu = false; // Closes the structure menu (even if a structure was not chosen)
                mousePressedDelay = 20; // Sets the mousePressed delay so bugs aren't caused
            }
            else if (spawnCellButton.isMouseOver() && mode == 5) {
                currentStructureActive = 0; // This checks if the spawnCellButton was clicked, and sets the current active structure to that
            } else if (currentStructureActive != -1 && mousePressedDelay == 0) {
                if(!cancelButton.isMouseOver())
                { // If the cancel button was not pressed, it calls the place function in the structure
                    structures.get(currentStructureActive).place();
                }
                if(!shiftPressed)
                { // If the shift is pressed, then a mousePressedDelay is set and the structure stays active (so you can keep placing them)
                    mousePressedDelay = 20;
                }else
                {
                    structures.get(currentStructureActive).resetRotated(); // Otherwise the structure is reset and nothing is set to active
                    currentStructureActive = -1;
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
    if(testBox.getIsFocused())
    {
        testBox.inputKey(key);
    }else if (key == CODED && !inMenu) {
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
    if (key == CODED && !inMenu) {
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
    if (!inMenu) {
        if (upPressed && screenYPos - screenSpeed >= 0) { // When a key is pressed, it checks to see if a the screen can more more in that direction
            screenYPos -= screenSpeed;
        }
        if (leftPressed && screenXPos - screenSpeed >= 0) {
            screenXPos -= screenSpeed;
        }
        if (downPressed && screenYPos + screenSpeed <= (BOARD_HEIGHT - 1) * CELL_SIZE - SCREEN_HEIGHT) {
            screenYPos += screenSpeed;
        }
        if (rightPressed && screenXPos + screenSpeed <= (BOARD_WIDTH - 1) * CELL_SIZE - SCREEN_WIDTH) {
            screenXPos += screenSpeed;
        }
    }
}

void backToMenu()
{ // This just clears the board to go back to the menu
    inMenu = true;
    screenXPos = 0;
    screenYPos = 0;
    paused = true;
    clearBoard();
}

// Updates the game
void god()
{
  if(paused == false) {
      for (int i = 0; i < BOARD_WIDTH; i++) {
          for (int j = 0; j < BOARD_HEIGHT; j++) {
              boardcopy[i][j] = board[i][j];
              int counter = 0;
              // counting the number of alive cells around the cell
              if (i != 0 && board[i-1][j]) {
                  counter++;
              }
              if (i != BOARD_WIDTH - 1 && board[i+1][j]) {
                  counter++;
              }
              if (i != 0 && j != 0 && board[i-1][j-1]) {
                  counter++;
              }
              if (j != 0 && board[i][j-1]) {
                  counter++;
              }
              if (i != BOARD_WIDTH - 1 && j != 0 && board[i+1][j-1]) {
                  counter++;
              }
              if (i != 0 && j != BOARD_HEIGHT - 1 && board[i-1][j+1]) {
                  counter++;
              }
              if (j != BOARD_HEIGHT - 1 && board[i][j+1]) {
                  counter++;
              }
              if (j != BOARD_HEIGHT - 1 && i != BOARD_WIDTH - 1 && board[i+1][j+1]) {
                  counter++;
              }
              //Running through the rules
              if ((counter < 2) && (board[i][j])) {
                  boardcopy[i][j] = false;
              }
              if ((counter > 3) && (board[i][j])) {
                  boardcopy[i][j] = false;
              }
              if ((counter == 3) && (board[i][j] == false)) {
                  boardcopy[i][j] = true;
              }
          }
      }
      for (int i = 0; i < BOARD_WIDTH; i++) {
          for (int j = 0; j < BOARD_HEIGHT; j++){
              board[i][j] = boardcopy[i][j];
          }
      }
  }
}

void setupMenu()
{ // This creates all the buttons for the Menu
    randomStartButton = new Button((SCREEN_WIDTH / 2) - 140, (SCREEN_HEIGHT / 2) - 145, 280, 50, "Start", 30);
    gosperGliderGun = new Button((SCREEN_WIDTH / 2) - 140, (SCREEN_HEIGHT / 2) - 85, 280, 50, "Gosper Glider Gun", 30);
    singleGlider = new Button((SCREEN_WIDTH / 2) - 140, (SCREEN_HEIGHT / 2) - 25, 280, 50, "Glider", 30);
    readFromFile = new Button((SCREEN_WIDTH / 2) - 140, (SCREEN_HEIGHT / 2) + 35, 280, 50, "Read From File", 30);
    sandbox = new Button((SCREEN_WIDTH / 2) - 140, (SCREEN_HEIGHT / 2) + 95, 280, 50, "Sandbox", 30);
    exitButton = new Button((SCREEN_WIDTH / 2) - 140, (SCREEN_HEIGHT / 2) + 155, 280, 50, "Exit", 30);
}

void setupGUI()
{ // This creates all the buttons of the GUI
    //spawnGliderButton = new Button(0, 0, 120, 50, "Glider", 30);
    spawnStructureButton = new Button(1, 1, 140, 50, "Structure", 30);
    inStructureMenu = false;
    spawnCellButton = new Button(0, 60, 120, 50, "Cell", 30);
    cancelButton = new Button(1, 52, 140, 50, "Cancel", 30);
    pauseButton = new Button(1, SCREEN_HEIGHT - 51, 120, 50, "PAUSE", 30);
    playButton = new Button(1, SCREEN_HEIGHT - 51, 120, 50, "PLAY", 30);
    menuButton = new Button(SCREEN_WIDTH - 121, 1, 120, 50, "Menu", 30);

    // Structures
    structures.add(new Structure("cell.txt", "Cell")); // This will now be index 0
    structures.add(new Structure("glider.txt", "Glider")); // This will be index 1
    structures.add(new Structure("glider gun.txt", "Glider Gun")); // This will be index 2
    structures.add(new Structure("spaceship.txt", "Spaceship")); //index 3
    structures.add(new Structure("dart.txt", "Dart")); //index 4
    structures.add(new Structure("schick engine.txt", "Schick")); //index 5
    currentStructureActive = -1;
}

void setup()
{
    size(1000, 850); // Sets the size of the window, and background colour
    background(backgroundColour);

    clearBoard(); // This clears the board, making sure everything is false

    setupMenu(); // Sets just the menu and GUI
    setupGUI();
    testBox = new TextBox(100, 100, 240);

    inMenu = true; // Makes sure you start in the menu

    frame.requestFocus(); // Makes the screen instantly focused
}

void draw()
{ // This acts like a update and render function
    checkKeys(); // This checks if any keys or mouse is pressed
    checkMousePressed();
    render(); // This renders everything on the screen

    timeControl++;
    if(timeControl == 10) // This limits how much it is updated
    {
        timeControl = 0;
        god(); // Runs the function for updating the board
    }
}
