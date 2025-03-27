part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class FetchPopularMovies extends HomeEvent {}

class FetchTopRatedMovies extends HomeEvent {}

class FetchTrendingMovies extends HomeEvent {}

class FetchUpcomingMovies extends HomeEvent {}
