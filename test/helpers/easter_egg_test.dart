import 'package:ant_time_flutter/helpers/easter_egg.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Confetti test', (tester) async {
    final ConfettiController controller = ConfettiController();

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: EasterEgg(controller: controller),
      ),
    ));

    final confettiFinder= find.byType(ConfettiWidget);
    expect(confettiFinder, findsOneWidget);
  });
}
