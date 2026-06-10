import 'package:flutter/material.dart';
import 'package:saranstore/core/constant/app_palette.dart';
import 'package:saranstore/feature/home/domain/entity/product_entity.dart';

class DescriptionRow extends StatelessWidget {
  final ProductEntity product;
  const DescriptionRow({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5, left: 20, right: 20, top: 7),
      child: Row(
        children: [
          Flexible(
            child: Text(
              product.description ?? '',
              overflow: TextOverflow.ellipsis,
              maxLines: 6,
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 18, color: AppPalette.white),
            ),
          ),
        ],
      ),
    );
  }
}
