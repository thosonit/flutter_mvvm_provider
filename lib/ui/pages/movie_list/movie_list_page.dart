import 'package:flutter/material.dart';
import 'package:flutter_app/models/entities/movie_entity.dart';
import 'package:flutter_app/models/enums/load_status.dart';
import 'package:flutter_app/repositories/movie_repository.dart';
import 'package:flutter_app/ui/pages/movie_list/movie_list_navigator.dart';
import 'package:provider/provider.dart';

import '../../../configs/app_configs.dart';
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
          movieRepository: context.read<MovieRepository>(),
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
      context.read<MovieListVM>().fetchFirstMovies();
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
      selector: (_, viewModel) => viewModel.fetchFirstMovieStatus,
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
                  //Todo
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
    // final movies = context.read<MovieListVM>().movies;
    // return RefreshIndicator(
    //   onRefresh: _onRefreshData,
    //   child: ListView.separated(
    //     controller: _scrollController,
    //     padding: const EdgeInsets.symmetric(horizontal: 20),
    //     itemBuilder: (context, index) {
    //       final movie = movies[index];
    //       return MovieWidget(
    //         movie: movie,
    //         onPressed: () {
    //           //Todo
    //         },
    //       );
    //     },
    //     itemCount: movies.length,
    //     separatorBuilder: (BuildContext context, int index) {
    //       return const SizedBox(height: 20);
    //     },
    //   ),
    // );
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= AppConfigs.scrollThreshold) {
      context.read<MovieListVM>().fetchNextMovies();
    }
  }

  Future<void> _onRefreshData() async {
    context.read<MovieListVM>().fetchFirstMovies();
  }
}
