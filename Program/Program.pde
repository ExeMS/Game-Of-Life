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

ArrayList<Cell> cellList = new ArrayList<Cell>(); // This creates a list that can store cells

ArrayList<Cell> god(ArrayList<Cell> cellList)
{ // This will add and delete cells depending on the rotation
    cellList = sortList(cellList);
    return cellList;
}

ArrayList<Cell> sortList(ArrayList<Cell> cellList)
{
    ArrayList<Cell> sortedList = new ArrayList<Cell>();
    for(Cell each : cellList)
    {
        int pos = -1;
        for(int j = 0; j < sortedList.size(); j++)
        {
            if(each.getX() < sortedList.get(j).getX())
            {
                pos = j;
                break;
            } else if(each.getX() == sortedList.get(j).getX() && each.getY() < sortedList.get(j).getY())
            {
                pos = j;
                break;
            }
        }
        if(pos == -1)
        {
            sortedList.add(each);
        }else
        {
            sortedList.add(pos, each);
        }
    }
    return sortedList;
}

void setup()
{
    size(1000,1000);
    background(255);
    // This is just here for testing purposes
    cellList.add(new Cell(10, 10, color(0, 255,0)));
    cellList.add(new Cell(100, 10, color(0, 255,0)));
    cellList.add(new Cell(50, 10, color(0, 255,0)));
    cellList.add(new Cell(60, 10, color(0, 255,0)));
    cellList.add(new Cell(20, 10, color(0, 255,0)));
    cellList.add(new Cell(40, 20, color(0, 255,0)));
    cellList.add(new Cell(40, 10, color(0, 255,0)));
    cellList.add(new Cell(40, 30, color(0, 255,0)));
    cellList = sortList(cellList);
    for(Cell each : cellList)
    {
        println("X value:");
        println(each.getX());
        println("Y value:");
        println(each.getY());
        println("--------------");
    }
    for (int i = 0; i < 20; i++)
    { // Need to randomise their x and y value - or give them a set one...
        //cellList.add(new Cell());
    }
}

void draw()
{
    background(255);
    for (Cell each : cellList) // This goes through all the cells
    {
        stroke(each.getColour());
        fill(each.getColour());
        rect(each.getX(), each.getY(), 10, 10);
        cellList = god(cellList);
        // To get an item use: cellList.get(i);
    }
}