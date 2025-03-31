import 'package:movie_app/core/common/feature/movie_details/domain/entities/movie_detail.dart';
import 'package:movie_app/core/common/feature/movie_details/domain/repositories/movie_detail_repository.dart';
import 'package:movie_app/core/usecase/usecase.dart';
import 'package:movie_app/core/utils/typedef.dart';

class MovieByIdUseCase extends UseCaseWithParams<MovieDetail, int> {
  final MovieDetailRepository repo;

  MovieByIdUseCase({required this.repo});

  @override
  ResultFuture<MovieDetail> call(int id) => repo.fetchMovieDetailsById(id: id);
}
