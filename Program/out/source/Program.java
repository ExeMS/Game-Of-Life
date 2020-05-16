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

public void resetToDefaults()
{
    for(Menu menu : menus)
    {
        menu.reset();
    }
    paused = true;
    inStructureMenu = false;
    currentMenu = 1;
    screenXPos = START_GRID_X;
    screenYPos = START_GRID_Y;
    cellSize = ORIGINAL_CELL_SIZE;
    screenGridHeight = ORIGINAL_SCREEN_GRID_HEIGHT;
    screenGridWidth = ORIGINAL_SCREEN_GRID_WIDTH;
    clearBoard();
}

public Menu setupMainMenu()
{ // This creates all the buttons for the Menu
    Button[] menuButtons = new Button[4];
    menuButtons[0] = new Button("explore", (SCREEN_WIDTH / 2) - 140, (SCREEN_HEIGHT / 2), 280, 50, "Explore", 30);
    menuButtons[1] = new Button("sandbox", (SCREEN_WIDTH / 2) - 140, (SCREEN_HEIGHT / 2) + 60, 280, 50, "Sandbox", 30);
    menuButtons[2] = new Button("openFileMenu", (SCREEN_WIDTH / 2) - 140, (SCREEN_HEIGHT / 2) + 120, 280, 50, "Read From File", 30);
    menuButtons[3] = new Button("exitGame", (SCREEN_WIDTH / 2) - 140, (SCREEN_HEIGHT / 2) + 180, 280, 50, "Exit", 30);
    GraphicImage img = new GraphicImage((SCREEN_WIDTH / 2) - (SCREEN_WIDTH / 4), 60, SCREEN_WIDTH / 2, SCREEN_HEIGHT / 3, "Images/LIFE-IS-JUST-A-GAME.png");
    return new Menu(menuButtons, img);
}

public Menu setupGUI()
{ // This creates all the buttons of the GUI
    inStructureMenu = false;
    Button[] menuButtons = new Button[4];
    menuButtons[0] = new Button("spawnStructure", 1, 1, 140, 50, "Structure", 30);
    menuButtons[1] = new Button("cancelPlacement", 1, 52, 140, 50, "Cancel", 30);
    menuButtons[2] = new Button("playPause", 1, SCREEN_HEIGHT - 51, 120, 50, "PLAY", 30); // This is the play pause button - it can change its text :D
    menuButtons[3] = new Button("mainMenu", SCREEN_WIDTH - 121, 1, 120, 50, "Menu", 30);
    return new Menu(menuButtons);
}

public Menu setupOpenGameMenu()
{
    TextBox menuTextBox = new TextBox(SCREEN_WIDTH / 2 - 120, SCREEN_HEIGHT / 2 - 10, 240);
    Button[] menuButtons = new Button[2];
    menuButtons[0] = new Button("cancelOpening", SCREEN_WIDTH / 2 - 165, SCREEN_HEIGHT / 2 + 20, 160, 50, "Cancel", 30);
    menuButtons[1] = new Button("openFile", SCREEN_WIDTH / 2 + 5, SCREEN_HEIGHT / 2 + 20, 160, 50, "Open", 30);
    return new Menu(SCREEN_WIDTH/4, SCREEN_HEIGHT/4, SCREEN_WIDTH/2, SCREEN_HEIGHT/2, menuButtons, menuTextBox, color(255), color(0), 1, "Input name of saved game:");
}

public Menu setupSaveGameMenu()
{
    TextBox menuTextBox = new TextBox(SCREEN_WIDTH / 2 - 120, SCREEN_HEIGHT / 2 - 10, 240);
    Button[] menuButtons = new Button[2];
    menuButtons[0] = new Button("dontSave", SCREEN_WIDTH / 2 - 165, SCREEN_HEIGHT / 2 + 20, 160, 50, "Don't Save", 30);
    menuButtons[1] = new Button("save", SCREEN_WIDTH / 2 + 5, SCREEN_HEIGHT / 2 + 20, 160, 50, "Save", 30);
    return new Menu(SCREEN_WIDTH/4, SCREEN_HEIGHT/4, SCREEN_WIDTH/2, SCREEN_HEIGHT/2, menuButtons, menuTextBox, color(255), color(0), 0, "Input name of save:");
}

public Menu setupStructureMenu()
{
    GraphicalStructure[] menuStructures = new GraphicalStructure[18];
    for(int i = 0; i < structures.size(); i++)
    {
        int structX = (i - PApplet.parseInt(i / STRUCTURE_MENU_WIDTH) * STRUCTURE_MENU_WIDTH) * 102 + 50;
        int structY = PApplet.parseInt(i / STRUCTURE_MENU_WIDTH) * 102 + 50;
        menuStructures[i] = new GraphicalStructure(structX, structY, i);
    }

    return new Menu(menuStructures, 0);
}

public void setupStructures()
{
    structures = new ArrayList<Structure>();
    structures.add(new Structure("Structures/cell.txt", "Cell")); // This will now be index 0
    structures.add(new Structure("Structures/glider.txt", "Glider")); // This will be index 1
    structures.add(new Structure("Structures/glider gun.txt", "Glider Gun")); // This will be index 2
    structures.add(new Structure("Structures/spaceship.txt", "Spaceship")); //index 3
    structures.add(new Structure("Structures/dart.txt", "Dart")); //index 4
    structures.add(new Structure("Structures/schick engine.txt", "Schick")); //index 5
    structures.add(new Structure("Structures/hammerhead.txt", "Hammer")); //index 6
    structures.add(new Structure("Structures/Sir Robin.txt", "Sir Robin")); //index 7
    structures.add(new Structure("Structures/copperhead.txt", "Copper")); //index 8
    structures.add(new Structure("Structures/pulsar.txt", "Pulsar")); //index 9
    structures.add(new Structure("Structures/kok's galaxy.txt", "Galaxy")); //index 10
    structures.add(new Structure("Structures/rich's P16.txt", "P16")); //index 11
    structures.add(new Structure("Structures/rocket.txt", "Rocket")); //index 12
    structures.add(new Structure("Structures/flash oscillator.txt", "Flash")); //index 13
    structures.add(new Structure("Structures/pentadecathalon.txt", "15")); //index 14
    structures.add(new Structure("Structures/oddball.txt", "Oddball")); //index 15
    structures.add(new Structure("Structures/fairy.txt", "Fairy")); //index 16
    structures.add(new Structure("Structures/weekender.txt", "Weekender")); //index 17
    currentStructureActive = -1;
}

public void setupMenus()
{
    setupStructures();
    menus = new Menu[5];
    menus[0] = setupGUI();
    menus[1] = setupMainMenu();
    menus[2] = setupOpenGameMenu();
    menus[3] = setupSaveGameMenu();
    menus[4] = setupStructureMenu();
}

public void setup()
{
     // Sets the size of the window, and background colour
    background(backgroundColour);

    clearBoard(); // This clears the board, making sure everything is false

    setupMenus(); // Sets up all menus

    currentMenu = 1; // Makes sure you start in the menu

    frame.requestFocus(); // Makes the screen instantly focused

    // Images must be in the "data" directory to load correctly
}

public void draw()
{ // This acts like a update and render function
    checkKeys(); // This checks if any keys or mouse is pressed
    checkMousePressed();
    render(); // This renders everything on the screen

    timeControl++;
    if(timeControl == 8) // This limits how much it is updated
    {
        timeControl = 0;
        god(); // Runs the function for updating the board
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

public void setBoardToStruct(boolean[][] struct)
{
    if(struct.length < BOARD_WIDTH || struct[0].length < BOARD_HEIGHT)
    {
        int startX = PApplet.parseInt((BOARD_WIDTH - struct.length) / 2);
        int startY = PApplet.parseInt((BOARD_HEIGHT - struct[0].length) / 2);
        for(int i = 0; i < struct.length; i++)
        {
            for(int j = 0; j < struct[i].length; j++)
            {
                board[startX + i][startY + j] = struct[i][j];
            }
        }
    }else
    {
        board = struct;
    }
}

public void sandboxStart() {
}

public void startGame_Explore()
{ // This randomizes the board and sets the mode to 1
    randomBoard();
    mode = 1;
    currentMenu = 0;
};

public void startGame_file()
{ // We might need do this at some point :D
    clearBoard();
    mode = 3;
    currentMenu = 2;
};

public void startGame_sandbox()
{
    sandboxStart();
    mode = 2;
    currentMenu = 0;
};

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
// This is for when we want to display a button
class Button extends GraphicalObject
{
    private String my_text;
    private int my_textSize;
    private int paddingX, paddingY;
    private int textColour, baseColour, hoverColour, outline;
    private String type;

    // We might also want to pass in a function for when it is pressed
    Button(String type, int x, int y, String text, int my_textSize)
    {
        super(x, y, textWidth(text) + 20, textAscent() * 0.8f + 20);
        this.type = type;
        textSize(my_textSize);
        this.paddingX = 10;
        this.paddingY = 10;

        this.my_text = text;
        this.my_textSize = my_textSize;
        this.textColour = color(0);

        this.outline = color(0);
        this.baseColour = color(255);
        this.hoverColour = color(150);
    }

    Button(String type, int x, int y, float my_width, float my_height)
    {
        super(x, y, my_width, my_height);
        this.type = type;
        this.paddingX = 10;
        this.paddingY = 10;

        this.my_text = "";
        this.my_textSize = 30;
        this.textColour = color(0);

        this.outline = color(0);
        this.baseColour = color(255);
        this.hoverColour = color(150);
    }

    Button(String type, int x, int y, int my_width, int my_height, String text, int my_textSize)
    {
        super(x, y, my_width, my_height);
        this.type = type;
        textSize(my_textSize);
        this.paddingX = PApplet.parseInt(my_width - textWidth(text)) / 2;
        this.paddingY = PApplet.parseInt(my_height - textAscent()) / 2;

        this.my_text = text;
        this.my_textSize = my_textSize;
        this.textColour = color(0);

        this.outline = color(0);
        this.baseColour = color(255);
        this.hoverColour = color(150);
    }

    Button(String type, int x, int y, int paddingX, int paddingY, String text, int my_textSize, int textColour, int outline, int baseColour, int hoverColour)
    {
        super(x, y, textWidth(text) + 20, textAscent() * 0.8f + 20);
        this.type = type;
        textSize(my_textSize);
        this.paddingX = paddingX;
        this.paddingY = paddingY;

        this.my_text = text;
        this.my_textSize = my_textSize;
        this.textColour = textColour;

        this.outline = outline;
        this.baseColour = baseColour;
        this.hoverColour = hoverColour;
    }

    public void render()
    { // This renders the button
        if(!(
            (type == "cancelPlacement" && currentStructureActive == -1)
            || (type == "spawnStructure" && mode == 1)
        ))
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
    }

    public boolean checkMousePressed(Menu menu,boolean hasSomethingBeenPressed)
    {
        if(isMouseOver() && !hasSomethingBeenPressed)
        { // This goes through all the types of buttons and runs what they are meant to do when pressed
          // It was done like this as processing doesn't allow you to write lambdas
            if(currentStructureActive != -1)
            { // This sets the rotation, if the user is placing down a structure
                structures.get(currentStructureActive).resetRotated();
                currentStructureActive = -1;
            }
            // GUI TYPES
            if(type == "spawnStructure")
            {
                currentMenu = 4;
                return true;
            }else if(type == "cancelPlacement")
            {
                currentStructureActive = -1;
                return true;
            }else if(type == "playPause")
            {
                paused = !paused;
                if(paused)
                {
                    my_text = "PLAY";
                }else
                {
                    my_text = "PAUSE";
                }
                textSize(my_textSize);
                this.paddingX = PApplet.parseInt(my_width - textWidth(my_text)) / 2;
                return true;
            }else if(type == "mainMenu")
            {
                currentMenu = 3;
                return true;
            }
            // MAIN MENU TYPES
            else if(type == "explore")
            {
                startGame_Explore();
                return true;
            }else if(type == "sandbox")
            {
                startGame_sandbox();
                return true;
            }else if(type == "openFileMenu")
            {
                startGame_file();
                return true;
            }else if(type == "exitGame")
            {
                exit(); // This just closes the window
                // The rest of the code is never run
            }
            // OPEN FILE TYPES
            else if(type == "cancelOpening")
            {
                resetToDefaults();
            } else if(type == "openFile")
            {
                openSavedGame(menu.getInput() + ".gol");
            }
            // SAVE FILE TYPES
            else if(type == "dontSave")
            {
                resetToDefaults();
            }else if(type == "save")
            {
                saveGame(menu.getInput() + ".gol");
            }
        }
        return false;
    }

    public String getType()
    {
        return "Button";
    }

    public void reset()
    {
        if(type == "playPause")
        {
            my_text = "PLAY";
            textSize(my_textSize);
            this.paddingX = PApplet.parseInt(my_width - textWidth(my_text)) / 2;
        }
    }
};
class GraphicalObject
{
    int x, y;
    float my_width, my_height;

    GraphicalObject(int x, int y, float my_width, float my_height)
    {
        this.x = x;
        this.y = y;
        this.my_width = my_width;
        this.my_height = my_height;
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
        println("Calling base function");
    }

    public boolean checkMousePressed()
    {
        println("Calling base function");
        return false;
    }

    public String getType()
    {
        println("Calling base function");
        return "Base";
    }
}
class GraphicalStructure extends GraphicalObject
{
    private int structureID;
    private float my_cellSize;
    private int textX, textY;

    GraphicalStructure(int x, int y, int structureID)
    {
        super(x, y, 100, 100);
        this.structureID = structureID;
        if(structures.get(structureID).getWidth() > structures.get(structureID).getHeight())
        {
            my_cellSize = my_width / (structures.get(structureID).getWidth() + 2);
        }else {
            my_cellSize = my_height / (structures.get(structureID).getHeight() + 2);
        }
        textX = x + PApplet.parseInt((my_width - textWidth(structures.get(structureID).getName())) / 2);
        textY = y + PApplet.parseInt(my_height) - 2;
    }

    public void render()
    { // This renders the button side of it
        stroke(0);
        if(isMouseOver())
        {
            fill(150);
        }else{
            fill(255);
        }
        rect(x, y, my_width, my_height);
        stroke(0,0,255);
        fill(0,0,255);
        for(int i = 0; i < structures.get(structureID).getWidth(); i++)
        {
            for(int j = 0; j < structures.get(structureID).getHeight(); j++)
            {
                if(structures.get(structureID).get(i, j))
                {
                    rect(x + i*my_cellSize + my_cellSize, y + j*my_cellSize + my_cellSize, my_cellSize, my_cellSize);
                }
            }
        }
        stroke(0);
        fill(0);
        textSize(20);
        text(structures.get(structureID).getName(), textX, textY);
    }

    public boolean checkMousePressed()
    {
        if(isMouseOver())
        {
            currentMenu = 0;
            currentStructureActive = structureID;
            return true;
        }
        return false;
    }
}
class GraphicImage extends GraphicalObject
{
    private PImage img;

    GraphicImage(int x, int y, float my_width, float my_height, String filename)
    {
        super(x, y, my_width, my_height);
        img = loadImage(filename);
    }

    public void render()
    {
        image(img, x, y, my_width, my_height);
    }
}
public void mouseWheel(MouseEvent event)
{ // This is called when the user uses the scroll wheel
    int e = PApplet.parseInt(event.getCount()); // This gets what direction the scroll wheel was used
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
public void checkMousePressed()
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

public void keyPressed()
{ // This is run when a key is pressed
    if(key == '\n')
    {
        if(currentMenu == 2)
        {
            currentMenu = 0;
            setBoardToStruct(readFromFile(menus[currentMenu].getInput()));
            menus[currentMenu].reset();
        }else if(currentMenu == 3)
        {
            saveToFile(menus[currentMenu].getInput(), board);
            resetToDefaults();
        }
    }else if(menus[currentMenu].isTextBoxFocused())
    {
        menus[currentMenu].getTextBox().inputKey(key);
    }else if(key == ESC)
    {
        if(currentMenu == 0)
        {
            currentMenu = 3;
        }else if(currentMenu == 1)
        {
            exit();
        } else if(currentMenu == 2)
        {
            resetToDefaults();
        } else if(currentMenu == 3)
        {
            currentMenu = 0;
            menus[currentMenu].reset();
        } else if(currentMenu == 4)
        {
            currentMenu = 0;
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

public void keyReleased()
{ // This is run when a key is released
    if (key == CODED && currentMenu == 0) {
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

public boolean[][] readFromFile(String filename)
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

public void openSavedGame(String filename)
{
    currentMenu = 0;
    setBoardToStruct(readFromFile("Saves/"+filename));
}

public void saveGame(String filename)
{
    saveToFile("Saves/"+filename, board);
    resetToDefaults();
}
public class Menu extends GraphicalObject
{
    private Button[] my_buttons;
    private GraphicalStructure[] my_structures;
    private TextBox my_textBox;
    private Menu[] my_menus;
    private GraphicImage my_image;
    private boolean hasImage = false;
    private boolean hasTextBox = false;
    private boolean hasStructures = false;
    private boolean hasButtons = false;
    private boolean hasMenus = false;

    private String text = "";
    private int textX, textY;

    private boolean hasBackground = false;
    private int backgroundColour, outlineColour;
    private int exitMenu = 1;

    public Menu(Button[] my_buttons)
    {
        super(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        this.my_buttons = my_buttons;
        hasButtons = true;
    }

    public Menu(Button[] my_buttons, GraphicImage img)
    {
        super(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        this.my_buttons = my_buttons;
        this.my_image = img;
        hasImage = true;
        hasButtons = true;
    }

    public Menu(GraphicalStructure[] my_structures, int exitMenu)
    {
        super(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        this.my_structures = my_structures;
        this.exitMenu = exitMenu;
        hasStructures = true;
    }

    public Menu(Button[] my_buttons, TextBox my_textBox)
    {
        super(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        this.my_buttons = my_buttons;
        this.my_textBox = my_textBox;
        hasTextBox = true;
        hasButtons = true;
    }

    public Menu(Menu[] my_menus)
    {
        super(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        this.my_menus = my_menus;
        hasMenus = true;
    }

    public Menu(int x, int y,
                int my_width, int my_height,
                Button[] my_buttons, TextBox my_textBox,
                int backgroundColour, int outlineColour,
                int exitMenu,
                String text)
    {
        super(x, y, my_width, my_height);

        this.my_buttons = my_buttons;
        hasButtons = true;
        hasTextBox = true;
        this.my_textBox = my_textBox;
        hasBackground = true;

        this.backgroundColour = backgroundColour;
        this.outlineColour = outlineColour;

        this.exitMenu = exitMenu;

        this.text = text;
        textX = x + (my_width / 2);
        textY = y + (my_height / 2) - 20;
    }

    public void reset()
    {
        if(hasMenus)
        {
            for(Menu menu : my_menus)
            {
                menu.reset();
            }
        }
        if(hasButtons)
        {
            for(Button button : my_buttons)
            {
                button.reset();
            }
        }
        if(hasTextBox)
        {
            my_textBox.reset();
        }
    }

    public boolean checkMousePressed()
    {
        boolean anythingClicked = false;
        boolean pleaseExit = false;
        boolean hasButtonBeenPressed = false;
        boolean hasStructureBeenPressed = false;
        if(hasButtons)
        {
            for(Button button : my_buttons)
            {
                if(hasButtonBeenPressed)
                {
                    button.checkMousePressed(this, hasButtonBeenPressed);
                }else
                {
                    hasButtonBeenPressed = button.checkMousePressed(this, hasButtonBeenPressed);
                }
            }
            anythingClicked = hasButtonBeenPressed;
        }

        if(hasMenus)
        {
            for(Menu menu : my_menus)
            {
                if(anythingClicked)
                {
                    menu.checkMousePressed();
                }else
                {
                    anythingClicked = menu.checkMousePressed();
                }
            }
        }

        if(hasStructures)
        {
            pleaseExit = true; // If no structure has been pressed, it will exit
            for(GraphicalStructure structure : my_structures)
            {
                hasStructureBeenPressed = structure.checkMousePressed();
                if(hasStructureBeenPressed)
                {
                    pleaseExit = false;
                }
            }
            if(!anythingClicked && !pleaseExit)
            {
                anythingClicked = true;
            }
        }

        if(hasTextBox)
        {
            if(anythingClicked)
            {
                my_textBox.checkMousePressed();
            }else{
                anythingClicked = my_textBox.checkMousePressed();
            }
        }
        if(mouseX > x + my_width || mouseX < x
                || mouseY < y || mouseY > y + my_height
                || pleaseExit)
        {
            currentMenu = exitMenu;
            if(hasTextBox)
            {
                my_textBox.reset();
            }
        }
        return anythingClicked;
    }

    public void render()
    {
        if(hasBackground)
        {
            stroke(outlineColour);
            fill(backgroundColour);
            rect(x, y, my_width, my_height);
        }
        if(hasButtons)
        {
            for(Button button : my_buttons)
            {
                button.render();
            }
        }
        if(hasMenus)
        {
            for(Menu menu : my_menus)
            {
                menu.render();
            }
        }
        if(hasStructures)
        {
            for(GraphicalStructure structure : my_structures)
            {
                structure.render();
            }
        }
        if(hasTextBox)
        {
            my_textBox.render();
        }

        if(hasImage)
        {
            my_image.render();
        }
        textSize(30);
        stroke(0);
        fill(0);
        textAlign(CENTER);
        text(text, SCREEN_WIDTH/2, SCREEN_HEIGHT/2 - 20);
        textAlign(LEFT);
    }

    public String getInput()
    {
        if(hasTextBox)
        {
            return my_textBox.getInput();
        }
        return "";
    }

    public boolean isTextBoxFocused()
    {
        if(hasTextBox)
        {
            return my_textBox.getIsFocused();
        }
        return false;
    }

    public TextBox getTextBox()
    {
        return my_textBox;
    }

    public String getType()
    {
        return "Menu";
    }
}
public void renderBoard()
{
    boolean notDrawnStructuresLines = true; // This makes sure that we don't draw the lines around the structure multiple times
    int gridX = screenXPos / cellSize;
    int gridY = screenYPos / cellSize;
    // This renders the current part of the matrix that is viewed (Also it renders one cell either side of the boarders to make sure scrolling is smooth)
    for(int i = gridX - 1; i < gridX + screenGridWidth + 1; i++) // Goes through the 2d matrix and draws the cell if it is alive
    {
        for(int j = gridY - 1; j < gridY + screenGridHeight + 1; j++)
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
                    int structScreenX = structures.get(currentStructureActive).getX() * cellSize - screenXPos;
                    int structScreenY = structures.get(currentStructureActive).getY() * cellSize - screenYPos;
                    line(structScreenX,
                         structScreenY,
                         structScreenX + structures.get(currentStructureActive).getWidth() * cellSize,
                         structScreenY
                    );
                    line(structScreenX,
                         structScreenY,
                         structScreenX,
                         structScreenY + structures.get(currentStructureActive).getHeight() * cellSize
                    );
                    line(structScreenX,
                         structScreenY + structures.get(currentStructureActive).getHeight() * cellSize,
                         structScreenX + structures.get(currentStructureActive).getWidth() * cellSize,
                         structScreenY + structures.get(currentStructureActive).getHeight() * cellSize
                    );
                    line(structScreenX + structures.get(currentStructureActive).getWidth() * cellSize,
                         structScreenY,
                         structScreenX + structures.get(currentStructureActive).getWidth() * cellSize,
                         structScreenY + structures.get(currentStructureActive).getHeight() * cellSize
                    );
                    notDrawnStructuresLines = false;
                }
                int structX = i - structures.get(currentStructureActive).getX(); // This gets the x and y value for which section it is looking at for the structure
                int structY = j - structures.get(currentStructureActive).getY();
                if(structures.get(currentStructureActive).get(structX, structY))
                { // This renders the squares as blue (as they will be created when the structure is placed)
                    stroke(0, 0, 255);
                    fill(0, 0, 255);
                    rect(i*cellSize - screenXPos, j*cellSize - screenYPos, cellSize, cellSize);
                } else if(board[i][j])
                { // This renders the squares as red (as they will be destroyed when the structure is placed)
                    stroke(255, 0, 0);
                    fill(255, 0, 0);
                    rect(i*cellSize - screenXPos, j*cellSize - screenYPos, cellSize, cellSize);
                }
            } else if(board[i][j]) // 1 means that it is alive
            {
                stroke(0, 255, 0);
                fill(0, 255, 0);
                rect(i*cellSize - screenXPos, j*cellSize - screenYPos, cellSize, cellSize); // Multiplies the index by 10 because each one is a 10 by 10 pixel
            }
        }
    }
}

public void render()
{ // This renders the background and then the other things
    background(backgroundColour);
    renderBoard();
    if(currentStructureActive != -1)
    {
        structures.get(currentStructureActive).update();
    }
    menus[currentMenu].render();
}
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
        gridX = screenXPos / cellSize + (mouseX - (my_RWidth * cellSize / 2)) / cellSize;
        gridY = screenYPos / cellSize + (mouseY - (my_RHeight * cellSize / 2)) / cellSize;
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

    public String getName()
    {
        return name;
    }

    public boolean get(int x, int y)
    {
        return rotatedStructure[x][y];
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
}
class TextBox extends GraphicalObject
{
    private boolean isFocused;
    private String inputText;
    private boolean showCursor = true;
    private int cursorDelay = 0;
    private int cursorPosition = 0;

    TextBox(int x, int y, int my_width)
    {
        super(x, y, my_width, textAscent() * 0.8f + 10);
        textSize(20);
        inputText = "";
        isFocused = false;
    }

    public void update()
    {
        if(isFocused)
        {
            if(cursorDelay == 0)
            {
                cursorDelay = 20;
                showCursor = !showCursor;
            }
            else{
                cursorDelay -= 1;
            }
        }
    }

    public void clear()
    {
        inputText = "";
    }

    public void inputKey(char inpKey)
    {
        textSize(20);
        if(inpKey == BACKSPACE)
        {
            if(inputText.length() != 0)
            {
                inputText = inputText.substring(0, inputText.length() - 1);
                cursorPosition -= 1;
            }
        }else if(inpKey == CODED)
        {
        }else if(textWidth(inputText + "W") + 10 < my_width)
        {
            cursorPosition += 1;
            inputText += inpKey;
        }
    }

    public void render()
    {
        update();
        stroke(0);
        fill(255);
        rect(x, y, my_width, my_height);
        fill(0);
        textSize(20);
        text(inputText, x + 5, y + textAscent() * 0.8f + 10);
        if(showCursor && isFocused)
        {
            line(x + textWidth(inputText) + 5, y + 5, x + textWidth(inputText) + 5, y + 10 + textAscent() * 0.8f);
        }
    }

    public void setFocused(boolean temp)
    {
        isFocused = temp;
    }

    public String getInput()
    {
        return inputText;
    }

    public boolean getIsFocused()
    {
        return isFocused;
    }

    public boolean checkMousePressed()
    {
        if(isMouseOver())
        {
            isFocused = true;
            return true;
        }else
        {
            isFocused = false;
            return false;
        }
    }

    public void reset()
    {
        clear();
        setFocused(false);
    }

    public String getType()
    {
        return "TextBox";
    }
}
// Screen
static final int SCREEN_HEIGHT = 850;
static final int SCREEN_WIDTH = 1000;
int screenSpeed = 5;
int backgroundColour = color(255);
int currentMenu = 0; // 0: Game. 1: Main menu, 2: Opening file, 3: Saving file

// Board and cell settings
static final int BOARD_HEIGHT = 1000;
static final int BOARD_WIDTH = 1000;

static final int ORIGINAL_CELL_SIZE = 10;
static final int STRUCTURE_MENU_WIDTH = 6;

static final int ORIGINAL_SCREEN_GRID_HEIGHT = SCREEN_HEIGHT / ORIGINAL_CELL_SIZE;
static final int ORIGINAL_SCREEN_GRID_WIDTH = SCREEN_WIDTH / ORIGINAL_CELL_SIZE;

static final int START_GRID_X = (500 - (ORIGINAL_SCREEN_GRID_WIDTH / 2)) * ORIGINAL_CELL_SIZE;
static final int START_GRID_Y = (500 - (ORIGINAL_SCREEN_GRID_HEIGHT / 2)) * ORIGINAL_CELL_SIZE;

int cellSize = ORIGINAL_CELL_SIZE;
int screenXPos = START_GRID_X;
int screenYPos = START_GRID_Y;
int screenGridHeight = ORIGINAL_SCREEN_GRID_HEIGHT;
int screenGridWidth = ORIGINAL_SCREEN_GRID_WIDTH;

// mode of use
int mode = 1;

// Pausing
boolean paused = true;

// Boards key: 0: empty, 1: cell
boolean[][] board = new boolean[BOARD_HEIGHT][BOARD_WIDTH]; // Will probably change this to a boolean later
boolean[][] boardcopy = new boolean[BOARD_HEIGHT][BOARD_WIDTH];

int timeControl = 0;

// Menus
Menu[] menus;
boolean inStructureMenu = false;
ArrayList<Structure> structures; // This will store all the structures
int currentStructureActive = -1;


// keys Pressed
Boolean upPressed    = false;
Boolean downPressed  = false;
Boolean rightPressed = false;
Boolean leftPressed  = false;
Boolean shiftPressed = false;
int mousePressedDelay = 0;
  public void settings() {  size(1000, 850); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Program" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
