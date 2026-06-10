import 'package:flutter/material.dart';
import 'package:saranstore/core/constant/app_palette.dart';
import 'package:saranstore/core/helper/helper_class.dart';
import 'package:saranstore/feature/home/domain/entity/product_entity.dart';

class ReviewSection extends StatelessWidget {
  final GlobalKey reviewKey;
  final ProductEntity product;
  const ReviewSection({super.key, required this.product, required this.reviewKey});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Column(
        spacing: 10,
        children: [
          Text(
            key: reviewKey,
            "Reviews",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              color: AppPalette.orange,
              fontWeight: FontWeight.bold,
            ),
          ),
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: AppPalette.orange, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: 2,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      spacing: 2,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Icon(
                            Icons.account_circle_rounded,
                            size: 23,
                            color: AppPalette.secondaryColor,
                          ),
                        ),
                        Text(
                          product.reviews![index].reviewerName,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 15,
                            color: AppPalette.white,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 26),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            HelperClass.formatDateTime(
                              product.reviews![index].date,
                            ),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 12,
                              color: AppPalette.white,
                            ),
                          ),
                          Row(
                            spacing: 2,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                product.reviews![index].rating.toString(),
                                style: TextStyle(
                                  fontSize: 15,
                                  color: AppPalette.white,
                                ),
                              ),
                              ...List.generate(product.reviews![index].rating, (
                                i,
                              ) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 1.9),
                                  child: Icon(
                                    size: 15,
                                    Icons.star,
                                    color: product.reviews![index].rating <= 2
                                        ? AppPalette.red
                                        : product.reviews![index].rating == 3
                                        ? AppPalette.orange
                                        : AppPalette.secondaryColor,
                                  ),
                                );
                              }),
                            ],
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 26),
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              maxLines: 10,
                              overflow: TextOverflow.ellipsis,
                              product.reviews![index].comment,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppPalette.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider(color: AppPalette.orange, thickness: 0.5);
            },
            itemCount: product.reviews!.length,
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
