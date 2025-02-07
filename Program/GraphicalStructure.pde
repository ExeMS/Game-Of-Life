class GraphicalStructure extends GraphicalObject
{
    private int structureID;
    private float my_cellSize;
    private int textX, textY;

    GraphicalStructure(int x, int y, int structureID)
    {
        super(x, y, 100, 100);
        this.structureID = structureID;
        // This calculates the cellsize based on the size of the structure
        if(structures.get(structureID).getWidth() > structures.get(structureID).getHeight())
        {
            my_cellSize = my_width / (structures.get(structureID).getWidth() + 2);
        }else {
            my_cellSize = my_height / (structures.get(structureID).getHeight() + 2);
        }
        // Works out the position of the text
        textX = x + int(my_width - (textWidth(structures.get(structureID).getName())) / 2);
        textY = y + int(my_height) - 2;
    }

    void render()
    { // This renders the button side of it
        stroke(0);
        if(isMouseOver())
        {
            // Changes the colour depending on if the mouse is over it
            fill(150);
            mouseOverButton();
        }else{
            fill(255);
        }
        rect(x, y, my_width, my_height);
        stroke(0,0,255);
        fill(0,0,255);
        // Renders the structure inside the grid
        for(int i = 0; i < structures.get(structureID).getWidth(); i++)
        {
            for(int j = 0; j < structures.get(structureID).getHeight(); j++)
            {
                if(structures.get(structureID).get(i, j))
                {
                    rect(x + i*my_cellSize + my_cellSize, y + j*my_cellSize + my_cellSize, my_cellSize, my_cellSize);
                }
            }
        }
        stroke(0);
        fill(0);
        textAlign(LEFT);
        textSize(15);
        text(structures.get(structureID).getName(), textX, textY);
    }

    boolean checkMousePressed()
    {
        if(isMouseOver())
        {
            // Sets the menu to 0 and then sets the currentStructureAction to this structure
            changeMenu(0);
            currentStructureActive = structureID;
            renderStructure = true;
            return true;
        }
        return false;
    }
}
