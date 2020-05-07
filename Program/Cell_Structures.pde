void createGliderGun(int xPos, int yPos)
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

void createGlider(int xPos, int yPos)
{
    board[xPos + 1][yPos + 2] = 1;
    board[xPos][yPos + 2] = 1;
    board[xPos + 2][yPos + 2] = 1;
    board[xPos + 2][yPos + 1] = 1;
    board[xPos + 1][yPos] = 1;
}

void pasteFromFile(String filename, int xPos, int yPos)
{ // Made a glider file with a glider in it so use that :D position is the top left corner

}