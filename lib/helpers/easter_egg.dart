import 'package:ant_time_flutter/resources/resources.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';

class EasterEgg extends StatelessWidget {
  final ConfettiController controller;

  const EasterEgg({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConfettiWidget(
        confettiController: controller,
        blastDirectionality: BlastDirectionality.explosive,
        shouldLoop: false,
        colors: const [
          AppColors.primaryColor,
          AppColors.secondaryColor,
          AppColors.errorColor,
        ],
        particleDrag: 0.05,
        numberOfParticles: 30,
        createParticlePath: _drawHeart,
      ),
    );
  }

  Path _drawHeart(Size size) {
    double width = size.width;
    double height = size.height;

    Path path = Path();
    path.moveTo(width * 0.5, height * 0.35);
    path.cubicTo(
      width * 0.2,
      height * 0.1,
      -0.25 * width,
      height * 0.6,
      width * 0.5,
      height,
    );
    path.moveTo(width * 0.5, height * 0.35);
    path.cubicTo(
      width * 0.8,
      height * 0.1,
      width * 1.25,
      height * 0.6,
      width * 0.5,
      height,
    );
    path.close();

    return path;
  }
}
