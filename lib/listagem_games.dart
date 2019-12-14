import 'package:flutter/material.dart';
import 'package:flutter_app/detalhes_games.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ListagemGames extends StatefulWidget {
  @override
  _ListagemGamesState createState() => _ListagemGamesState();
}

class _ListagemGamesState extends State<ListagemGames> {
  List<dynamic> _listaGames = List();
  String _nextPage;
  String _previousPage;

  @override
  void initState() {
    super.initState();

    _carregarListaGames();
  }

  Future<List<dynamic>> _getListaGames() async {
    return _listaGames;
  }

  void _previous() {
    if (_previousPage == null) {
      return;
    }
  }

  void _next() {
    if (_nextPage == null) {
      return;
    }
  }

  void _makeRequest(String url) async {
    _listaGames.clear();

    final response = await http.get(url);
    final json = convert.jsonDecode(response.body);

    setState(() {
      _nextPage = json['next'];
      _previousPage = json['previous'];
      _listaGames = json['results'];
    });
  }

  void _carregarListaGames() async {
    _makeRequest('https://api.rawg.io/api/games?page_size=30');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text(
          "Curso de Flutter",
          style: TextStyle(
              fontSize: 22.0, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                  ),
                  onPressed: () => _previous,
                ),
              ),
              Container(
                child: Text(
                  'NAVEGAÇÃO',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20.0,
                  ),
                ),
              ),
              Container(
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_forward,
                  ),
                  onPressed: () => _next,
                ),
              ),
            ],
          ),
          FutureBuilder(
            future: _getListaGames(),
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

              return Flexible(
                child: ListView.builder(
                  itemCount: _listaGames.length,
                  itemBuilder: (BuildContext context, int index) {
                    final objeto = _listaGames[index];

                    return Column(
                      children: <Widget>[
                        ListTile(
                          title: Row(
                            children: <Widget>[
                              Text(
                                "Game: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 23.0),
                              ),
                              Text(
                                _listaGames[index]['name'],
                                style: TextStyle(fontSize: 23.0),
                              ),
                            ],
                          ),
                          subtitle: Row(
                            children: <Widget>[
                              Text(
                                "Score: ",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.blue,
                                ),
                              ),
                              Text(
                                _listaGames[index]['rating'].toString(),
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetalhesGames(
                                  id: objeto['id'],
                                  title: objeto['name'],
                                ),
                              )),
                        ),
                      ],
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
