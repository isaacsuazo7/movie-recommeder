import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_recommender/src/home/models/movie.dart';
import 'package:movie_recommender/src/home/repository/repository.dart';
import 'package:translator/translator.dart';

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear_rounded), onPressed: () => this.query = '')
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => this.close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.trim().length == 0) {
      return Text('No hay valor en el query');
    }
    final repository = Repository();

    return FutureBuilder(
      future: repository.getMovieByName(query),
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
    );

    // return FutureBuilder(
    //   future: repository.getCountryByName(query),
    //   builder: (BuildContext context, AsyncSnapshot snapshot) {
    //     if (snapshot.hasData) {
    //       return _showCountries(snapshot.data);
    //     } else {
    //       return Center(child: CircularProgressIndicator());
    //     }
    //   },
    // );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListTile(
      title: Text('Sugerencias'),
    );
  }

  Widget _showMovies(List<Movie> movies) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        Movie movie = movies[index];
        return Column(
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
              subtitle: FutureBuilder(
                future: _getOverviewTranslate(movie.overview),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      snapshot.data,
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600),
                    );
                  }
                  return Text('Description');
                },
              ),
            ),
            Divider()
          ],
        );
      },
    );
  }

  Future _getOverviewTranslate(String overview) async {
    final translator = GoogleTranslator();
    var translation =
        await translator.translate(overview, from: 'en', to: 'es');
    return translation.text;
  }
}
