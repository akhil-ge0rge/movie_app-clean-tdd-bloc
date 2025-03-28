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
  ResultFuture<List<Movie>> getPopularMovie({required int pageNum}) async {
    try {
      final res = await remoteDatasource.getPopularMovie(pageNum: pageNum);
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Movie>> getTopRatedMovie({required int pageNum}) async {
    try {
      final res = await remoteDatasource.getTopRatedMovie(pageNum: pageNum);
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
  ResultFuture<List<Movie>> getUpcomingMovie({required int pageNum}) async {
    try {
      final res = await remoteDatasource.getUpcomingMovie(pageNum: pageNum);
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
