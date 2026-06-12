import 'package:flutter/material.dart';
import 'package:saranstore/core/responsiveness/responsive_sizes.dart';
import 'package:saranstore/feature/home/presentation/pages/mobile/mobile_home_view.dart';
import 'package:saranstore/feature/home/presentation/widgets/dummy_placeholder.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget getResponsiveView(BuildContext context) {
      if (ResponsiveSizes.isMobile(context)) {
        return MobileHomeView();
      } else if (ResponsiveSizes.isTablet(context)) {
        return DummyPlaceholder();
      } else if (ResponsiveSizes.isDesktop(context)) {
        return DummyPlaceholder();
      } else if (ResponsiveSizes.isUltrahd(context)) {
        return DummyPlaceholder();
      }
      return MobileHomeView();
    }

    return getResponsiveView(context);
  }
}
