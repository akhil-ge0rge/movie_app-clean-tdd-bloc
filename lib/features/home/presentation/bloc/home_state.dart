part of 'home_bloc.dart';

class HomeState extends Equatable {
  final List<Movie> trendingMovie;
  final bool trendingMovieLoading;
  final String? trendingMovieError;
  final bool trendingMoviePaginationLoading;
  final bool trendingMoviePaginationHasMore;
  final List<Movie> topratedMovie;
  final bool topratedMovieLoading;
  final String? topratedMovieError;
  final bool topratedMoviePaginationLoading;
  final bool topratedMoviePaginationHasMore;
  final List<Movie> upcomingMovie;
  final bool upcomingMovieLoading;
  final String? upcomingMovieError;
  final bool upcomingMoviePaginationLoading;
  final bool upcomingMoviePaginationHasMore;
  final List<Movie> popularMovie;
  final bool popularMovieLoading;
  final String? popularMovieError;
  final bool popularMoviePaginationLoading;
  final bool popularMoviePaginationHasMore;

  const HomeState({
    this.trendingMovie = const [],
    this.trendingMovieLoading = false,
    this.trendingMovieError,
    this.trendingMoviePaginationHasMore = true,
    this.trendingMoviePaginationLoading = false,
    this.topratedMovie = const [],
    this.topratedMovieLoading = false,
    this.topratedMovieError,
    this.topratedMoviePaginationHasMore = true,
    this.topratedMoviePaginationLoading = false,
    this.upcomingMovie = const [],
    this.upcomingMovieLoading = false,
    this.upcomingMovieError,
    this.upcomingMoviePaginationHasMore = true,
    this.upcomingMoviePaginationLoading = false,
    this.popularMovie = const [],
    this.popularMovieLoading = false,
    this.popularMovieError,
    this.popularMoviePaginationHasMore = true,
    this.popularMoviePaginationLoading = false,
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
    bool? topratedMoviePaginationLoading,
    bool? topratedMoviePaginationHasMore,
    List<Movie>? upcomingMovie,
    bool? upcomingMovieLoading,
    String? upcomingMovieError,
    bool? upcomingMoviePaginationLoading,
    bool? upcomingMoviePaginationHasMore,
    List<Movie>? popularMovie,
    bool? popularMovieLoading,
    String? popularMovieError,
    bool? popularMoviePaginationLoading,
    bool? popularMoviePaginationHasMore,
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
      popularMoviePaginationHasMore:
          popularMoviePaginationHasMore ?? this.popularMoviePaginationHasMore,
      popularMoviePaginationLoading:
          popularMoviePaginationLoading ?? this.popularMoviePaginationLoading,
      topratedMoviePaginationHasMore:
          topratedMoviePaginationHasMore ?? this.topratedMoviePaginationHasMore,
      topratedMoviePaginationLoading:
          topratedMoviePaginationLoading ?? this.topratedMoviePaginationLoading,
      upcomingMoviePaginationHasMore:
          upcomingMoviePaginationHasMore ?? this.upcomingMoviePaginationHasMore,
      upcomingMoviePaginationLoading:
          upcomingMoviePaginationLoading ?? this.upcomingMoviePaginationLoading,
    );
  }

  @override
  List<Object?> get props => [
    trendingMovie,
    trendingMovieLoading,
    trendingMovieError,
    trendingMoviePaginationLoading,
    trendingMoviePaginationHasMore,
    topratedMovie,
    topratedMovieLoading,
    topratedMovieError,
    topratedMoviePaginationLoading,
    topratedMoviePaginationHasMore,
    upcomingMovie,
    upcomingMovieLoading,
    upcomingMovieError,
    upcomingMoviePaginationLoading,
    upcomingMoviePaginationHasMore,
    popularMovie,
    popularMovieLoading,
    popularMovieError,
    popularMoviePaginationLoading,
    popularMoviePaginationHasMore,
  ];
}
