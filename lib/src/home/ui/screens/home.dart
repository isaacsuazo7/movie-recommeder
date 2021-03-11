import 'package:flutter/material.dart';
import 'package:movie_recommender/src/home/ui/widgets/genre.dart';
import 'package:movie_recommender/src/home/ui/widgets/genre_card.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Movie Recommender',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Genres(),
        ],
      ),
    );
  }
}
