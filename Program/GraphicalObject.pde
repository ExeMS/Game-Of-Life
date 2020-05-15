class GraphicalObject
{
    int x, y;
    float my_width, my_height;

    GraphicalObject(int x, int y, float my_width, float my_height)
    {
        this.x = x;
        this.y = y;
        this.my_width = my_width;
        this.my_height = my_height;
    }

    boolean isMouseOver()
    {
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
        return false;
    }

    String getType()
    {
        println("Calling base function");
        return "Base";
    }
}