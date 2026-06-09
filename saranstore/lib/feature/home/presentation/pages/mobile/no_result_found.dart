import 'package:flutter/material.dart';
import 'package:saranstore/core/constant/app_palette.dart';

class NoResultFound extends StatelessWidget {
  final String? message;
  const NoResultFound({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.sentiment_dissatisfied_outlined,
            color: AppPalette.secondaryColor,
            size: 70,
          ),
          SizedBox(height: 5),
          Text(
            message??"No Result found",
            style: TextStyle(color: AppPalette.secondaryColor, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
