import 'package:dio/dio.dart';
import 'package:movie_app/core/common/models/movie_model.dart';
import 'package:movie_app/core/constants/app_url.dart';
import 'package:movie_app/core/errors/exception.dart';
import 'package:movie_app/core/services/dio.dart';

abstract class HomeRemoteDatasource {
  Future<List<MovieModel>> getPopularMovie();
  Future<List<MovieModel>> getTopRatedMovie();
  Future<List<MovieModel>> getTrendingMovie({required int pageNum});
  Future<List<MovieModel>> getUpcomingMovie();
}

class HomeRemoteDatasourceImpl implements HomeRemoteDatasource {
  final DioService dioService;
  HomeRemoteDatasourceImpl(this.dioService);
  @override
  Future<List<MovieModel>> getPopularMovie() async {
    try {
      final res = await dioService.get(
        AppUrl.popularMovieEND,
        params: {'language': 'en-US', 'page': 1},
      );

      final listMovie = res.data['results'] as List;
      List<MovieModel> popularMovieList = [];
      for (dynamic item in listMovie) {
        popularMovieList.add(MovieModel.fromMap(item));
      }
      return popularMovieList;
    } on DioException catch (e) {
      throw ServerException(message: e.message.toString(), statusCode: 600);
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovie() async {
    try {
      final res = await dioService.get(
        AppUrl.topRatedMovieEND,
        params: {'language': 'en-US', 'page': 1},
      );

      final listMovie = res.data['results'] as List;
      List<MovieModel> topratedMovieList = [];
      for (dynamic item in listMovie) {
        topratedMovieList.add(MovieModel.fromMap(item));
      }
      return topratedMovieList;
    } on DioException catch (e) {
      throw ServerException(message: e.message.toString(), statusCode: 600);
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<List<MovieModel>> getTrendingMovie({required int pageNum}) async {
    try {
      final res = await dioService.get(
        AppUrl.trendingMovieEND,
        params: {'language': 'en-US', 'page': pageNum},
      );

      final listMovie = res.data['results'] as List;
      List<MovieModel> trendingMovieList = [];
      for (dynamic item in listMovie) {
        trendingMovieList.add(MovieModel.fromMap(item));
      }
      return trendingMovieList;
    } on DioException catch (e) {
      throw ServerException(message: e.message.toString(), statusCode: 600);
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<List<MovieModel>> getUpcomingMovie() async {
    try {
      final res = await dioService.get(
        AppUrl.upcomingMovieEND,
        params: {'language': 'en-US', 'page': 1},
      );

      final listMovie = res.data['results'] as List;
      List<MovieModel> upcomingMovieList = [];
      for (dynamic item in listMovie) {
        upcomingMovieList.add(MovieModel.fromMap(item));
      }
      return upcomingMovieList;
    } on DioException catch (e) {
      throw ServerException(message: e.message.toString(), statusCode: 600);
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: 500);
    }
  }
}
