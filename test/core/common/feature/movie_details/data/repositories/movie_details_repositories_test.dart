import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/core/common/feature/movie_details/data/datasource/movie_detail_remote_datasource.dart';
import 'package:movie_app/core/common/feature/movie_details/data/model/movie_detail_model.dart';
import 'package:movie_app/core/common/feature/movie_details/data/repository/movie_detail_repo_impl.dart';
import 'package:movie_app/core/common/feature/movie_details/domain/entities/movie_detail.dart';
import 'package:movie_app/core/errors/exception.dart';
import 'package:movie_app/core/errors/failure.dart';

class MockMovieDetailsRemoteDataSource extends Mock
    implements MovieDetailRemoteDatasource {}

void main() {
  late MovieDetailRemoteDatasource remoteDatasource;
  late MovieDetailRepoImpl repoImpl;

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

  const tException = ServerException(
    message: 'Something Went Wrong',
    statusCode: 500,
  );
  setUp(() {
    remoteDatasource = MockMovieDetailsRemoteDataSource();
    repoImpl = MovieDetailRepoImpl(remoteDatasource: remoteDatasource);
    registerFallbackValue(tMovieDetailsModel);
  });

  group('getMovieDetailsById', () {
    test(
      'should return [MovieDetails] when call to datasource is success',
      () async {
        when(
          () => remoteDatasource.fetchMovieDetailById(id: any(named: 'id')),
        ).thenAnswer((invocation) async => tMovieDetailsModel);

        final res = await repoImpl.fetchMovieDetailsById(id: 1);

        expect(res, isA<Right<dynamic, MovieDetail>>());
        verify(() => remoteDatasource.fetchMovieDetailById(id: 1)).called(1);
        verifyNoMoreInteractions(remoteDatasource);
      },
    );

    test(
      'should return [ServerException] when call to datasource is fails',
      () async {
        when(
          () => remoteDatasource.fetchMovieDetailById(id: any(named: 'id')),
        ).thenThrow(tException);
        final res = await repoImpl.fetchMovieDetailsById(id: 1);
        expect(
          res,
          Left<Failure, dynamic>(ServerFailure.fromException(tException)),
        );
        verify(() => remoteDatasource.fetchMovieDetailById(id: 1)).called(1);
        verifyNoMoreInteractions(remoteDatasource);
      },
    );
  });
}
