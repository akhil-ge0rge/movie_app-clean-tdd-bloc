import 'package:movie_app/core/common/feature/movie_details/domain/entities/movie_detail.dart';
import 'package:movie_app/core/utils/typedef.dart';

abstract class MovieDetailRepository {
  const MovieDetailRepository();
  ResultFuture<MovieDetail> fetchMovieDetailsById({required int id});
}
