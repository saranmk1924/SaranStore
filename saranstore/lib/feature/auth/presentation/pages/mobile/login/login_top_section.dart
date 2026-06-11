import 'package:flutter/material.dart';
import 'package:saranstore/core/constant/app_palette.dart';

class LoginTopSection extends StatelessWidget {
  const LoginTopSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 7,
      children: [
        Center(
          child: Hero(
            tag: 'app_logo',
            transitionOnUserGestures: true,
            child: SizedBox(
              width: 80,
              height: 80,
              child: ClipOval(child: Image.asset("assets/pngs/app_logo_2.png")),
            ),
          ),
        ),

        ShaderMask(
          shaderCallback: (bounds) {
            return const LinearGradient(
              colors: [AppPalette.secondaryColor, AppPalette.orange],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds);
          },
          child: const Text(
            'SaranStore',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: AppPalette.white,
            ),
          ),
        ),
      ],
    );
  }
}
