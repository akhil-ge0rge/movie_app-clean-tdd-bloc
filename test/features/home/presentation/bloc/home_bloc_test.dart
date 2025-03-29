import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/core/common/entities/movie.dart';
import 'package:movie_app/core/errors/failure.dart';
import 'package:movie_app/features/home/domain/usecase/popular_movie_usecase.dart';
import 'package:movie_app/features/home/domain/usecase/toprated_movie_usecase.dart';
import 'package:movie_app/features/home/domain/usecase/trending_movie_usecase.dart';
import 'package:movie_app/features/home/domain/usecase/upcoming_movie_usecase.dart';
import 'package:movie_app/features/home/presentation/bloc/home_bloc.dart';

class MockPopularMovieUsecase extends Mock implements PopularMovieUsecase {}

class MockTrendingMovieUsecase extends Mock implements TrendingMovieUsecase {}

class MockUpcomingMovieUsecase extends Mock implements UpcomingMovieUsecase {}

class MockTopratedMovieUsecases extends Mock implements TopratedMovieUsecase {}

void main() {
  late PopularMovieUsecase popularMovieUsecase;
  late TrendingMovieUsecase trendingMovieUsecase;
  late UpcomingMovieUsecase upcomingMovieUsecase;
  late TopratedMovieUsecase topratedMovieUsecase;

  late HomeBloc bloc;

  setUp(() {
    popularMovieUsecase = MockPopularMovieUsecase();
    trendingMovieUsecase = MockTrendingMovieUsecase();
    upcomingMovieUsecase = MockUpcomingMovieUsecase();
    topratedMovieUsecase = MockTopratedMovieUsecases();
    bloc = HomeBloc(
      popularMovieUsecase: popularMovieUsecase,
      topratedMovieUsecase: topratedMovieUsecase,
      trendingMovieUsecase: trendingMovieUsecase,
      upcomingMovieUsecase: upcomingMovieUsecase,
    );
  });

  tearDown(() {
    bloc.close();
  });

  final tMovieList = [
    const Movie(
      id: 1,
      backdropPath: "backdropPath",
      posterPath: "posterPath",
      title: "title",
      adult: false,
    ),
  ];
  final failure = ServerFailure(message: 'Server Error', statusCode: 200);

  group('FetchPopularMovies', () {
    blocTest(
      'should emit [loading,sucess] when sucess',
      build: () {
        when(
          () => popularMovieUsecase(1),
        ).thenAnswer((invocation) async => Right(tMovieList));
        return bloc;
      },
      act: (_) => bloc.add(FetchPopularMovies()),

      expect:
          () => [
            isA<HomeState>().having(
              (p0) => p0.popularMovieLoading,
              'loading',
              true,
            ),
            isA<HomeState>().having(
              (p0) => p0.popularMovie,
              'loaded',
              tMovieList,
            ),
          ],
      verify: (_) {
        verify(() => popularMovieUsecase(any())).called(1);
      },
    );

    blocTest<HomeBloc, HomeState>(
      'emits [loading, error] when FetchPopularMovies fails',
      build: () {
        when(
          () => popularMovieUsecase(any()),
        ).thenAnswer((_) async => Left(failure));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchPopularMovies()),
      expect:
          () => [
            isA<HomeState>().having(
              (s) => s.popularMovieLoading,
              'loading',
              true,
            ),
            isA<HomeState>().having(
              (s) => s.popularMovieError,
              'error message',
              failure.message,
            ),
          ],
    );
  });
  group('FetchTrendingMovies', () {
    blocTest(
      'should emit [loading,sucess] when sucess',
      build: () {
        when(
          () => trendingMovieUsecase(1),
        ).thenAnswer((invocation) async => Right(tMovieList));
        return bloc;
      },
      act: (_) => bloc.add(FetchTrendingMovies()),

      expect:
          () => [
            isA<HomeState>().having(
              (p0) => p0.trendingMovieLoading,
              'loading',
              true,
            ),
            isA<HomeState>().having(
              (p0) => p0.trendingMovie,
              'loaded',
              tMovieList,
            ),
          ],
      verify: (_) {
        verify(() => trendingMovieUsecase(any())).called(1);
      },
    );

    blocTest<HomeBloc, HomeState>(
      'emits [loading, error] when FetchTrendingMovie fails',
      build: () {
        when(
          () => trendingMovieUsecase(any()),
        ).thenAnswer((_) async => Left(failure));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchTrendingMovies()),
      expect:
          () => [
            isA<HomeState>().having(
              (s) => s.trendingMovieLoading,
              'loading',
              true,
            ),
            isA<HomeState>().having(
              (s) => s.trendingMovieError,
              'error message',
              failure.message,
            ),
          ],
    );
  });

  group('FetchTopRatedMovies', () {
    blocTest(
      'should emit [loading,sucess] when sucess',
      build: () {
        when(
          () => topratedMovieUsecase(1),
        ).thenAnswer((invocation) async => Right(tMovieList));
        return bloc;
      },
      act: (_) => bloc.add(FetchTopRatedMovies()),

      expect:
          () => [
            isA<HomeState>().having(
              (p0) => p0.topratedMovieLoading,
              'loading',
              true,
            ),
            isA<HomeState>().having(
              (p0) => p0.topratedMovie,
              'loaded',
              tMovieList,
            ),
          ],
      verify: (_) {
        verify(() => topratedMovieUsecase(any())).called(1);
      },
    );

    blocTest<HomeBloc, HomeState>(
      'emits [loading, error] when FetchTopRatedMovie fails',
      build: () {
        when(
          () => topratedMovieUsecase(any()),
        ).thenAnswer((_) async => Left(failure));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedMovies()),
      expect:
          () => [
            isA<HomeState>().having(
              (s) => s.topratedMovieLoading,
              'loading',
              true,
            ),
            isA<HomeState>().having(
              (s) => s.topratedMovieError,
              'error message',
              failure.message,
            ),
          ],
    );
  });

  group('FetchUpcomingMovies', () {
    blocTest(
      'should emit [loading,sucess] when sucess',
      build: () {
        when(
          () => upcomingMovieUsecase(1),
        ).thenAnswer((invocation) async => Right(tMovieList));
        return bloc;
      },
      act: (_) => bloc.add(FetchUpcomingMovies()),

      expect:
          () => [
            isA<HomeState>().having(
              (p0) => p0.upcomingMovieLoading,
              'loading',
              true,
            ),
            isA<HomeState>().having(
              (p0) => p0.upcomingMovie,
              'loaded',
              tMovieList,
            ),
          ],
      verify: (_) {
        verify(() => upcomingMovieUsecase(any())).called(1);
      },
    );

    blocTest<HomeBloc, HomeState>(
      'emits [loading, error] when FetchUpCommingMovie fails',
      build: () {
        when(
          () => upcomingMovieUsecase(any()),
        ).thenAnswer((_) async => Left(failure));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchUpcomingMovies()),
      expect:
          () => [
            isA<HomeState>().having(
              (s) => s.upcomingMovieLoading,
              'loading',
              true,
            ),
            isA<HomeState>().having(
              (s) => s.upcomingMovieError,
              'error message',
              failure.message,
            ),
          ],
    );
  });
}
