part of 'movie_details_bloc.dart';

sealed class MovieDetailsState extends Equatable {
  const MovieDetailsState();

  @override
  List<Object> get props => [];
}

final class MovieDetailsInitial extends MovieDetailsState {}

final class MovieDetailsLoading extends MovieDetailsState {}

final class MovieDetailsLoaded extends MovieDetailsState {
  final MovieDetail movie;

  const MovieDetailsLoaded({required this.movie});
}

final class MovieDetailsError extends MovieDetailsState {
  final String message;

  const MovieDetailsError({required this.message});
}
