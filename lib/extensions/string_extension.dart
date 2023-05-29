extension StringExtension on String {
  T use<T>(T Function(String s) f) {
    return f(this);
  }

  String get limitedLink {
    if (length > 15) {
      return substring(0, 11) + '..' + substring(indexOf('.'));
    }

    return this;
  }
}
