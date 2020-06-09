public class Menu extends GraphicalObject
{
    private Button[] my_buttons;
    private GraphicalStructure[] my_structures;
    private TextBox my_textBox;
    private Menu[] my_menus;
    private GraphicImage my_image;

    private boolean hasImage = false;
    private boolean hasTextBox = false;
    private boolean hasStructures = false;
    private boolean hasButtons = false;
    private boolean hasMenus = false;

    private String my_text = "";
    private String startText = "";
    private int textX, textY;

    private boolean hasBackground = false;
    private color backgroundColour, outlineColour;
    private int exitMenu = 1;

    // Constructors set all the variables
    public Menu(Button[] my_buttons)
    {
        super(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        this.my_buttons = my_buttons;
        hasButtons = true;
    }

    public Menu(Button[] my_buttons, GraphicImage img)
    {
        super(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        this.my_buttons = my_buttons;
        this.my_image = img;
        hasImage = true;
        hasButtons = true;
    }

    public Menu(GraphicalStructure[] my_structures, int exitMenu)
    {
        super(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        this.my_structures = my_structures;
        this.exitMenu = exitMenu;
        hasStructures = true;
    }

    public Menu(Button[] my_buttons, TextBox my_textBox)
    {
        super(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        this.my_buttons = my_buttons;
        this.my_textBox = my_textBox;
        hasTextBox = true;
        hasButtons = true;
    }

    public Menu(Menu[] my_menus)
    {
        super(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        this.my_menus = my_menus;
        hasMenus = true;
    }

    public Menu(int x, int y,
                int my_width, int my_height,
                Button[] my_buttons, TextBox my_textBox,
                color backgroundColour, color outlineColour,
                int exitMenu,
                String my_text)
    {
        super(x, y, my_width, my_height);

        this.my_buttons = my_buttons;
        hasButtons = true;
        hasTextBox = true;
        this.my_textBox = my_textBox;
        hasBackground = true;

        this.backgroundColour = backgroundColour;
        this.outlineColour = outlineColour;

        this.exitMenu = exitMenu;

        this.my_text = my_text;
        startText = my_text;
        textX = x + (my_width / 2);
        textY = y + (my_height / 2) - 20;
    }

    void reset()
    {
        // This resets all the objects in the menu
        if(hasMenus)
        {
            for(Menu menu : my_menus)
            {
                menu.reset();
            }
        }
        if(hasButtons)
        {
            for(Button button : my_buttons)
            {
                button.reset();
            }
        }
        if(hasTextBox)
        {
            my_textBox.reset();
        }
        my_text = startText;
    }

    boolean isMouseOverElement()
    {
        // Goes through checking if the mouse is over any element
        if(hasButtons)
        {
            for(Button button : my_buttons)
            {
                boolean temp = button.isMouseOver();
                if(temp)
                {
                    return true;
                }
            }
        }
        if(hasMenus)
        {
            for(Menu menu : my_menus)
            {
                boolean temp = menu.isMouseOverElement();
                if(temp)
                {
                    return true;
                }
            }
        }
        if(hasStructures)
        {
            for(GraphicalStructure structure : my_structures)
            {
                boolean temp = structure.isMouseOver();
                if(temp)
                {
                    return true;
                }
            }
        }
        if(hasTextBox)
        {
            boolean temp = my_textBox.isMouseOver();
            if(temp)
            {
                return true;
            }
        }
        return false;
    }

    boolean checkMousePressed()
    {
        boolean anythingClicked = false;
        boolean pleaseExit = false;
        boolean hasButtonBeenPressed = false;
        boolean hasStructureBeenPressed = false;
        // Goes through each object and making them check if they have been pressed
        if(hasButtons)
        {
            for(Button button : my_buttons)
            {
                if(hasButtonBeenPressed)
                {
                    button.checkMousePressed(this, hasButtonBeenPressed);
                }else
                {
                    hasButtonBeenPressed = button.checkMousePressed(this, hasButtonBeenPressed);
                }
            }
            anythingClicked = hasButtonBeenPressed;
        }

        if(hasMenus)
        {
            for(Menu menu : my_menus)
            {
                if(anythingClicked)
                {
                    menu.checkMousePressed();
                }else
                {
                    anythingClicked = menu.checkMousePressed();
                }
            }
        }

        if(hasStructures)
        {
            pleaseExit = true; // If no structure has been pressed, it will exit
            for(GraphicalStructure structure : my_structures)
            {
                hasStructureBeenPressed = structure.checkMousePressed();
                if(hasStructureBeenPressed)
                {
                    pleaseExit = false;
                }
            }
            if(!anythingClicked && !pleaseExit)
            {
                anythingClicked = true;
            }
        }

        if(hasTextBox)
        {
            if(anythingClicked)
            {
                my_textBox.checkMousePressed();
            }else{
                anythingClicked = my_textBox.checkMousePressed();
            }
        }
        if(mouseX > x + my_width || mouseX < x
                || mouseY < y || mouseY > y + my_height
                || pleaseExit)
        {
            // If nothing has been pressed, or the mouse is out-of-bounds it changes the menu to the exitMenu
            changeMenu(exitMenu);
        }
        return anythingClicked;
    }

    void render()
    {
        // This renders everything
        if(hasBackground)
        {
            stroke(outlineColour);
            fill(backgroundColour);
            rect(x, y, my_width, my_height);
        }
        if(hasButtons)
        {
            for(Button button : my_buttons)
            {
                button.render();
            }
        }
        if(hasMenus)
        {
            for(Menu menu : my_menus)
            {
                menu.render();
            }
        }
        if(hasStructures)
        {
            for(GraphicalStructure structure : my_structures)
            {
                structure.render();
            }
        }
        if(hasTextBox)
        {
            my_textBox.render();
        }

        if(hasImage)
        {
            my_image.render();
        }
        textSize(30);
        stroke(0);
        fill(0);
        textAlign(CENTER);
        text(my_text, SCREEN_WIDTH/2, SCREEN_HEIGHT/2 - 20);
        textAlign(LEFT);
    }

    String getInput()
    {
        // This gets the input of the text box - if it has one
        if(hasTextBox)
        {
            return my_textBox.getInput();
        }
        return "";
    }

    void setInputText(String newString)
    {
        // sets the input of the text box - if it has one
        if(hasTextBox)
        {
            my_textBox.setInputText(newString);
        }
    }

    void setString(String newString)
    {
        // Changes the text on the menu
        my_text = newString;
    }

    boolean isTextBoxFocused()
    {
        // Checks if the text box is focused - if it has one
        if(hasTextBox)
        {
            return my_textBox.getIsFocused();
        }
        return false;
    }

    TextBox getTextBox()
    { // Returns the textBox
        return my_textBox;
    }

    String getType()
    {
        return "Menu";
    }
}
