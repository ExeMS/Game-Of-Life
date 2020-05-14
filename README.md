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

# Design
In design.docx

# Evaluation
Suggest Improvements:
1) Add a larger range of structures.
2) Add a speed controller to the game, so the player can change how fast the game moves.
3) Add a "single stage" button, so the user can move forward one stage at a time.
4) Allow the user to use the forward and back keys in the textboxes for readFromFile and SaveToFile.
