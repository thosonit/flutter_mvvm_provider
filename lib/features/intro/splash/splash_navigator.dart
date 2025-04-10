import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/base/base_navigator.dart';
import 'package:flutter_app/navigation/app_router.dart';
import 'package:go_router/go_router.dart';

class SplashNavigator extends BaseNavigator {
  SplashNavigator({required BuildContext context}) : super(context: context);

  void openMovieList() {
    context.go(AppRouter.movies);
  }
}
