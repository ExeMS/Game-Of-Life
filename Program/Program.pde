// Checks if mouse is pressed and is over any button
void checkMousePressed()
{
    if(mousePressed)
    {
        if(inMenu)
        {
            if (randomStartButton.isMouseOver()) {
                startGame_random();
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
        } else { // This means that the GUI is active, so we need to check if any of those buttons have been pressed
            if (spawnStructureButton.isMouseOver() && !inStructureMenu) {
                inStructureMenu = true;
                mousePressedDelay = 20;
                currentStructureActive = -1;
            } else if(inStructureMenu && mousePressedDelay == 0)
            {
                for(int i = 1; i < structures.size(); i++)
                {
                    if(structures.get(i).isMouseOver((i - 1) * 102 + 50, 50))
                    {
                        currentStructureActive = i;
                        break;
                    }
                }
                inStructureMenu = false;
                mousePressedDelay = 20;
            }
            else if (spawnCellButton.isMouseOver() && mode == 5) {
                currentStructureActive = 0;
            } else if (currentStructureActive != -1 && mousePressedDelay == 0) {
                if(!cancelButton.isMouseOver())
                {
                    structures.get(currentStructureActive).place();
                }
                if(shiftPressed)
                {
                    mousePressedDelay = 20;
                }else
                {
                    currentStructureActive = -1;
                }
            }
            if(pauseButton.isMouseOver() && paused == false && mousePressedDelay == 0) {
              paused = true;
              mousePressedDelay = 20;
            } else if(playButton.isMouseOver() && paused == true && mousePressedDelay == 0) {
              paused = false;
              mousePressedDelay = 20;
            }
        }
    }else
    {
        if(!shiftPressed) // This is what happens when the mouse is released
        {
            mousePressedDelay = 0;
        }
    }
    if(mousePressedDelay != 0)
    {
        mousePressedDelay -= 1;
    }
}

void keyPressed()
{
    if (key == CODED && !inMenu) {
        if (keyCode == UP) { // When a key is pressed, it checks to see if a the screen can more more in that direction
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
{
    if (key == CODED && !inMenu) {
        if (keyCode == UP) { // When a key is pressed, it checks to see if a the screen can more more in that direction
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
{
    randomStartButton = new Button(360, 475, 280, 50, "Start", 30);
    gosperGliderGun = new Button(360, 535, 280, 50, "Gosper Glider Gun", 30);
    singleGlider = new Button(360, 595, 280, 50, "Glider", 30);
    readFromFile = new Button(360, 655, 280, 50, "Read From File", 30);
    sandbox = new Button(360, 715, 280, 50, "Sandbox", 30);
}

void setupGUI()
{
    //spawnGliderButton = new Button(0, 0, 120, 50, "Glider", 30);
    spawnStructureButton = new Button(1, 1, 140, 50, "Structure", 30);
    inStructureMenu = false;
    spawnCellButton = new Button(0, 60, 120, 50, "Cell", 30);
    cancelButton = new Button(1, 52, 140, 50, "Cancel", 30);
    pauseButton = new Button(1, 949, 120, 50, "PAUSE", 30);
    playButton = new Button(1, 949, 120, 50, "PLAY", 30);

    // Structures
    structures.add(new Structure("cell.txt", "Cell")); // This will now be index 0
    structures.add(new Structure("glider.txt", "Glider")); // This will be index 1
    currentStructureActive = -1;
}

void setup()
{
    size(1000, 1000);
    background(backgroundColour);

    clearBoard();

    setupMenu();
    setupGUI();

    inMenu = true;

    frame.requestFocus(); // Makes the screen instantly focused
}

void draw()
{
    checkKeys();
    checkMousePressed();
    render();

    timeControl++;
    if(timeControl == 10) // This limits how much it is updated
    {
        timeControl = 0;
        god();
    }
}
