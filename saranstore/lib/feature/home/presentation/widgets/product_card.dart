import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:saranstore/core/common_widget/ss_button.dart';
import 'package:saranstore/core/common_widget/ss_shimmer.dart';
import 'package:saranstore/core/common_widget/ss_snackbar.dart';
import 'package:saranstore/core/constant/app_palette.dart';
import 'package:saranstore/feature/cart/domain/entity/cart_item_entity.dart';
import 'package:saranstore/feature/cart/presentation/bloc/cart_bloc.dart';
import 'package:saranstore/feature/cart/presentation/bloc/cart_event.dart';
import 'package:saranstore/feature/cart/presentation/pages/mobile/remove_item_cart_confirmation_dialog.dart';
import 'package:saranstore/feature/home/presentation/bloc/home_state.dart';
import 'package:saranstore/feature/home/presentation/pages/mobile/add_product_dialog.dart';
import 'package:saranstore/feature/home/presentation/pages/mobile/delete_confirmation_dialog.dart';

import '../../domain/entity/product_entity.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;
  final HomeLoaded state;
  final TextEditingController searchProductController;
  final CartItemEntity? cartItem;

  const ProductCard({
    super.key,
    required this.product,
    required this.state,
    required this.searchProductController,
    this.cartItem,
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
                price: product.price.toString().contains('.')
                    ? double.tryParse(
                            '${product.price.toString().split('.').first}.${product.price.toString().split('.').last.substring(0, 1)}',
                          ) ??
                          0.0
                    : double.tryParse(
                            product.price.toString().substring(0, 6),
                          ) ??
                          0.0,
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
                          '\$${product.price.toString().contains('.') ? '${product.price.toString().split('.').first}.${product.price.toString().split('.').last.substring(0, 1)}' : product.price.toString().substring(0, 6)}',
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

            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
              child: SizedBox(
                height: 45,
                child: AnimatedSwitcher(
                  duration: Duration(microseconds: 500),
                  child: cartItem != null
                      ? _cartCounterWidget(
                          cartItem: cartItem!,
                          context: context,
                        )
                      : Center(
                          child: SsButton(
                            onPressed: () {
                              context.read<CartBloc>().add(
                                AddProductEvent(
                                  product: CartItemEntity(
                                    product: product,
                                    quantity: 1,
                                  ),
                                ),
                              );
                              SsSnackbar().show(
                                context: context,
                                message:
                                    "Product added to cart successfully :)",
                              );
                            },
                            buttonText: "Add to cart",
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cartCounterWidget({
    required BuildContext context,
    required CartItemEntity cartItem,
  }) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            RemoveItemCartConfirmationDialog().showDialogBox(
              context: context,
              product: cartItem,
            );
          },
          child: Icon(Icons.delete, color: AppPalette.red),
        ),
        Spacer(),
        GestureDetector(
          onTap: () {
            if (cartItem.quantity == 1) {
              RemoveItemCartConfirmationDialog().showDialogBox(
                context: context,
                product: cartItem,
              );
            } else {
              context.read<CartBloc>().add(
                DecreaseProductQuantityEvent(productId: product.id),
              );
            }
          },
          child: Icon(Icons.remove_circle_outlined, color: AppPalette.orange),
        ),
        SizedBox(width: 10),
        Text(
          cartItem.quantity.toString(),
          style: TextStyle(color: AppPalette.secondaryColor, fontSize: 18),
        ),
        SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            context.read<CartBloc>().add(
              IncreaseProductQuantityEvent(productId: product.id),
            );
          },
          child: Icon(
            Icons.add_circle_outlined,
            color: cartItem.quantity >= 10
                ? AppPalette.grey
                : AppPalette.orange,
            fontWeight: FontWeight.w100,
          ),
        ),
      ],
    );
  }
}
