import 'package:json_annotation/json_annotation.dart';

part "movie.g.dart";

@JsonSerializable()
class Movie {
  final int id;
  final String cast;
  final String genres;
  final String name;
  final String overview;

  Movie({this.id, this.cast, this.genres, this.name, this.overview});

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
  Map<String, dynamic> toJson() => _$MovieToJson(this);
}
