import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool isXsTurn;
  late List<String> displayXorO;
  late final TextStyle textStyle;
  late int scoreO;
  late int scoreX;
  late int filledBoxes;

  final fontStyleBlack = GoogleFonts.pressStart2p(
      textStyle: const TextStyle(color: Colors.black, letterSpacing: 3));

  final fontStyleWhite = GoogleFonts.pressStart2p(
      textStyle: const TextStyle(color: Colors.white, letterSpacing: 3));

  @override
  void initState() {
    isXsTurn = false;
    displayXorO = List.filled(9, '');
    textStyle = const TextStyle(color: Colors.white, fontSize: 30);
    scoreO = 0;
    scoreX = 0;
    filledBoxes = 0;
    _resetGame();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        foregroundColor: Colors.white,
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                scoreO = 0;
                scoreX = 0;
                _resetGame();
              });
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.restore,
                size: 30,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      backgroundColor: Colors.blueGrey[800],
      body: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Player X',
                          style: fontStyleWhite.copyWith(fontSize: 13)),
                      const SizedBox(height: 20),
                      Text('$scoreX',
                          style: fontStyleWhite.copyWith(fontSize: 15)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Player O',
                          style: fontStyleWhite.copyWith(fontSize: 13)),
                      const SizedBox(height: 20),
                      Text('$scoreO',
                          style: fontStyleWhite.copyWith(fontSize: 15)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _tapped(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueGrey.shade700),
                    ),
                    child: Center(
                      child: Text(
                        displayXorO[index],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                children: [
                  Text('TIC TAC TOE', style: fontStyleWhite),
                  const SizedBox(height: 20),
                  Text(
                    '© Binoy Barman',
                    style: fontStyleWhite,
                    textScaler: const TextScaler.linear(0.8),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (isXsTurn && displayXorO[index] == '') {
        displayXorO[index] = 'X';
        filledBoxes++;
      } else if (displayXorO[index] == '') {
        displayXorO[index] = 'O';
        filledBoxes++;
      } else {
        return;
      }
      isXsTurn ^= true;
      _checkWinner();
    });
  }

  void _checkWinner() {
    if (displayXorO[0] == displayXorO[1] &&
        displayXorO[0] == displayXorO[2] &&
        displayXorO[0] != '') {
      _showWinDialog(displayXorO[0]);
    } else if (displayXorO[3] == displayXorO[4] &&
        displayXorO[3] == displayXorO[5] &&
        displayXorO[3] != '') {
      _showWinDialog(displayXorO[3]);
    } else if (displayXorO[6] == displayXorO[7] &&
        displayXorO[6] == displayXorO[8] &&
        displayXorO[6] != '') {
      _showWinDialog(displayXorO[6]);
    } else if (displayXorO[0] == displayXorO[3] &&
        displayXorO[0] == displayXorO[6] &&
        displayXorO[0] != '') {
      _showWinDialog(displayXorO[0]);
    } else if (displayXorO[1] == displayXorO[4] &&
        displayXorO[1] == displayXorO[7] &&
        displayXorO[1] != '') {
      _showWinDialog(displayXorO[1]);
    } else if (displayXorO[2] == displayXorO[5] &&
        displayXorO[2] == displayXorO[8] &&
        displayXorO[2] != '') {
      _showWinDialog(displayXorO[2]);
    } else if (displayXorO[0] == displayXorO[4] &&
        displayXorO[0] == displayXorO[8] &&
        displayXorO[0] != '') {
      _showWinDialog(displayXorO[0]);
    } else if (displayXorO[2] == displayXorO[4] &&
        displayXorO[2] == displayXorO[6] &&
        displayXorO[2] != '') {
      _showWinDialog(displayXorO[2]);
    } else if (filledBoxes == 9) {
      _showDrawDialog();
    }
  }

  void _showWinDialog(String winner) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('WINNER IS: $winner'),
          actions: [
            TextButton(
              onPressed: () {
                _resetGame();
                Navigator.of(context).pop();
              },
              child: const Text('Play Again!'),
            ),
          ],
        );
      },
    );
    winner == 'O' ? scoreO++ : scoreX++;
  }

  void _showDrawDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("IT'S A TIE"),
          actions: [
            TextButton(
              onPressed: () {
                _resetGame();
                Navigator.of(context).pop();
              },
              child: const Text('Play Again!'),
            ),
          ],
        );
      },
    );
  }

  void _resetGame() {
    setState(() {
      filledBoxes = 0;
      for (int i = 0; i < 9; i++) {
        displayXorO[i] = '';
      }
    });
  }
}
