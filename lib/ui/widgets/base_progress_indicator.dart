import 'package:flutter/material.dart';

class BaseProgressIndicator extends StatelessWidget {
  final Color color;
  const BaseProgressIndicator({this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: color,
      strokeWidth: 3,
    );
  }
}
