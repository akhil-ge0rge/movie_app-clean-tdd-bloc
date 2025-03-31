import 'package:get_it/get_it.dart';
import 'package:movie_app/core/common/feature/movie_details/data/datasource/movie_detail_remote_datasource.dart';
import 'package:movie_app/core/common/feature/movie_details/data/repository/movie_detail_repo_impl.dart';
import 'package:movie_app/core/common/feature/movie_details/domain/usecase/movie_by_id.dart';
import 'package:movie_app/core/common/feature/movie_details/presentation/bloc/movie_details_bloc.dart';
import 'package:movie_app/core/services/dio.dart';
import 'package:movie_app/features/bottom_navigation/presentation/bloc/navigation_bloc.dart';
import 'package:movie_app/features/home/data/datasources/home_remote_datasource.dart';
import 'package:movie_app/features/home/data/repo/home_repo_impl.dart';
import 'package:movie_app/features/home/domain/repositories/home_repo.dart';
import 'package:movie_app/features/home/domain/usecase/popular_movie_usecase.dart';
import 'package:movie_app/features/home/domain/usecase/toprated_movie_usecase.dart';
import 'package:movie_app/features/home/domain/usecase/trending_movie_usecase.dart';
import 'package:movie_app/features/home/domain/usecase/upcoming_movie_usecase.dart';
import 'package:movie_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:movie_app/features/splash/presentation/bloc/splash_bloc.dart';

import '../common/feature/movie_details/domain/repositories/movie_detail_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _initSplash();
  await _initHome();
  await _initNavigation();
  await _initMovieDetails();
}

Future<void> _initSplash() async {
  sl.registerFactory(() => SplashBloc());
}

Future<void> _initNavigation() async {
  sl.registerFactory(() => NavigationBloc());
}

Future<void> _initHome() async {
  sl
    ..registerFactory(
      () => HomeBloc(
        popularMovieUsecase: sl(),
        topratedMovieUsecase: sl(),
        trendingMovieUsecase: sl(),
        upcomingMovieUsecase: sl(),
      ),
    )
    ..registerLazySingleton(() => PopularMovieUsecase(sl()))
    ..registerLazySingleton(() => TopratedMovieUsecase(sl()))
    ..registerLazySingleton(() => TrendingMovieUsecase(sl()))
    ..registerLazySingleton(() => UpcomingMovieUsecase(sl()))
    ..registerLazySingleton<HomeRepo>(() => HomeRepoImpl(sl()))
    ..registerLazySingleton<HomeRemoteDatasource>(
      () => HomeRemoteDatasourceImpl(sl()),
    )
    ..registerLazySingleton(() => DioService());
}

Future<void> _initMovieDetails() async {
  sl
    ..registerFactory(() => MovieDetailsBloc(movieByIdUseCase: sl()))
    ..registerLazySingleton(() => MovieByIdUseCase(repo: sl()))
    ..registerLazySingleton<MovieDetailRepository>(
      () => MovieDetailRepoImpl(remoteDatasource: sl()),
    )
    ..registerLazySingleton<MovieDetailRemoteDatasource>(
      () => MovieDetailRemoteDatasourceImpl(service: sl()),
    );
}
