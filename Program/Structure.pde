class Structure
{
    private boolean[][] structure;
    private int gridX, gridY; // Stores the grid location of the structure
    private int my_width, my_height;

    Structure(String filename)
    {
        structure = readFromFile(filename);
        my_width = structure.length;
        my_height = structure[0].length;
        gridX = 0;
        gridY = 0;
    }

    void update()
    {
        gridX = screenXPos / 10 + (mouseX - (my_width * CELL_SIZE / 2)) / CELL_SIZE;
        gridY = screenYPos / 10 + (mouseY - (my_height * CELL_SIZE / 2)) / CELL_SIZE;
    }

    int getWidth()
    {
        return my_width;
    }

    int getHeight()
    {
        return my_height;
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
        return structure[x][y];
    }
}