import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saranstore/core/constant/app_palette.dart';
import 'package:saranstore/feature/cart/presentation/bloc/cart_bloc.dart';
import 'package:saranstore/feature/cart/presentation/bloc/cart_state.dart';
import 'package:saranstore/feature/cart/presentation/pages/mobile/cart_header_row.dart';
import 'package:saranstore/feature/cart/presentation/pages/mobile/cart_item.dart';
import 'package:saranstore/feature/cart/presentation/pages/mobile/cart_total_widget.dart';
import 'package:saranstore/feature/home/presentation/pages/mobile/no_result_found.dart';

class MobileCartView extends StatefulWidget {
  const MobileCartView({super.key});

  @override
  State<MobileCartView> createState() => _MobileCartViewState();
}

class _MobileCartViewState extends State<MobileCartView> {
  final ScrollController _cartItemsScrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _cartItemsScrollController.dispose();
  }

  @override
  Widget build(BuildContext caontext) {
    return PopScope(
      canPop: false,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              top: 10,
              bottom: 15,
              right: 20,
            ),
            child: CartHeaderRow(),
          ),

          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoaded) {
                return state.products.isEmpty
                    ? Expanded(child: NoResultFound(message: 'Cart is empty'))
                    : Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: RawScrollbar(
                                controller: _cartItemsScrollController,
                                thumbVisibility: true,
                                radius: const Radius.circular(50),
                                thickness: 5,
                                padding: EdgeInsets.only(right: 1),
                                thumbColor: AppPalette.scrollThumbColor,
                                child: GridView.builder(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  controller: _cartItemsScrollController,
                                  primary: false,
                                  itemCount: state.products.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 16,
                                        mainAxisSpacing: 16,
                                        childAspectRatio: 0.68,
                                      ),
                                  itemBuilder: (context, index) {
                                    final product = state.products[index];

                                    return BlocBuilder<CartBloc, CartState>(
                                      builder: (context, cartState) {
                                        return CartItem(
                                          cartItem: product,
                                          state: state,
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                            CartTotalWidget(state: state),
                          ],
                        ),
                      );
              }
              return SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
