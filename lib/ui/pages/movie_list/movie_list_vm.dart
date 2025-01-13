import 'package:flutter_app/common/base/base_view_model.dart';
import 'package:flutter_app/models/entities/movie_entity.dart';
import 'package:flutter_app/models/enums/load_status.dart';
import 'package:flutter_app/repositories/movie_repository.dart';

import 'movie_list_navigator.dart';

class MovieListVM extends BaseViewModel {
  // Navigator
  final MovieListNavigator navigator;

  // Repositories
  final MovieRepository movieRepo;

  // Properties
  LoadStatus get loadInitialMoviesStatus => _loadInitialMoviesStatus;
  LoadStatus _loadInitialMoviesStatus = LoadStatus.initial;

  LoadStatus get loadMoreMoviesStatus => _loadMoreMoviesStatus;
  LoadStatus _loadMoreMoviesStatus = LoadStatus.initial;

  List<MovieEntity> get movies => _movies;
  var _movies = <MovieEntity>[];

  int get currentPage => _currentPage;
  int _currentPage = 1;

  MovieListVM({
    required this.navigator,
    required this.movieRepo,
  });

  Future<void> loadInitialMovies() async {
    _loadInitialMoviesStatus = LoadStatus.loading;
    _currentPage = 1;
    notifyListeners();
    try {
      final result = await movieRepo.getMovies(page: _currentPage);
      _movies = result.results;
      _loadInitialMoviesStatus = LoadStatus.success;
      notifyListeners();
    } catch (e) {
      _loadInitialMoviesStatus = LoadStatus.failure;
      notifyListeners();
    }
  }

  Future<void> loadMoreMovies() async {
    if (_loadMoreMoviesStatus == LoadStatus.loading) {
      return;
    }
    _loadMoreMoviesStatus = LoadStatus.loading;
    notifyListeners();
    try {
      final result = await movieRepo.getMovies(page: _currentPage + 1);
      _currentPage = result.page;
      _movies += result.results;
      _loadMoreMoviesStatus = LoadStatus.success;
      notifyListeners();
    } catch (e) {
      _loadMoreMoviesStatus = LoadStatus.failure;
      notifyListeners();
    }
  }
}
