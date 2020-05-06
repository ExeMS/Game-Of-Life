// Screen
static final int SCREEN_HEIGHT = 1000;
static final int SCREEN_WIDTH = 1000;
int screenXPos = 0;
int screenYPos = 0;
int screenSpeed = 5;

// Board and cell settings
static final int BOARD_HEIGHT = 1000;
static final int BOARD_WIDTH = 1000;
static final int CELL_SIZE = 10;
static final int SCREEN_GRID_HEIGHT = SCREEN_HEIGHT / CELL_SIZE;
static final int SCREEN_GRID_WIDTH = SCREEN_WIDTH / CELL_SIZE;

// Boards key: 0: empty, 2: cell
int[][] board = new int[BOARD_HEIGHT][BOARD_WIDTH];
int[][] boardcopy = new int[BOARD_HEIGHT][BOARD_WIDTH];

int timeControl = 0;

void god()
{
    for (int i = 0; i < BOARD_WIDTH; i++) {
        for (int j = 0; j < BOARD_HEIGHT; j++) {
            boardcopy[i][j] = board[i][j];
        }
    }
    for (int i = 0; i < BOARD_WIDTH; i++) {
        for (int j = 0; j < BOARD_HEIGHT; j++) {
            int counter = 0;
            // counting the number of alive cells around the cell
            if (i != 0 && board[i-1][j] == 1) {
                counter++;
            }
            if (i != BOARD_WIDTH - 1 && board[i+1][j] == 1) {
                counter++;
            }
            if (i != 0 && j != 0 && board[i-1][j-1] == 1) {
                counter++;
            }
            if (j != 0 && board[i][j-1] == 1) {
                counter++;
            }
            if (i != BOARD_WIDTH - 1 && j != 0 && board[i+1][j-1] == 1) {
                counter++;
            }
            if (i != 0 && j != BOARD_HEIGHT - 1 && board[i-1][j+1] == 1) {
                counter++;
            }
            if (j != BOARD_HEIGHT - 1 && board[i][j+1] == 1) {
                counter++;
            }
            if (j != BOARD_HEIGHT - 1 && i != BOARD_WIDTH - 1 && board[i+1][j+1] == 1) {
                counter++;
            }
            //Running through the rules
            if ((counter < 2) && (board[i][j] == 1)) {
                boardcopy[i][j] = 0;
            }
            if ((counter > 3) && (board[i][j] == 1)) {
                boardcopy[i][j] = 0;
            }
            if ((counter == 3) && (board[i][j] == 0)) {
                boardcopy[i][j] = 1;
            }
        }
    }
    for (int i = 0; i < BOARD_WIDTH; i++) {
        for (int j = 0; j < BOARD_HEIGHT; j++) {
            board[i][j] = boardcopy[i][j];
        }
    }
}

void setup()
{
    size(1000, 1000);
    background(255);
    for(int i = 0; i < BOARD_WIDTH; i++) // Sets the whole board to 0
    {
        for(int j = 0; j < BOARD_HEIGHT; j++)
        {
            int r = int(random(4));
            if(r == 0)
            {
                board[i][j] = 1;
            }else {
                board[i][j] = 0;
            }
        }
    }
    frame.requestFocus(); // Makes the screen instantly focused
    /*board[50][50] = 1; // THis is setting one thing to be alive
    board[49][50] = 1;
    board[51][50] = 1;
    board[51][49] = 1;
    board[50][48] = 1;*/
}

void draw()
{
    if(keyPressed) // This senses a key being pressed
    {
        if (key == CODED) {
            if (keyCode == UP && screenYPos - screenSpeed >= 0) {
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

    background(255);
    int gridX = screenXPos / CELL_SIZE;
    int gridY = screenYPos / CELL_SIZE;
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


    timeControl++;
    if(timeControl == 10) // This limits how much it is updated
    {
        timeControl = 0;
        god();
    }
}