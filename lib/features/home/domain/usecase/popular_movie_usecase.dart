import 'package:movie_app/core/common/entities/movie.dart';
import 'package:movie_app/core/usecase/usecase.dart';
import 'package:movie_app/core/utils/typedef.dart';
import 'package:movie_app/features/home/domain/repositories/home_repo.dart';

class PopularMovieUsecase extends UseCaseWithOutParams<List<Movie>> {
  const PopularMovieUsecase(this._homeRepo);
  final HomeRepo _homeRepo;

  @override
  ResultFuture<List<Movie>> call() => _homeRepo.getPopularMovie();
}
