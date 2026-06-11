import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saranstore/core/constant/app_palette.dart';

class SsTextformfield extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final int? maxLength;
  final Widget? suffix;
  final bool? obscureText;
  const SsTextformfield({
    super.key,
    required this.controller,
    required this.labelText,
    this.keyboardType,
    this.validator,
    this.inputFormatters,
    this.onChanged,
    this.maxLength,
    this.suffix,
    this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: TextFormField(
        onTapOutside: (_) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        controller: controller,
        onChanged: onChanged,
        obscureText: obscureText ?? false,
        maxLength: maxLength ?? 100,
        maxLines: 1,
        cursorColor: AppPalette.white,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: TextStyle(color: AppPalette.white),
        inputFormatters: [
          LengthLimitingTextInputFormatter(100),
          ...?inputFormatters,
        ],

        decoration: InputDecoration(
          suffixIcon: suffix,
          counterText: '',
          labelText: labelText,
          floatingLabelStyle: TextStyle(color: AppPalette.secondaryColor),
          labelStyle: TextStyle(color: AppPalette.grey),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppPalette.white, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppPalette.white, width: 2.5),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppPalette.white, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppPalette.red, width: 1.5),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppPalette.red, width: 2.5),
            borderRadius: BorderRadius.circular(8),
          ),
          errorStyle: TextStyle(color: AppPalette.red),
        ),
        keyboardType: keyboardType,
        validator: validator,
      ),
    );
  }
}
