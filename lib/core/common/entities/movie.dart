import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final int id;
  final String backdropPath;
  final String posterPath;
  final String title;
  final bool adult;

  const Movie({
    required this.id,
    required this.backdropPath,
    required this.posterPath,
    required this.title,
    required this.adult,
  });

  @override
  List<Object> get props {
    return [id, backdropPath, posterPath, title, adult];
  }
}
