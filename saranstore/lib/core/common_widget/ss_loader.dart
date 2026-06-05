import 'package:flutter/cupertino.dart';
import 'package:saranstore/core/constant/app_palette.dart';

class SsLoader extends StatelessWidget {
  const SsLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoActivityIndicator(
      color: AppPalette.secondaryColor,
      radius: 30,
      animating: true,
    );
  }
}
