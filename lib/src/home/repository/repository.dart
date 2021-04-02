import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:movie_recommender/src/home/models/movie.dart';

class Repository {
  Future<List<Movie>> getMovieByName(String name) async {
    try {
      String url = "https://movie-recommender-api-is.herokuapp.com/movie/$name";

      final http.Response resp = await http.get(url);

      List<Movie> moviesList = [];

      if (resp.statusCode != 200) {
        throw Exception('Error');
      } else {
        var movies = jsonDecode(resp.body) as List;
        movies.forEach((element) {
          moviesList.add(Movie.fromJson(element));
        });
      }

      return moviesList;

      // final List<dynamic> movieList = resp.data;
      // return movieList.map((e) => Movie.fromJson(e)).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<Movie>> getMovies() async {
    try {
      String url = "https://movie-recommender-api-is.herokuapp.com/all";

      final http.Response resp = await http.get(url);

      List<Movie> moviesList = [];

      if (resp.statusCode != 200) {
        throw Exception('Error');
      } else {
        var movies = jsonDecode(resp.body) as List;
        movies.forEach((element) {
          if (element['overview'] != null) {
            moviesList.add(Movie.fromJson(element));
          }
        });
      }

      return moviesList;

      // final List<dynamic> movieList = resp.data;
      // return movieList.map((e) => Movie.fromJson(e)).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }
}
