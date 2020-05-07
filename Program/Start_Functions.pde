void clearBoard()
{
    for(int i = 0; i < BOARD_WIDTH; i++) // Sets the whole board to 0
    {
        for(int j = 0; j < BOARD_HEIGHT; j++)
        {
            board[i][j] = 0;
        }
    }
}

void randomStart()
{
    for(int i = 0; i < BOARD_WIDTH; i++) // Sets the whole board to 0
    {
        for(int j = 0; j < BOARD_HEIGHT; j++)
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
}

void startGame_random()
{
    randomStart();
    inMenu = false;
};

void startGame_gun()
{
    createGliderGun(0, 0);
    inMenu = false;
};

void startGame_glider()
{
    createGlider(0, 0);
    inMenu = false;
};

void startGame_file()
{
    pasteFromFile("xxx", 0, 0);
    inMenu = false;
};
