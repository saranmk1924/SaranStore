import 'package:flutter/material.dart';
import 'package:saranstore/core/constant/app_palette.dart';

class SsSnackbar {
  void show({required BuildContext context, required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(milliseconds: 1000),
        backgroundColor: AppPalette.white,
        content: Text(
          message,
          style: TextStyle(
            color: AppPalette.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
