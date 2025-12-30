import 'package:flutter/material.dart';

abstract class PackageColors {
  static ThemeData _themeData(BuildContext context) => Theme.of(context);

  static Color transparent = Colors.transparent;

  static Color primary(BuildContext context) {
    return _themeData(context).colorScheme.primary;
  }

  static Color secondary(BuildContext context) {
    return _themeData(context).colorScheme.secondary;
  }

  static Color error(BuildContext context) {
    return _themeData(context).colorScheme.error;
  }

  static Color disabled(BuildContext context) {
    return _themeData(context).disabledColor;
  }
}
