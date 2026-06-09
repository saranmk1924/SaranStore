import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:saranstore/core/constant/app_palette.dart';
import 'package:saranstore/feature/cart/presentation/bloc/cart_state.dart';

class CartTotalWidget extends StatelessWidget {
  final CartLoaded state;
  const CartTotalWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 14.0, left: 14, bottom: 16, top: 4),
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          radius: Radius.circular(16),
          strokeWidth: 3,
          color: AppPalette.secondaryColor,
          dashPattern: [3, 4],
        ),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  spacing: 5,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      color: AppPalette.secondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                    Text(
                      "Total (${state.quantity} items)",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppPalette.secondaryColor,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),

                ShaderMask(
                  shaderCallback: (bounds) {
                    return const LinearGradient(
                      colors: [AppPalette.secondaryColor, AppPalette.orange],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds);
                  },
                  child: Text(
                    state.totalPrice.toString().contains('.')
                        ? '\$ ${state.totalPrice.toString().split('.').first}.${state.totalPrice.toString().split('.').last.substring(0, 1)}'
                        : "\$ ${state.totalPrice}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppPalette.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
