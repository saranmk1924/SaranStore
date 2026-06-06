import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:saranstore/core/common_widget/ss_shimmer.dart';
import 'package:saranstore/core/constant/app_palette.dart';
import 'package:saranstore/feature/home/presentation/bloc/home_state.dart';
import 'package:saranstore/feature/home/presentation/pages/mobile/add_product_dialog.dart';
import 'package:saranstore/feature/home/presentation/pages/mobile/delete_confirmation_dialog.dart';

import '../../domain/entity/product_entity.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;
  final HomeLoaded state;
  final TextEditingController searchProductController;

  const ProductCard({
    super.key,
    required this.product,
    required this.state,
    required this.searchProductController,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(product.id),
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        extentRatio: 0.75,
        children: [
          SlidableAction(
            onPressed: (value) {
              AddProductDialog().addProduct(
                context: context,
                selectedCategory: state.selectedCategory!,
                searchProductController: searchProductController,
                title: product.title,
                thumbnail: product.thumbnail,
                price: product.price,
                id: product.id,
                rating: product.rating,
              );
            },
            backgroundColor: AppPalette.primaryColor,
            foregroundColor: AppPalette.orange,
            icon: Icons.edit,
            label: 'Edit',
          ),
          SlidableAction(
            onPressed: (value) {
              DeleteConfirmationDialog().showDialogBox(
                context: context,
                product: product,
              );
             
            },
            backgroundColor: AppPalette.primaryColor,
            foregroundColor: AppPalette.red,
            label: 'Delete',
            icon: Icons.delete,
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppPalette.primaryColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppPalette.secondaryColor, width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: product.thumbnail,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    memCacheWidth: null,
                    memCacheHeight: null,
                    useOldImageOnUrlChange: false,
                    placeholder: (context, url) => SsShimmer(),
                    errorWidget: (context, url, error) {
                      return Icon(
                        Icons.broken_image,
                        color: AppPalette.grey,
                        size: 80,
                      );
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppPalette.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) {
                          return const LinearGradient(
                            colors: [
                              AppPalette.secondaryColor,
                              AppPalette.orange,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds);
                        },
                        child: Text(
                          '\$${product.price}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.star,
                            size: 16,
                            color: AppPalette.secondaryColor,
                          ),
                          const SizedBox(width: 1),
                          Text(
                            product.rating.toString(),
                            style: TextStyle(color: AppPalette.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
