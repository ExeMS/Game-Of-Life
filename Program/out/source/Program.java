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

// Checks if mouse is pressed and is over any button
public void mousePressed()
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

public void setupMenu()
{
    randomStartButton = new Button(360, 475, 280, 50, "Start", 30);
    gosperGliderGun = new Button(360, 535, 280, 50, "Gosper Glider Gun", 30);
    singleGlider = new Button(360, 595, 280, 50, "Glider", 30);
    readFromFile = new Button(360, 655, 280, 50, "Read From File", 30);
}

public void setupGUI()
{

}

public void setup()
{
    
    background(backgroundColour);

    clearBoard();

    setupMenu();
    inMenu = true;

    frame.requestFocus(); // Makes the screen instantly focused
}

public void draw()
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

    Button(int x, int y, int my_width, int my_height, String text, int my_textSize)
    {
        this.x = x;
        this.y = y;
        textSize(my_textSize);
        this.my_width = my_width;
        this.my_height = my_height;
        this.paddingX = PApplet.parseInt(my_width - textWidth(text)) / 2;
        this.paddingY = PApplet.parseInt(my_height - textAscent()) / 2;

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

    public void render()
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
};
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

public int[][] readFromFile(String filename)
{ // This should return a 2d array of the file (same layout as the board but just smaller)
    return new int[10][10];
}

public void placeStructure(int[][] structure, int xPos, int yPos)
{
    // This will place in a structure (given in the form of a 2d array)
}
public void renderMenu()
{
    randomStartButton.render();
    gosperGliderGun.render();
    singleGlider.render();
    readFromFile.render();
}
public void renderGUI()
{ // Render process for the GUI will go in here
}

public void renderBoard()
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

public void render()
{
    background(backgroundColour);
    renderBoard();
    if(inMenu)
    {
        renderMenu();
    }else {
        renderGUI();
    }
}
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

public void randomBoard()
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

public void startGame_random()
{
    randomBoard();
    inMenu = false;
};

public void startGame_gun()
{
    createGliderGun(0, 0);
    inMenu = false;
};

public void startGame_glider()
{
    createGlider(0, 0);
    inMenu = false;
};

public void startGame_file()
{ // We might need do this at some point :D
    readFromFile("xxx");
    inMenu = false;
};
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

// Menu Buttons
Button randomStartButton;
Button gosperGliderGun;
Button singleGlider;
Button readFromFile;
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
