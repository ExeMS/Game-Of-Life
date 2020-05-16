void clearBoard()
{ // This sets the whole board to 0
    for(int i = 0; i < BOARD_WIDTH; i++) // Sets the whole board to 0
    {
        for(int j = 0; j < BOARD_HEIGHT; j++)
        {
            board[i][j] = false;
        }
    }
}

void randomBoard()
{ // This randomizes the whole board
    for(int i = 0; i < BOARD_WIDTH; i++)
    {
        for(int j = 0; j < BOARD_HEIGHT; j++)
        {
            int r = int(random(4));
            if(r == 0)
            {
                board[i][j] = true;
            }else {
                board[i][j] = false;
            }
        }
    }
}

void setBoardToStruct(boolean[][] struct)
{
    if(struct.length < BOARD_WIDTH || struct[0].length < BOARD_HEIGHT)
    {
        int startX = int((BOARD_WIDTH - struct.length) / 2);
        int startY = int((BOARD_HEIGHT - struct[0].length) / 2);
        for(int i = 0; i < struct.length; i++)
        {
            for(int j = 0; j < struct[i].length; j++)
            {
                board[startX + i][startY + j] = struct[i][j];
            }
        }
    }else
    {
        board = struct;
    }
}

void sandboxStart() {
}

void startGame_Explore()
{ // This randomizes the board and sets the mode to 1
    randomBoard();
    mode = 1;
    changeMenu(0);
};

void startGame_file()
{ // We might need do this at some point :D
    clearBoard();
    mode = 3;
    changeMenu(2);
};

void startGame_sandbox()
{
    sandboxStart();
    mode = 2;
    changeMenu(0);
};

// Updates the game
void god()
{
  if(paused == false) {
      for (int i = 0; i < BOARD_WIDTH; i++) {
          for (int j = 0; j < BOARD_HEIGHT; j++) {
              boardcopy[i][j] = board[i][j];
              int counter = 0;
              // counting the number of alive cells around the cell
              if (i != 0 && board[i-1][j]) {
                  counter++;
              }
              if (i != BOARD_WIDTH - 1 && board[i+1][j]) {
                  counter++;
              }
              if (i != 0 && j != 0 && board[i-1][j-1]) {
                  counter++;
              }
              if (j != 0 && board[i][j-1]) {
                  counter++;
              }
              if (i != BOARD_WIDTH - 1 && j != 0 && board[i+1][j-1]) {
                  counter++;
              }
              if (i != 0 && j != BOARD_HEIGHT - 1 && board[i-1][j+1]) {
                  counter++;
              }
              if (j != BOARD_HEIGHT - 1 && board[i][j+1]) {
                  counter++;
              }
              if (j != BOARD_HEIGHT - 1 && i != BOARD_WIDTH - 1 && board[i+1][j+1]) {
                  counter++;
              }
              //Running through the rules
              if ((counter < 2) && (board[i][j])) {
                  boardcopy[i][j] = false;
              }
              if ((counter > 3) && (board[i][j])) {
                  boardcopy[i][j] = false;
              }
              if ((counter == 3) && (board[i][j] == false)) {
                  boardcopy[i][j] = true;
              }
          }
      }
      for (int i = 0; i < BOARD_WIDTH; i++) {
          for (int j = 0; j < BOARD_HEIGHT; j++){
              board[i][j] = boardcopy[i][j];
          }
      }
  }
}