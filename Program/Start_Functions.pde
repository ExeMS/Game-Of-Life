void clearBoard()
{
    for(int i = 0; i < BOARD_WIDTH; i++) // Sets the whole board to 0
    {
        for(int j = 0; j < BOARD_HEIGHT; j++)
        {
            board[i][j] = false;
        }
    }
}

void randomBoard()
{
    for(int i = 0; i < BOARD_WIDTH; i++) // Sets the whole board to 0
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

void startGame_random()
{
    randomBoard();
    mode = 1;
    inMenu = false;
};

void startGame_gun()
{
    createGliderGun(0, 0);
    mode = 2;
    inMenu = false;
};

void startGame_glider()
{
    structures.get(1).placeInLocation(49, 49);
    mode = 3;
    inMenu = false;
};

void startGame_file()
{ // We might need do this at some point :D
    readFromFile("xxx");
    mode = 4;
    inMenu = false;
};

void startGame_sandbox()
{
    sandboxStart();
    mode = 5;
    inMenu = false;
};
