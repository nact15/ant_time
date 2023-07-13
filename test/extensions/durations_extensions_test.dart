import 'package:ant_time_flutter/resources/resources.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(('StringExtensionTest'), () {
    test('Format duration without seconds', () {
      const Duration duration = Duration(hours: 3, minutes: 45);
      final String formattedDate = duration.formatDurationWithoutSeconds;
      expect(formattedDate, '03:45');
    });
  });
  test('Format duration with seconds', () {
    const Duration duration = Duration(
      hours: 3,
      minutes: 45,
      seconds: 7,
    );
    final String formattedDate = duration.formatDuration;
    expect(formattedDate, '03:45:07');
  });
  test('Subtract duration', () {
    const Duration firstDuration = Duration(seconds: 55);
    const Duration secondDuration = Duration(seconds: 34);
    final Duration subtract = firstDuration.subtractDuration(secondDuration);
    expect(subtract, const Duration(seconds: 21));
  });
  test('Add duration', () {
    const Duration firstDuration = Duration(seconds: 7);
    const Duration secondDuration = Duration(seconds: 34);
    final Duration add = firstDuration.addDuration(secondDuration);
    expect(add, const Duration(seconds: 41));
  });
}
