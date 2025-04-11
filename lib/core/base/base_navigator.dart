import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Base class for feature-specific navigators, providing common navigation
/// actions using GoRouter.
///
/// Feature navigators (e.g., SplashNavigator, MovieListNavigator) should
/// extend this class and add methods specific to their feature's navigation needs.
class BaseNavigator {
  final BuildContext context;

  /// Creates a BaseNavigator. Requires the [context] from which navigation
  /// will be initiated.
  BaseNavigator({required this.context});

  /// Pops the current route off the GoRouter stack.
  ///
  /// Equivalent to `Navigator.of(context).pop()`, but integrated with GoRouter.
  /// Optionally returns a [result] to the previous route.
  void pop<T extends Object?>([T? result]) {
    // Use the GoRouter extension method on context
    if (context.canPop()) {
      context.pop(result);
    } else {
      // Optional: Add logging or specific handling if pop is called when it shouldn't be
      // (e.g., on the very first screen in the stack)
      debugPrint("Attempted to pop when cannot pop.");
    }
  }

  /// Navigates to a named route, replacing the current route stack if it's
  /// a top-level route, or pushing within a nested stack.
  ///
  /// Use this for general navigation where you don't necessarily want to
  /// keep the current screen in the back stack (e.g., navigating from splash
  /// to home, or switching main tabs).
  ///
  /// - [routeName]: The name of the target route (defined in AppRouter).
  /// - [pathParameters]: Parameters to be embedded in the route path (e.g., `/users/:id`).
  /// - [queryParameters]: Parameters to be appended to the route path (e.g., `?search=query`).
  /// - [extra]: An optional object to pass along to the route, accessible via `GoRouterState.extra`.
  void goNamed(
    String routeName, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    context.goNamed(
      routeName,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  /// Pushes a named route onto the GoRouter stack.
  ///
  /// Use this when you want to navigate to a new screen and allow the user
  /// to navigate back to the current screen (e.g., navigating from a list
  /// to a detail screen).
  ///
  /// Returns a `Future<T?>` which completes when the pushed route is popped,
  /// potentially returning a result of type `T`.
  ///
  /// Parameters are the same as [goNamed].
  Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    return context.pushNamed<T>(
      routeName,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  /// Navigates to a specific location (path), replacing the current stack
  /// similar to [goNamed]. Less type-safe than named routes.
  void go(String location, {Object? extra}) {
    context.go(location, extra: extra);
  }

  /// Pushes a specific location (path) onto the stack, similar to [pushNamed].
  /// Less type-safe than named routes.
  Future<T?> push<T extends Object?>(String location, {Object? extra}) {
    return context.push<T>(location, extra: extra);
  }
}
