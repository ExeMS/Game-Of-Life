void changeMenu(int menuIndex)
{
    menus[currentMenu].reset();
    currentMenu = menuIndex;
}

void cancelPlacement()
{
    currentStructureActive = -1;
    renderStructure = false;
}

void openSaveMenu()
{
    changeMenu(3);
    menus[currentMenu].setInputText(currentFilename);
}

void resetToDefaults()
{
    changeMenu(1);

    paused = true;
    screenXPos = START_GRID_X;
    screenYPos = START_GRID_Y;
    cellSize = ORIGINAL_CELL_SIZE;
    screenGridHeight = ORIGINAL_SCREEN_GRID_HEIGHT;
    screenGridWidth = ORIGINAL_SCREEN_GRID_WIDTH;
    currentFilename = "";
    clearBoard();
}

Menu setupMainMenu()
{ // This creates all the buttons for the Menu
    Button[] menuButtons = new Button[4];
    menuButtons[0] = new Button("explore", (SCREEN_WIDTH / 2) - 140, (SCREEN_HEIGHT / 2), 280, 50, "Explore", 30);
    menuButtons[1] = new Button("sandbox", (SCREEN_WIDTH / 2) - 140, (SCREEN_HEIGHT / 2) + 60, 280, 50, "Sandbox", 30);
    menuButtons[2] = new Button("openFileMenu", (SCREEN_WIDTH / 2) - 140, (SCREEN_HEIGHT / 2) + 120, 280, 50, "Read From File", 30);
    menuButtons[3] = new Button("exitGame", (SCREEN_WIDTH / 2) - 140, (SCREEN_HEIGHT / 2) + 180, 280, 50, "Exit", 30);
    GraphicImage img = new GraphicImage((SCREEN_WIDTH / 2) - (SCREEN_WIDTH / 4), 60, SCREEN_WIDTH / 2, SCREEN_HEIGHT / 3, "Images/LIFE-IS-JUST-A-GAME.png");
    return new Menu(menuButtons, img);
}

Menu setupGUI()
{ // This creates all the buttons of the GUI
    Button[] menuButtons = new Button[4];
    menuButtons[0] = new Button("spawnStructure", 1, 1, 140, 50, "Structure", 30);
    menuButtons[1] = new Button("cancelPlacement", 1, 52, 140, 50, "Cancel", 30);
    menuButtons[2] = new Button("playPause", 1, SCREEN_HEIGHT - 51, 120, 50, "PLAY", 30); // This is the play pause button - it can change its text :D
    menuButtons[3] = new Button("mainMenu", SCREEN_WIDTH - 121, 1, 120, 50, "Menu", 30);
    return new Menu(menuButtons);
}

Menu setupOpenGameMenu()
{
    TextBox menuTextBox = new TextBox(SCREEN_WIDTH / 2 - 120, SCREEN_HEIGHT / 2 - 10, 240);
    Button[] menuButtons = new Button[2];
    menuButtons[0] = new Button("cancelOpening", SCREEN_WIDTH / 2 - 165, SCREEN_HEIGHT / 2 + 40, 160, 50, "Cancel", 30);
    menuButtons[1] = new Button("openFile", SCREEN_WIDTH / 2 + 5, SCREEN_HEIGHT / 2 + 40, 160, 50, "Open", 30);
    return new Menu(SCREEN_WIDTH/4, SCREEN_HEIGHT/4, SCREEN_WIDTH/2, SCREEN_HEIGHT/2, menuButtons, menuTextBox, color(255), color(0), 1, "Input name of saved game:");
}

Menu setupSaveGameMenu()
{
    TextBox menuTextBox = new TextBox(SCREEN_WIDTH / 2 - 120, SCREEN_HEIGHT / 2 - 10, 240);
    Button[] menuButtons = new Button[2];
    menuButtons[0] = new Button("dontSave", SCREEN_WIDTH / 2 - 165, SCREEN_HEIGHT / 2 + 40, 160, 50, "Don't Save", 30);
    menuButtons[1] = new Button("save", SCREEN_WIDTH / 2 + 5, SCREEN_HEIGHT / 2 + 40, 160, 50, "Save", 30);
    return new Menu(SCREEN_WIDTH/4, SCREEN_HEIGHT/4, SCREEN_WIDTH/2, SCREEN_HEIGHT/2, menuButtons, menuTextBox, color(255), color(0), 0, "Input name of save:");
}

Menu setupStructureMenu()
{
    GraphicalStructure[] menuStructures = new GraphicalStructure[18];
    for(int i = 0; i < structures.size(); i++)
    {
        int structX = (i - int(i / STRUCTURE_MENU_WIDTH) * STRUCTURE_MENU_WIDTH) * 102 + 50;
        int structY = int(i / STRUCTURE_MENU_WIDTH) * 102 + 50;
        menuStructures[i] = new GraphicalStructure(structX, structY, i);
    }

    return new Menu(menuStructures, 0);
}

void setupStructures()
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
    renderStructure = false;
}

void setupGameSaves()
{
    gameSaves = new ArrayList<String>();
    String[] lines = loadStrings(GAME_SAVES_FILENAME);
    for(String s : lines)
    {
        if(s == "") { continue; }
        gameSaves.add(s);
    }
}

void setupMenus()
{
    menus = new Menu[5];
    menus[0] = setupGUI();
    menus[1] = setupMainMenu();
    menus[2] = setupOpenGameMenu();
    menus[3] = setupSaveGameMenu();
    menus[4] = setupStructureMenu();
}

void setup()
{
    size(1000, 850); // Sets the size of the window, and background colour
    background(backgroundColour);

    clearBoard(); // This clears the board, making sure everything is false

    setupStructures();
    setupMenus(); // Sets up all menus

    setupGameSaves();

    currentMenu = 1; // Makes sure you start in the menu

    frame.requestFocus(); // Makes the screen instantly focused
}

void draw()
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
