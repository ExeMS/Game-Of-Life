class TextBox extends GraphicalObject
{
    private boolean isFocused;
    private String inputText;
    private String visibleText;
    private boolean showCursor = true;
    private int cursorDelay = 0;
    private int cursorPosition = 0;
    private int inputTextStartPos = 0;

    TextBox(int x, int y, int my_width)
    {
        super(x, y, my_width, textAscent() * 0.8 + 10);
        textSize(20);
        inputText = "";
        visibleText = "";
        isFocused = false;
    }

    private void changeTextStartPos(int changeBy)
    {
        updateVisibleText();
        if(changeBy > 0)
        {
            while(cursorPosition - inputTextStartPos > visibleText.length())
            {
                inputTextStartPos += 1;
                updateVisibleText();
            }
        }else
        {
            textSize(20);
            while(inputTextStartPos != 0 && textWidth(visibleText + inputText.substring(inputTextStartPos - 1, inputTextStartPos)) + 10 <= my_width)
            {
                inputTextStartPos -= 1;
                updateVisibleText();
            }
        }
    }

    private void updateVisibleText()
    {
        visibleText = "";
        String tempText = inputText.substring(inputTextStartPos, inputText.length());
        for(int i = 0; i < tempText.length(); i++)
        {
            if(textWidth(visibleText + tempText.substring(i, i + 1)) + 10 > my_width)
            {
                break;
            }else
            {
                visibleText += tempText.charAt(i);
            }
        }
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
                if(inputTextStartPos != 0)
                {
                    changeTextStartPos(-1);
                }
                cursorPosition -= 1;
                updateVisibleText();
            }
        }else if(inpKey == DELETE)
        {
            if(cursorPosition != inputText.length())
            {
                inputText = inputText.substring(0, cursorPosition) + inputText.substring(cursorPosition + 1, inputText.length());
                if(inputTextStartPos != 0 && inputText.length() <= inputTextStartPos + visibleText.length())
                {
                    changeTextStartPos(-1);
                }
                updateVisibleText();
            }
        }else if(inpKey == CODED)
        {
            if(keyCode == RIGHT)
            {
                if(inputText.length() == cursorPosition)
                {} else if(cursorPosition - inputTextStartPos == visibleText.length() && textWidth(visibleText) + CHARACTER_WIDTH + 10 > my_width)
                {
                    changeTextStartPos(1);
                    cursorPosition += 1;
                }else
                {
                    cursorPosition += 1;
                }
            }else if(keyCode == LEFT)
            {
                if(cursorPosition == 0)
                {}else if(cursorPosition == inputTextStartPos)
                {
                    inputTextStartPos -= 1;
                    updateVisibleText();
                    cursorPosition -= 1;
                }else
                {
                    cursorPosition -= 1;
                }
            }
        }else if(cursorPosition - inputTextStartPos == visibleText.length() && textWidth(visibleText) + CHARACTER_WIDTH + 10 > my_width)
        {
            inputText = inputText.substring(0, cursorPosition) + inpKey + inputText.substring(cursorPosition, inputText.length());
            int totalWidth = 0;
            cursorPosition += 1;
            changeTextStartPos(1);
        }else
        {
            inputText = inputText.substring(0, cursorPosition) + inpKey + inputText.substring(cursorPosition, inputText.length());
            cursorPosition += 1;
            updateVisibleText();
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
        text(visibleText, x + 5, y + textAscent() * 0.8 + 10);
        if(showCursor && isFocused)
        {
            String tempA = "";
            if(cursorPosition - inputTextStartPos > visibleText.length())
            {
                println(cursorPosition - inputTextStartPos);
                println("What happened?");
                tempA = visibleText.substring(0, visibleText.length());
            }else
            {
                tempA = visibleText.substring(0, cursorPosition - inputTextStartPos);
            }
            line(x + textWidth(tempA) + 5, y + 5, x + textWidth(tempA) + 5, y + 10 + textAscent() * 0.8);
        }
    }

    void setFocused(boolean newFocused)
    {
        isFocused = newFocused;
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
            if(isFocused)
            {
                textSize(20);
                if(mouseX - x + 5 >= textWidth(visibleText))
                {
                    cursorPosition = inputTextStartPos + visibleText.length();
                } else if(mouseX <= x + 5)
                {
                    cursorPosition = 0;
                } else
                {
                    float tempX = mouseX - x + 5;
                    for(int i = 0; i < visibleText.length(); i++)
                    {
                        String substrBefore = visibleText.substring(0, i);
                        String substrChr = visibleText.substring(i, i + 1);
                        float substrWidth = textWidth(substrBefore);
                        float chrWidth = textWidth(substrChr);
                        if(tempX < substrWidth + chrWidth * 0.5)
                        {
                            continue;
                        } else
                        {
                            cursorPosition = inputTextStartPos + i;
                        }
                    }
                }
            }else
            {
                isFocused = true;
            }
            return true;
        }else
        {
            isFocused = false;
            inputTextStartPos = 0;
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