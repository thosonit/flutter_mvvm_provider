import 'package:flutter_app/core/network/api_util.dart';
import 'package:flutter_app/data/repositories/movie_repository.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> createRepositoryProviders() {
  final apiClient = ApiUtil.apiClient;
  return [
    //Define repositories
    Provider<MovieRepository>(
        create: (_) => MovieRepositoryImpl(apiClient: apiClient)),
    //Define global ViewModels
  ];
}
