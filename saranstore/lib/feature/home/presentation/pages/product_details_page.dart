import 'package:flutter/material.dart';
import 'package:saranstore/core/responsiveness/responsive_sizes.dart';
import 'package:saranstore/feature/home/domain/entity/product_entity.dart';
import 'package:saranstore/feature/home/presentation/pages/mobile/product_details/product_details_view.dart';
import 'package:saranstore/feature/home/presentation/widgets/dummy_placeholder.dart';

class ProductDetailsPage extends StatelessWidget {
  final ProductEntity product;
  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    Widget getResponsiveView(BuildContext context){
      if(ResponsiveSizes.isMobile(context)){
        return ProductDetailsView(product: product);
      }
      if(ResponsiveSizes.isTablet(context)){
        return DummyPlaceholder();
      }
      if(ResponsiveSizes.isDesktop(context)){
        return DummyPlaceholder();
      }
      if(ResponsiveSizes.isUltrahd(context)){
        return DummyPlaceholder();
      }
      return ProductDetailsView(product: product);
      
    }

    return getResponsiveView(context);
  }
}