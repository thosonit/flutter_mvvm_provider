import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/app_navigator.dart';
import 'package:flutter_app/ui/pages/movie_list/movie_list_page.dart';

class SplashNavigator extends AppNavigator {
  SplashNavigator({required BuildContext context}) : super(context: context);

  void openSignInPage() {
    //Todo:
  }

  void openMainPage() {
    //Todo:
  }

  void openOnboardingPage() {
    //Todo:
  }

  void openMovieList() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const MovieListPage(),
      ),
    );
  }
}
