import 'package:flutter/material.dart';

class BaseNavigator {
  BuildContext context;

  BaseNavigator({required this.context});

  void pop<T extends Object?>([T? result]) {
    Navigator.of(context).pop(result);
  }
}
