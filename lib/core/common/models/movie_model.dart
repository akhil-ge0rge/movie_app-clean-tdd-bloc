import 'dart:convert';

import 'package:movie_app/core/common/entities/movie.dart';

class MovieModel extends Movie {
  const MovieModel({
    required super.id,
    required super.backdropPath,
    required super.posterPath,
    required super.title,
    required super.adult,
  });

  MovieModel copyWith({
    int? id,
    String? backdropPath,
    String? posterPath,
    String? title,
    bool? adult,
  }) {
    return MovieModel(
      id: id ?? this.id,
      backdropPath: backdropPath ?? this.backdropPath,
      posterPath: posterPath ?? this.posterPath,
      title: title ?? this.title,
      adult: adult ?? this.adult,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'backdrop_path': backdropPath,
      'poster_path': posterPath,
      'title': title,
      'adult': adult,
    };
  }

  factory MovieModel.fromMap(Map<String, dynamic> map) {
    return MovieModel(
      id: map['id'] ?? 0,
      backdropPath: map['backdrop_path'] ?? '',
      posterPath: map['poster_path'] ?? '',
      title: map['title'] ?? '',
      adult: map['adult'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory MovieModel.fromJson(String source) =>
      MovieModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
