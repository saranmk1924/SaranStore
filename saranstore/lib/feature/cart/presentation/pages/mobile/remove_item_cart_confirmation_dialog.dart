import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:go_router/go_router.dart';
import 'package:saranstore/core/common_widget/ss_button.dart';
import 'package:saranstore/core/common_widget/ss_snackbar.dart';
import 'package:saranstore/core/constant/app_palette.dart';
import 'package:saranstore/feature/cart/domain/entity/cart_item_entity.dart';
import 'package:saranstore/feature/cart/presentation/bloc/cart_bloc.dart';
import 'package:saranstore/feature/cart/presentation/bloc/cart_event.dart';

class RemoveItemCartConfirmationDialog {
  void showDialogBox({
    required BuildContext context,
    required CartItemEntity product,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: AppPalette.transparent,
          child: GlassmorphicContainer(
            width: 310,
            height: 230,
            borderRadius: 12,
            linearGradient: LinearGradient(
              colors: [AppPalette.primaryColor, AppPalette.black],
            ),

            border: 4,
            blur: 3,
            borderGradient: LinearGradient(
              colors: [AppPalette.secondaryColor, AppPalette.orange],
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Text(
                        "Are you sure you want to remove this product from cart?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppPalette.secondaryColor,
                          fontSize: 22,
                        ),
                      ),
                      SizedBox(height: 25),
                      Row(
                        children: [
                          Expanded(child: SizedBox()),
                          Expanded(
                            flex: 2,
                            child: SsButton(
                              onPressed: () {
                                context.pop();
                              },
                              buttonText: 'No',
                            ),
                          ),
                          Expanded(child: SizedBox()),
                          Expanded(
                            flex: 2,
                            child: SsButton(
                              onPressed: () {
                                context.read<CartBloc>().add(
                                  RemoveProductEvent(product: product),
                                );
                                context.pop();
                                SsSnackbar().show(
                                  context: context,
                                  message:
                                      "Product removed from cart successfully",
                                );
                              },
                              buttonText: 'Yes',
                            ),
                          ),
                          Expanded(child: SizedBox()),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
