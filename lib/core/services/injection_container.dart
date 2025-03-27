import 'package:get_it/get_it.dart';
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

final sl = GetIt.instance;

Future<void> init() async {
  await _initSplash();
  await _initHome();
  await _initNavigation();
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
