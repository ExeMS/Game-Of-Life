// Checks if mouse is pressed and is over any button
void mousePressed()
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
    } else { // This means that the GUI is active, so we need to check if any of those buttons have been pressed
        if (spawnGliderButton.isMouseOver()) {
            currentStructureActive = 0;
        }else if (currentStructureActive != -1) {
            if(!cancelButton.isMouseOver())
            {
                structures.get(currentStructureActive).place();
            }
            currentStructureActive = -1;
        }
    }
}

// Checks if any of the keys are pressed
void checkKeys()
{
    if(keyPressed) // This senses a key being pressed
    {
        if (key == CODED && !inMenu) {
            if (keyCode == UP && screenYPos - screenSpeed >= 0) { // When a key is pressed, it checks to see if a the screen can more more in that direction
                screenYPos -= screenSpeed;
            }
            if (keyCode == LEFT && screenXPos - screenSpeed >= 0) {
                screenXPos -= screenSpeed;
            }
            if (keyCode == DOWN && screenYPos + screenSpeed <= (BOARD_HEIGHT - 1) * CELL_SIZE - SCREEN_HEIGHT) {
                screenYPos += 5;
            }
            if (keyCode == RIGHT && screenXPos + screenSpeed <= (BOARD_WIDTH - 1) * CELL_SIZE - SCREEN_WIDTH) {
                screenXPos += 5;
            }
        }
    }
}

// Updates the game
void god()
{
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
        for (int j = 0; j < BOARD_HEIGHT; j++) {
            board[i][j] = boardcopy[i][j];
        }
    }
}

void setupMenu()
{
    randomStartButton = new Button(360, 475, 280, 50, "Start", 30);
    gosperGliderGun = new Button(360, 535, 280, 50, "Gosper Glider Gun", 30);
    singleGlider = new Button(360, 595, 280, 50, "Glider", 30);
    readFromFile = new Button(360, 655, 280, 50, "Read From File", 30);
}

void setupGUI()
{
    spawnGliderButton = new Button(0, 0, "Glider", 30);
    cancelButton = new Button(SCREEN_WIDTH - 150, 0, "Cancel", 30);

    // Structures
    structures.add(new Structure("glider.txt"));
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

    render();

    timeControl++;
    if(timeControl == 10) // This limits how much it is updated
    {
        timeControl = 0;
        god();
    }
}
