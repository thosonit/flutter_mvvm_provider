# Flutter Project Template with MVVM Architecture

## Project Structure

```
your_flutter_project/
├── lib/                             # Main source code directory
│   ├── main.dart                    # App entry point, sets up DI/Provider scope
│   ├── app.dart                     # Root widget, theme, and router configuration
│   │
│   ├── core/                        # Shared code, not specific to any feature
│   │   ├── constants/               # App-wide constants (e.g., strings, colors, API endpoints)
│   │   ├── error/                   # Error handling (e.g., exceptions, failures)
│   │   ├── network/                 # Base network client configuration
│   │   ├── services/                # Shared services (e.g., logging, analytics)
│   │   ├── theme/                   # Theme definitions (e.g., colors, typography)
│   │   ├── utils/                   # Utility functions and extensions
│   │   └── widgets/                 # Common reusable widgets (e.g., buttons, loaders)
│   │
│   ├── data/                        # Data layer (models, repositories, data sources)
│   │   ├── datasources/             # Concrete data sources
│   │   │   ├── local/               # Local data access (e.g., SQLite, SharedPreferences)
│   │   │   └── remote/              # Remote data access (e.g., API services)
│   │   ├── models/                  # Data structure definitions (e.g., DTOs, entities)
│   │   └── repositories/            # Data abstraction layer (interfaces and implementations)
│   │
│   ├── features/                    # Main application features
│   │   ├── intro/                   # Example: Intro feature
│   │   │   ├── splash/              # Splash screen feature
│   │   │   │   ├── splash_page.dart # Splash screen UI
│   │   │   │   ├── splash_vm.dart   # Splash screen ViewModel
│   │   │   │   └── splash_navigator.dart # Splash screen navigation logic
│   │   ├── movie/                   # Example: Movie feature
│   │   │   ├── movie_list/          # Movie list feature
│   │   │   │   ├── movie_list_page.dart # Movie list UI
│   │   │   │   ├── movie_list_vm.dart   # Movie list ViewModel
│   │   │   │   ├── movie_list_navigator.dart # Movie list navigation logic
│   │   │   │   └── widgets/         # Widgets specific to the movie list feature
│   │   │   │       └── movie_widget.dart # Custom widget for displaying a movie
│   │
│   ├── navigation/                  # Navigation management
│   │   └── app_router.dart          # Route configuration (e.g., GoRouter setup)
│   │
│   └── di.dart                      # Dependency injection setup (e.g., GetIt, Provider)
│
├── test/                            # Test files (unit, widget, integration)
│   ├── features/                    # Tests for features
│   │   └── movie/                   # Example: Movie feature tests
│   │       └── movie_list_vm_test.dart # Unit test for MovieListVM
│   ├── core/                        # Tests for core utilities and services
│   └── data/                        # Tests for data layer (e.g., repositories, models)
│
├── assets/                          # Static resources (e.g., images, fonts)
│   ├── images/                      # Image assets
│   └── fonts/                       # Font assets
│
├── pubspec.yaml                     # Dependency and asset management file
└── ...                              # Other configuration files (e.g., analysis_options.yaml)
```

## How to use

### Create a page. Ex: MovieList

`movie_list_navigator.dart`

```dart
class MovieListNavigator extends AppNavigator {
  MovieListNavigator({required BuildContext context}) : super(context: context);
}
```

`movie_list_page.dart`

```dart
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

`movie_list_vm.dart`

```dart
class MovieListVM extends AppViewModel {
  // Navigator
  final MovieListNavigator navigator;

  // Repositories
  final MovieRepository movieRepo;

  // Properties
  LoadStatus get loadInitialMoviesStatus => _loadInitialMoviesStatus;
  LoadStatus _loadInitialMoviesStatus = LoadStatus.initial;

  MovieListVM({
    required this.navigator,
    required this.movieRepo,
  });

  Future<void> loadInitialMovies() async {
  }

  Future<void> loadMoreMovies() async {
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

* New repository should be placed in `MultiProvider` in `app.dart`.
* Use only `Selector` to reduce rebuild UI when ViewModel is updated.
* All setup/init in ViewModel must run after the Widget tree is created. Read it
  first: https://pub.dev/packages/provider.
* Run lint and format code before committing. Run `code_linter` and fix all issues before
  committing.
* Follow the naming convention:
    * Screens should have the suffix `_page`.
    * Custom Views should have the suffix `_widget`.
    * Data Objects should have the suffix `_entity`.
    * Data Lists should have the suffix `List` or `s`.
*

Follow [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) & [Git Branching](https://dev.to/couchcamote/git-branching-name-convention-cch).

* Avoid using hardcoded strings; place them in the `core/constants` folder.
* Ensure all public methods and classes are documented with comments.
* Write unit tests for all ViewModels and repositories.