import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:go_router/go_router.dart';
import 'package:saranstore/core/common_widget/ss_button.dart';
import 'package:saranstore/core/common_widget/ss_snackbar.dart';
import 'package:saranstore/core/constant/app_palette.dart';
import 'package:saranstore/feature/home/domain/entity/product_entity.dart';
import 'package:saranstore/feature/home/presentation/bloc/home_bloc.dart';
import 'package:saranstore/feature/home/presentation/bloc/home_event.dart';

class DeleteConfirmationDialog {
  void showDialogBox({
    required BuildContext context,
    required ProductEntity product,
    String? message,
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
                        message ??
                            "Are you sure you want to delete this product?",
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
                                context.read<HomeBloc>().add(
                                  DeleteProductEvent(productId: product.id),
                                );
                                context.pop();
                                SsSnackbar().show(
                                  context: context,
                                  message: "Product deleted successfully :)",
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
