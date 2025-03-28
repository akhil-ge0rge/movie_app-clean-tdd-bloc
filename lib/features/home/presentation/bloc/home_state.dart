part of 'home_bloc.dart';

class HomeState {
  final List<Movie> trendingMovie;
  final bool trendingMovieLoading;
  final String? trendingMovieError;
  final bool trendingMoviePaginationLoading;
  final bool trendingMoviePaginationHasMore;
  final List<Movie> topratedMovie;
  final bool topratedMovieLoading;
  final String? topratedMovieError;
  final List<Movie> upcomingMovie;
  final bool upcomingMovieLoading;
  final String? upcomingMovieError;
  final List<Movie> popularMovie;
  final bool popularMovieLoading;
  final String? popularMovieError;

  HomeState({
    this.trendingMovie = const [],
    this.trendingMovieLoading = false,
    this.trendingMovieError,
    this.trendingMoviePaginationHasMore = true,
    this.trendingMoviePaginationLoading = false,
    this.topratedMovie = const [],
    this.topratedMovieLoading = false,
    this.topratedMovieError,
    this.upcomingMovie = const [],
    this.upcomingMovieLoading = false,
    this.upcomingMovieError,
    this.popularMovie = const [],
    this.popularMovieLoading = false,
    this.popularMovieError,
  });

  HomeState copyWith({
    List<Movie>? trendingMovie,
    bool? trendingMovieLoading,
    String? trendingMovieError,
    bool? trendingMoviePaginationLoading,
    bool? trendingMoviePaginationHasMore,
    List<Movie>? topratedMovie,
    bool? topratedMovieLoading,
    String? topratedMovieError,
    List<Movie>? upcomingMovie,
    bool? upcomingMovieLoading,
    String? upcomingMovieError,
    List<Movie>? popularMovie,
    bool? popularMovieLoading,
    String? popularMovieError,
  }) {
    return HomeState(
      trendingMovie: trendingMovie ?? this.trendingMovie,
      topratedMovie: topratedMovie ?? this.topratedMovie,
      upcomingMovie: upcomingMovie ?? this.upcomingMovie,
      popularMovie: popularMovie ?? this.popularMovie,
      popularMovieError: popularMovieError ?? this.popularMovieError,
      topratedMovieError: topratedMovieError ?? this.topratedMovieError,
      trendingMovieError: trendingMovieError ?? this.trendingMovieError,
      upcomingMovieError: upcomingMovieError ?? this.upcomingMovieError,
      popularMovieLoading: popularMovieLoading ?? this.popularMovieLoading,
      topratedMovieLoading: topratedMovieLoading ?? this.topratedMovieLoading,
      trendingMovieLoading: trendingMovieLoading ?? this.trendingMovieLoading,
      upcomingMovieLoading: upcomingMovieLoading ?? this.upcomingMovieLoading,
      trendingMoviePaginationHasMore:
          trendingMoviePaginationHasMore ?? this.trendingMoviePaginationHasMore,
      trendingMoviePaginationLoading:
          trendingMoviePaginationLoading ?? this.trendingMoviePaginationLoading,
    );
  }
}
