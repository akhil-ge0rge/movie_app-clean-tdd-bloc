import 'package:dartz/dartz.dart';
import 'package:movie_app/core/common/feature/movie_details/data/datasource/movie_detail_remote_datasource.dart';
import 'package:movie_app/core/common/feature/movie_details/domain/entities/movie_detail.dart';
import 'package:movie_app/core/common/feature/movie_details/domain/repositories/movie_detail_repository.dart';
import 'package:movie_app/core/errors/exception.dart';
import 'package:movie_app/core/errors/failure.dart';
import 'package:movie_app/core/utils/typedef.dart';

class MovieDetailRepoImpl implements MovieDetailRepository {
  final MovieDetailRemoteDatasource remoteDatasource;
  MovieDetailRepoImpl({required this.remoteDatasource});
  @override
  ResultFuture<MovieDetail> fetchMovieDetailsById({required int id}) async {
    try {
      final res = await remoteDatasource.fetchMovieDetailById(id: id);
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
