import 'package:flutter/material.dart';
import 'package:tetris_game/board.dart';
import 'package:tetris_game/values.dart';

class Piece {
  // type of tetris piece
  Tetromino type;

  Piece({required this.type});

  // the piece is just the list of integers
  List<int> position = [];

  // color of tetris piece
  Color get color {
    return tetrominoColors[type] ??
        const Color(0xFFFFFFFF); // default to white if no color is found
  }

  // generate the integers
  void initializePiece() {
    switch (type) {
      case Tetromino.L:
        position = [
          -26,
          -16,
          -6,
          -5,
        ];
        break;
      case Tetromino.J:
        position = [
          -25,
          -15,
          -5,
          -6,
        ];
        break;
      case Tetromino.I:
        position = [
          -4,
          -5,
          -6,
          -7,
        ];
        break;
      case Tetromino.O:
        position = [
          -15,
          -16,
          -5,
          -6,
        ];
        break;
      case Tetromino.S:
        position = [
          -15,
          -14,
          -6,
          -5,
        ];
        break;
      case Tetromino.Z:
        position = [
          -17,
          -16,
          -6,
          -5,
        ];
        break;
      case Tetromino.T:
        position = [
          -26,
          -16,
          -6,
          -15,
        ];
        break;
      default:
    }
  }

  // move piece
  void movePiece(Direction direction) {
    switch (direction) {
      case Direction.down:
        for (int i = 0; i < position.length; i++) {
          position[i] += rowLength;
        }
        break;
      case Direction.left:
        for (int i = 0; i < position.length; i++) {
          position[i] -= 1;
        }
        break;
      case Direction.right:
        for (int i = 0; i < position.length; i++) {
          position[i] += 1;
        }
        break;
      default:
    }
  }

  // rotate piece
  int rotationState = 1;

  // rotate piece
  void rotatePiece() {
    // new postion
    List<int> newPosition = [];

    // rotate the place based on it's type
    switch (type) {
      case Tetromino.L:
        switch (rotationState) {
          case 0:

            // get the new position
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength + 1,
            ];

            // check that the new position is valid before assigning it to real position
            if (piecePositionValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }

            break;
          case 1:

            // get the new position
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
            ];

            // check that the new position is valid before assigning it to real position
            if (piecePositionValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }

            break;
          case 2:

            // get the new position
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength - 1,
            ];

            // check that the new position is valid before assigning it to real position
            if (piecePositionValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }

            break;
          case 3:

            // get the new position
            newPosition = [
              position[1] - rowLength + 1,
              position[1],
              position[1] + 1,
              position[1] - 1,
            ];

            // check that the new position is valid before assigning it to real position
            if (piecePositionValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }

            break;
        }
      case Tetromino.J:
        switch (rotationState) {
          case 0:

            // get the new position
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength - 1,
            ];

            // check that the new position is valid before assigning it to real position
            if (piecePositionValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }

            break;
          case 1:

            // get the new position
            newPosition = [
              position[1] - rowLength - 1,
              position[1],
              position[1] - 1,
              position[1] + 1,
            ];

            // check that the new position is valid before assigning it to real position
            if (piecePositionValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = 0;
            }

            break;
          case 2:

            // get the new position
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength + 1,
            ];

            // check that the new position is valid before assigning it to real position
            if (piecePositionValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }

            break;
          case 3:

            // get the new position
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] + rowLength + 1,
            ];

            // check that the new position is valid before assigning it to real position
            if (piecePositionValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }

            break;
        }
        break;
      case Tetromino.I:
        switch (rotationState) {
          case 0:

            // get the new position
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + 2,
            ];

            // check that the new position is valid before assigning it to real position
            if (piecePositionValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }

            break;
          case 1:

            // get the new position
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + 2 * rowLength,
            ];

            // check that the new position is valid before assigning it to real position
            if (piecePositionValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }

            break;
          case 2:

            // get the new position
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] - 2,
            ];

            // check that the new position is valid before assigning it to real position
            if (piecePositionValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }

            break;
          case 3:

            // get the new position
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - 2 * rowLength,
            ];

            // check that the new position is valid before assigning it to real position
            if (piecePositionValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = 0;
            }

            break;
        }
      case Tetromino.O:
        break;
      case Tetromino.S:
        switch (rotationState) {
          case 0:

            // get the new position
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
              position[1] + rowLength,
            ];

            // check that the new position is valid before assigning it to real position
            if (piecePositionValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }

            break;
          case 1:

            // get the new position
            newPosition = [
              position[0] - rowLength,
              position[0],
              position[0] + 1,
              position[0] + rowLength + 1,
            ];

            // check that the new position is valid before assigning it to real position
            if (piecePositionValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }

            break;
          case 2:

            // get the new position
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength - 1,
            ];

            // check that the new position is valid before assigning it to real position
            if (piecePositionValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }

            break;
          case 3:

            // get the new position
            newPosition = [
              position[0] - rowLength,
              position[0],
              position[0] + 1,
              position[0] + rowLength + 1,
            ];

            // check that the new position is valid before assigning it to real position
            if (piecePositionValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }

            break;
        }
      case Tetromino.Z:
        switch (rotationState) {
          case 0:

            // get the new position
            newPosition = [
              position[0] + rowLength - 2,
              position[1],
              position[2] + rowLength - 1,
              position[3] + 1,
            ];

            // check that the new position is valid before assigning it to real position
            if (piecePositionValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }

            break;
          case 1:

            // get the new position
            newPosition = [
              position[0] - rowLength + 2,
              position[1],
              position[2] - rowLength + 1,
              position[3] - 1,
            ];

            // check that the new position is valid before assigning it to real position
            if (piecePositionValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }

            break;
          case 2:

            // get the new position
            newPosition = [
              position[0] + rowLength - 2,
              position[1],
              position[2] + rowLength - 1,
              position[3] + 1,
            ];

            // check that the new position is valid before assigning it to real position
            if (piecePositionValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }

            break;
          case 3:

            // get the new position
            newPosition = [
              position[0] - rowLength + 2,
              position[1],
              position[2] - rowLength + 1,
              position[3] - 1,
            ];

            // check that the new position is valid before assigning it to real position
            if (piecePositionValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }

            break;
        }

      case Tetromino.T:
        switch (rotationState) {
          case 0:

            // get the new position
            newPosition = [
              position[2] - rowLength,
              position[2],
              position[2] + 1,
              position[2] + rowLength,
            ];

            // check that the new position is valid before assigning it to real position
            if (piecePositionValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }

            break;
          case 1:

            // get the new position
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength,
            ];

            // check that the new position is valid before assigning it to real position
            if (piecePositionValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }

            break;
          case 2:

            // get the new position
            newPosition = [
              position[1] - rowLength,
              position[1] - 1,
              position[1],
              position[1] + rowLength,
            ];

            // check that the new position is valid before assigning it to real position
            if (piecePositionValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }

            break;
          case 3:

            // get the new position
            newPosition = [
              position[2] - rowLength,
              position[2] - 1,
              position[2],
              position[2] + 1,
            ];

            // check that the new position is valid before assigning it to real position
            if (piecePositionValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = 0;
            }

            break;
        }
      default:
    }
  }

  // check if the position is valid
  bool positionIsValid(int position) {
    // get the row and col of position
    int row = (position / rowLength).floor();
    int col = position % rowLength;

    // if the position is taken, return false
    if (row < 0 || col < 0 || gameBoard[row][col] != null) {
      return false;
    }

    // otherwise position is valid return true
    else {
      return true;
    }
  }

  // check if piece is valid position
  bool piecePositionValid(List<int> piecePosition) {
    bool firstColOccupied = false;
    bool lastColOccupied = false;

    for (int pos in piecePosition) {
      // return false if any position is already taken
      if (!positionIsValid(pos)) {
        return false;
      }

      // get the col of the position
      int col = pos % rowLength;

      // check if the first or last column is occupied
      if (col == 0) {
        firstColOccupied = true;
      }

      if (col == rowLength - 1) {
        lastColOccupied = true;
      }
    }

    // if there is a piece in the first col and last col, it is going through the wall
    return !(firstColOccupied && lastColOccupied);
  }
}
