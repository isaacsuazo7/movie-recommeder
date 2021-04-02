// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) {
  return Movie(
    id: json['id'] as int,
    cast: json['cast'] as String,
    genres: json['genres'] as String,
    name: json['name'] as String,
    overview: json['overview'] as String,
  );
}

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'id': instance.id,
      'cast': instance.cast,
      'genres': instance.genres,
      'name': instance.name,
      'overview': instance.overview,
    };
