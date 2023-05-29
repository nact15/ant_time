extension DurationExtension on Duration {
  String get formatDuration {
    return '${inHours.toString().padLeft(2, '0')}'
        ':${inMinutes.remainder(60).toString().padLeft(2, '0')}:'
        '${(inSeconds.remainder(60).toString().padLeft(2, '0'))}';
  }

  String get formatDurationWithoutSeconds {
    return '${inHours.toString().padLeft(2, '0')}'
        ':${inMinutes.remainder(60).toString().padLeft(2, '0')}';
  }

  Duration subtractDuration(Duration duration) {
    return Duration(seconds: inSeconds - duration.inSeconds);
  }

  Duration addDuration(Duration duration) {
    return Duration(seconds: inSeconds + duration.inSeconds);
  }
}
