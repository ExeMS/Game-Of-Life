import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Program extends PApplet {

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

public void createGliderGun()
{
    board[1][7] = 1;
    board[1][8] = 1;
    board[2][7] = 1;
    board[2][8] = 1;

    board[9][8] = 1;
    board[9][9] = 1;
    board[10][7] = 1;
    board[10][9] = 1;
    board[11][7] = 1;
    board[11][8] = 1;

    board[17][9] = 1;
    board[17][10] = 1;
    board[17][11] = 1;
    board[18][9] = 1;
    board[19][10] = 1;

    board[23][6] = 1;
    board[23][7] = 1;
    board[24][5] = 1;
    board[24][7] = 1;
    board[25][5] = 1;
    board[25][6] = 1;

    board[25][17] = 1;
    board[25][18] = 1;
    board[26][17] = 1;
    board[26][19] = 1;
    board[27][17] = 1;

    board[35][5] = 1;
    board[35][6] = 1;
    board[36][5] = 1;
    board[36][6] = 1;

    board[36][12] = 1;
    board[36][13] = 1;
    board[36][14] = 1;
    board[37][12] = 1;
    board[38][13] = 1;
}

public void randomStart()
{
    for(int i = 0; i < BOARD_WIDTH; i++) // Sets the whole board to 0
    {
        for(int j = 0; j < BOARD_HEIGHT; j++)
        {
            int r = PApplet.parseInt(random(4));
            if(r == 0)
            {
                board[i][j] = 1;
            }else {
                board[i][j] = 0;
            }
        }
    }
}

public void god()
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

public void setup()
{
    
    background(255);

    randomStart();

    frame.requestFocus(); // Makes the screen instantly focused
    /*board[50][50] = 1; // THis is setting one thing to be alive
    board[49][50] = 1;
    board[51][50] = 1;
    board[51][49] = 1;
    board[50][48] = 1;*/
}

public void draw()
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
  public void settings() {  size(1000, 1000); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Program" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
