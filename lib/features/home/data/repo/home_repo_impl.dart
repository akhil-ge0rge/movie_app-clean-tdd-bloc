import 'package:dartz/dartz.dart';
import 'package:movie_app/core/common/entities/movie.dart';
import 'package:movie_app/core/errors/exception.dart';
import 'package:movie_app/core/errors/failure.dart';
import 'package:movie_app/core/utils/typedef.dart';
import 'package:movie_app/features/home/data/datasources/home_remote_datasource.dart';
import 'package:movie_app/features/home/domain/repositories/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  HomeRepoImpl(this.remoteDatasource);
  final HomeRemoteDatasource remoteDatasource;
  @override
  ResultFuture<List<Movie>> getPopularMovie({required int pageNum}) =>
      fetchApi(() => remoteDatasource.getPopularMovie(pageNum: pageNum));

  @override
  ResultFuture<List<Movie>> getTopRatedMovie({required int pageNum}) =>
      fetchApi(() => remoteDatasource.getTopRatedMovie(pageNum: pageNum));

  @override
  ResultFuture<List<Movie>> getTrendingMovie({required int pageNum}) =>
      fetchApi(() => remoteDatasource.getTrendingMovie(pageNum: pageNum));

  @override
  ResultFuture<List<Movie>> getUpcomingMovie({required int pageNum}) =>
      fetchApi(() => remoteDatasource.getUpcomingMovie(pageNum: pageNum));

  ResultFuture<List<Movie>> fetchApi(
    Future<List<Movie>> Function() apicall,
  ) async {
    try {
      final res = await apicall();
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
