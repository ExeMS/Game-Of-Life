class Cell
{
    private int x, y; // x and y for the position
    private color c;

    Cell(int x, int y, color c)
    {
        this.x = x;
        this.y = y;
        this.c = c;
    }

    // Getter functions for the variables
    int getX() { return x; }
    int getY() { return y; }
    color getColour() { return c; }

    void Update()
    {
        if(c == color(0, 0, 255)) // Checks if colour is blue
        {
            if(x > 1920) {
                c = color(255, 0, 0); // Sets colour to red
            } else {
                c = color(0, 255, 0); // Sets colour to green
            }
        }
    }
}

void god(cellList)
{ // This will add and delete cells depending on the rotation

}

void sortList(cellList)
{

}

ArrayList<Cell> cellList = new ArrayList<Cell>(); // This creates a list that can store cells

void setup()
{
    size(1920,1080);
    background(255);
    for (int i = 0; i < 20; ++i)
    { // Need to randomise their x and y value - or give them a set one...
        //cellList.add(new Cell());
    }
}

void draw()
{
    for (int i = 0; i < cellList.size(); i++) // This goes through all the cells
    {
        // To get an item use: cellList.get(i);
    }
}