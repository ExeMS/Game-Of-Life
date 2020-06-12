// Screen
static final int SCREEN_HEIGHT = 850;
static final int SCREEN_WIDTH = 1000;
int screenSpeed = 5;
color backgroundColour = color(255);
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

// Used for timings
int updatesPerSecond = 7;
int waitTime = 0;
int startToWaitTime = 0;

// Menus
Menu[] menus;
ArrayList<Structure> structures; // This will store all the structures
int currentStructureActive = -1;
boolean renderStructure = false;


// keys Pressed
Boolean upPressed    = false;
Boolean downPressed  = false;
Boolean rightPressed = false;
Boolean leftPressed  = false;
Boolean shiftPressed = false;
int mousePressedDelay = 0;

static final float CHARACTER_WIDTH = 28.007812; // This is the width of m

String currentFilename = ""; // Stores the name of the current game
ArrayList<String> gameSaves; // This stores all the names to the games
static final String GAME_SAVES_FILENAME = "Saves/Game Saves.txt"; // Stores the filename of the file that stores all the names to the games