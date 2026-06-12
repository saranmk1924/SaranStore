import 'package:flutter/material.dart';
import 'package:saranstore/core/constant/app_palette.dart';

class DummyPlaceholder extends StatefulWidget {
  const DummyPlaceholder({super.key});

  @override
  State<DummyPlaceholder> createState() => _DummyPlaceholderState();
}

class _DummyPlaceholderState extends State<DummyPlaceholder> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "This application is presently designed only for the mobile portrait mode.",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppPalette.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
