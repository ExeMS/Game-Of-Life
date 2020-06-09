class TextBox extends GraphicalObject
{
    private boolean isFocused;
    private String inputText;
    private String visibleText;
    private String tempString = "";
    private boolean showCursor = true;
    private int cursorDelay = 0;
    private int cursorPosition = 0;
    private int inputTextStartPos = 0;

    // Constructor
    TextBox(int x, int y, int my_width)
    {
        super(x, y, my_width, textAscent() * 0.8 + 10);
        textSize(20);
        inputText = "";
        visibleText = "";
        isFocused = false;
    }

    private void changeTextStartPos(int changeBy)
    { // Changes the textStartPosition
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
    { // Updates the visible text - so it includes the cursor
        visibleText = "";
        String tempText = inputText.substring(inputTextStartPos, inputText.length());
        textSize(20);
        for(int i = 0; i < tempText.length(); i++)
        {
            if(textWidth(visibleText + tempText.substring(i, i + 1)) + 10 > my_width)
            { // If no more characters fit in the width, it stops there
                break;
            }else
            {
                visibleText += tempText.charAt(i);
            }
        }
    }

    void update()
    {
        // Makes the cursor flash
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
    { // Clears the inputText
        inputText = "";
    }

    void inputKey(char inpKey)
    {
        textSize(20);
        if(inpKey == BACKSPACE)
        {// Deletes the character before the cursor
            tempString = "";
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
        } else if(inpKey == DELETE)
        {// Deletes the character after the cursor
            tempString = "";
            if(cursorPosition != inputText.length())
            {
                inputText = inputText.substring(0, cursorPosition) + inputText.substring(cursorPosition + 1, inputText.length());
                if(inputTextStartPos != 0 && inputText.length() <= inputTextStartPos + visibleText.length())
                {
                    changeTextStartPos(-1);
                }
                updateVisibleText();
            }
        } else if(inpKey == CODED)
        {// Checks if arrow keys have been moved
            tempString = "";
            if(keyCode == RIGHT)
            { // Moves the cursor right
                if(inputText.length() == cursorPosition)
                {} else if(cursorPosition - inputTextStartPos == visibleText.length() && textWidth(visibleText) + CHARACTER_WIDTH + 10 > my_width)
                {
                    changeTextStartPos(1);
                    cursorPosition += 1;
                    inputTextStartPos += 1;
                }else
                {
                    cursorPosition += 1;
                }
            }else if(keyCode == LEFT)
            { // Moves the cursor left
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
        } else if(inpKey == ENTER)
        {
            tempString = "";
            if(currentMenu == 2)
            {
                openSavedGame(inputText);
            } else if(currentMenu == 3)
            {
                saveGame(inputText);
            }
        } else if(inpKey == ESC)
        {
            isFocused = false;
        } else if(inpKey == TAB)
        { // Autocomplete
            if(tempString == "")
            {
                for(String s : gameSaves)
                { // Checks if there are any things like it
                    int inpStrLength = inputText.length();
                    if(inpStrLength <= s.length() && s.toLowerCase().substring(0, inpStrLength).equals(inputText.toLowerCase()))
                    {
                        tempString = inputText;
                        setInputText(s);
                        break;
                    }
                }
            } else
            { // Goes through in a loop of all the possibilities
                boolean looking = false;
                boolean foundNothing = true;
                for(String s : gameSaves)
                {
                    if(looking)
                    {
                        int inpStrLength = tempString.length();
                        if(inpStrLength <= s.length() && s.toLowerCase().substring(0, inpStrLength).equals(tempString.toLowerCase()))
                        {
                            foundNothing = false;
                            setInputText(s);
                            break;
                        }
                    }else
                    {
                        if(s == inputText)
                        {
                            looking = true;
                        }
                    }
                }
                if(foundNothing) // This starts the process from the beginning (a complete cycle)
                {
                    for(String s : gameSaves)
                    {
                        int inpStrLength = tempString.length();
                        if(inpStrLength <= s.length() && s.toLowerCase().substring(0, inpStrLength).equals(tempString.toLowerCase()))
                        {
                            setInputText(s);
                            break;
                        }
                    }
                }
            }
        } else if(cursorPosition - inputTextStartPos == visibleText.length() && textWidth(visibleText) + CHARACTER_WIDTH + 10 > my_width)
        { // Updates the visibleText and places a character
            tempString = "";
            inputText = inputText.substring(0, cursorPosition) + inpKey + inputText.substring(cursorPosition, inputText.length());
            int totalWidth = 0;
            cursorPosition += 1;
            changeTextStartPos(1);
        } else
        { // Places a character
            tempString = "";
            inputText = inputText.substring(0, cursorPosition) + inpKey + inputText.substring(cursorPosition, inputText.length());
            cursorPosition += 1;
            updateVisibleText();
        }
    }

    void render()
    { // This renders the text function
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
            { // If the cursor is out-of-bounds it shouts a lot
                println(cursorPosition - inputTextStartPos);
                println("What happened?");
                tempA = visibleText.substring(0, visibleText.length());
            }else
            {
                tempA = visibleText.substring(0, cursorPosition - inputTextStartPos);
            }
            // draws the cursor
            line(x + textWidth(tempA) + 5, y + 5, x + textWidth(tempA) + 5, y + 10 + textAscent() * 0.8);
        }
    }

    void sendCursorToEnd()
    { // This puts the cursor at the end of the text + deals with the visibleText
        cursorPosition = inputText.length();
        String tempText = "";
        inputTextStartPos = 0;
        textSize(20);
        for(int i = cursorPosition - 1; i > -1; i--)
        {
            if(textWidth(tempText + inputText.charAt(i)) + 10 > my_width)
            {
                inputTextStartPos = i + 1;
                break;
            }else
            {
                tempText = inputText.charAt(i) + tempText;
            }
        }
        visibleText = tempText;
    }

    void setFocused(boolean newFocused)
    { // Sets isFocused
        isFocused = newFocused;
    }

    void setInputText(String newInput)
    { // Sets the inputText and sends the cursor to the back
        inputText = newInput;
        sendCursorToEnd();
    }

    String getInput()
    { // Returns the input
        return inputText;
    }

    boolean getIsFocused()
    { // returns isFocused
        return isFocused;
    }

    boolean checkMousePressed()
    { // Checks if the mouse has pressed it
        if(isMouseOver())
        {
            isFocused = true;
            textSize(20);
            // Calculates where it should place the cursor, depending on the position of the mouse
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
            return true;
        }else
        {
            // If it has not been placed, it shows only the beginning of the text and sets isFocused to false
            if(isFocused)
            {
                isFocused = false;
                inputTextStartPos = 0;
                cursorPosition = 0;
                updateVisibleText();
            }
            return false;
        }
    }

    void reset()
    { // Resets all the variables
        clear();
        setFocused(false);
        inputTextStartPos = 0;
        cursorPosition = 0;
        tempString = "";
        updateVisibleText();
    }

    String getType()
    {
        return "TextBox";
    }
}