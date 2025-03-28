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
  int trendingMoviePage = 1;
  int topratedMoviePage = 1;
  int upcomingMoviePage = 1;
  int popularMoviePage = 1;
  int pageLimit = 500;
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
    if (!state.trendingMoviePaginationHasMore ||
        state.trendingMoviePaginationLoading == true) {
      return;
    }

    if (state.trendingMovie.isEmpty) {
      emit(state.copyWith(popularMovieLoading: true));
    } else {
      emit(state.copyWith(popularMoviePaginationLoading: true));
    }

    final result = await popularMovieUsecase(popularMoviePage);
    result.fold(
      (l) => emit(
        state.copyWith(
          popularMovieError: l.message,
          popularMovieLoading: false,
          popularMoviePaginationLoading: false,
        ),
      ),
      (r) {
        if (r.isEmpty) {
          emit(
            state.copyWith(
              popularMovieLoading: false,
              popularMoviePaginationLoading: false,
              popularMoviePaginationHasMore: false,
            ),
          );
        } else {
          emit(
            state.copyWith(
              popularMovie: [...state.popularMovie, ...r],
              popularMovieLoading: false,
              popularMoviePaginationLoading: false,
            ),
          );
          popularMoviePage++;
        }
      },
    );
  }

  void _handleFetchTopRatedMovie(
    FetchTopRatedMovies event,
    Emitter<HomeState> emit,
  ) async {
    if (!state.topratedMoviePaginationHasMore ||
        state.topratedMoviePaginationLoading) {
      return;
    }

    if (state.topratedMovie.isEmpty) {
      emit(state.copyWith(topratedMovieLoading: true));
    } else {
      emit(state.copyWith(topratedMoviePaginationLoading: true));
    }

    final result = await topratedMovieUsecase(topratedMoviePage);
    result.fold(
      (l) => emit(
        state.copyWith(
          topratedMovieError: l.message,
          topratedMovieLoading: false,
          topratedMoviePaginationLoading: false,
        ),
      ),
      (r) {
        if (r.isEmpty) {
          emit(
            state.copyWith(
              topratedMovieLoading: false,
              topratedMoviePaginationLoading: false,
              topratedMoviePaginationHasMore: false,
            ),
          );
        } else {
          emit(
            state.copyWith(
              topratedMovie: [...state.topratedMovie, ...r],
              topratedMovieLoading: false,
              topratedMoviePaginationLoading: false,
            ),
          );
          topratedMoviePage++;
        }
      },
    );
  }

  void _handleFetchTrendingMovie(
    FetchTrendingMovies event,
    Emitter<HomeState> emit,
  ) async {
    if (state.trendingMoviePaginationHasMore == false ||
        state.trendingMoviePaginationLoading == true ||
        trendingMoviePage > pageLimit) {
      return;
    }
    if (state.trendingMovie.isEmpty) {
      emit(state.copyWith(trendingMovieLoading: true));
    } else {
      emit(state.copyWith(trendingMoviePaginationLoading: true));
    }
    final result = await trendingMovieUsecase(trendingMoviePage);

    result.fold(
      (l) => emit(
        state.copyWith(
          trendingMovieError: l.message,
          trendingMovieLoading: false,
          trendingMoviePaginationLoading: false,
        ),
      ),
      (r) {
        if (r.isEmpty) {
          emit(
            state.copyWith(
              trendingMovieLoading: false,
              trendingMoviePaginationLoading: false,
              trendingMoviePaginationHasMore: false,
            ),
          );
        } else {
          emit(
            state.copyWith(
              trendingMovie: [...state.trendingMovie, ...r],
              trendingMovieLoading: false,
              trendingMoviePaginationLoading: false,
            ),
          );
          trendingMoviePage++;
        }
      },
    );
  }

  void _handleFetchUpcomingMovie(
    FetchUpcomingMovies event,
    Emitter<HomeState> emit,
  ) async {
    if (!state.upcomingMoviePaginationHasMore ||
        state.upcomingMoviePaginationLoading) {
      return;
    }

    if (state.upcomingMovie.isEmpty) {
      emit(state.copyWith(upcomingMovieLoading: true));
    } else {
      emit(state.copyWith(upcomingMoviePaginationLoading: true));
    }

    final result = await upcomingMovieUsecase(upcomingMoviePage);
    result.fold(
      (l) {
        emit(
          state.copyWith(
            upcomingMovieError: l.message,
            upcomingMoviePaginationLoading: false,
            upcomingMovieLoading: false,
          ),
        );
      },
      (r) {
        if (r.isEmpty) {
          emit(
            state.copyWith(
              upcomingMovieLoading: false,
              upcomingMoviePaginationHasMore: false,
              upcomingMoviePaginationLoading: false,
            ),
          );
        } else {
          emit(
            state.copyWith(
              upcomingMovie: [...state.upcomingMovie, ...r],
              upcomingMovieLoading: false,
              upcomingMoviePaginationLoading: false,
            ),
          );
          upcomingMoviePage++;
        }
      },
    );
  }
}
