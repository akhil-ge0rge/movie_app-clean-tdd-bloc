import 'package:equatable/equatable.dart';

import 'package:movie_app/core/common/feature/movie_details/domain/entities/movie_genres.dart';

class MovieDetail extends Equatable {
  final int id;
  final String originalTitle;
  final bool adult;
  final String backdropPath;
  final List<MovieGenres> genres;
  final String overview;
  final String posterPath;
  final String releaseDate;

  const MovieDetail({
    required this.id,
    required this.originalTitle,
    required this.adult,
    required this.backdropPath,
    required this.genres,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
  });
  @override
  List<Object> get props {
    return [
      id,
      originalTitle,
      adult,
      backdropPath,
      genres,
      overview,
      posterPath,
      releaseDate,
    ];
  }
}
