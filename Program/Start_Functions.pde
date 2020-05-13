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

void setBoardToStruct(boolean[][] struct)
{
    if(struct.length < 1000)
    {
        for(int i = 0; i < struct.length; i++)
        {
            for(int j = 0; j < struct[i].length; j++)
            {
                board[i][j] = struct[i][j];
            }
        }
    }else
    {
        board = struct;
    }
}

void sandboxStart() {
}

void startGame_Explore()
{ // This randomizes the board and sets the mode to 1
    randomBoard();
    mode = 1;
    currentMenu = 0;
};

void startGame_file()
{ // We might need do this at some point :D
    clearBoard();
    mode = 4;
    inputFileBox.clear();
    currentMenu = 2;
};

void startGame_sandbox()
{
    sandboxStart();
    mode = 5;
    currentMenu = 0;
};
