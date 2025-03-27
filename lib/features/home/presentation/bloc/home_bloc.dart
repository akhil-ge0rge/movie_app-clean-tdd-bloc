import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/core/common/entities/movie.dart';
import 'package:movie_app/features/home/domain/usecase/popular_movie_usecase.dart';
import 'package:movie_app/features/home/domain/usecase/toprated_movie_usecase.dart';
import 'package:movie_app/features/home/domain/usecase/trending_movie_usecase.dart';
import 'package:movie_app/features/home/domain/usecase/upcoming_movie_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final PopularMovieUsecase popularMovieUsecase;
  final TopratedMovieUsecase topratedMovieUsecase;
  final TrendingMovieUsecase trendingMovieUsecase;
  final UpcomingMovieUsecase upcomingMovieUsecase;
  HomeBloc({
    required this.popularMovieUsecase,
    required this.topratedMovieUsecase,
    required this.trendingMovieUsecase,
    required this.upcomingMovieUsecase,
  }) : super(HomeState()) {
    on<FetchPopularMovies>(_handleFetchPopularMovie);
    on<FetchTopRatedMovies>(_handleFetchTopRatedMovie);
    on<FetchTrendingMovies>(_handleFetchTrendingMovie);
    on<FetchUpcomingMovies>(_handleFetchUpcomingMovie);
  }

  void _handleFetchPopularMovie(
    FetchPopularMovies event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(popularMovieLoading: true));

    final result = await popularMovieUsecase();
    result.fold(
      (l) => emit(
        state.copyWith(
          popularMovieError: l.message,
          popularMovieLoading: false,
        ),
      ),
      (r) => emit(state.copyWith(popularMovie: r, popularMovieLoading: false)),
    );
  }

  void _handleFetchTopRatedMovie(
    FetchTopRatedMovies event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(topratedMovieLoading: true));

    final result = await topratedMovieUsecase();
    result.fold(
      (l) => emit(
        state.copyWith(
          topratedMovieError: l.message,
          topratedMovieLoading: false,
        ),
      ),
      (r) =>
          emit(state.copyWith(topratedMovie: r, topratedMovieLoading: false)),
    );
  }

  void _handleFetchTrendingMovie(
    FetchTrendingMovies event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(trendingMovieLoading: true));

    final result = await trendingMovieUsecase();
    result.fold(
      (l) => emit(
        state.copyWith(
          trendingMovieError: l.message,
          trendingMovieLoading: false,
        ),
      ),
      (r) =>
          emit(state.copyWith(trendingMovie: r, trendingMovieLoading: false)),
    );
  }

  void _handleFetchUpcomingMovie(
    FetchUpcomingMovies event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(upcomingMovieLoading: true));

    final result = await upcomingMovieUsecase();
    result.fold(
      (l) => emit(
        state.copyWith(
          upcomingMovieError: l.message,
          upcomingMovieLoading: false,
        ),
      ),
      (r) =>
          emit(state.copyWith(upcomingMovie: r, upcomingMovieLoading: false)),
    );
  }
}
