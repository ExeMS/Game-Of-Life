import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Program extends PApplet {

// 0: empty, 2: cell
int[][] board = new int[100][100];
int[][] boardcopy = new int[100][100];

public void god()
{
    for (int i = 0; i < board.length; i++) {
        for (int j = 0; j < board.length; j++) {
            boardcopy[i][j] = board[i][j];
        }
    }
    for (int i = 0; i < board.length; i++) {
        for (int j = 0; j < board.length; j++) {
            int counter = 0;
            if ((i != 0) && (j !=0) && (i != 99) && (j != 99)) {
                // counting the number of alive cells around the cell
                if (board[i-1][j] == 1) {
                    counter++;
                }
                if (board[i+1][j] == 1) {
                    counter++;
                }
                if (board[i-1][j-1] == 1) {
                    counter++;
                }
                if (board[i][j-1] == 1) {
                    counter++;
                }
                if (board[i+1][j-1] == 1) {
                    counter++;
                }
                if (board[i-1][j+1] == 1) {
                    counter++;
                }
                if (board[i][j+1] == 1) {
                    counter++;
                }
                if (board[i+1][j+1] == 1) {
                    counter++;
                }
            }
            //Running through the rules
            if ((counter < 2) && (board[i][j] == 1)) {
                boardcopy[i][j] = 0;
            }
            if ((counter > 3) && (board[i][j] == 1)) {
                boardcopy[i][j] = 0;
            }
            if ((counter == 3) && (board[i][j] == 0)) {
                boardcopy[i][j] = 1;
            }
        }
    }
    for (int i = 0; i < 100; i++) {
        for (int j = 0; j < 100; j++) {
            board[i][j] = boardcopy[i][j];
        }
    }
}

public void setup()
{
    
    background(255);
    for(int i = 0; i < 100; i++) // Sets the whole board to 0
    {
        for(int j = 0; j < 100; j++)
        {
            int r = PApplet.parseInt(random(4));
            if(r == 0)
            {
                board[i][j] = 1;
            }else {
                board[i][j] = 0;
            }
        }
    }
    /*board[50][50] = 1; // THis is setting one thing to be alive
    board[49][50] = 1;
    board[51][50] = 1;
    board[51][49] = 1;
    board[50][48] = 1;*/
}

public void draw()
{
    delay(100); // Just waits a second
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
  public void settings() {  size(1000,1000); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Program" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
