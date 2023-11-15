# Flutter & Riverpod
A flutter app using [Riverpod](https://riverpod.dev/)

## Checklist
- [x] Set **AppName** & **BundleID** / **PackageName**
- [x] Models
- [x] Networking
- [x] Page with Provider
- [x] ListView with PullToRefresh & LoadMore

## How to use
### Create a page. Ex: MovieList
movie_list_navigator.dart
```dart
class MovieListNavigator extends AppNavigator {
  MovieListNavigator({required BuildContext context}) : super(context: context);
}
```

movie_list_page.dart
```dart
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieListVM>().fetchFirstMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
```

movie_list_vm.dart
```dart
class MovieListVM extends AppViewModel {
  final MovieListNavigator navigator;
  final MovieRepository movieRepository;

  MovieListVM({
    required this.navigator,
    required this.movieRepository,
  });

  Future<void> fetchFirstMovies() async {
  }

  Future<void> fetchNextMovies() async {
  }
}
```
### Create a view. Ex: MovieWidget
- Should be placed in `widgets` folder.
- Should be a `StateLess`
```dart
class MovieWidget extends StatelessWidget {
  final MovieEntity movie;
  final VoidCallback? onPressed;

  const MovieWidget({
    Key? key,
    required this.movie,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }
}
```

## Other rules
* New repository should be placed in `MultiProvider` in `app.dart` . And use `context.read<T>()` to read.
* All setup/init in ViewModel have to run after the Widget tree is created. Read it first: https://pub.dev/packages/provider.
* Run lint and format code before commit. Run `code_linter` and fix before commit
* Follow the naming convention
  * Screen should have the suffix `_page`
  * Custom View should have the suffix `_widget`
  * Data Object should have the suffix `_entity`
  * Data List should have the suffix `s`
* Follow [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) & [Git Branching](https://dev.to/couchcamote/git-branching-name-convention-cch)
