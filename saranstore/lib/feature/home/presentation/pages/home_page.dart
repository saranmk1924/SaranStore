import 'package:flutter/material.dart';
import 'package:saranstore/core/responsiveness/responsive_sizes.dart';
import 'package:saranstore/feature/home/presentation/pages/mobile/mobile_home_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget getResponsiveView(BuildContext context) {
      if (ResponsiveSizes.isMobile(context)) {
        return MobileHomeView();
      } else if (ResponsiveSizes.isTablet(context)) {
        return Placeholder();
      } else if (ResponsiveSizes.isDesktop(context)) {
        return Placeholder();
      } else if (ResponsiveSizes.isUltrahd(context)) {
        return Placeholder();
      }
      return MobileHomeView();
    }

    return getResponsiveView(context);
  }
}
