import 'package:flutter/cupertino.dart';
import 'package:saranstore/core/constant/app_palette.dart';

class SsLoader extends StatelessWidget {
  final Color? color;
  final double? radius;
  const SsLoader({super.key, this.color, this.radius});

  @override
  Widget build(BuildContext context) {
    return CupertinoActivityIndicator(
      color: color ?? AppPalette.secondaryColor,
      radius: radius ?? 30,
      animating: true,
    );
  }
}
