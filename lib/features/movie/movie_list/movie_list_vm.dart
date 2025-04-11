import 'package:flutter_app/core/base/base_view_model.dart';
import 'package:flutter_app/data/models/entities/movie_entity.dart';
import 'package:flutter_app/data/models/enums/load_status.dart';
import 'package:flutter_app/data/repositories/movie_repository.dart';

import '../../../core/utils/logger.dart';
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
    if (_loadInitialMoviesStatus == LoadStatus.loading) {
      return; // Prevent concurrent loads
    }

    _loadInitialMoviesStatus = LoadStatus.loading;
    _currentPage = 1;
    notifyListeners();

    final result = await movieRepo.getMovies(page: _currentPage);

    result.fold(
      (failure) {
        _loadInitialMoviesStatus = LoadStatus.failure;
        logger.e("Error loading initial movies: ${failure.message}");
        notifyListeners();
      },
      (successResponse) {
        _movies = successResponse.results;
        _loadInitialMoviesStatus = LoadStatus.success;
        notifyListeners();
      },
    );
  }

  Future<void> loadMoreMovies() async {
    if (_loadMoreMoviesStatus == LoadStatus.loading) {
      return; // Prevent concurrent loads
    }
    _loadMoreMoviesStatus = LoadStatus.loading;
    notifyListeners();

    final result = await movieRepo.getMovies(page: _currentPage + 1);
    result.fold(
      (failure) {
        _loadMoreMoviesStatus = LoadStatus.failure;
        notifyListeners();
      },
      (successResponse) {
        _currentPage = successResponse.page;
        _movies += successResponse.results;
        _loadMoreMoviesStatus = LoadStatus.success;
        notifyListeners();
      },
    );
  }
}
