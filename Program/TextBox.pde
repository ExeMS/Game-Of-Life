class TextBox
{
    private int x, y;
    private boolean isFocused;
    private int my_width, my_height;
    private String inputText;
    private boolean showCursor = true;
    private int cursorDelay = 0;

    TextBox(int x, int y, int my_width)
    {
        this.x = x;
        this.y = y;
        this.my_width = my_width;
        textSize(20);
        this.my_height = textAscent() * 0.8 + 20;
        isFocused = false;
    }

    void update()
    {
        if(cursorDelay == 0)
        {
            cursorDelay = 10;
            showCursor = !showCursor;
        }
        else{
            cursorDelay -= 1;
        }
    }

    void inputKey(char inpKey)
    {
        inputText
    }

    void render()
    {
        stroke(0);
        fill(255);
        rect(x, y, my_width, my_height);
        fill(0);
        textSize(20);
        text(inputText, x + 10, y + textAscent() * 0.8 + 10);
        if(showCursor)
        {
            line(x + textWidth(inputText), y + 10, x + textWidth(inputText), y + 10 + textAscent() * 0.8);
        }
    }

    void setFocused(boolean temp)
    {
        isFocused = temp;
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

    String getInput()
    {
        return inputText;
    }
}