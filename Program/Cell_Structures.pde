void createGliderGun(int xPos, int yPos)
{
    board[1][7] = true;
    board[1][8] = true;
    board[2][7] = true;
    board[2][8] = true;

    board[9][8] = true;
    board[9][9] = true;
    board[10][7] = true;
    board[10][9] = true;
    board[11][7] = true;
    board[11][8] = true;

    board[17][9] = true;
    board[17][10] = true;
    board[17][11] = true;
    board[18][9] = true;
    board[19][10] = true;

    board[23][6] = true;
    board[23][7] = true;
    board[24][5] = true;
    board[24][7] = true;
    board[25][5] = true;
    board[25][6] = true;

    board[25][17] = true;
    board[25][18] = true;
    board[26][17] = true;
    board[26][19] = true;
    board[27][17] = true;

    board[35][5] = true;
    board[35][6] = true;
    board[36][5] = true;
    board[36][6] = true;

    board[36][12] = true;
    board[36][13] = true;
    board[36][14] = true;
    board[37][12] = true;
    board[38][13] = true;
}

void createGlider(int xPos, int yPos)
{
    board[xPos + 1][yPos + 2] = true;
    board[xPos][yPos + 2] = true;
    board[xPos + 2][yPos + 2] = true;
    board[xPos + 2][yPos + 1] = true;
    board[xPos + 1][yPos] = true;
}

boolean[][] readFromFile(String filename)
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