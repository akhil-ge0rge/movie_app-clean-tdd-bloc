import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/core/common/models/movie_model.dart';
import 'package:movie_app/core/constants/app_url.dart';
import 'package:movie_app/core/errors/exception.dart';
import 'package:movie_app/core/services/dio.dart';
import 'package:movie_app/features/home/data/datasources/home_remote_datasource.dart';

class MockDioService extends Mock implements DioService {}

void main() {
  late DioService dio;
  late HomeRemoteDatasource datasource;

  setUp(() {
    dio = MockDioService();
    datasource = HomeRemoteDatasourceImpl(dio);
  });

  const tMovieModel = MovieModel(
    id: 1,
    backdropPath: "backdropPath",
    posterPath: "posterPath",
    title: "title",
    adult: false,
  );

  final tJsonResponse = {
    "results": [
      {
        "id": 1,
        "backdrop_path": "backdropPath",
        "poster_path": "posterPath",
        "title": "title",
        "adult": false,
      },
    ],
  };

  void setMockDioGetFailure(String path) {
    when(() => dio.get(any(), params: any(named: 'params'))).thenThrow(
      DioException(
        response: Response(
          statusCode: 500,
          data: 'Something Went Wrong',
          requestOptions: RequestOptions(path: path),
        ),
        requestOptions: RequestOptions(path: path),
      ),
    );
  }

  void setMockDioGetSucess(String path) {
    when(() => dio.get(any(), params: any(named: 'params'))).thenAnswer(
      (_) async => Response(
        data: tJsonResponse,
        statusCode: 200,
        requestOptions: RequestOptions(path: path),
      ),
    );
  }

  group('getPopularMovie', () {
    test('should return [List<MovieModel>] when call is success', () async {
      setMockDioGetSucess(AppUrl.popularMovieEND);
      final result = await datasource.getPopularMovie();
      expect(result, isA<List<MovieModel>>());
      expect(result.length, 1);
      verify(
        () => dio.get(AppUrl.popularMovieEND, params: any(named: 'params')),
      ).called(1);
      verifyNoMoreInteractions(dio);
    });

    test('should throw [ServerException] when call fails', () async {
      setMockDioGetFailure(AppUrl.popularMovieEND);

      final result = datasource.getPopularMovie;
      expect(result(), throwsA(isA<ServerException>()));
      verify(
        () => dio.get(AppUrl.popularMovieEND, params: any(named: 'params')),
      ).called(1);
      verifyNoMoreInteractions(dio);
    });
  });

  group('getTopRatedMovie', () {
    test('should return [List<MovieModel>] when call is succes', () async {
      setMockDioGetSucess(AppUrl.topRatedMovieEND);

      final res = await datasource.getTopRatedMovie();

      expect(res, isA<List<MovieModel>>());
      verify(
        () => dio.get(AppUrl.topRatedMovieEND, params: any(named: 'params')),
      ).called(1);
      verifyNoMoreInteractions(dio);
    });

    test('should throw [ServerException] when call fails', () async {
      setMockDioGetFailure(AppUrl.topRatedMovieEND);
      final res = datasource.getTopRatedMovie;

      expect(res(), throwsA(isA<ServerException>()));
      verify(
        () => dio.get(AppUrl.topRatedMovieEND, params: any(named: 'params')),
      ).called(1);
      verifyNoMoreInteractions(dio);
    });
  });

  group('getTrendingMovie', () {
    test('should return [List<MovieModel>] when call is success', () async {
      setMockDioGetSucess(AppUrl.trendingMovieEND);

      final res = await datasource.getTrendingMovie(pageNum: 1);
      expect(res, isA<List<MovieModel>>());
      verify(
        () => dio.get(AppUrl.trendingMovieEND, params: any(named: 'params')),
      ).called(1);
      verifyNoMoreInteractions(dio);
    });

    test('should throw [ServerException] when call fails', () {
      setMockDioGetFailure(AppUrl.trendingMovieEND);
      final call = datasource.getTrendingMovie;

      expect(call(pageNum: 1), throwsA(isA<ServerException>()));
      verify(
        () => dio.get(AppUrl.trendingMovieEND, params: any(named: 'params')),
      ).called(1);
      verifyNoMoreInteractions(dio);
    });
  });

  group('getUpcomingMovie', () {
    test('should return [List<MovieModel>] when call is success', () async {
      setMockDioGetSucess(AppUrl.upcomingMovieEND);

      final res = await datasource.getUpcomingMovie();
      expect(res, isA<List<MovieModel>>());
      verify(
        () => dio.get(AppUrl.upcomingMovieEND, params: any(named: 'params')),
      ).called(1);
      verifyNoMoreInteractions(dio);
    });

    test('should throw [ServerException] when call fails', () async {
      setMockDioGetFailure(AppUrl.upcomingMovieEND);
      final call = datasource.getUpcomingMovie;

      expect(call(), throwsA(isA<ServerException>()));
      verify(
        () => dio.get(AppUrl.upcomingMovieEND, params: any(named: 'params')),
      ).called(1);
      verifyNoMoreInteractions(dio);
    });
  });
}
