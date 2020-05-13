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

public void mouseWheel(MouseEvent event) { // This is called when the user uses the scroll wheel
    if(currentStructureActive != -1)
    {
        int e = PApplet.parseInt(event.getCount()); // This gets what direction the scroll wheel was used
        structures.get(currentStructureActive).rotate(e); // This rotates the active structure
    }
}

// Checks if mouse is pressed and is over any button
public void checkMousePressed()
{
    if(mousePressed)
    {
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

            if (spawnStructureButton.isMouseOver() && !inStructureMenu) {
                inStructureMenu = true; // This opens the structure menu
                mousePressedDelay = 20; // The mousePressedDelay is set to stop causing some bugs
                if(currentStructureActive != -1)
                { // This sets the rotation, if the user is placing down a structure
                    structures.get(currentStructureActive).resetRotated();
                    currentStructureActive = -1;
                }
            } else if(inStructureMenu && mousePressedDelay == 0)
            { // This checks if any of the structures were pressed (in the structure menu)
                for(int i = 1; i < structures.size(); i++) // This goes through every structure in the list and checks its location
                {
                    if(structures.get(i).isMouseOver((i - 1) * 102 + 50, 50))
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
                if(shiftPressed)
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

public void keyPressed()
{ // This is run when a key is pressed
    if (key == CODED && !inMenu) {
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

public void keyReleased()
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
public void checkKeys()
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

public void backToMenu()
{ // This just clears the board to go back to the menu
    inMenu = true;
    clearBoard();
}

// Updates the game
public void god()
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

public void setupMenu()
{ // This creates all the buttons for the Menu
    randomStartButton = new Button(360, 475, 280, 50, "Start", 30);
    gosperGliderGun = new Button(360, 535, 280, 50, "Gosper Glider Gun", 30);
    singleGlider = new Button(360, 595, 280, 50, "Glider", 30);
    readFromFile = new Button(360, 655, 280, 50, "Read From File", 30);
    sandbox = new Button(360, 715, 280, 50, "Sandbox", 30);
    exitButton = new Button(360, 900, 280, 50, "Exit", 30);
}

public void setupGUI()
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
    currentStructureActive = -1;
}

public void setup()
{
     // Sets the size of the window, and background colour
    background(backgroundColour);

    clearBoard(); // This clears the board, making sure everything is false

    setupMenu(); // Sets just the menu and GUI
    setupGUI();

    inMenu = true; // Makes sure you start in the menu

    frame.requestFocus(); // Makes the screen instantly focused
}

public void draw()
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
    { // This checks if the mouse is over
        if (mouseX >= x && mouseX <= x+my_width &&
            mouseY >= y && mouseY <= y+my_height)
        {
            return true;
        } else {
            return false;
        }
    }

    public void render()
    { // This renders the button
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
public boolean[][] createGliderGun(int xPos, int yPos)
{
    boolean[][] struct = new boolean[39][20];
    struct[1][7] = true;
    struct[1][8] = true;
    struct[2][7] = true;
    struct[2][8] = true;

    struct[9][8] = true;
    struct[9][9] = true;
    struct[10][7] = true;
    struct[10][9] = true;
    struct[11][7] = true;
    struct[11][8] = true;

    struct[17][9] = true;
    struct[17][10] = true;
    struct[17][11] = true;
    struct[18][9] = true;
    struct[19][10] = true;

    struct[23][6] = true;
    struct[23][7] = true;
    struct[24][5] = true;
    struct[24][7] = true;
    struct[25][5] = true;
    struct[25][6] = true;

    struct[25][17] = true;
    struct[25][18] = true;
    struct[26][17] = true;
    struct[26][19] = true;
    struct[27][17] = true;

    struct[35][5] = true;
    struct[35][6] = true;
    struct[36][5] = true;
    struct[36][6] = true;

    struct[36][12] = true;
    struct[36][13] = true;
    struct[36][14] = true;
    struct[37][12] = true;
    struct[38][13] = true;
    return struct;
}

public void createGlider(int xPos, int yPos)
{
    board[xPos + 1][yPos + 2] = true;
    board[xPos][yPos + 2] = true;
    board[xPos + 2][yPos + 2] = true;
    board[xPos + 2][yPos + 1] = true;
    board[xPos + 1][yPos] = true;
}

public boolean[][] readFromFile(String filename)
{ // This should return a 2d array of the file (same layout as the board but just smaller)
    // This is temporary just so I can test the GUI structures
    /*boolean[][] struct = new boolean[3][3];
    for(int i = 0; i < 3; i++)
    {
        for(int j = 0; j < 3; j++)
        {
            struct[i][j] = false;
        }
    }
    struct[1][2] = true;
    struct[0][2] = true;
    struct[2][2] = true;
    struct[2][1] = true;
    struct[1][0] = true;*/


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

public void saveToFile(String filename, boolean[][] struct)
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
public void renderMenu()
{ // Renders all the videos
    randomStartButton.render();
    gosperGliderGun.render();
    singleGlider.render();
    readFromFile.render();
    sandbox.render();
    exitButton.render();
}
public void renderGUI()
{ // Render process for the GUI will go in here
    if(mode == 2 || mode == 3 || mode == 4){ // checks what mode you are in
        if(inStructureMenu)
        { // If in the structure menu it renders the structures
            for(int i = 1; i < structures.size(); i++)
            {
                structures.get(i).render((i - 1) * 102 + 50, 50);
            }
        } else
        { // Otherwise it renders the structure button
            spawnStructureButton.render();
        }
        if(currentStructureActive != -1)
        { // If the user is placing a structure, it updates the structure and renders the cancel button
            cancelButton.render();
            structures.get(currentStructureActive).update();
        }
    }
    menuButton.render(); // Always renders the menuButton
    if(mode == 1 || mode == 2 || mode == 3 || mode == 4){ // Checks the right mode
      if(paused == false){ // Renders the pause and play button
        pauseButton.render();
      }
      if(paused == true){
        playButton.render();
      }
    }
}

public void renderBoard()
{
    boolean notDrawnStructuresLines = true; // This makes sure that we don't draw the lines around the structure multiple times
    int gridX = screenXPos / CELL_SIZE;
    int gridY = screenYPos / CELL_SIZE;
    // This renders the current part of the matrix that is viewed (Also it renders one cell either side of the boarders to make sure scrolling is smooth)
    for(int i = gridX - 1; i < gridX + SCREEN_GRID_WIDTH + 1; i++) // Goes through the 2d matrix and draws the cell if it is alive
    {
        for(int j = gridY - 1; j < gridY + SCREEN_GRID_HEIGHT + 1; j++)
        {
            if(i < 0 || j < 0 || i >= BOARD_WIDTH || j >= BOARD_HEIGHT) // This is just safe guards just so it doesn't through an error
            {
                continue;
            }
            // This renders a structure, if the user is trying to place one (and also checks if things are in the right place)
            if(currentStructureActive != -1
                && i >= structures.get(currentStructureActive).getX()
                && i < structures.get(currentStructureActive).getX() + structures.get(currentStructureActive).getWidth()
                && j >= structures.get(currentStructureActive).getY()
                && j < structures.get(currentStructureActive).getY() + structures.get(currentStructureActive).getHeight())
            {
                if (notDrawnStructuresLines)
                { // This draws the lines around the structure
                    stroke(0);
                    int structScreenX = structures.get(currentStructureActive).getX() * CELL_SIZE - screenXPos;
                    int structScreenY = structures.get(currentStructureActive).getY() * CELL_SIZE - screenYPos;
                    line(structScreenX,
                         structScreenY,
                         structScreenX + structures.get(currentStructureActive).getWidth() * CELL_SIZE,
                         structScreenY
                    );
                    line(structScreenX,
                         structScreenY,
                         structScreenX,
                         structScreenY + structures.get(currentStructureActive).getHeight() * CELL_SIZE
                    );
                    line(structScreenX,
                         structScreenY + structures.get(currentStructureActive).getHeight() * CELL_SIZE,
                         structScreenX + structures.get(currentStructureActive).getWidth() * CELL_SIZE,
                         structScreenY + structures.get(currentStructureActive).getHeight() * CELL_SIZE
                    );
                    line(structScreenX + structures.get(currentStructureActive).getWidth() * CELL_SIZE,
                         structScreenY,
                         structScreenX + structures.get(currentStructureActive).getWidth() * CELL_SIZE,
                         structScreenY + structures.get(currentStructureActive).getHeight() * CELL_SIZE
                    );
                    notDrawnStructuresLines = false;
                }
                int structX = i - structures.get(currentStructureActive).getX(); // This gets the x and y value for which section it is looking at for the structure
                int structY = j - structures.get(currentStructureActive).getY();
                if(structures.get(currentStructureActive).get(structX, structY))
                { // This renders the squares as blue (as they will be created when the structure is placed)
                    stroke(0, 0, 255);
                    fill(0, 0, 255);
                    rect(i*CELL_SIZE - screenXPos, j*CELL_SIZE - screenYPos, CELL_SIZE, CELL_SIZE);
                } else if(board[i][j])
                { // This renders the squares as red (as they will be destroyed when the structure is placed)
                    stroke(255, 0, 0);
                    fill(255, 0, 0);
                    rect(i*CELL_SIZE - screenXPos, j*CELL_SIZE - screenYPos, CELL_SIZE, CELL_SIZE);
                }
            } else if(board[i][j]) // 1 means that it is alive
            {
                stroke(0, 255, 0);
                fill(0, 255, 0);
                rect(i*CELL_SIZE - screenXPos, j*CELL_SIZE - screenYPos, CELL_SIZE, CELL_SIZE); // Multiplies the index by 10 because each one is a 10 by 10 pixel
            }
        }
    }
}

public void render()
{ // This renders the background and then the other things
    background(backgroundColour);
    renderBoard();
    if(inMenu) // Chooses the run the board or...
    {
        renderMenu();
    }else {
        renderGUI();
    }
}
public void clearBoard()
{ // This sets the whole board to 0
    for(int i = 0; i < BOARD_WIDTH; i++) // Sets the whole board to 0
    {
        for(int j = 0; j < BOARD_HEIGHT; j++)
        {
            board[i][j] = false;
        }
    }
}

public void randomBoard()
{ // This randomizes the whole board
    for(int i = 0; i < BOARD_WIDTH; i++)
    {
        for(int j = 0; j < BOARD_HEIGHT; j++)
        {
            int r = PApplet.parseInt(random(4));
            if(r == 0)
            {
                board[i][j] = true;
            }else {
                board[i][j] = false;
            }
        }
    }
}

public void sandboxStart() {
}

public void startGame_Explore()
{ // This randomizes the board and sets the mode to 1
    randomBoard();
    mode = 1;
    inMenu = false;
};

public void startGame_gun()
{ // This spawns the glider gun
    createGliderGun(0, 0);
    mode = 2;
    inMenu = false;
};

public void startGame_glider()
{ // This spawns in a glider in the center of the screen
    structures.get(1).placeInLocation(49, 49);
    mode = 3;
    inMenu = false;
};

public void startGame_file()
{ // We might need do this at some point :D
    readFromFile("xxx");
    mode = 4;
    inMenu = false;
};

public void startGame_sandbox()
{
    sandboxStart();
    mode = 5;
    inMenu = false;
};
class Structure
{
    private boolean[][] structure;
    private boolean[][] rotatedStructure;
    private int gridX, gridY; // Stores the grid location of the structure
    private int my_width, my_height;
    private int my_RWidth, my_RHeight; // Stores the height and width of the rotated structure
    private String name;

    Structure(String filename, String name)
    {
        structure = readFromFile(filename);
        rotatedStructure = structure;
        this.name = name;
        my_width = structure.length;
        my_height = structure[0].length;
        my_RHeight = my_height;
        my_RWidth = my_width;
        gridX = 0;
        gridY = 0;
    }

    public void update()
    { // This updates the gridX and gridY
        gridX = screenXPos / 10 + (mouseX - (my_width * CELL_SIZE / 2)) / CELL_SIZE;
        gridY = screenYPos / 10 + (mouseY - (my_height * CELL_SIZE / 2)) / CELL_SIZE;
    }

    public void place()
    { // This places the structure at its location
        for(int i = 0; i < my_RWidth; i++)
        {
            for(int j = 0; j < my_RHeight; j++)
            {
                board[i + gridX][j + gridY] = rotatedStructure[i][j];
            }
        }
    }

    public void placeInLocation(int x, int y)
    { // This places the structure at a given x and y coordinates
        for(int i = 0; i < my_RWidth; i++)
        {
            for(int j = 0; j < my_RHeight; j++)
            {
                board[i + x][j + y] = rotatedStructure[i][j];
            }
        }
    }

    // Get functions:
    public int getWidth()
    {
        return my_RWidth;
    }

    public int getHeight()
    {
        return my_RHeight;
    }

    public int getX()
    {
        return gridX;
    }

    public int getY()
    {
        return gridY;
    }

    public boolean get(int x, int y)
    {
        return rotatedStructure[x][y];
    }

    // Checks if the mouse is over it at a given x and y coordinate
    public boolean isMouseOver(int x, int y)
    {
        if (mouseX >= x && mouseX <= x+100 &&
            mouseY >= y && mouseY <= y+100)
        {
            return true;
        } else {
            return false;
        }
    }

    public void resetRotated()
    { // This resets the rotation of it
        rotatedStructure = structure;
        my_RHeight = my_height;
        my_RWidth = my_width;
    }

    public void rotate(int r)
    { // This rotates it in a given direction
        int temp = my_RHeight;
        my_RHeight = my_RWidth;
        my_RWidth = temp;
        boolean[][] tempStructure = new boolean[my_RWidth][my_RHeight];
        for(int i = 0; i < my_RHeight; i++)
        {
            for(int j = 0; j < my_RWidth; j++)
            {
                if(r == 1)
                {
                    tempStructure[j][i] = rotatedStructure[i][my_RWidth - j - 1];
                } else
                {
                    tempStructure[j][i] = rotatedStructure[my_RHeight - i - 1][j];
                }
            }
        }
        rotatedStructure = tempStructure;
    }

    public void render(int x, int y)
    { // This renders the button side of it
        int my_boardSize = 100;
        int my_cellSize;
        if(my_width > my_height)
        {
            my_cellSize = my_boardSize / (my_width + 2);
        }else {
            my_cellSize = my_boardSize / (my_width + 2);
        }
        stroke(0);
        if(isMouseOver(x, y))
        {
            fill(150);
        }else{
            fill(255);
        }
        rect(x, y, my_boardSize, my_boardSize);
        for(int i = 0; i < my_width; i++)
        {
            for(int j = 0; j < my_height; j++)
            {
                if(structure[i][j])
                {
                    stroke(0,0,255);
                    fill(0,0,255);
                    rect(x + i*my_cellSize + my_cellSize, y + j*my_cellSize + my_cellSize, my_cellSize, my_cellSize);
                }
            }
        }
        stroke(0);
        fill(0);
        textSize(20);
        int xGap = PApplet.parseInt((my_boardSize - textWidth(name)) / 2);
        text(name, x + xGap, y + my_boardSize - 2);
    }
}
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

// mode of use
int mode = 1;

// Pausing
boolean paused = true;

// Boards key: 0: empty, 1: cell
boolean[][] board = new boolean[BOARD_HEIGHT][BOARD_WIDTH]; // Will probably change this to a boolean later
boolean[][] boardcopy = new boolean[BOARD_HEIGHT][BOARD_WIDTH];

int timeControl = 0;

// Menu Buttons
Button randomStartButton;
Button gosperGliderGun;
Button singleGlider;
Button readFromFile;
Button sandbox;
Button exitButton;

// GUI Stuff
//Button spawnGliderButton;
Button spawnStructureButton;
boolean inStructureMenu = false;
Button spawnCellButton;
ArrayList<Structure> structures = new ArrayList<Structure>(); // This will store all the structures
Button cancelButton;
int currentStructureActive = -1;
Button pauseButton;
Button playButton;
Button menuButton;


// keys Pressed
Boolean upPressed    = false;
Boolean downPressed  = false;
Boolean rightPressed = false;
Boolean leftPressed  = false;
Boolean shiftPressed = false;
int mousePressedDelay = 0;
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
