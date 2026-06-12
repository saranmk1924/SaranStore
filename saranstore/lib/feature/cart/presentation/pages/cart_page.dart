import 'package:flutter/material.dart';
import 'package:saranstore/core/responsiveness/responsive_sizes.dart';
import 'package:saranstore/feature/cart/presentation/pages/mobile/mobile_cart_view.dart';
import 'package:saranstore/feature/home/presentation/widgets/dummy_placeholder.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget getResponsiveView(BuildContext context) {
      if (ResponsiveSizes.isMobile(context)) {
        return MobileCartView();
      }
      if (ResponsiveSizes.isTablet(context)) {
        return DummyPlaceholder();
      }
      if (ResponsiveSizes.isDesktop(context)) {
        return DummyPlaceholder();
      }
      if (ResponsiveSizes.isUltrahd(context)) {
        return DummyPlaceholder();
      }
      return MobileCartView();
    }

    return getResponsiveView(context);
  }
}
