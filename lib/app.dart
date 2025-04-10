import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/injection/repository_providers.dart';
import 'package:provider/provider.dart';

import 'core/configs/app_configs.dart';
import 'navigation/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Setup PortraitUp only
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiProvider(
      providers: [
        ...createRepositoryProviders(),
      ],
      child: GestureDetector(
        onTap: () {
          _hideKeyboard(context);
        },
        child: MaterialApp.router(
          title: AppConfigs.appName,
          theme: ThemeData.light(useMaterial3: true),
          themeMode: ThemeMode.light,
          routerConfig: AppRouter.router,
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
