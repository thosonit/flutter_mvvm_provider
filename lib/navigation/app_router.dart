import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/features/intro/splash/splash_page.dart';
import 'package:flutter_app/features/movie/movie_list/movie_list_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter._();

  // --- Route Paths ---
  static const String _splashPath = '/';
  static const String _moviesPath = '/movies';
  static const String _movieDetailPath = '/movies/:movieId';

  // --- Route Names ---
  static const String splashRouteName = 'splash';
  static const String moviesRouteName = 'movies';
  static const String movieDetailRouteName = 'movieDetail';

  static final GoRouter router = GoRouter(
    debugLogDiagnostics: kDebugMode,
    initialLocation: _splashPath,
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Page Not Found')),
      body: Center(
        child: Text('Error: ${state.error?.message ?? 'Route not found'}'),
      ),
    ),
    routes: [
      GoRoute(
        path: _splashPath,
        name: splashRouteName,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: _moviesPath,
        name: moviesRouteName,
        builder: (context, state) => const MovieListPage(),
      ),
    ],
  );
}
