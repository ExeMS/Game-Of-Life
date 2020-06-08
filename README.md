# JC's Game Of Life

# Analysis
Cellular Automata: a system involving a finitely dimensioned grid, where cells can exist in one of a finite number of states (e.g. on and off), and where a cell's neibourhood is directly affected by it, under a finite number of rules, usually a mathmatical function.

Our Project: Creating a working version of Conway's Game Of Life (one of the more famous cellular automata) using Processing. This involves making a system that can create and delete life depending on patterns on an interface. After establishing a solid base to work from, add the option for the user to create their own patterns, as well as upload patterns from files.

How the problem was researched:
1) Google Search Conway's Game Of Life for rules and common patterns.
2) Do some programming.

Full details of the user(s)
A user will press start, and look at the pretty patterns for fun.

Feedback from a third part to find out if the analysis is detailed and clear enough

Objectives for the project:
1) Create a functioning version of Conway's game of life.
2) Maybe create an interactive interface so that a user can create their own start patterns.
3) Add a file reading function, so patterns can be taken from a user's file.
4) Add a save to file function, so a user can save their progress on a certain pattern.

The extent to which each objective has been achieved:
1) We have a fully functioning game of life, with all the bugs we've found along the way removed.
2) Sandbox mode is an interactive interface, allowing the player to create their own start patterns with the cell structure.
3) The file reading function works for both regular and apple keyboards.
4) The save to file function operates perfectly.

Extra features we've added:
1) Players can add more structures than just single cells, other strucures include gliders and spaceships.
2) The creation of user patterns is not limited to starting patterns, instead the board can be edited at any time in sandbox and file mode.
3) Players can also pause the game at any time in all three modes.

Significant Versions:
1) ee026b2 - Initial layout. - 2/5/2020
2) 5449aff - Changed to 2d Array System. - 5/5/2020
3) 74e3e46 - First working God function. - 6/5/2020
4) 4c6b5c4 - Split the program into several different files. - 7/5/2020
5) 62560f9 - First implementation of GUI. - 9/5/2020
6) a635c8d - Switched from int based system to boolean. - 9/5/2020
7) bae9ae4 - Added readFromFile function. - 13/5/2020

A model of a representation of the problem, possibly a drawing.

Sections that we should write for each one
## 1.1 Intoduction
We decided to create a program to simulate cellular automata. This is a system involving a finitely dimensioned grid, where cells can exist in one of a finite number of states (e.g. on and off), and where a cell's neibourhood is directly affected by it, under a finite number of rules, usually a mathmatical function. Depending on the pattern of cells, they can either create or destroy a cell, this allows the program, depending on the pattern, to create a moving object and also simulate a very basic version of cellular interactions. 
Our program should allow the user to explore and view a randomly generated map, and also allow them to create their own patterns on a blank map.

## 1.2 Background 
(talk about original game)

## 1.3 End user input 
(Just write the questions we could have asked)

## 1.4 Objectives

## 1.5 Proposed Solution
The program will be written in processing-java as it allows us to easily create a GUI. It will also be split up into multiple menus, to make it easier to navigate the program and also to minimise repeating code.
The main menu was just a simple menu to chose if you wanted the default mode (play) where a world is randomly generated or the sandbox mode which allowed you to create their own pattern.
![Image of main menu](https://github.com/ExeMS/Game-Of-Life/blob/master/Main%20Menu.png)
The GUI allows the user to play or pause the game, in the bottom left corner, go back to the menu, in the top right corner, or access the structures through the "Structures" button in the top left
![Image of GUI](https://github.com/ExeMS/Game-Of-Life/blob/master/GUI.png)
The "Structures" button would take you to a menu to select which structure to place in.
![Image of Structure Menu](https://github.com/ExeMS/Game-Of-Life/blob/master/Structure%20Menu.png)

The program will use a boolean 2d array to store the board, which contains all the cells. The cells will be represented by a boolean variable (whether they are alive, true, or dead, false). As the board is much bigger than what can be represented on the screen, we will allow the user to traverse the board with the arrow keys. Objects will also be used for the menu features (e.g. the buttons).

## 1.6 Challenges
We predicted a few challenges that we might face when creating the game. First of all, the representation of all the cells, as we could have represented them as a class with co-ordinates. However, this would have made it tricky to create the system for creating and deleting cells. So instead, we decided to use a 2d array and effectively allow a cell to be dead and also be visible to the program.
Another problem, was to render the board correctly and make a smooth transision. A solution to this is to render cells the cells around the screen, that are not totally visible to the user, this makes the traversal of the board smooth. This allows us to not render the whole board, which would make the program slow, while also making it feel as though the whole board is rendered at once.



# 2 Design
In design.docx

# 3 Evaluation
Suggest Improvements:
1) Add a larger range of structures.
2) Add a speed controller to the game, so the player can change how fast the game moves.
3) Add a "single stage" button, so the user can move forward one stage at a time.
4) Allow the user to use the forward and back keys in the textboxes for readFromFile and SaveToFile.
