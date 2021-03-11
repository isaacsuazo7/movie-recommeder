import 'package:flutter/material.dart';
import 'package:movie_recommender/src/home/ui/widgets/genre_card.dart';

class Genres extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> genres = ["Action", "Crime", "Comedy", "Horror", "Animation"];

    return Container(
      margin: EdgeInsets.only(left: 10, bottom: 10, right: 10, top: 10),
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: genres.length,
        itemBuilder: (context, i) => GenreCard(
          genre: genres[i],
        ),
      ),
    );
  }
}
