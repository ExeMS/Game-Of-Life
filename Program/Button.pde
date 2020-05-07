// This is for when we want to display a button
class Button
{
    private int x, y;
    private float my_width, my_height;
    private String my_text;
    private int my_textSize;
    private int paddingX, paddingY;
    private color textColour, baseColour, hoverColour, outline;

    // We might also want to pass in a function for when it is pressed
    Button(int x, int y, String text, int my_textSize)
    {
        this.x = x;
        this.y = y;
        textSize(my_textSize);
        this.my_width = textWidth(text) + 20;
        this.my_height = textAscent() * 0.8 + 20;
        this.paddingX = 10;
        this.paddingY = 10;

        this.my_text = text;
        this.my_textSize = my_textSize;
        this.textColour = color(0);

        this.outline = color(0);
        this.baseColour = color(255);
        this.hoverColour = color(150);
    }

    Button(int x, int y, float my_width, float my_height)
    {
        this.x = x;
        this.y = y;
        this.my_width = my_width;
        this.my_height = my_height;
        this.paddingX = 10;
        this.paddingY = 10;

        this.my_text = "";
        this.my_textSize = 30;
        this.textColour = color(0);

        this.outline = color(0);
        this.baseColour = color(255);
        this.hoverColour = color(150);
    }

    Button(int x, int y, int my_width, int my_height, String text, int my_textSize)
    {
        this.x = x;
        this.y = y;
        textSize(my_textSize);
        this.my_width = my_width;
        this.my_height = my_height;
        this.paddingX = int(my_width - textWidth(text)) / 2;
        this.paddingY = int(my_height - textAscent()) / 2;

        this.my_text = text;
        this.my_textSize = my_textSize;
        this.textColour = color(0);

        this.outline = color(0);
        this.baseColour = color(255);
        this.hoverColour = color(150);
    }

    Button(int x, int y, int paddingX, int paddingY, String text, int my_textSize, color textColour, color outline, color baseColour, color hoverColour)
    {
        this.x = x;
        this.y = y;
        textSize(my_textSize);
        this.my_width = textWidth(text) + 2 * paddingX;
        this.my_height = textAscent() * 0.8 + 2 * paddingX;
        this.paddingX = paddingX;
        this.paddingY = paddingY;

        this.my_text = text;
        this.my_textSize = my_textSize;
        this.textColour = textColour;

        this.outline = outline;
        this.baseColour = baseColour;
        this.hoverColour = hoverColour;
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

    void update()
    {
        stroke(outline);
        if(isMouseOver())
        {
            fill(hoverColour);
        }else
        {
            fill(baseColour);
        }
        rect(x, y, my_width, my_height);
        fill(textColour);
        textSize(my_textSize);
        text(my_text, x + paddingX, y + textAscent() * 0.8 + paddingY);
    }

    void setBackgroundColour(color baseColour, color hoverColour)
    {
        this.baseColour = baseColour;
        this.hoverColour = hoverColour;
    }
};