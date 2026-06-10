import 'package:flutter/material.dart';
import 'package:saranstore/core/constant/app_palette.dart';
import 'package:saranstore/feature/home/presentation/pages/mobile/header_row.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  final bool isCartPage;
  const MainLayout({super.key, required this.child, this.isCartPage = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.primaryColor,
      appBar: AppBar(
        backgroundColor: AppPalette.primaryColor,
        titleSpacing: 0,
        title: HeaderRow(isCartPage: isCartPage),
      ),
      body: child,
    );
  }
}
