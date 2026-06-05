import 'package:flutter/material.dart';
import 'package:saranstore/core/constant/app_palette.dart';

class HeaderRow extends StatelessWidget {
  const HeaderRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
          alignment: Alignment.center,
          children: [
            /// Left & Right Items
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipOval(
                  child: Image.asset(
                    'assets/pngs/app_logo.png',
                    width: 45,
                    height: 45,
                    fit: BoxFit.cover,
                  ),
                ),

                const Icon(Icons.shopping_cart_outlined, color: AppPalette.white),
              ],
            ),

            /// Center Title
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
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
  }
}