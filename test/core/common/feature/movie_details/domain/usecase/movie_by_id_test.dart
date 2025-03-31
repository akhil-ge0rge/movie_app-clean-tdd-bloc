import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/core/common/feature/movie_details/domain/entities/movie_detail.dart';
import 'package:movie_app/core/common/feature/movie_details/domain/repositories/movie_detail_repository.dart';
import 'package:movie_app/core/common/feature/movie_details/domain/usecase/movie_by_id.dart';
import 'package:movie_app/core/errors/failure.dart';

class MockMovieDetailsRepo extends Mock implements MovieDetailRepository {}

void main() {
  late MovieDetailRepository repo;
  late MovieByIdUseCase usecase;

  setUp(() {
    repo = MockMovieDetailsRepo();
    usecase = MovieByIdUseCase(repo: repo);
  });
  final tMovieDetail = const MovieDetail(
    id: 1,
    originalTitle: "originalTitle",
    adult: true,
    backdropPath: "backdropPath",
    genres: [],
    overview: "overview",
    posterPath: "posterPath",
    releaseDate: "releaseDate",
  );
  group('MovieByIdUseCase', () {
    test(
      'should return a [MovieDetail] when call to [MovieDetailRepository] success',
      () async {
        when(
          () => repo.fetchMovieDetailsById(id: any(named: 'id')),
        ).thenAnswer((invocation) async => Right(tMovieDetail));

        final res = await usecase(1);

        expect(res, equals(Right<dynamic, MovieDetail>(tMovieDetail)));
        verify(() => repo.fetchMovieDetailsById(id: 1)).called(1);
        verifyNoMoreInteractions(repo);
      },
    );

    test(
      'should return a [Failure] when call to [MovieDetailRepository] fails',
      () async {
        final failure = ServerFailure(message: "Server error", statusCode: 200);
        when(
          () => repo.fetchMovieDetailsById(id: any(named: 'id')),
        ).thenAnswer((invocation) async => Left(failure));

        final res = await usecase(1);

        expect(res, equals(Left<Failure, dynamic>(failure)));
        verify(() => repo.fetchMovieDetailsById(id: 1)).called(1);
        verifyNoMoreInteractions(repo);
      },
    );
  });
}
