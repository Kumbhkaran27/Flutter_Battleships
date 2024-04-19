import 'package:battleships/model/gameData.dart';
import 'package:battleships/utils/http_service.dart';
import 'package:battleships/views/gameList.dart';
import 'package:flutter/material.dart';

class GameViewPage extends StatefulWidget {
  final int gameId;

  GameViewPage({required this.gameId});

  @override
  _GameViewPageState createState() => _GameViewPageState();
}

class _GameViewPageState extends State<GameViewPage> {
  GameData? gameData;
  HttpService httpService = HttpService();
  List<String> selectedPositions = [];

  @override
  void initState() {
    super.initState();
    fetchGameData();
  }

  void checkGameOver() {
    if (gameData!.ships.length == 0 || gameData!.sunk.length == 5) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Game Over'),
            content: Text(
                'All ships of ${gameData!.ships.length == 0 ? gameData!.player1 : gameData!.player2} are sunk!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog first
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => GameListPage()),
                  );
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void fetchGameData() async {
    print("in fetch game data");
    Map<String, dynamic> fetchedData =
        await httpService.fetchGameDataFromApi(widget.gameId);
    setState(() {
      gameData = GameData.fromJson(fetchedData);
      checkGameOver();
    });
  }

  void playShot(String position) {
    setState(() {
      selectedPositions.add(position);
    });
  }

  void submitShots() async {
    List<bool> response =
        await httpService.playShot(widget.gameId, selectedPositions);

    // Update the gameData based on the response
    setState(() {
      if (response[0] == true) {
        gameData!.sunk.add(selectedPositions[selectedPositions.length - 1]);
        fetchGameData();
      } else {
        gameData!.shots.add(selectedPositions[selectedPositions.length - 1]);
        fetchGameData();
      }
      checkGameOver();

      selectedPositions.clear(); // Clear the selected positions
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Game ${widget.gameId}')),
      body: gameData == null ? CircularProgressIndicator() : buildGameGrid(),
      floatingActionButton: selectedPositions.isEmpty
          ? null
          : FloatingActionButton(
              onPressed: submitShots,
              child: Icon(Icons.check),
            ),
    );
  }

  Widget getGridIcon(String position) {
    List<Widget> icons = [];

    if (gameData!.sunk.contains(position)) {
      icons.add(Icon(Icons.block, color: Colors.red)); // Red block for sunk
    }

    if (gameData!.ships.contains(position)) {
      icons.add(
          Icon(Icons.directions_boat, color: Colors.green)); // Green boat for ships
    }

    if (gameData!.shots.contains(position)) {
      icons.add(Icon(Icons.clear, color: Colors.black)); // Black cross for shots
    }

    if (gameData!.wrecks.contains(position)) {
      icons.add(Icon(Icons.warning, color: Colors.orange)); // Orange warning for wrecks
    }

    if (icons.isEmpty) {
      return SizedBox();
    }

    if (icons.length == 1) {
      return icons.first;
    }

    return icons.isEmpty
        ? SizedBox()
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: icons,
          );
  }

  Widget buildGameGrid() {
    return Container(
      width: 700,
      height: 700,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          childAspectRatio: 1, // Ensures square cells
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemCount: 25, // 5x5 grid
        itemBuilder: (context, index) {
          String position = getPositionFromIndex(index);
          bool isSelected = selectedPositions.contains(position);
          return GestureDetector(
            onTap: isSelected ? null : () => playShot(position),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                // color: getCellColor(position),
              ),
              child: Center(child: getGridIcon(position)),
            ),
          );
        },
      ),
    );
  }

  String getPositionFromIndex(int index) {
    int row = index ~/ 5; // Integer division to get row index
    int col = index % 5; // Remainder to get column index
    String rowLabel =
        String.fromCharCode('A'.codeUnitAt(0) + row); // Converts 0-4 to A-E
    String colLabel = (col + 1).toString(); // Converts 0-4 to 1-5
    return '$rowLabel$colLabel';
  }
}
