import 'package:movie_app/core/common/entities/movie.dart';
import 'package:movie_app/core/utils/typedef.dart';

abstract class HomeRepo {
  const HomeRepo();

  ResultFuture<List<Movie>> getTrendingMovie();
  ResultFuture<List<Movie>> getUpcomingMovie();
  ResultFuture<List<Movie>> getTopRatedMovie();
  ResultFuture<List<Movie>> getPopularMovie();
}
