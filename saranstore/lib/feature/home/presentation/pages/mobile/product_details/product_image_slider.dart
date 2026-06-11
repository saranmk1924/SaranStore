import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saranstore/core/common_widget/ss_shimmer.dart';
import 'package:saranstore/core/constant/app_palette.dart';
import 'package:saranstore/feature/home/presentation/cubit/image_slider_cubit.dart';

class ProductImageSlider extends StatelessWidget {
  final List<String> images;
  ProductImageSlider({super.key, required this.images});

  final PageController _pageController = PageController(viewportFraction: 0.9);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (images.isNotEmpty && images.length > 1) ? 360 : 300,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                PageView.builder(
                  controller: _pageController,
                  onPageChanged: (value) {
                    context.read<ImageSliderCubit>().changePage(value);
                  },
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    // return SsShimmer();
                    return CachedNetworkImage(
                      placeholder: (context, url) => SsShimmer(),
                      imageUrl: images[index],
                      fit: BoxFit.contain,
                      errorWidget: (context, url, error) {
                        return Icon(
                          Icons.broken_image,
                          color: AppPalette.grey,
                          size: 80,
                        );
                      },
                    );
                  },
                ),

                if (images.isNotEmpty && images.length > 1)
                  BlocBuilder<ImageSliderCubit, int>(
                    builder: (context, pageIndex) {
                      return Positioned(
                        top: 15,
                        right: 15,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppPalette.secondaryColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            "${pageIndex + 1}/${images.length}",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),

          if (images.isNotEmpty && images.length > 1) ...[
            SizedBox(height: 10),
            BlocBuilder<ImageSliderCubit, int>(
              builder: (context, pageIndex) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    images.length,
                    (currentIndex) => AnimatedContainer(
                      duration: Duration(milliseconds: 3),
                      margin: EdgeInsets.all(8),
                      height: 8,
                      width: currentIndex == pageIndex ? 20 : 12,
                      decoration: BoxDecoration(
                        color: pageIndex == currentIndex
                            ? AppPalette.secondaryColor
                            : AppPalette.grey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}
