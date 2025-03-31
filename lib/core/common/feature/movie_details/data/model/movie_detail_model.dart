import 'dart:convert';

import 'package:movie_app/core/common/feature/movie_details/data/model/movie_genres_model.dart';
import 'package:movie_app/core/common/feature/movie_details/domain/entities/movie_detail.dart';

class MovieDetailModel extends MovieDetail {
  const MovieDetailModel({
    required super.id,
    required super.originalTitle,
    required super.adult,
    required super.backdropPath,
    required super.genres,
    required super.overview,
    required super.posterPath,
    required super.releaseDate,
  });

  MovieDetailModel copyWith({
    int? id,
    String? originalTitle,
    bool? adult,
    String? backdropPath,
    List<MovieGenresModel>? genres,
    String? overview,
    String? posterPath,
    String? releaseDate,
  }) {
    return MovieDetailModel(
      id: id ?? this.id,
      originalTitle: originalTitle ?? this.originalTitle,
      adult: adult ?? this.adult,
      backdropPath: backdropPath ?? this.backdropPath,
      genres: genres ?? this.genres,
      overview: overview ?? this.overview,
      posterPath: posterPath ?? this.posterPath,
      releaseDate: releaseDate ?? this.releaseDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'original_title': originalTitle,
      'adult': adult,
      'backdrop_path': backdropPath,
      'genres': genres.map((x) => x).toList(),
      'overview': overview,
      'poster_path': posterPath,
      'release_date': releaseDate,
    };
  }

  factory MovieDetailModel.fromMap(Map<String, dynamic> map) {
    return MovieDetailModel(
      id: map['id'] ?? 0,
      originalTitle: map['original_title'] ?? '',
      adult: map['adult'] ?? false,
      backdropPath: map['backdrop_path'] ?? '',
      genres:
          (map['genres'] as List<dynamic>)
              .map(
                (genre) =>
                    MovieGenresModel.fromMap(genre as Map<String, dynamic>),
              )
              .toList(),
      overview: map['overview'] ?? '',
      posterPath: map['poster_path'] ?? '',
      releaseDate: map['release_date'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MovieDetailModel.fromJson(String source) =>
      MovieDetailModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
