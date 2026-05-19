import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:saranstore/core/constant/app_palette.dart';
import 'package:saranstore/feature/home/presentation/pages/home_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 4000,
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/pngs/app_logo.png', width: 240),

          // const SizedBox(height: 20),

          // ShaderMask(
          //   shaderCallback: (bounds) {
          //     return const LinearGradient(
          //       colors: [AppPalette.secondaryColor, AppPalette.orange],
          //       begin: Alignment.topLeft,
          //       end: Alignment.bottomRight,
          //     ).createShader(bounds);
          //   },
          //   child: Text(
          //     'SaranStore',
          //     style: const TextStyle(
          //       fontSize: 22,
          //       fontWeight: FontWeight.bold,
          //       color: Colors.white,
          //     ),
          //   ),
          // ),
        ],
      ),

      nextScreen: const HomePage(),

      splashIconSize: 310,

      backgroundColor: AppPalette.primaryColor,

      pageTransitionType: PageTransitionType.bottomToTop,

      animationDuration: const Duration(milliseconds: 300),
    );
  }
}
