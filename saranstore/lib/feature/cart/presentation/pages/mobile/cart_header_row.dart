import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saranstore/core/constant/app_palette.dart';

class CartHeaderRow extends StatelessWidget {
  const CartHeaderRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        /// Left & Right Items
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 10,
          children: [
            GestureDetector(
              onTap: () {
                context.pop();
              },
              child: CircleAvatar(
                backgroundColor: AppPalette.secondaryColor,
                child: Icon(
                  Icons.arrow_back_sharp,
                  color: AppPalette.primaryColor,
                  size: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 3,
              children: [
                const Text(
                  'Cart',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
