import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:saranstore/core/common_widget/ss_snackbar.dart';
import 'package:saranstore/core/constant/app_palette.dart';
import 'package:saranstore/core/router/route_names.dart';
import 'package:saranstore/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:saranstore/feature/auth/presentation/bloc/auth_state.dart';
import 'package:saranstore/feature/cart/presentation/bloc/cart_bloc.dart';
import 'package:saranstore/feature/cart/presentation/bloc/cart_state.dart';
import 'package:saranstore/feature/home/presentation/bloc/home_bloc.dart';
import 'package:saranstore/feature/home/presentation/bloc/home_event.dart';
import 'package:saranstore/feature/home/presentation/pages/mobile/product_details/logout_confirmation_dialog.dart';

class HeaderRow extends StatelessWidget {
  final bool isCartPage;
  const HeaderRow({super.key, this.isCartPage = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        /// Left & Right Items
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 16),
          child: Row(
            mainAxisAlignment: isCartPage
                ? MainAxisAlignment.start
                : MainAxisAlignment.spaceBetween,
            children: [
              // ClipOval(
              //   child: Image.asset(
              //     'assets/pngs/app_logo.png',
              //     width: 45,
              //     height: 45,
              //     fit: BoxFit.cover,
              //   ),
              // ),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthUnauthenticated) {
                    context.read<HomeBloc>().add(ResetHomeEvent());
                    context.go(RouteNames.login);
                  }
                  if (state is AuthError) {
                    SsSnackbar().show(context: context, message: state.message);
                  }
                },
                builder: (context, state) {
                  return PopupMenuButton(
                    offset: Offset(20, 47),

                    color: AppPalette.secondaryColor,
                    padding: EdgeInsetsGeometry.zero,
                    icon: Icon(
                      Icons.account_circle_rounded,
                      color: AppPalette.white,
                      size: 40,
                    ),
                    onSelected: (value) {
                      if (value == 'logout') {
                        LogoutConfirmationDialog().showDialogBox(
                          context: context,
                        );
                      }
                    },
                    itemBuilder: (_) {
                      return [
                        PopupMenuItem(
                          value: 'logout',
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: AppPalette.secondaryColor,
                              border: Border.all(
                                color: AppPalette.black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              spacing: 3,
                              children: [
                                Icon(Icons.logout, color: AppPalette.black),
                                Text(
                                  "Logout",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ];
                    },
                  );
                },
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
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: AppPalette.white,
            ),
          ),
        ),
      ],
    );
  }
}
