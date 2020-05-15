class GraphicImage extends GraphicalObject
{
    private PImage img;

    GraphicImage(int x, int y, float my_width, float my_height, String filename)
    {
        super(x, y, my_width, my_height);
        img = loadImage(filename);
    }

    void render()
    {
        image(img, x, y, my_width, my_height);
    }
}