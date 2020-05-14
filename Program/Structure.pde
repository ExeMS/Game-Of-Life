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
        gridX = screenXPos / cellSize + (mouseX - (my_width * cellSize / 2)) / cellSize;
        gridY = screenYPos / cellSize + (mouseY - (my_height * cellSize / 2)) / cellSize;
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

    boolean get(int x, int y)
    {
        return rotatedStructure[x][y];
    }

    // Checks if the mouse is over it at a given x and y coordinate
    boolean isMouseOver(int x, int y)
    {
        if (mouseX >= x && mouseX <= x+100 &&
            mouseY >= y && mouseY <= y+100)
        {
            return true;
        } else {
            return false;
        }
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

    void render(int x, int y)
    { // This renders the button side of it
        int my_boardSize = 100;
        int my_cellSize;
        if(my_width > my_height)
        {
            my_cellSize = my_boardSize / (my_width + 2);
        }else {
            my_cellSize = my_boardSize / (my_height + 2);
        }
        stroke(0);
        if(isMouseOver(x, y))
        {
            fill(150);
        }else{
            fill(255);
        }
        rect(x, y, my_boardSize, my_boardSize);
        for(int i = 0; i < my_width; i++)
        {
            for(int j = 0; j < my_height; j++)
            {
                if(structure[i][j])
                {
                    stroke(0,0,255);
                    fill(0,0,255);
                    rect(x + i*my_cellSize + my_cellSize, y + j*my_cellSize + my_cellSize, my_cellSize, my_cellSize);
                }
            }
        }
        stroke(0);
        fill(0);
        textSize(20);
        int xGap = int((my_boardSize - textWidth(name)) / 2);
        text(name, x + xGap, y + my_boardSize - 2);
    }
}