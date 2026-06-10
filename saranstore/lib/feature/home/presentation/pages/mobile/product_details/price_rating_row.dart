import 'package:flutter/material.dart';
import 'package:saranstore/core/constant/app_palette.dart';
import 'package:saranstore/feature/home/domain/entity/product_entity.dart';

class PriceRatingRow extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback? onPressed;
  const PriceRatingRow({super.key, required this.product, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ShaderMask(
            shaderCallback: (bounds) {
              return const LinearGradient(
                colors: [AppPalette.secondaryColor, AppPalette.orange],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds);
            },
            child: Text(
              '\$${product.price.toString().contains('.') ? '${product.price.toString().split('.').first}.${product.price.toString().split('.').last.substring(0, 1)}' : product.price.toString().substring(0, 6)}',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),

          GestureDetector(
            onTap: onPressed,
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(color: AppPalette.secondaryColor),
                borderRadius: BorderRadius.circular(8),
                color: const Color.fromARGB(47, 255, 172, 64),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.star,
                    size: 24,
                    color: AppPalette.secondaryColor,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    product.rating.toString(),
                    style: TextStyle(color: AppPalette.white, fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
