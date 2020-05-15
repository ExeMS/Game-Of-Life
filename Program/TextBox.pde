class TextBox extends GraphicalObject
{
    private boolean isFocused;
    private String inputText;
    private boolean showCursor = true;
    private int cursorDelay = 0;

    TextBox(int x, int y, int my_width)
    {
        super(x, y, my_width, textAscent() * 0.8 + 10);
        textSize(20);
        inputText = "";
        isFocused = false;
    }

    void update()
    {
        if(isFocused)
        {
            if(cursorDelay == 0)
            {
                cursorDelay = 20;
                showCursor = !showCursor;
            }
            else{
                cursorDelay -= 1;
            }
        }
    }

    void clear()
    {
        inputText = "";
    }

    void inputKey(char inpKey)
    {
        if(inpKey == BACKSPACE)
        {
            if(inputText.length() != 0)
            {
                inputText = inputText.substring(0, inputText.length() - 1);
            }
        }else if(inpKey == CODED && keyCode < 31)
        {
        }else if(textWidth(inputText + "W") + 10 < my_width)
        {
            inputText += inpKey;
        }
    }

    void render()
    {
        update();
        stroke(0);
        fill(255);
        rect(x, y, my_width, my_height);
        fill(0);
        textSize(20);
        text(inputText, x + 5, y + textAscent() * 0.8 + 5);
        if(showCursor && isFocused)
        {
            line(x + textWidth(inputText) + 5, y + 5, x + textWidth(inputText) + 5, y + 5 + textAscent() * 0.8);
        }
    }

    void setFocused(boolean temp)
    {
        isFocused = temp;
    }

    String getInput()
    {
        return inputText;
    }

    boolean getIsFocused()
    {
        return isFocused;
    }

    boolean checkMousePressed()
    {
        if(isMouseOver())
        {
            isFocused = true;
            return true;
        }else
        {
            isFocused = false;
            return false;
        }
    }

    void reset()
    {
        clear();
        setFocused(false);
    }

    String getType()
    {
        return "TextBox";
    }
}