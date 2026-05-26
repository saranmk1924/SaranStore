import 'package:flutter/cupertino.dart';
import 'package:saranstore/core/constant/app_palette.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoActivityIndicator(
      color: AppPalette.secondaryColor,
      radius: 20,
      animating: true,
    );
  }
}
