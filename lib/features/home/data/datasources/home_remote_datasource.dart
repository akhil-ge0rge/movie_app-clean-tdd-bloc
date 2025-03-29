import 'package:dio/dio.dart';
import 'package:movie_app/core/common/models/movie_model.dart';
import 'package:movie_app/core/constants/app_url.dart';
import 'package:movie_app/core/errors/exception.dart';
import 'package:movie_app/core/services/dio.dart';

abstract class HomeRemoteDatasource {
  Future<List<MovieModel>> getPopularMovie({required int pageNum});
  Future<List<MovieModel>> getTopRatedMovie({required int pageNum});
  Future<List<MovieModel>> getTrendingMovie({required int pageNum});
  Future<List<MovieModel>> getUpcomingMovie({required int pageNum});
}

class HomeRemoteDatasourceImpl implements HomeRemoteDatasource {
  final DioService dioService;
  HomeRemoteDatasourceImpl(this.dioService);
  @override
  Future<List<MovieModel>> getPopularMovie({required int pageNum}) =>
      _fetchMovies(apiEndPoint: AppUrl.popularMovieEND, pageNum: pageNum);

  @override
  Future<List<MovieModel>> getTopRatedMovie({required int pageNum}) =>
      _fetchMovies(apiEndPoint: AppUrl.topRatedMovieEND, pageNum: pageNum);

  @override
  Future<List<MovieModel>> getTrendingMovie({required int pageNum}) =>
      _fetchMovies(apiEndPoint: AppUrl.trendingMovieEND, pageNum: pageNum);

  @override
  Future<List<MovieModel>> getUpcomingMovie({required int pageNum}) =>
      _fetchMovies(apiEndPoint: AppUrl.upcomingMovieEND, pageNum: pageNum);

  Future<List<MovieModel>> _fetchMovies({
    required String apiEndPoint,
    required int pageNum,
  }) async {
    try {
      final res = await dioService.get(
        AppUrl.popularMovieEND,
        params: {'language': 'en-US', 'page': pageNum},
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
}
