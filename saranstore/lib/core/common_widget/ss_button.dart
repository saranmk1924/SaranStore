import 'package:flutter/material.dart';
import 'package:saranstore/core/common_widget/ss_loader.dart';
import 'package:saranstore/core/constant/app_palette.dart';

class SsButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final Color? buttonColor;
  final Color? textColor;
  final IconData? prefixIcon;
  final bool? isLoading;
  const SsButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.buttonColor,
    this.textColor,
    this.prefixIcon,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: WidgetStatePropertyAll(
          EdgeInsetsGeometry.symmetric(horizontal: 18, vertical: 10),
        ),
        elevation: WidgetStatePropertyAll(5),
        backgroundColor: WidgetStatePropertyAll(
          isLoading ?? false
              ? AppPalette.grey
              : buttonColor ?? AppPalette.secondaryColor,
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(8),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (prefixIcon != null) ...{
            Icon(
              prefixIcon,
              color: AppPalette.primaryColor,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(width: 6),
          },
          Text(
            buttonText,
            style: TextStyle(
              color: isLoading ?? false
                  ? AppPalette.white
                  : textColor ?? AppPalette.primaryColor,
              fontSize: 17,
            ),
          ),

          if (isLoading == true) ...{
            SizedBox(width: 8),
            Padding(
              padding: EdgeInsetsGeometry.only(top: 3),
              child: SsLoader(color: AppPalette.black, radius: 7.5),
            ),
          },
        ],
      ),
    );
  }
}
