import 'package:movie_app/core/common/entities/movie.dart';
import 'package:movie_app/core/utils/typedef.dart';

abstract class HomeRepo {
  const HomeRepo();

  ResultFuture<List<Movie>> getTrendingMovie({required int pageNum});
  ResultFuture<List<Movie>> getUpcomingMovie({required int pageNum});
  ResultFuture<List<Movie>> getTopRatedMovie({required int pageNum});
  ResultFuture<List<Movie>> getPopularMovie({required int pageNum});
}
