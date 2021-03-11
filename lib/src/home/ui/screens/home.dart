import 'package:flutter/material.dart';
import 'package:movie_recommender/src/home/search.dart';
import 'package:movie_recommender/src/home/ui/widgets/genre.dart';

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
          GestureDetector(
            onTap: () async {
              final countrySeleccionado =
                  await showSearch(context: context, delegate: Search());

              print(countrySeleccionado);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Buscar',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.search_outlined),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Genres(),
        ],
      ),
    );
  }
}
