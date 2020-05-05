import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Program extends PApplet {

class Cell
{
    private int x, y; // x and y for the position
    private int c;

    Cell(int x, int y, int c)
    {
        this.x = x;
        this.y = y;
        this.c = c;
    }

    // Getter functions for the variables
    public int getX() { return x; }
    public int getY() { return y; }
    public int getColour() { return c; }

    public void Update()
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

public ArrayList<Cell> god(ArrayList<Cell> cellList)
{ // This will add and delete cells depending on the rotation
    cellList = sortList(cellList);
    return cellList;
}

public ArrayList<Cell> sortList(ArrayList<Cell> cellList)
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

public void setup()
{
    
    background(255);
    // This is just here for testing purposes
    cellList.add(new Cell(10, 10, color(0, 255,0)));
    cellList.add(new Cell(100, 10, color(0, 255,0)));
    cellList.add(new Cell(50, 10, color(0, 255,0)));
    cellList.add(new Cell(60, 10, color(0, 255,0)));
    cellList.add(new Cell(20, 10, color(0, 255,0)));
    cellList.add(new Cell(40, 20, color(0, 255,0)));
    cellList.add(new Cell(40, 10, color(0, 255,0)));
    cellList.add(new Cell(40, 30, color(255, 0,0)));
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

public void draw()
{
    delay(1000);
    background(255);
    for (int i = cellList.size() - 1; i >= 0; i--) {
        Cell each = cellList.get(i);
        stroke(each.getColour());
        fill(each.getColour());
        rect(each.getX(), each.getY(), 10, 10);
        each.Update();
        if(each.getColour() == color(255,0,0))
        {
            cellList.remove(i);
        }
    }
    cellList = god(cellList);
}
  public void settings() {  size(1000,1000); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Program" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
