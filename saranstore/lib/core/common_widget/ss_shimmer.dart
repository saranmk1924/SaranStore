import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SsShimmer extends StatelessWidget {
  const SsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF0A192F), // Primary navy blue
      highlightColor: const Color(0xFF132D46), // Slightly lighter navy
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFF0A192F),
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
      ),
    );
  }
}
