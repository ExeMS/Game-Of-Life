class Structure
{
    private boolean[][] structure;
    private boolean[][] rotatedStructure;
    private int gridX, gridY; // Stores the grid location of the structure
    private int my_width, my_height;
    private int my_RWidth, my_RHeight; // Stores the height and width of the rotated structure
    private String name;

    Structure(String filename, String name)
    {
        structure = readFromFile(filename);
        rotatedStructure = structure;
        this.name = name;
        my_width = structure.length;
        my_height = structure[0].length;
        my_RHeight = my_height;
        my_RWidth = my_width;
        gridX = 0;
        gridY = 0;
    }

    void update()
    { // This updates the gridX and gridY
        gridX = screenXPos / cellSize + (mouseX - (my_RWidth * cellSize / 2)) / cellSize;
        gridY = screenYPos / cellSize + (mouseY - (my_RHeight * cellSize / 2)) / cellSize;
    }

    void place()
    { // This places the structure at its location
        for(int i = 0; i < my_RWidth; i++)
        {
            for(int j = 0; j < my_RHeight; j++)
            {
                board[i + gridX][j + gridY] = rotatedStructure[i][j];
            }
        }
    }

    void placeInLocation(int x, int y)
    { // This places the structure at a given x and y coordinates
        for(int i = 0; i < my_RWidth; i++)
        {
            for(int j = 0; j < my_RHeight; j++)
            {
                board[i + x][j + y] = rotatedStructure[i][j];
            }
        }
    }

    // Get functions:
    int getWidth()
    {
        return my_RWidth;
    }

    int getHeight()
    {
        return my_RHeight;
    }

    int getX()
    {
        return gridX;
    }

    int getY()
    {
        return gridY;
    }

    String getName()
    {
        return name;
    }

    boolean get(int x, int y)
    {
        return rotatedStructure[x][y];
    }

    void resetRotated()
    { // This resets the rotation of it
        rotatedStructure = structure;
        my_RHeight = my_height;
        my_RWidth = my_width;
    }

    void rotate(int r)
    { // This rotates it in a given direction
        int temp = my_RHeight;
        my_RHeight = my_RWidth;
        my_RWidth = temp;
        boolean[][] tempStructure = new boolean[my_RWidth][my_RHeight];
        for(int i = 0; i < my_RHeight; i++)
        {
            for(int j = 0; j < my_RWidth; j++)
            {
                if(r == 1)
                {
                    tempStructure[j][i] = rotatedStructure[i][my_RWidth - j - 1];
                } else
                {
                    tempStructure[j][i] = rotatedStructure[my_RHeight - i - 1][j];
                }
            }
        }
        rotatedStructure = tempStructure;
    }
}