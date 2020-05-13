boolean[][] createGliderGun(int xPos, int yPos)
{
    boolean[][] struct = new boolean[39][20];
    struct[1][7] = true;
    struct[1][8] = true;
    struct[2][7] = true;
    struct[2][8] = true;

    struct[9][8] = true;
    struct[9][9] = true;
    struct[10][7] = true;
    struct[10][9] = true;
    struct[11][7] = true;
    struct[11][8] = true;

    struct[17][9] = true;
    struct[17][10] = true;
    struct[17][11] = true;
    struct[18][9] = true;
    struct[19][10] = true;

    struct[23][6] = true;
    struct[23][7] = true;
    struct[24][5] = true;
    struct[24][7] = true;
    struct[25][5] = true;
    struct[25][6] = true;

    struct[25][17] = true;
    struct[25][18] = true;
    struct[26][17] = true;
    struct[26][19] = true;
    struct[27][17] = true;

    struct[35][5] = true;
    struct[35][6] = true;
    struct[36][5] = true;
    struct[36][6] = true;

    struct[36][12] = true;
    struct[36][13] = true;
    struct[36][14] = true;
    struct[37][12] = true;
    struct[38][13] = true;
    return struct;
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

void saveToFile(String filename, boolean[][] struct)
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