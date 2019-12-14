import 'package:flutter/material.dart';
import 'package:flutter_app/listagem_games.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.green,
      ),
      home: ListagemGames(),
    );
  }
}