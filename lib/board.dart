import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tetris_game/pixel.dart';
import 'package:tetris_game/values.dart';

import 'piece.dart';

/* 

GAME BOARD

This is a 2x2 grid with null representing an empty space.
A non empty space will have the color to represent the landed pieces

*/

// create game board
List<List<Tetromino?>> gameBoard = List.generate(
  columnLenght,
  (i) => List.generate(
    rowLength,
    (j) => null,
  ),
);

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  // current Tetris Piece
  Piece currentPiece = Piece(type: Tetromino.L);

  // current score
  int currentScore = 0;

  // game over status
  bool gameOver = false;

  @override
  void initState() {
    super.initState();

    // start the game when app starts
    startGame();

    // frame refresh rate
    Duration frameRate = const Duration(milliseconds: 400);
    gameLoop(frameRate);
  }

  void startGame() {
    currentPiece.initializePiece();
  }

  // game loop
  void gameLoop(Duration frameRate) {
    Timer.periodic(frameRate, (timer) {
      setState(() {
        // clear lines
        clearLines();

        // check landing
        checkLanding();

        // check if game is over
        if (gameOver == true) {
          timer.cancel();
          showGameOverDialog();
        }

        // move current piece down
        currentPiece.movePiece(Direction.down);
      });
    });
  }

  // game over message
  void showGameOverDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Game Over'),
        content: Text('Your score is: $currentScore'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);

              // reset the game
              resetGame();
            },
            child: const Text('Play again'),
          ),
        ],
      ),
    );
  }

  // reset game
  void resetGame() {
    setState(() {
      // clear the game board
      gameBoard = List.generate(
        columnLenght,
        (i) => List.generate(
          rowLength,
          (j) => null,
        ),
      );

      // new game
      gameOver = false;
      currentScore = 0;

      // create the new piece
      createNewPiece();

      // start game again
      startGame();

      // restart the game loop
      Duration frameRate = const Duration(milliseconds: 400);
      gameLoop(frameRate);
    });
  }

  // check for collision in a future position
  // return true -> there is a collision
  // return false -> there is no collision
  bool checkCollision(Direction direction) {
    // loop through each position of the current piece
    for (int i = 0; i < currentPiece.position.length; i++) {
      // calculate the row and column of the current position
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = (currentPiece.position[i] % rowLength);

      // adjust the row and col based on direction
      if (direction == Direction.left) {
        col -= 1;
      } else if (direction == Direction.right) {
        col += 1;
      } else if (direction == Direction.down) {
        row += 1;
      }

      // check if the piece is out the bounds (either too low or far to the left of right)
      if (row >= columnLenght || col < 0 || col >= rowLength) {
        return true;
      }

      // check if the current postion is already occupied
      if (row >= 0 && col >= 0) {
        if (gameBoard[row][col] != null) {
          return true;
        }
      }
    }
    // if no collisions are detected, return false
    return false;
  }

  void checkLanding() {
    // if going down is occupied
    if (checkCollision(Direction.down)) {
      // mark position as occupied on gameboard
      for (int i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / rowLength).floor();
        int col = currentPiece.position[i] % rowLength;
        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currentPiece.type;
        }
      }

      // once landed create a new piece
      createNewPiece();
    }
  }

  void createNewPiece() {
    // create a random object to generate random tetroming types
    Random rand = Random();

    // create a new piece with random type
    Tetromino randomType =
        Tetromino.values[rand.nextInt(Tetromino.values.length)];
    currentPiece = Piece(type: randomType);
    currentPiece.initializePiece();

    /*

    Since our game over condition is if there is a piece at the top level,
    you want to check if the game is over when you create a new piece,
    instead of checking every frame, because new places are allowed to go through the top level
    but if there is aleready a piece in the top lever when the new piece is created,
    then the game is over

    */
    if (isGameOver()) {
      gameOver = true;
    }
  }

  // moveleft
  void moveLeft() {
    // make sure the move is valid before moving there
    if (!checkCollision(Direction.left)) {
      setState(() {
        currentPiece.movePiece(Direction.left);
      });
    }
  }

  // moveright
  void moveRight() {
    // make sure the move is valid before moving there
    if (!checkCollision(Direction.right)) {
      setState(() {
        currentPiece.movePiece(Direction.right);
      });
    }
  }

  // rotate
  void rotatePiece() {
    setState(() {
      currentPiece.rotatePiece();
    });
  }

  // clear lines
  void clearLines() {
    // step 1: Loop through each row of the game board from bottom to top
    for (int row = columnLenght - 1; row >= 0; row--) {
      // step 2: Initialize the variable to track if the row is full
      bool rowIsFull = true;

      // step 3: Check if the row is full (all columns in the row are filled with pieces)
      for (int col = 0; col < rowLength; col++) {
        // if there's an empty column, set rowIsFull to false and break the loop
        if (gameBoard[row][col] == null) {
          rowIsFull = false;
          break;
        }
      }

      // step 4: if the row is full, clear the row and shift rows down
      if (rowIsFull) {
        // step 5: move all rows above the cleared row down by position
        for (int r = row; r > 0; r--) {
          // copy the above row to the current row
          gameBoard[r] = List.from(gameBoard[r - 1]);
        }

        // step 6: set the top row to empty
        gameBoard[0] = List.generate(row, (index) => null);

        // step 7: increase the score
        currentScore++;
      }
    }
  }

  // GAME OVER
  bool isGameOver() {
    // check if any columns in the top row are filled
    for (int col = 0; col < rowLength; col++) {
      if (gameBoard[0][col] != null) {
        return true;
      }
    }

    // if the top row is empty, the game is over
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Game grid
          Expanded(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: rowLength * columnLenght,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: rowLength),
              itemBuilder: (context, index) {
                // get row and column of each index
                int row = (index / rowLength).floor();
                int col = index % rowLength;

                // current piece
                if (currentPiece.position.contains(index)) {
                  return Pixel(
                    color: Colors.yellow,
                  );
                }

                // landed pieces
                else if (gameBoard[row][col] != null) {
                  final Tetromino? tetrominoType = gameBoard[row][col];
                  return Pixel(
                    color: tetrominoColors[tetrominoType],
                  );
                }

                // blank panel
                else {
                  return Pixel(
                    color: Colors.grey[900],
                  );
                }
              },
            ),
          ),

          // SCORE
          Text(
            'Score: ' + currentScore.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),

          // GAME CONROLS
          Padding(
            padding: const EdgeInsets.only(
              bottom: 50,
              top: 50,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // left
                IconButton(
                    onPressed: moveLeft,
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    )),

                // rotate
                IconButton(
                    onPressed: rotatePiece,
                    icon: const Icon(
                      Icons.rotate_right,
                      color: Colors.white,
                    )),

                // right
                IconButton(
                  onPressed: moveRight,
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
