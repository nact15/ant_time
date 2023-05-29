import 'package:flutter/material.dart';

extension BuildContextExtension<T> on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;

  double get baseSizeWidthCard => MediaQuery.of(this).size.width * 0.9;

  double getBaseSizeWidthCard(double size) => MediaQuery.of(this).size.width * size;

  double getBaseSizeHeightCard(double size) => MediaQuery.of(this).size.height * size;

  ThemeData get theme => Theme.of(this);

  void pop<T>({
    bool rootNavigator = false,
    T? result,
  }) =>
      Navigator.of(this, rootNavigator: rootNavigator).pop(result);

  void maybePop() => Navigator.of(this).maybePop();

  void popUntil(
    bool Function(Route<dynamic>) predicate,
  ) =>
      Navigator.of(this).popUntil(predicate);

  void unfocus() => FocusScope.of(this).unfocus();

  bool get isPortrait => MediaQuery.of(this).orientation == Orientation.portrait;

  double get calculateTimerFontSize => ((screenSize.width / 10) <= 100) ? screenSize.width / 10 : 100;

  void openDrawer() => Scaffold.of(this).openDrawer();
}
