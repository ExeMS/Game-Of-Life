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
