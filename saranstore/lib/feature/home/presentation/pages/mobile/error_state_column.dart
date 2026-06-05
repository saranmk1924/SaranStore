import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saranstore/core/common_widget/ss_button.dart';
import 'package:saranstore/core/constant/app_palette.dart';
import 'package:saranstore/feature/home/presentation/bloc/home_bloc.dart';
import 'package:saranstore/feature/home/presentation/bloc/home_event.dart';
import 'package:saranstore/feature/home/presentation/bloc/home_state.dart';

class ErrorStateColumn extends StatelessWidget {
  final HomeError state;
  const ErrorStateColumn({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: AppPalette.red, size: 70),
            SizedBox(height: 5),
            Text(
              state.message,
              style: TextStyle(color: AppPalette.red, fontSize: 18),
            ),
            SizedBox(height: 15),
            SsButton(
              onPressed: () {
                if (state.isCategoriesView) {
                  context.read<HomeBloc>().add(
                    FetchCategoriesEvent(isFromProductsList: false),
                  );
                } else {
                  context.read<HomeBloc>().add(
                    FetchProductsEvent(
                      selectedCategory: state.selectedCategory!,
                    ),
                  );
                }
              },
              buttonText: 'Retry',
            ),
          ],
        ),
      ),
    );
  }
}
