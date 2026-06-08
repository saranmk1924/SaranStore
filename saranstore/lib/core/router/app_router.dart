import 'package:go_router/go_router.dart';
import 'package:saranstore/core/router/route_names.dart';
import 'package:saranstore/feature/cart/presentation/pages/cart_page.dart';
import 'package:saranstore/feature/home/presentation/pages/home_page.dart';
import 'package:saranstore/feature/splash/presentation/pages/mobile/splash_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.splash,
    routes: [
      GoRoute(
        path: RouteNames.splash,
        builder: (context, state) => SplashPage(),
      ),
      // GoRoute(path: RouteNames.login, builder: (context,state)=>LoginPage()),
      GoRoute(path: RouteNames.home, builder: (context, state) => HomePage()),
      GoRoute(path: RouteNames.cart, builder: (context, state) => CartPage()),
    ],
  );
}
