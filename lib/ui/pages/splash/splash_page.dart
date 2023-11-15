import 'package:flutter/material.dart';
import 'package:flutter_app/common/app_colors.dart';
import 'package:flutter_app/ui/pages/splash/splash_navigator.dart';
import 'package:flutter_app/ui/pages/splash/splash_view_model.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SplashViewModel>(
      create: (BuildContext context) {
        return SplashViewModel(
          navigator: SplashNavigator(context: context),
        );
      },
      child: const SplashChildPage(),
    );
  }
}

class SplashChildPage extends StatefulWidget {
  const SplashChildPage({Key? key}) : super(key: key);

  @override
  State<SplashChildPage> createState() => _SplashChildPageState();
}

class _SplashChildPageState extends State<SplashChildPage> {
  late SplashViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = Provider.of<SplashViewModel>(context, listen: false);
    _viewModel.checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
