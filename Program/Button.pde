// This is for when we want to display a button
class Button extends GraphicalObject
{
    private String my_text;
    private int my_textSize;
    private int paddingX, paddingY;
    private color textColour, baseColour, hoverColour, outline;
    private String type;

    // We might also want to pass in a function for when it is pressed
    Button(String type, int x, int y, String text, int my_textSize)
    {
        super(x, y, textWidth(text) + 20, textAscent() * 0.8 + 20);
        this.type = type;
        textSize(my_textSize);
        this.paddingX = 10;
        this.paddingY = 10;

        this.my_text = text;
        this.my_textSize = my_textSize;
        this.textColour = color(0);

        this.outline = color(0);
        this.baseColour = color(255);
        this.hoverColour = color(150);
    }

    Button(String type, int x, int y, float my_width, float my_height)
    {
        super(x, y, my_width, my_height);
        this.type = type;
        this.paddingX = 10;
        this.paddingY = 10;

        this.my_text = "";
        this.my_textSize = 30;
        this.textColour = color(0);

        this.outline = color(0);
        this.baseColour = color(255);
        this.hoverColour = color(150);
    }

    Button(String type, int x, int y, int my_width, int my_height, String text, int my_textSize)
    {
        super(x, y, my_width, my_height);
        this.type = type;
        textSize(my_textSize);
        this.paddingX = int(my_width - textWidth(text)) / 2;
        this.paddingY = int(my_height - textAscent()) / 2;

        this.my_text = text;
        this.my_textSize = my_textSize;
        this.textColour = color(0);

        this.outline = color(0);
        this.baseColour = color(255);
        this.hoverColour = color(150);
    }

    Button(String type, int x, int y, int paddingX, int paddingY, String text, int my_textSize, color textColour, color outline, color baseColour, color hoverColour)
    {
        super(x, y, textWidth(text) + 20, textAscent() * 0.8 + 20);
        this.type = type;
        textSize(my_textSize);
        this.paddingX = paddingX;
        this.paddingY = paddingY;

        this.my_text = text;
        this.my_textSize = my_textSize;
        this.textColour = textColour;

        this.outline = outline;
        this.baseColour = baseColour;
        this.hoverColour = hoverColour;
    }

    void render()
    { // This renders the button
        if(!(
            (type == "cancelPlacement" && currentStructureActive == -1)
            || (type == "spawnStructure" && mode == 1)
        ))
        {
            stroke(outline);
            if(isMouseOver())
            {
                fill(hoverColour);
                mouseOverButton();
            }else
            {
                fill(baseColour);
            }
            rect(x, y, my_width, my_height);
            fill(textColour);
            textSize(my_textSize);
            text(my_text, x + paddingX, y + textAscent() * 0.8 + paddingY);
        }
    }

    boolean checkMousePressed(Menu menu,boolean hasSomethingBeenPressed)
    {
        if(isMouseOver() && !hasSomethingBeenPressed)
        { // This goes through all the types of buttons and runs what they are meant to do when pressed
          // It was done like this as processing doesn't allow you to write lambdas
            if(currentStructureActive != -1)
            { // This sets the rotation, if the user is placing down a structure
                structures.get(currentStructureActive).resetRotated();
                currentStructureActive = -1;
            }
            // GUI TYPES
            if(type == "spawnStructure")
            {
                changeMenu(4);
                return true;
            }else if(type == "cancelPlacement")
            {
                cancelPlacement();
                return true;
            }else if(type == "playPause")
            {
                paused = !paused;
                if(paused)
                {
                    my_text = "PLAY";
                }else
                {
                    my_text = "PAUSE";
                }
                textSize(my_textSize);
                this.paddingX = int(my_width - textWidth(my_text)) / 2;
                return true;
            }else if(type == "mainMenu")
            {
                changeMenu(3);
                return true;
            }
            // MAIN MENU TYPES
            else if(type == "explore")
            {
                startGame_Explore();
                return true;
            }else if(type == "sandbox")
            {
                startGame_sandbox();
                return true;
            }else if(type == "openFileMenu")
            {
                startGame_file();
                return true;
            }else if(type == "exitGame")
            {
                exit(); // This just closes the window
                // The rest of the code is never run
            }
            // OPEN FILE TYPES
            else if(type == "cancelOpening")
            {
                resetToDefaults();
            } else if(type == "openFile")
            {
                openSavedGame(menu.getInput() + ".gol");
            }
            // SAVE FILE TYPES
            else if(type == "dontSave")
            {
                resetToDefaults();
            }else if(type == "save")
            {
                saveGame(menu.getInput() + ".gol");
            }
        }
        return false;
    }

    String getType()
    {
        return "Button";
    }

    void reset()
    {
        if(type == "playPause")
        {
            my_text = "PLAY";
            textSize(my_textSize);
            this.paddingX = int(my_width - textWidth(my_text)) / 2;
        }
    }
};