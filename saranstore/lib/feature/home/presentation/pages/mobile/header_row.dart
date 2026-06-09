import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:saranstore/core/constant/app_palette.dart';
import 'package:saranstore/core/router/route_names.dart';
import 'package:saranstore/feature/cart/presentation/bloc/cart_bloc.dart';
import 'package:saranstore/feature/cart/presentation/bloc/cart_state.dart';

class HeaderRow extends StatelessWidget {
  final bool isCartPage;
  const HeaderRow({super.key, this.isCartPage = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        /// Left & Right Items
        Row(
          mainAxisAlignment: isCartPage
              ? MainAxisAlignment.start
              : MainAxisAlignment.spaceBetween,
          children: [
            ClipOval(
              child: Image.asset(
                'assets/pngs/app_logo.png',
                width: 45,
                height: 45,
                fit: BoxFit.cover,
              ),
            ),

            isCartPage
                ? SizedBox.shrink()
                : GestureDetector(
                    onTap: () {
                      context.push(RouteNames.cart);
                    },
                    child: BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        if (state is CartLoaded) {
                          return Stack(
                            clipBehavior: Clip.none,
                            alignment: AlignmentGeometry.bottomRight,
                            children: [
                              const Icon(
                                Icons.shopping_cart_outlined,
                                color: AppPalette.white,
                                size: 35,
                              ),

                              state.quantity > 0
                                  ? Positioned(
                                      bottom: -9,
                                      right: -5,

                                      child: CircleAvatar(
                                        radius: 10,
                                        backgroundColor:
                                            AppPalette.secondaryColor,
                                        child: Text(
                                          state.quantity.toString(),

                                          style: TextStyle(
                                            color: AppPalette.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    )
                                  : SizedBox.shrink(),
                            ],
                          );
                        }
                        return SizedBox.shrink();
                      },
                    ),
                  ),
          ],
        ),

        /// Center Title
        ShaderMask(
          shaderCallback: (bounds) {
            return const LinearGradient(
              colors: [AppPalette.secondaryColor, AppPalette.orange],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds);
          },
          child: const Text(
            'SaranStore',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppPalette.white,
            ),
          ),
        ),
      ],
    );
  }
}
