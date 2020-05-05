// 0: empty, 2: cell
int[][] board = new int[100][100];

void god()
{
}

void setup()
{
    size(1000,1000);
    background(255);
    for(int i = 0; i < 100; i++) // Sets the whole board to 0
    {
        for(int j = 0; j < 100; j++)
        {
            board[i][j] = 0;
        }
    }
    board[1][1] = 1; // THis is setting one thing to be alive
}

void draw()
{
    delay(1000); // Just waits a second
    background(255);
    for(int i = 0; i < 100; i++) // Goes through the 2d matrix and draws the cell if it is alive
    {
        for(int j = 0; j < 100; j++)
        {
            if(board[i][j] == 1) // 1 means that it is alive
            {
                stroke(0, 255, 0);
                fill(0, 255, 0);
                rect(i*10, j*10, 10, 10); // Multiplies the index by 10 because each one is a 10 by 10 pixel
            }
        }
    }
    god();
}