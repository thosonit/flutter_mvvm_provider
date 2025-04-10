import 'package:flutter_app/core/base/base_view_model.dart';

import 'splash_navigator.dart';

class SplashVM extends BaseViewModel {
  // Navigator
  final SplashNavigator navigator;

  SplashVM({
    required this.navigator,
  });

  Future<void> checkLogin() async {
    await Future.delayed(const Duration(seconds: 2));
    navigator.openMovieList();
  }
}
