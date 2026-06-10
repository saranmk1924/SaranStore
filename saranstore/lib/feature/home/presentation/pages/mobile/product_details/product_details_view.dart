import 'package:flutter/material.dart';
import 'package:saranstore/core/constant/app_palette.dart';
import 'package:saranstore/feature/home/domain/entity/product_entity.dart';
import 'package:saranstore/feature/home/presentation/pages/mobile/product_details/additional_info.dart';
import 'package:saranstore/feature/home/presentation/pages/mobile/product_details/description_row.dart';
import 'package:saranstore/feature/home/presentation/pages/mobile/product_details/price_rating_row.dart';
import 'package:saranstore/feature/home/presentation/pages/mobile/product_details/product_details_header_row.dart';
import 'package:saranstore/feature/home/presentation/pages/mobile/product_details/product_image_slider.dart';
import 'package:saranstore/feature/home/presentation/pages/mobile/product_details/review_section.dart';

class ProductDetailsView extends StatefulWidget {
  final ProductEntity product;
  const ProductDetailsView({super.key, required this.product});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey reviewKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Column(
        children: [
          ProductDetailsHeaderRow(title: widget.product.title),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Divider(
              color: AppPalette.secondaryColor,
              thickness: 0.8,

              height: 0,
            ),
          ),

          ProductImageSlider(images: widget.product.images ?? []),
          PriceRatingRow(
            product: widget.product,
            onPressed: () {
              if (reviewKey.currentContext != null) {
                Scrollable.ensureVisible(
                  reviewKey.currentContext!,
                  duration: Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                );
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 12),
            child: Divider(
              color: AppPalette.secondaryColor,
              thickness: 0.8,

              height: 0,
            ),
          ),
          Expanded(
            child: RawScrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              radius: const Radius.circular(50),
              thickness: 5,
              padding: EdgeInsets.only(right: 1),
              thumbColor: AppPalette.secondaryColor,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    DescriptionRow(product: widget.product),

                    AdditionalInfo(product: widget.product),

                    if (widget.product.reviews != null &&
                        widget.product.reviews!.isNotEmpty)
                      ReviewSection(
                        product: widget.product,
                        reviewKey: reviewKey,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
