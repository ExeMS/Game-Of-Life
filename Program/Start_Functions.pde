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

void startGame_random()
{
    randomBoard();
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
{ // We might need do this at some point :D
    readFromFile("xxx");
    inMenu = false;
};
