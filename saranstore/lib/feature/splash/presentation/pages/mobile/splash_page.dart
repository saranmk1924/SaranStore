import 'dart:math';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:saranstore/core/constant/app_palette.dart';
import 'package:saranstore/feature/home/presentation/pages/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _clockwiseController;
  late AnimationController _antiClockwiseController;

  @override
  void initState() {
    super.initState();

    _clockwiseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    _antiClockwiseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
  }

  @override
  void dispose() {
    _clockwiseController.dispose();
    _antiClockwiseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 4000,
      backgroundColor: AppPalette.primaryColor,
      splashIconSize: 380,

      splash: AnimatedBuilder(
        animation: Listenable.merge([
          _clockwiseController,
          _antiClockwiseController,
        ]),
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              // Outer Ring (Clockwise)
              Transform.rotate(
                angle: _clockwiseController.value * 2 * pi,
                child: CustomPaint(
                  size: const Size(340, 340),
                  painter: DottedCirclePainter(dotCount: 48, dotRadius: 4),
                ),
              ),

              // Inner Ring (Anti-Clockwise)
              Transform.rotate(
                angle: -_antiClockwiseController.value * 2 * pi,
                child: CustomPaint(
                  size: const Size(280, 280),
                  painter: DottedCirclePainter(dotCount: 36, dotRadius: 3.5),
                ),
              ),

              // Logo
              ClipOval(
                child: Image.asset('assets/pngs/app_logo_2.png', width: 240),
              ),
            ],
          );
        },
      ),

      nextScreen: const HomePage(),
      pageTransitionType: PageTransitionType.bottomToTop,
      animationDuration: const Duration(milliseconds: 1000),
    );
  }
}

class DottedCirclePainter extends CustomPainter {
  final int dotCount;
  final double dotRadius;

  DottedCirclePainter({required this.dotCount, required this.dotRadius});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppPalette.secondaryColor
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;

    for (int i = 0; i < dotCount; i++) {
      final angle = (2 * pi * i) / dotCount;

      final x = center.dx + radius * cos(angle);
      final y = center.dy + radius * sin(angle);

      // Alternate dot sizes for a premium look
      final currentRadius = i % 4 == 0 ? dotRadius * 1.6 : dotRadius;

      canvas.drawCircle(Offset(x, y), currentRadius, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
