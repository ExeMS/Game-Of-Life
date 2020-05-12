class Structure
{
    private boolean[][] structure;
    private int gridX, gridY; // Stores the grid location of the structure
    private int my_width, my_height;
    private String name;

    Structure(String filename)
    {
        structure = readFromFile(filename);
        name = filename;
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

    void place()
    {
        for(int i = 0; i < my_width; i++)
        {
            for(int j = 0; j < my_height; j++)
            {
                board[i + gridX][j + gridY] = structure[i][j];
            }
        }
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

    void render(int x, int y)
    {
        int my_boardSize = 100;
        int my_cellSize;
        if(my_width > my_height)
        {
            my_cellSize = my_boardSize / (my_width + 2);
        }else {
            my_cellSize = my_boardSize / (my_width + 2);
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