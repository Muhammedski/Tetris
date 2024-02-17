import 'package:flutter/material.dart';
import 'package:tetris/board.dart';
import 'package:tetris/values.dart';

class Piece {
//type of tetris piece
  Tetromino type;

  Piece({required this.type});

// the piece is just a list of integers
  List<int> position = [];

// color of tetris piece
  Color get color {
    return tetrominoColors[type] ?? Colors.white;
  }

// generate the integers
  void initiaLizePiece() {
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

  void movePiece(Direction direction) {
    switch (direction) {
      case Direction.down:
        for (int i = 0; i < position.length; i++) {
          position[i] += rowLenth;
        }
        break;
      case Direction.left:
        for (int i = 0; i < position.length; i++) {
          position[i] -= rowLenth;
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

// rotato piece
  int rotationState = 1;

  void rotatePiece() {
    // new position
    List<int> newPosition = [];
    // rotato thr piece based on it's type
    switch (type) {
      case Tetromino.L:
        switch (rotationState) {
          case 0:
            /*

          o
          o
          o o
             
                
          */
            // get the new position
            newPosition = [
              position[1] - rowLenth,
              position[1],
              position[1] + rowLenth,
              position[1] + rowLenth * 1,
            ];
            // check that this new position is a valid moveee beofore ass
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            /*

          o o o
          o
          


          */
            // get the new position
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLenth - 1,
            ];
            // check that this new position is a valid moveee beofore ass
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            /*

          o o 
            o
            o
          


          */
            // get the new position
            newPosition = [
              position[1] + rowLenth,
              position[1],
              position[1] - rowLenth,
              position[1] - rowLenth - 1,
            ];
            // check that this new position is a valid moveee beofore ass
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            /*
              o
          o o o 
          */
            // get the new position
            newPosition = [
              position[1] - rowLenth + 1,
              position[1],
              position[1] + 1,
              position[1] - 1,
            ];
            // check that this new position is a valid moveee beofore ass
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;
      case Tetromino.J:
        switch (rotationState) {
          case 0:
            /*

          o
          o
          o o
             
                
          */
            // get the new position
            newPosition = [
              position[1] - rowLenth,
              position[1],
              position[1] + rowLenth,
              position[1] + rowLenth * 1,
            ];
            // check that this new position is a valid moveee beofore ass
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            /*

          o o o
          o
          


          */
            // get the new position
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLenth - 1,
            ];
            // check that this new position is a valid moveee beofore ass
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            /*

          o o 
            o
            o
          


          */
            // get the new position
            newPosition = [
              position[1] + rowLenth,
              position[1],
              position[1] - rowLenth,
              position[1] - rowLenth - 1,
            ];
            // check that this new position is a valid moveee beofore ass
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            /*
              o
          o o o 
          */
            // get the new position
            newPosition = [
              position[1] - rowLenth + 1,
              position[1],
              position[1] + 1,
              position[1] - 1,
            ];
            // check that this new position is a valid moveee beofore ass
            if (piecePositionIsValid(newPosition)) {
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
            /*

          o
          o
          o 
          o   
                
          */
            // get the new position
            newPosition = [
              position[1] - rowLenth,
              position[1],
              position[1] + rowLenth,
              position[1] + rowLenth * 1,
            ];
            // check that this new position is a valid moveee beofore ass
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            /*

         o o o o
          
          


          */
            // get the new position
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLenth - 1,
            ];
            // check that this new position is a valid moveee beofore ass
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            /*

            o 
            o
            o
            o


          */
            // get the new position
            newPosition = [
              position[1] + rowLenth,
              position[1],
              position[1] - rowLenth,
              position[1] - rowLenth - 1,
            ];
            // check that this new position is a valid moveee beofore ass
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            /*
              o o o o             
          */
            // get the new position
            newPosition = [
              position[1] - rowLenth + 1,
              position[1],
              position[1] + 1,
              position[1] - 1,
            ];
            // check that this new position is a valid moveee beofore ass
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;

      case Tetromino.O:
        /*
              The O teromino does not be rotated

              o o
              o o

              */
        break;

      case Tetromino.S:
        switch (rotationState) {
          case 0:
            /*
                 
            o o
          o o 
                
          */
            // get the new position
            newPosition = [
              position[1] - rowLenth,
              position[1],
              position[1] + rowLenth,
              position[1] + rowLenth * 1,
            ];
            // check that this new position is a valid moveee beofore ass
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            /*
             
          o
          o o
            o
          */
            // get the new position
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLenth - 1,
            ];
            // check that this new position is a valid moveee beofore ass
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            /*
               
               o o
             o o
          */
            // get the new position
            newPosition = [
              position[1] + rowLenth,
              position[1],
              position[1] - rowLenth,
              position[1] - rowLenth - 1,
            ];
            // check that this new position is a valid moveee beofore ass
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            /*
              
              o
              o o
                o
          */
            // get the new position
            newPosition = [
              position[1] - rowLenth + 1,
              position[1],
              position[1] + 1,
              position[1] - 1,
            ];
            // check that this new position is a valid moveee beofore ass
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;

      case Tetromino.Z:
        switch (rotationState) {
          case 0:
            /*

          o o
            o o
          
         
                
          */
            // get the new position
            newPosition = [
              position[1] - rowLenth,
              position[1],
              position[1] + rowLenth,
              position[1] + rowLenth * 1,
            ];
            // check that this new position is a valid moveee beofore ass
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            /*

               o
             o o
             o
          */
            // get the new position
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLenth - 1,
            ];
            // check that this new position is a valid moveee beofore ass
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            /*

             o o
               o o


          */
            // get the new position
            newPosition = [
              position[1] + rowLenth,
              position[1],
              position[1] - rowLenth,
              position[1] - rowLenth - 1,
            ];
            // check that this new position is a valid moveee beofore ass
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            /*
                o 
              o o
              o 
          */
            // get the new position
            newPosition = [
              position[1] - rowLenth + 1,
              position[1],
              position[1] + 1,
              position[1] - 1,
            ];
            // check that this new position is a valid moveee beofore ass
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;

      case Tetromino.T:
        switch (rotationState) {
          case 0:
            /*

          o
          o o
          o
                
          */
            // get the new position
            newPosition = [
              position[1] - rowLenth,
              position[1],
              position[1] + rowLenth,
              position[1] + rowLenth * 1,
            ];
            // check that this new position is a valid moveee beofore ass
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            /*

         o o o 
           o
          
          


          */
            // get the new position
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLenth - 1,
            ];
            // check that this new position is a valid moveee beofore ass
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            /*

            o 
          o o
            o


          */
            // get the new position
            newPosition = [
              position[1] + rowLenth,
              position[1],
              position[1] - rowLenth,
              position[1] - rowLenth - 1,
            ];
            // check that this new position is a valid moveee beofore ass
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            /*
              o 
            o o o
          */
            // get the new position
            newPosition = [
              position[1] - rowLenth + 1,
              position[1],
              position[1] + 1,
              position[1] - 1,
            ];
            // check that this new position is a valid moveee beofore ass
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              // update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;

      default:
    }
  }

  // check  if valid position
  bool positionIsValid(int position) {
    // get the row and col of position
    int row = (position / rowLenth).floor();
    int col = position % rowLenth;
    // if the position is taken, return false
    if (row < 0 || col < 0 || gameBoard[row][col] != null) {
      return false;
    }
    // otherwise position is valid so return true
    else {
      return true;
    }
  }

  // check if piece is valid position
  bool piecePositionIsValid(List<int> piecePosition) {
    bool firstCol0ccupied = false;
    bool lastCol0ccupied = false;

    for (int pos in piecePosition) {
      // return false if any positions is \alrealdy taken
      if (!positionIsValid(pos)) {
        return false;
      }
      // get the col position
      int col = pos % rowLenth;

      //check if The first or last col is occupied
      if (col == 0) {
        firstCol0ccupied = true;
      }
      if (col == rowLenth - 1) {
        lastCol0ccupied = true;
      }
    }
    // if therer is a piece in the first col and last col, it is going through we wall
    return !(firstCol0ccupied && lastCol0ccupied);
  }
}
