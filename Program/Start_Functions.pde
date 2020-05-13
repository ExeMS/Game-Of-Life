void clearBoard()
{ // This sets the whole board to 0
    for(int i = 0; i < BOARD_WIDTH; i++) // Sets the whole board to 0
    {
        for(int j = 0; j < BOARD_HEIGHT; j++)
        {
            board[i][j] = false;
        }
    }
}

void randomBoard()
{ // This randomizes the whole board
    for(int i = 0; i < BOARD_WIDTH; i++)
    {
        for(int j = 0; j < BOARD_HEIGHT; j++)
        {
            int r = int(random(4));
            if(r == 0)
            {
                board[i][j] = true;
            }else {
                board[i][j] = false;
            }
        }
    }
}

void sandboxStart() {
}

void startGame_Explore()
{ // This randomizes the board and sets the mode to 1
    randomBoard();
    mode = 1;
    inMenu = false;
};

void startGame_gun()
{ // This spawns the glider gun
    structures.get(2).placeInLocation(6, 8);
    mode = 2;
    inMenu = false;
};

void startGame_glider()
{ // This spawns in a glider in the center of the screen
    structures.get(1).placeInLocation(49, 49);
    mode = 3;
    inMenu = false;
};

void startGame_file()
{ // We might need do this at some point :D
    readFromFile("cell.txt");
    mode = 4;
    inMenu = false;
};

void startGame_sandbox()
{
    sandboxStart();
    mode = 5;
    inMenu = false;
};
