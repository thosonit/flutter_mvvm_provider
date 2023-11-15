import 'package:flutter_app/common/app_view_model.dart';

import 'splash_navigator.dart';

class SplashViewModel extends AppViewModel {
  final SplashNavigator navigator;

  SplashViewModel({
    required this.navigator,
  });

  Future<void> checkLogin() async {
    await Future.delayed(const Duration(seconds: 2));
    navigator.openMovieList();
  }
}
