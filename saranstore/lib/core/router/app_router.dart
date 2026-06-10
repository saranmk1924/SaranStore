import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saranstore/core/router/route_names.dart';
import 'package:saranstore/feature/cart/presentation/pages/cart_page.dart';
import 'package:saranstore/feature/home/domain/entity/product_entity.dart';
import 'package:saranstore/feature/home/presentation/pages/home_page.dart';
import 'package:saranstore/feature/home/presentation/pages/mobile/product_details/product_details_view.dart';
import 'package:saranstore/feature/splash/presentation/pages/mobile/splash_page.dart';
import 'package:saranstore/main_layout.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.splash,
    routes: [
      GoRoute(
        path: RouteNames.splash,
        pageBuilder: (context, state) => NoTransitionPage(child: SplashPage()),
      ),
      // GoRoute(path: RouteNames.login, builder: (context,state)=>LoginPage()),
      ShellRoute(
        builder: ((context, state, child) {
          debugPrint("Shell path = ${state.uri.path}");
          return MainLayout(
            isCartPage: state.uri.path == RouteNames.cart,
            child: child,
          );
        }),
        routes: [
          GoRoute(
            path: RouteNames.home,
            pageBuilder: (context, state) =>
                NoTransitionPage(child: HomePage()),
          ),
          GoRoute(
            path: RouteNames.cart,
            pageBuilder: (context, state) =>
                NoTransitionPage(child: CartPage()),
          ),
          GoRoute(
            path: '${RouteNames.productDetails}/:id',
            pageBuilder: (context, state) {
              final product = state.extra as ProductEntity;
              return NoTransitionPage(
                child: ProductDetailsView(product: product),
              );
            },
          ),
        ],
      ),
    ],
  );
}
