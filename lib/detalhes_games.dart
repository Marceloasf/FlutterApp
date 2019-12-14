import 'package:flutter/material.dart';
import 'package:flutter_app/game_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class DetalhesGames extends StatefulWidget {
  final String title;
  final int id;

  const DetalhesGames({Key key, this.title, this.id}) : super(key: key);

  @override
  _DetalhesGamesState createState() => _DetalhesGamesState();
}

class _DetalhesGamesState extends State<DetalhesGames> {
  GameModel _game = GameModel();

  @override
  void initState() {
    super.initState();

    _carregarInfoGame();
  }

  Future<GameModel> _carregarInfoGame() async {
    final response =
        await http.get('https://api.rawg.io/api/games/${widget.id}');
    _game = GameModel.fromJson(convert.jsonDecode(response.body));

    return _game;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.lightBlue,
        title: Center(
          child: Text(
            this.widget.title,
            style: TextStyle(
              fontSize: 22.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: _carregarInfoGame(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Column(
            children: <Widget>[
              Container(
                width: width * 1.0,
                height: height * 0.7,
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      _game.backgroundImage,
                    ),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Release data: ',
                            style: TextStyle(
                              fontSize: 28.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            _game.released,
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 10.0,
                  bottom: 10.0,
                ),
                child: Text(
                  'Game description',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Flexible(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      _game.description,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
