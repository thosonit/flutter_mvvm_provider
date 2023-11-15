import 'package:flutter_app/common/app_view_model.dart';
import 'package:flutter_app/models/entities/movie_entity.dart';
import 'package:flutter_app/models/enums/load_status.dart';
import 'package:flutter_app/repositories/movie_repository.dart';

import 'movie_list_navigator.dart';

class MovieListVM extends AppViewModel {
  final MovieListNavigator navigator;
  final MovieRepository movieRepository;

  LoadStatus _fetchFirstMovieStatus = LoadStatus.initial;
  LoadStatus _fetchNextMovieStatus = LoadStatus.initial;
  final _movies = <MovieEntity>[];
  int _currentPage = 1;

  LoadStatus get fetchFirstMovieStatus => _fetchFirstMovieStatus;

  LoadStatus get fetchNextMovieStatus => _fetchNextMovieStatus;

  List<MovieEntity> get movies => _movies;

  MovieListVM({
    required this.navigator,
    required this.movieRepository,
  });

  Future<void> fetchFirstMovies() async {
    _fetchFirstMovieStatus = LoadStatus.loading;
    _currentPage = 1;
    notifyListeners();
    try {
      final result = await movieRepository.getMovies(page: _currentPage);
      _movies.clear();
      _movies.addAll(result.results);
      _fetchFirstMovieStatus = LoadStatus.success;
      notifyListeners();
    } catch (e) {
      _fetchFirstMovieStatus = LoadStatus.failure;
      notifyListeners();
    }
  }

  Future<void> fetchNextMovies() async {
    _fetchNextMovieStatus = LoadStatus.loading;
    notifyListeners();
    try {
      final result = await movieRepository.getMovies(page: _currentPage + 1);
      _currentPage = result.page;
      _movies.addAll(result.results);
      _fetchNextMovieStatus = LoadStatus.success;
      notifyListeners();
    } catch (e) {
      _fetchNextMovieStatus = LoadStatus.failure;
      notifyListeners();
    }
  }
}
