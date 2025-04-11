import 'package:flutter/material.dart';
import 'package:flutter_app/core/configs/app_configs.dart';
import 'package:flutter_app/data/models/entities/movie_entity.dart';
import 'package:flutter_app/data/models/enums/load_status.dart';
import 'package:flutter_app/data/repositories/movie_repository.dart';
import 'package:provider/provider.dart';

import 'movie_list_navigator.dart';
import 'movie_list_vm.dart';
import 'widgets/movie_widget.dart';

class MovieListPage extends StatelessWidget {
  const MovieListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MovieListVM>(
      create: (BuildContext context) {
        return MovieListVM(
          navigator: MovieListNavigator(context: context),
          movieRepo: context.read<MovieRepository>(),
        );
      },
      child: const _MoviesListChildPage(),
    );
  }
}

class _MoviesListChildPage extends StatefulWidget {
  const _MoviesListChildPage();

  @override
  State<_MoviesListChildPage> createState() => _MoviesListChildPageState();
}

class _MoviesListChildPageState extends State<_MoviesListChildPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieListVM>().loadInitialMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movies"),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Selector<MovieListVM, LoadStatus>(
      builder: (context, loadStatus, _) {
        switch (loadStatus) {
          case LoadStatus.initial:
            return Container();
          case LoadStatus.loading:
            return _buildLoadingList();
          case LoadStatus.success:
            return _buildMoviesList();
          case LoadStatus.failure:
            return _buildMoviesList();
        }
      },
      selector: (_, viewModel) => viewModel.loadInitialMoviesStatus,
    );
  }

  Widget _buildLoadingList() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildMoviesList() {
    return Selector<MovieListVM, List<MovieEntity>>(
      builder: (context, movies, _) {
        return RefreshIndicator(
          onRefresh: _onRefreshData,
          child: ListView.separated(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemBuilder: (context, index) {
              final movie = movies[index];
              return MovieWidget(
                movie: movie,
                onPressed: () {
                  context.read<MovieListVM>().onMovieTap(movie);
                },
              );
            },
            itemCount: movies.length,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 20);
            },
          ),
        );
      },
      selector: (_, viewModel) => viewModel.movies,
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll); // Remove listener first
    _scrollController.dispose(); // Then dispose the controller
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= AppConfigs.scrollThreshold) {
      context.read<MovieListVM>().loadMoreMovies();
    }
  }

  Future<void> _onRefreshData() async {
    context.read<MovieListVM>().loadInitialMovies();
  }
}
