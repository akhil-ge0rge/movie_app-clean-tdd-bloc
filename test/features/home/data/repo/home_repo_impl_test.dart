import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/core/common/entities/movie.dart';
import 'package:movie_app/core/common/models/movie_model.dart';
import 'package:movie_app/core/errors/exception.dart';
import 'package:movie_app/core/errors/failure.dart';
import 'package:movie_app/features/home/data/datasources/home_remote_datasource.dart';
import 'package:movie_app/features/home/data/repo/home_repo_impl.dart';

class MockHomeRemoteDataSource extends Mock implements HomeRemoteDatasource {}

void main() {
  late HomeRemoteDatasource remote;
  late HomeRepoImpl homeRepoImpl;

  final tMovie = const MovieModel(
    id: 0,
    backdropPath: 'backdropPath',
    posterPath: 'posterPath',
    title: 'title',
    adult: false,
  );

  setUp(() {
    remote = MockHomeRemoteDataSource();
    homeRepoImpl = HomeRepoImpl(remote);
    registerFallbackValue(tMovie);
  });

  const tException = ServerException(
    message: 'Something Went Wrong',
    statusCode: 500,
  );

  group('getPopularMovie', () {
    test(
      'should return [List<Movie>] when call to remote datasource is success',
      () async {
        when(
          () => remote.getPopularMovie(pageNum: any(named: 'pageNum')),
        ).thenAnswer((_) async => [tMovie]);

        final res = await homeRepoImpl.getPopularMovie(pageNum: 1);

        expect(res, isA<Right<dynamic, List<Movie>>>());
        verify(() => remote.getPopularMovie(pageNum: 1)).called(1);
        verifyNoMoreInteractions(remote);
      },
    );

    test(
      'should return [ServerException] when call to remote datasource is unsccessful',
      () async {
        when(
          () => remote.getPopularMovie(pageNum: any(named: 'pageNum')),
        ).thenThrow(tException);

        final res = await homeRepoImpl.getPopularMovie(pageNum: 1);
        expect(
          res,
          Left<Failure, dynamic>(ServerFailure.fromException(tException)),
        );
        verify(() => remote.getPopularMovie(pageNum: 1)).called(1);
        verifyNoMoreInteractions(remote);
      },
    );
  });

  group('getTopRatedMovie', () {
    test(
      'should return [List<Movie>] when call to remote datasource is sucess',
      () async {
        when(
          () => remote.getTopRatedMovie(pageNum: any(named: 'pageNum')),
        ).thenAnswer((_) async => [tMovie]);

        final res = await homeRepoImpl.getTopRatedMovie(pageNum: 1);

        expect(res, isA<Right<dynamic, List<Movie>>>());
        verify(() => remote.getTopRatedMovie(pageNum: 1)).called(1);
        verifyNoMoreInteractions(remote);
      },
    );

    test(
      'should return [ServerException] when call to remote datasource is unsuccessful',
      () async {
        when(
          () => remote.getTopRatedMovie(pageNum: any(named: 'pageNum')),
        ).thenThrow(tException);

        final res = await homeRepoImpl.getTopRatedMovie(pageNum: 1);

        expect(
          res,
          Left<Failure, dynamic>(ServerFailure.fromException(tException)),
        );

        verify(() => remote.getTopRatedMovie(pageNum: 1)).called(1);
        verifyNoMoreInteractions(remote);
      },
    );
  });

  group('getTrendingMovie', () {
    test(
      'should return [List<Movie>] when call to remote datasource is successful',
      () async {
        when(
          () => remote.getTrendingMovie(pageNum: any(named: 'pageNum')),
        ).thenAnswer((_) async => [tMovie]);

        final res = await homeRepoImpl.getTrendingMovie(pageNum: 1);

        expect(res, isA<Right<dynamic, List<Movie>>>());
        verify(() => remote.getTrendingMovie(pageNum: 1)).called(1);
        verifyNoMoreInteractions(remote);
      },
    );

    test(
      'should return [ServerException] when call to remote datasource is unsuccessful',
      () async {
        when(
          () => remote.getTrendingMovie(pageNum: any(named: 'pageNum')),
        ).thenThrow(tException);
        final res = await homeRepoImpl.getTrendingMovie(pageNum: 1);
        expect(res, Left(ServerFailure.fromException(tException)));
        verify(() => remote.getTrendingMovie(pageNum: 1)).called(1);
        verifyNoMoreInteractions(remote);
      },
    );
  });

  group('getUpcomingMovie', () {
    test(
      'should return [List<Movie>] when call to remote datasource is successful',
      () async {
        when(
          () => remote.getUpcomingMovie(pageNum: any(named: 'pageNum')),
        ).thenAnswer((_) async => [tMovie]);

        final res = await homeRepoImpl.getUpcomingMovie(pageNum: 1);

        expect(res, isA<Right<dynamic, List<Movie>>>());
        verify(() => remote.getUpcomingMovie(pageNum: 1)).called(1);
        verifyNoMoreInteractions(remote);
      },
    );

    test(
      'should return [ServerException] when call to remote datasource is unsuccessful',
      () async {
        when(
          () => remote.getUpcomingMovie(pageNum: any(named: 'pageNum')),
        ).thenThrow(tException);
        final res = await homeRepoImpl.getUpcomingMovie(pageNum: 1);
        expect(res, Left(ServerFailure.fromException(tException)));
        verify(() => remote.getUpcomingMovie(pageNum: 1)).called(1);
        verifyNoMoreInteractions(remote);
      },
    );
  });
}
