import 'dart:math';

import 'package:flutter/material.dart';
import 'package:movie_recommender/src/home/models/movie.dart';
import 'package:movie_recommender/src/home/repository/repository.dart';
import 'package:movie_recommender/src/home/ui/widgets/modal_detail.dart';

class MoviesHorror extends StatefulWidget {
  @override
  _MoviesHorrorState createState() => _MoviesHorrorState();
}

class _MoviesHorrorState extends State<MoviesHorror> {
  final repository = Repository();
  final modalDetail = ModalDetail();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              'Te recomendaremos de acuerdo a tus gustos, selecciona una',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.purple),
            ),
            SizedBox(
              height: 10,
            ),
            FutureBuilder(
              future: repository.getMovieByName(_movieRandom()),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                List<Movie> movies = snapshot.data;
                if (snapshot.hasData && movies.length > 1) {
                  return _showMovies(movies);
                } else if (snapshot.hasData && movies.length < 1) {
                  return Container(child: Text('No existe'));
                } else {
                  return Center(child: CircularProgressIndicator.adaptive());
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _showMovies(List<Movie> movies) {
    return ListView.builder(
      itemCount: movies.length,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        Movie movie = movies[index];
        return GestureDetector(
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor:
                      Color((Random().nextDouble() * 0xFFFFFF).toInt())
                          .withOpacity(1.0),
                  child: Text(
                    movie.name.substring(0, 1).toUpperCase(),
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                title: Text(
                  movie.name.toUpperCase(),
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Divider()
            ],
          ),
        );
      },
    );
  }

  String _movieRandom() {
    List horror = [
      'Creepshow',
      'The Haunting',
      'Exorcist: The Beginning',
      'Dracula Untold',
      'I, Frankenstein',
      'The Relic',
      'Supernova',
      'Silent Hill',
      'Resident Evil: Apocalypse',
      'The Tooth Fairy'
    ];
    final _random = new Random();

    String movie = horror[_random.nextInt(horror.length)];
    print(movie);
    return movie;
  }
}
