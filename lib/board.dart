import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tetris/piece.dart';
import 'package:tetris/pixel.dart';
import 'package:tetris/values.dart';
// import 'package:game_board/piece.dart';
// import 'package:game_board/pixel.dart';
// import 'package:game_board/values.dart';

/*
GAME BOARD 

This is a 2x2 grid with null representing an empty space.
A non empty space will have the color to reperesent the the landed pieces

*/

// create game board
List<List<Tetromino?>> gameBoard = List.generate(
  colLength,
  (i) => List.generate(
    rowLenth,
    (j) => null,
  ),
);

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  //current tetris piece
  Piece currentPiece = Piece(type: Tetromino.L);

  // current score
  int currentScore = 0;

  // game over status
  bool gameOver = false;

  @override
  void initState() {
    super.initState();
    StartGame();
  }

  void StartGame() {
    currentPiece.initiaLizePiece();

    Duration frameRate = const Duration(milliseconds: 600);
    gameLoop(frameRate);
  }

  // gameLoop
  void gameLoop(Duration frameRate) {
    Timer.periodic(
      frameRate,
      (timer) {
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

          //move current piece down
          currentPiece.movePiece(Direction.down);
        });
      },
    );
  }

  // game over message
  void showGameOverDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Game over'),
        content: Text("You score is: $currentScore "),
        actions: [
          TextButton(
              onPressed: () {
                // reset the game
                resetGame();

                Navigator.pop((context));
              },
              child: Text('Play Again'))
        ],
      ),
    );
  }

  // reset game
  void resetGame() {
    // clear the game board
    gameBoard = gameBoard = List.generate(
      colLength,
      (i) => List.generate(
        rowLenth,
        (j) => null,
      ),
    );

    // new game\
    gameOver = false;
    currentScore = 0;

    // create new piece
    createNewPiece();

    // start game again
    StartGame();
  }

  // check for collision in a future position
  // return true -> there is a collision
  // return false -> there is no collision
  bool checkCollision(Direction direction) {
    // Loop through each  position of the current piece
    for (int i = 0; i < currentPiece.position.length; i++) {
      //calculate the row and column of the current position
      int row = (currentPiece.position[i] / rowLenth).floor();
      int col = currentPiece.position[i] % rowLenth.floor();

      // abjust the row and col based on the direction
      if (direction == Direction.left) {
        col -= 1;
      } else if (direction == Direction.right) {
        col += 1;
      } else if (direction == Direction.down) {
        row += 1;
      }
      // check if the piece is out of bounds (eighter too low or too the left or right)
      if (row >= colLength || col < 0 || col >= rowLenth) {
        return true;
      }
    }

    // if no collisions are detected, false
    return false;
  }

  void checkLanding() {
    // if going down is occupied
    if (checkCollision(Direction.down)) {
      // mark positions as occupied on the gameboard
      for (int i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / rowLenth).floor();
        int col = currentPiece.position[1] % rowLenth;
        if (row >= 0 && col > 0) {
          gameBoard[row][col] = currentPiece.type;
        }
      }
      //once landed, create the next pice
      createNewPiece();
    }
  }

  void createNewPiece() {
    Random rand = Random();
    Tetromino randomeType =
        Tetromino.values[rand.nextInt(Tetromino.values.length)];
    currentPiece = Piece(type: randomeType);
    currentPiece.initiaLizePiece();
    /*
    Since our game over condition is of there is a piece at the top leve,
    you want to check if the game is over when create a new piece,
    insteade of checking every frame, because new piece are allowed to go through the top level
    but if there is already a piece in the top level when the new piece is created,
    then game is over
    */
    if (isGameOver()) {
      gameOver = true;
    }
  }

// move left
  void moveLeft() {
    // make sure the move is valid before mopving there
    if (!checkCollision(Direction.left)) {
      setState(() {
        currentPiece.movePiece(Direction.left);
      });
    }
  }

//move right
  void moveRight() {
    // make sure the move is valid before mopving there
    if (!checkCollision(Direction.right)) {
      setState(() {
        currentPiece.movePiece(Direction.right);
      });
    }
  }

// rotate piece
  void rotatePiece() {
    setState(() {
      currentPiece.rotatePiece();
    });
  }

// clear lines
  void clearLines() {
    // step 1: Loop through each row of the game board from bottom to top
    for (int row = colLength - 1; row >= 0; row--) {
// step 2: Initialize a variable to track if the row is full
      bool rowIsFull = true;

      // step 3: Check if the row if full (all columns in the row are filled with piece)
      for (int col = 0; col < rowLenth; col++) {
        // if there's an empty column, set rowIsFull to false and break the loop
        if (gameBoard[row][col] == null) {
          rowIsFull = false;
          break;
        }
      }
      // step 4: Is the ro wis full, clear the row and shift rows down
      if (rowIsFull) {
        //step 5: mave all rows above the cleared row down by one position
        for (int r = row; r > 0; r--) {
          // copy the above row to the current row
          gameBoard[r] = List.from(gameBoard[r - 1]);
        }
        // step 6: det the top row to emoty
        gameBoard[0] = List.generate(row, (index) => null);

        // step 7: Incerease the score!
        currentScore++;
      }
    }
  }

// GAME  OVER METHOD
  bool isGameOver() {
    // check if any columns in the top row are filled
    for (int col = 0; col < rowLenth; col++) {
      if (gameBoard[0][col] != null) {
        return true;
      }
    }

    // if the top row is empty, the game is not over
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: rowLenth * colLength,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: rowLenth),
              itemBuilder: ((context, index) {
                //get row and col each index
                int row = (index / rowLenth).floor();
                int col = index % rowLenth;
                //current piece
                if (currentPiece.position.contains(index)) {
                  return Pixel(
                    color: currentPiece.color,
                  );
                }
                //landed pieces
                else if (gameBoard[row][col] != null) {
                  final Tetromino? tetrominoType = gameBoard[row][col];
                  return Pixel(color: tetrominoColors[tetrominoType]);
                } else {
                  return Pixel(
                    color: Colors.grey[900],
                  );
                }
              }),
            ),
          ),

          // SCORE
          Text(
            'Score: $currentScore',
            style: const TextStyle(color: Colors.white),
          ),

          // Game consol
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0, top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // left
                IconButton(
                    onPressed: moveLeft,
                    color: const Color(0xffffffff),
                    icon: const Icon(Icons.arrow_back_ios_new)),
                //rotate
                IconButton(
                    onPressed: rotatePiece,
                    color: const Color(0xffffffff),
                    icon: const Icon(Icons.rotate_right)),
                //right
                IconButton(
                    onPressed: moveRight,
                    color: const Color(0xffffffff),
                    icon: const Icon(Icons.arrow_forward_ios_sharp)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
