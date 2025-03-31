import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:movie_app/core/common/feature/movie_details/data/model/movie_detail_model.dart';
import 'package:movie_app/core/constants/app_url.dart';
import 'package:movie_app/core/errors/exception.dart';
import 'package:movie_app/core/services/dio.dart';

abstract class MovieDetailRemoteDatasource {
  Future<MovieDetailModel> fetchMovieDetailById({required int id});
}

class MovieDetailRemoteDatasourceImpl implements MovieDetailRemoteDatasource {
  final DioService service;
  MovieDetailRemoteDatasourceImpl({required this.service});
  @override
  Future<MovieDetailModel> fetchMovieDetailById({required int id}) async {
    try {
      final res = await service.get("${AppUrl.movieDetailsEND}/$id");

      final movie = MovieDetailModel.fromMap(res.data);
      return movie;
    } on DioException catch (e) {
      throw ServerException(message: e.message.toString(), statusCode: 600);
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: 500);
    }
  }
}
