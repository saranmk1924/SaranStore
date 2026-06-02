import 'package:flutter/material.dart';
import 'package:saranstore/core/constant/app_palette.dart';

class SsButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final Color? buttonColor;
  final Color? textColor;
  final IconData? prefixIcon;
  const SsButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.buttonColor,
    this.textColor,
    this.prefixIcon,
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
          buttonColor ?? AppPalette.secondaryColor,
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(8),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Row(
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
              color: textColor ?? AppPalette.primaryColor,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}
