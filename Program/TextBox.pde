class TextBox
{
    private int x, y;
    private int my_width, my_height;
    private String inputText;
    private boolean showCursor = true;
    private int cursorDelay = 0;

    TextBox(int x, int y, int my_width)
    {
        this.x = x;
        this.y = y;
        this.my_width = my_width;
        textSize(my_textSize);
        this.my_height = textAscent() * 0.8 + 20;
    }

    void update()
    {
    }

    void render()
    {
    }

    boolean isMouseOver()
    {
    }
}