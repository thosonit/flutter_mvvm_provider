import 'package:flutter/material.dart';

class AppNavigator {
  BuildContext context;

  AppNavigator({required this.context});

  void pop<T extends Object?>([T? result]) {
    Navigator.of(context).pop(result);
  }
}
