import 'package:flutter/material.dart';

class GenreCard extends StatelessWidget {
  final String genre;

  const GenreCard({Key key, this.genre}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.only(left: 15, right: 15, top: 10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.purpleAccent),
          borderRadius: BorderRadius.circular(8)),
      child: Text(
        genre,
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
