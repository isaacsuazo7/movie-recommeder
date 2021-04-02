import 'dart:math';

import 'package:flutter/material.dart';
import 'package:movie_recommender/src/home/models/movie.dart';
import 'package:movie_recommender/src/home/repository/repository.dart';
import 'package:translator/translator.dart';

class ModalDetail {
  final repository = Repository();
  Widget recommenderMovies(String movie) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: Text('Te recomendamos'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Text(
              'En base a: ${movie.toUpperCase()}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            FutureBuilder(
              future: repository.getMovieByName(movie),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                List<Movie> movies = snapshot.data;
                if (snapshot.hasData && movies.length > 1) {
                  return _showMoviesModal(movies);
                } else if (snapshot.hasData && movies.length < 1) {
                  return Container(child: Text('No existe'));
                } else {
                  return Center(child: CircularProgressIndicator.adaptive());
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _showMoviesModal(List<Movie> movies) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
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
