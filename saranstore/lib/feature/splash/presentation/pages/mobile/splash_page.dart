// import 'package:animated_splash_screen/animated_splash_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:saranstore/core/constant/app_palette.dart';
// import 'package:saranstore/feature/home/presentation/pages/home_page.dart';

// class SplashPage extends StatelessWidget {
//   const SplashPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedSplashScreen(
//       duration: 4000,
//       splash: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           ClipOval(
//             child: Image.asset('assets/pngs/app_logo_2.png', width: 240),
//           ),
//         ],
//       ),

//       nextScreen: const HomePage(),

//       splashIconSize: 310,

//       backgroundColor: AppPalette.primaryColor,

//       pageTransitionType: PageTransitionType.bottomToTop,

//       animationDuration: const Duration(milliseconds: 700),
//     );
//   }
// }

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

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    // Start effect after 700ms
    Future.delayed(const Duration(milliseconds: 700), () {
      if (mounted) {
        _controller.repeat();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 4000,

      splash: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              // Animated glowing circle effect
              Container(
                width: 260 + (_controller.value * 40),
                height: 260 + (_controller.value * 40),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppPalette.secondaryColor,
                ),
              ),

              // Main logo
              ClipOval(
                child: Image.asset('assets/pngs/app_logo_2.png', width: 240),
              ),
            ],
          );
        },
      ),

      nextScreen: const HomePage(),

      splashIconSize: 320,

      backgroundColor: AppPalette.primaryColor,

      pageTransitionType: PageTransitionType.bottomToTop,

      animationDuration: const Duration(milliseconds: 700),
    );
  }
}
