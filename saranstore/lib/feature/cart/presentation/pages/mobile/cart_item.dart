import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:saranstore/core/common_widget/ss_shimmer.dart';
import 'package:saranstore/core/constant/app_palette.dart';
import 'package:saranstore/core/router/route_names.dart';
import 'package:saranstore/feature/cart/domain/entity/cart_item_entity.dart';
import 'package:saranstore/feature/cart/presentation/bloc/cart_bloc.dart';
import 'package:saranstore/feature/cart/presentation/bloc/cart_event.dart';
import 'package:saranstore/feature/cart/presentation/bloc/cart_state.dart';
import 'package:saranstore/feature/cart/presentation/pages/mobile/remove_item_cart_confirmation_dialog.dart';

class CartItem extends StatelessWidget {
  final CartItemEntity cartItem;
  final CartLoaded state;
  const CartItem({super.key, required this.cartItem, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppPalette.primaryColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppPalette.secondaryColor, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                context.push(
                  '${RouteNames.productDetails}/${cartItem.product.id}',
                  extra: cartItem.product,
                );
              },
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: cartItem.product.thumbnail,
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
                          cartItem.product.title,
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
                                '\$${cartItem.product.price.toString().contains('.') ? '${cartItem.product.price.toString().split('.').first}.${cartItem.product.price.toString().split('.').last.substring(0, 1)}' : cartItem.product.price.toString().substring(0, 6)}',
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
                                  cartItem.product.rating.toString(),
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
          ),

          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
            child: SizedBox(
              height: 35,
              child: _cartCounterWidget(cartItem: cartItem, context: context),
            ),
          ),
        ],
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
                DecreaseProductQuantityEvent(productId: cartItem.product.id),
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
              IncreaseProductQuantityEvent(productId: cartItem.product.id),
            );
          },
          child: Tooltip(
            message: cartItem.quantity >= 10 ? 'No more stock available' : '',
            child: Icon(
              Icons.add_circle_outlined,
              color: cartItem.quantity >= 10
                  ? AppPalette.grey
                  : AppPalette.orange,
              fontWeight: FontWeight.w100,
            ),
          ),
        ),
      ],
    );
  }
}
