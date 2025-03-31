import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/core/common/feature/movie_details/data/datasource/movie_detail_remote_datasource.dart';
import 'package:movie_app/core/common/feature/movie_details/data/model/movie_detail_model.dart';
import 'package:movie_app/core/constants/app_url.dart';
import 'package:movie_app/core/errors/exception.dart';
import 'package:movie_app/core/services/dio.dart';

import '../../../../../../fixtures/fixture_reader.dart';

class MockDioServices extends Mock implements DioService {}

void main() {
  late DioService dioService;
  late MovieDetailRemoteDatasource remoteDataSource;

  setUp(() {
    dioService = MockDioServices();
    remoteDataSource = MovieDetailRemoteDatasourceImpl(service: dioService);
  });

  final tMovieDetailsModel = const MovieDetailModel(
    id: 1,
    originalTitle: "",
    adult: false,
    backdropPath: '',
    genres: [],
    overview: '',
    posterPath: '',
    releaseDate: '',
  );

  final tMovieDetailJson = fixture('movie_details.json');

  group('getMovieDetilsById', () {
    test('should return [MovieDetilsModel]  when call is success', () async {
      when(() => dioService.get(any())).thenAnswer(
        (_) async => Response(
          data: tMovieDetailJson,
          statusCode: 200,
          requestOptions: RequestOptions(path: "${AppUrl.movieDetailsEND}/1"),
        ),
      );
      final res = await remoteDataSource.fetchMovieDetailById(id: 1);
      expect(res, isA<MovieDetailModel>());
      verify(() => dioService.get("${AppUrl.movieDetailsEND}/1")).called(1);
      verifyNoMoreInteractions(dioService);
    });

    test('should throw [ServerException] when call fails', () async {
      when(() => dioService.get(any())).thenThrow(
        DioException(
          response: Response(
            statusCode: 500,
            data: 'Something Went Wrong',
            requestOptions: RequestOptions(path: "${AppUrl.movieDetailsEND}/1"),
          ),
          requestOptions: RequestOptions(path: "${AppUrl.movieDetailsEND}/1"),
        ),
      );

      final result = remoteDataSource.fetchMovieDetailById;
      expect(result(id: 1), throwsA(isA<ServerException>()));
      verify(() => dioService.get("${AppUrl.movieDetailsEND}/1")).called(1);
      verifyNoMoreInteractions(dioService);
    });
  });
}
