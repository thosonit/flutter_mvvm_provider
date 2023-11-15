import 'package:flutter/material.dart';
import 'package:flutter_app/common/app_colors.dart';
import 'package:flutter_app/ui/pages/splash/splash_navigator.dart';
import 'package:flutter_app/ui/pages/splash/splash_vm.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SplashVM>(
      create: (BuildContext context) {
        return SplashVM(
          navigator: SplashNavigator(context: context),
        );
      },
      child: const _SplashChildPage(),
    );
  }
}

class _SplashChildPage extends StatefulWidget {
  const _SplashChildPage({Key? key}) : super(key: key);

  @override
  State<_SplashChildPage> createState() => _SplashChildPageState();
}

class _SplashChildPageState extends State<_SplashChildPage> {
  @override
  void initState() {
    super.initState();
    context.read<SplashVM>().checkLogin();
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
