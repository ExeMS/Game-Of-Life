class GraphicalObject
{
    protected int x, y;
    protected float my_width, my_height;

    GraphicalObject(int x, int y, float my_width, float my_height)
    {
        this.x = x;
        this.y = y;
        this.my_width = my_width;
        this.my_height = my_height;
    }

    boolean isMouseOver()
    {
        // Works out if the mouse is over the coordinates
        if (mouseX >= x && mouseX <= x+my_width &&
            mouseY >= y && mouseY <= y+my_height)
        {
            return true;
        } else {
            return false;
        }
    }

    void render()
    {
        println("Calling base function");
    }

    boolean checkMousePressed()
    {
        println("Calling base function");
        return isMouseOver();
    }

    String getType()
    {
        println("Calling base function");
        return "Base";
    }
}