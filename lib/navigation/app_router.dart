import 'package:flutter_app/features/intro/splash/splash_page.dart';
import 'package:flutter_app/features/movie/movie_list/movie_list_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter._();

  static const String splash = '/';
  static const String movies = '/movies';

  static final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: splash,
    routes: [
      GoRoute(path: splash, builder: (context, state) => const SplashPage()),
      GoRoute(path: movies, builder: (context, state) => const MovieListPage()),
    ],
  );
}
