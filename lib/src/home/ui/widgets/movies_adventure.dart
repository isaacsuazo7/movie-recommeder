import 'dart:math';

import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:movie_recommender/src/home/models/movie.dart';
import 'package:movie_recommender/src/home/repository/repository.dart';
import 'package:movie_recommender/src/home/ui/widgets/modal_detail.dart';

class MoviesAdventure extends StatefulWidget {
  @override
  _MoviesAdventureState createState() => _MoviesAdventureState();
}

class _MoviesAdventureState extends State<MoviesAdventure> {
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
          onTap: () {
            showCupertinoModalBottomSheet(
              topRadius: Radius.circular(10),
              barrierColor: Colors.purple,
              context: context,
              builder: (context) => modalDetail.recommenderMovies(movie.name),
            );
            print(movie.name);
          },
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
    List adventure = [
      'Pirates of the Caribbean: At World',
      'Spider-Man 3',
      'Harry Potter and the Half-Blood Prince',
      'Quantum of Solace',
      'Robin Hood',
      'King Kong',
      'Prince of Persia: The Sands of Time',
      'Indiana Jones and the Kingdom of the Crystal Skull',
      'Interstellar',
      'The Chronicles of Narnia: The Voyage of the Dawn Treader',
      'Back to the Future Part II'
    ];
    final _random = new Random();

// generate a random index based on the list length
// and use it to retrieve the element
    String movie = adventure[_random.nextInt(adventure.length)];
    print(movie);
    return movie;
  }
}
