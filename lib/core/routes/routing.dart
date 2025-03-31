import 'package:go_router/go_router.dart';
import 'package:movie_app/core/common/feature/movie_details/presentation/pages/movie_detail_page.dart';
import 'package:movie_app/core/routes/route_names.dart';
import 'package:movie_app/features/bottom_navigation/presentation/pages/bottom_navigation_screen.dart';
import 'package:movie_app/features/splash/presentation/page/splash_screen.dart';

class PageRouter {
  PageRouter._();

  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: RouteNames.splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RouteNames.bottomNavBar,
        builder: (context, state) => const BottomNavigationScreen(),
      ),
      GoRoute(
        path: RouteNames.movieDetailsScreen,
        builder: (context, state) => const MovieDetailPage(),
      ),
    ],
  );
}
