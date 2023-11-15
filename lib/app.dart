import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/repositories/movie_repository.dart';
import 'package:flutter_app/ui/pages/splash/splash_page.dart';
import 'package:provider/provider.dart';

import 'configs/app_configs.dart';
import 'network/api_client.dart';
import 'network/api_util.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  late ApiClient _apiClient;

  @override
  void initState() {
    _apiClient = ApiUtil.apiClient;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Setup PortraitUp only
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiProvider(
      providers: [
        //Define repositories
        Provider<MovieRepository>(
            create: (_) => MovieRepositoryImpl(apiClient: _apiClient)),
        //Define global ViewModels
      ],
      child: GestureDetector(
        onTap: () {
          _hideKeyboard(context);
        },
        child: MaterialApp(
          title: AppConfigs.appName,
          theme: ThemeData.light(useMaterial3: true),
          themeMode: ThemeMode.light,
          home: const SplashPage(),
        ),
      ),
    );
  }

  void _hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
