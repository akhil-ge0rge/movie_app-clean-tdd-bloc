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
  ResultFuture<List<Movie>> getPopularMovie() async {
    try {
      final res = await remoteDatasource.getPopularMovie();
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Movie>> getTopRatedMovie() async {
    try {
      final res = await remoteDatasource.getTopRatedMovie();
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Movie>> getTrendingMovie({required int pageNum}) async {
    try {
      final res = await remoteDatasource.getTrendingMovie(pageNum: pageNum);
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Movie>> getUpcomingMovie() async {
    try {
      final res = await remoteDatasource.getUpcomingMovie();
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
