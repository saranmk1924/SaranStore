import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saranstore/core/constant/app_palette.dart';
import 'package:saranstore/core/router/route_names.dart';

class HeaderRow extends StatelessWidget {
  final bool isCartPage;
  const HeaderRow({super.key, this.isCartPage=false});

  @override
  Widget build(BuildContext context) {
   
    return Stack(
      alignment: Alignment.center,
      children: [
        /// Left & Right Items
        Row(
          mainAxisAlignment: isCartPage
              ? MainAxisAlignment.start
              : MainAxisAlignment.spaceBetween,
          children: [
            ClipOval(
              child: Image.asset(
                'assets/pngs/app_logo.png',
                width: 45,
                height: 45,
                fit: BoxFit.cover,
              ),
            ),

            isCartPage
                ? SizedBox.shrink()
                : GestureDetector(
                    onTap: () {
                      context.push(RouteNames.cart);
                    },
                    child: const Icon(
                      Icons.shopping_cart_outlined,
                      color: AppPalette.white,
                    ),
                  ),
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
