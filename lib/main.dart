import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/services/injection_container.dart';
import 'package:movie_app/core/theme/app_theme.dart';
import 'package:movie_app/features/bottom_navigation/presentation/bloc/navigation_bloc.dart';
import 'package:movie_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:movie_app/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:movie_app/features/splash/presentation/page/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<SplashBloc>()..add(SplashStart())),
        BlocProvider(create: (context) => sl<NavigationBloc>()),
        BlocProvider(create: (context) => sl<HomeBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      theme: AppTheme.theme,
      home: const SplashScreen(),
    );
  }
}
