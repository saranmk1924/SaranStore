import 'package:flutter/material.dart';
import 'package:saranstore/core/constant/app_palette.dart';
import 'package:saranstore/feature/home/domain/entity/product_entity.dart';

class AdditionalInfo extends StatelessWidget {
  final ProductEntity product;
  const AdditionalInfo({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        spacing: 4,
        children: [
          //warranty
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 120,
                child: Text(
                  "Warranty: ",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 18,
                    color: AppPalette.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  product.warrantyInformation ?? '',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 18,
                    color: AppPalette.white,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ),
            ],
          ),
          //return policy
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 120,
                child: Text(
                  "Return policy: ",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 18,
                    color: AppPalette.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  product.returnPolicy ?? '',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 18,
                    color: AppPalette.white,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ),
            ],
          ),
          //shipping
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 120,
                child: Text(
                  "Shipping: ",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 18,
                    color: AppPalette.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  product.shippingInformation ?? '',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 18,
                    color: AppPalette.white,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
