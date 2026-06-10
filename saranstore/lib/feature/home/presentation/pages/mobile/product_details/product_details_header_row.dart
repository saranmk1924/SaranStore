import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:saranstore/core/constant/app_palette.dart';
import 'package:saranstore/feature/home/presentation/cubit/image_slider_cubit.dart';

class ProductDetailsHeaderRow extends StatelessWidget {
  final String title;
  const ProductDetailsHeaderRow({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
              left: 20.0,
              top: 10,
              bottom: 15,
              right: 20,
            ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          /// Left & Right Items
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 10,
            children: [
              GestureDetector(
                onTap: () {
                  context.read<ImageSliderCubit>().reset();
                  context.pop();
                },
                child: CircleAvatar(
                  backgroundColor: AppPalette.secondaryColor,
                  child: Icon(
                    Icons.arrow_back_sharp,
                    color: AppPalette.primaryColor,
                    size: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 3,
                  children: [
                    Flexible(
                      child: Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
