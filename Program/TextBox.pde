class TextBox extends GraphicalObject
{
    private boolean isFocused;
    private String inputText;
    private boolean showCursor = true;
    private int cursorDelay = 0;
    private int cursorPosition = 0;

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
        textSize(20);
        if(inpKey == BACKSPACE)
        {
            if(cursorPosition != 0)
            {
                inputText = inputText.substring(0, cursorPosition - 1) + inputText.substring(cursorPosition, inputText.length());
                cursorPosition -= 1;
            }
        }else if(inpKey == DELETE)
        {
            if(cursorPosition != inputText.length())
            {
                inputText = inputText.substring(0, cursorPosition) + inputText.substring(cursorPosition + 1, inputText.length());
            }
        }else if(inpKey == CODED)
        {
            if(keyCode == RIGHT && cursorPosition != inputText.length())
            {
                cursorPosition += 1;
            }else if(keyCode == LEFT && cursorPosition != 0)
            {
                cursorPosition -= 1;
            }
        }else if(textWidth(inputText + "W") + 10 < my_width)
        {
            inputText = inputText.substring(0, cursorPosition) + inpKey + inputText.substring(cursorPosition, inputText.length());
            cursorPosition += 1;
        }
    }

    void render()
    {
        update();
        if(isMouseOver())
        {
            mouseOverText();
        }
        stroke(0);
        fill(255);
        rect(x, y, my_width, my_height);
        fill(0);
        textSize(20);
        text(inputText, x + 5, y + textAscent() * 0.8 + 10);
        if(showCursor && isFocused)
        {
            String tempA = inputText.substring(0, cursorPosition);
            line(x + textWidth(tempA) + 5, y + 5, x + textWidth(tempA) + 5, y + 10 + textAscent() * 0.8);
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