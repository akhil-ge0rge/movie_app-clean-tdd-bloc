import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/core/common/entities/movie.dart';
import 'package:movie_app/core/errors/failure.dart';
import 'package:movie_app/features/home/domain/repositories/home_repo.dart';
import 'package:movie_app/features/home/domain/usecase/upcoming_movie_usecase.dart';

import 'home_repo.mock.dart';

void main() {
  late HomeRepo repo;
  late UpcomingMovieUsecase usecase;

  setUp(() {
    repo = MockHomeRepo();
    usecase = UpcomingMovieUsecase(repo);
  });

  group('UpcomingMovieUseCase', () {
    test('should return [Movie] list from [HomeRepo]', () async {
      when(
        () => repo.getUpcomingMovie(),
      ).thenAnswer((_) async => const Right([]));

      final res = await usecase();

      expect(res, equals(const Right<Failure, List<Movie>>([])));

      verify(() => repo.getUpcomingMovie()).called(1);
      verifyNoMoreInteractions(repo);
    });

    test('should return [Failure] when repository fails', () async {
      final failure = ServerFailure(message: "Server error", statusCode: 200);
      when(
        () => repo.getUpcomingMovie(),
      ).thenAnswer((_) async => Left(failure));

      final res = await usecase();
      expect(res, equals(Left(failure)));

      verify(() => repo.getUpcomingMovie()).called(1);
      verifyNoMoreInteractions(repo);
    });
  });
}
