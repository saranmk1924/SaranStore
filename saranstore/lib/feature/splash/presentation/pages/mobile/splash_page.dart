import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saranstore/core/constant/app_images.dart';
import 'package:saranstore/core/constant/app_palette.dart';
import 'package:saranstore/core/router/route_names.dart';

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

    _navigateToLogin();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    precacheImage(AppImages.logo, context);
  }

  @override
  void dispose() {
    _clockwiseController.dispose();
    _antiClockwiseController.dispose();
    super.dispose();
  }

  Future<void> _navigateToLogin() async {
    await Future.delayed(Duration(seconds: 4));
    _clockwiseController.stop();
    _antiClockwiseController.stop();

    // await Future.delayed(const Duration(milliseconds: 300));
    if (mounted) {
      context.pushReplacement(
        RouteNames.login,
        extra: {'is_from_splash': true},
      );
    }
  }

  // Future<void> _navigateToHome() async {
  //   await Future.delayed(Duration(seconds: 4));

  //   if (mounted) {
  //     context.go(RouteNames.home);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppPalette.primaryColor,
        body: Center(
          child: AnimatedBuilder(
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
                  Hero(
                    tag: 'app_logo',
                    transitionOnUserGestures: true,
                    child: Material(
                      color: AppPalette.transparent,
                      child: ClipOval(
                        child: Image.asset(
                          'assets/pngs/app_logo_2.png',
                          width: 240,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
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
