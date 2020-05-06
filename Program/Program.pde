// Screen
static final int SCREEN_HEIGHT = 1000;
static final int SCREEN_WIDTH = 1000;
int screenX = 0;
int screenY = 0;

// Board and cell settings
static final int BOARD_HEIGHT = 1000;
static final int BOARD_WIDTH = 1000;
static final int CELL_SIZE = 10;
static final int SCREEN_GRID_HEIGHT = SCREEN_HEIGHT / CELL_SIZE;
static final int SCREEN_GRID_WIDTH = SCREEN_WIDTH / CELL_SIZE;

// Boards key: 0: empty, 2: cell
int[][] board = new int[BOARD_HEIGHT][BOARD_WIDTH];
int[][] boardcopy = new int[BOARD_HEIGHT][BOARD_WIDTH];

void god()
{
    for (int i = 0; i < BOARD_HEIGHT; i++) {
        for (int j = 0; j < BOARD_WIDTH; j++) {
            boardcopy[i][j] = board[i][j];
        }
    }
    for (int i = 0; i < board.length; i++) {
        for (int j = 0; j < board.length; j++) {
            int counter = 0;
            // counting the number of alive cells around the cell
            if (i != 0 && board[i-1][j] == 1) {
                counter++;
            }
            if (i != BOARD_HEIGHT - 1 && board[i+1][j] == 1) {
                counter++;
            }
            if (i != 0 && j != 0 && board[i-1][j-1] == 1) {
                counter++;
            }
            if (j != 0 && board[i][j-1] == 1) {
                counter++;
            }
            if (i != BOARD_HEIGHT - 1 && j != 0 && board[i+1][j-1] == 1) {
                counter++;
            }
            if (i != 0 && j != BOARD_WIDTH - 1 && board[i-1][j+1] == 1) {
                counter++;
            }
            if (j != BOARD_WIDTH - 1 && board[i][j+1] == 1) {
                counter++;
            }
            if (j != BOARD_WIDTH - 1 && i != BOARD_HEIGHT - 1 && board[i+1][j+1] == 1) {
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
    for (int i = 0; i < 100; i++) {
        for (int j = 0; j < 100; j++) {
            board[i][j] = boardcopy[i][j];
        }
    }
}

void setup()
{
    size(1000, 1000);
    background(255);
    for(int i = 0; i < BOARD_HEIGHT; i++) // Sets the whole board to 0
    {
        for(int j = 0; j < BOARD_WIDTH; j++)
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
    /*board[50][50] = 1; // THis is setting one thing to be alive
    board[49][50] = 1;
    board[51][50] = 1;
    board[51][49] = 1;
    board[50][48] = 1;*/
}

void draw()
{
    delay(100); // Just waits a second
    background(255);
    for(int i = screenY; i < screenY + SCREEN_GRID_HEIGHT; i++) // Goes through the 2d matrix and draws the cell if it is alive
    {
        for(int j = screenX; j < screenX + SCREEN_GRID_WIDTH; j++)
        {
            if(board[i][j] == 1) // 1 means that it is alive
            {
                stroke(0, 255, 0);
                fill(0, 255, 0);
                rect(i*10, j*10, 10, 10); // Multiplies the index by 10 because each one is a 10 by 10 pixel
            }
        }
    }
    god();
}