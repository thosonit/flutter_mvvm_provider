import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/base/base_navigator.dart';

class MovieListNavigator extends BaseNavigator {
  MovieListNavigator({required BuildContext context}) : super(context: context);

  void goToMovieDetails({required int movieId}) {
    // Todo: Implement the navigation to movie details page
    // pushNamed(
    //   AppRouter.movieDetailsRouteName,
    //   arguments: movieId,
    // );
  }
}
