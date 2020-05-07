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
int backgroundColour = color(255);
boolean inMenu = false;

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
Button startButton;


// This is for when we want to display a button
class Button
{
    private int x, y;
    private float my_width, my_height;
    private String my_text;
    private int my_textSize;
    private int paddingX, paddingY;
    private int textColour, baseColour, hoverColour, outline;

    // We might also want to pass in a function for when it is pressed
    Button(int x, int y, String text, int my_textSize)
    {
        this.x = x;
        this.y = y;
        textSize(my_textSize);
        this.my_width = textWidth(text) + 20;
        this.my_height = textAscent() * 0.8f + 20;
        this.paddingX = 10;
        this.paddingY = 10;

        this.my_text = text;
        this.my_textSize = my_textSize;
        this.textColour = color(0);

        this.outline = color(0);
        this.baseColour = color(255);
        this.hoverColour = color(150);
    }

    Button(int x, int y, float my_width, float my_height)
    {
        this.x = x;
        this.y = y;
        this.my_width = my_width;
        this.my_height = my_height;
        this.paddingX = 10;
        this.paddingY = 10;

        this.my_text = "";
        this.my_textSize = 30;
        this.textColour = color(0);

        this.outline = color(0);
        this.baseColour = color(255);
        this.hoverColour = color(150);
    }

    Button(int x, int y, int paddingX, int paddingY, String text, int my_textSize)
    {
        this.x = x;
        this.y = y;
        textSize(my_textSize);
        this.my_width = textWidth(text) + 2 * paddingX;
        this.my_height = textAscent() * 0.8f + 2 * paddingX;
        this.paddingX = paddingX;
        this.paddingY = paddingY;

        this.my_text = text;
        this.my_textSize = my_textSize;
        this.textColour = color(0);

        this.outline = color(0);
        this.baseColour = color(255);
        this.hoverColour = color(150);
    }

    Button(int x, int y, int paddingX, int paddingY, String text, int my_textSize, int textColour, int outline, int baseColour, int hoverColour)
    {
        this.x = x;
        this.y = y;
        textSize(my_textSize);
        this.my_width = textWidth(text) + 2 * paddingX;
        this.my_height = textAscent() * 0.8f + 2 * paddingX;
        this.paddingX = paddingX;
        this.paddingY = paddingY;

        this.my_text = text;
        this.my_textSize = my_textSize;
        this.textColour = textColour;

        this.outline = outline;
        this.baseColour = baseColour;
        this.hoverColour = hoverColour;
    }

    public boolean isMouseOver()
    {
        if (mouseX >= x && mouseX <= x+my_width &&
            mouseY >= y && mouseY <= y+my_height)
        {
            return true;
        } else {
            return false;
        }
    }

    public void update()
    {
        stroke(outline);
        if(isMouseOver())
        {
            fill(hoverColour);
        }else
        {
            fill(baseColour);
        }
        rect(x, y, my_width, my_height);
        fill(textColour);
        textSize(my_textSize);
        text(my_text, x + paddingX, y + textAscent() * 0.8f + paddingY);
    }

    public void setBackgroundColour(int baseColour, int hoverColour)
    {
        this.baseColour = baseColour;
        this.hoverColour = hoverColour;
    }
};

// Checks if mouse is pressed and is over any button
public void mousePressed()
{
    if(inMenu)
    {
        if (startButton.isMouseOver()) {
            startGame();
        }
    }
}

// Checks if any of the keys are pressed
public void checkKeys()
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

// Different creations
public void createGliderGun(int xPos, int yPos)
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

public void createGlider(int xPos, int yPos)
{
    board[xPos + 1][yPos + 2] = 1;
    board[xPos][yPos + 2] = 1;
    board[xPos + 2][yPos + 2] = 1;
    board[xPos + 2][yPos + 1] = 1;
    board[xPos + 1][yPos] = 1;
}

public void pasteFromFile(String filename, int xPos, int yPos)
{ // Made a glider file with a glider in it so use that :D position is the top left corner

}

// Different starts
public void clearBoard()
{
    for(int i = 0; i < BOARD_WIDTH; i++) // Sets the whole board to 0
    {
        for(int j = 0; j < BOARD_HEIGHT; j++)
        {
            board[i][j] = 0;
        }
    }
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

// Updates the game
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

public void renderMenu()
{
    startButton.update();
}
public void renderGUI()
{ // Render process for the GUI will go in here
}

public void renderGame()
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


public void startGame()
{
    randomStart();
    inMenu = false;
};

public void setup()
{
    
    background(backgroundColour);

    //randomStart();
    clearBoard();
    // int x, int y, int my_width, int my_height, String text

    // Menu setup
    startButton = new Button(500, 500, "Start", 30);
    inMenu = true;

    frame.requestFocus(); // Makes the screen instantly focused
}

public void draw()
{
    checkKeys();
    background(backgroundColour);

    renderGame();
    if(inMenu)
    {
        renderMenu();
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
