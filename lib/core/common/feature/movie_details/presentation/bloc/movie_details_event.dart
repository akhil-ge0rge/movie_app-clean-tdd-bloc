part of 'movie_details_bloc.dart';

sealed class MovieDetailsEvent extends Equatable {
  const MovieDetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchMovieDetailById extends MovieDetailsEvent {
  final int movieId;

  const FetchMovieDetailById({required this.movieId});
}
