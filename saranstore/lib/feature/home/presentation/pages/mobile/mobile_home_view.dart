import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saranstore/core/common_widget/ss_loader.dart';
import 'package:saranstore/core/common_widget/ss_snackbar.dart';
import 'package:saranstore/core/constant/app_palette.dart';
import 'package:saranstore/feature/home/presentation/bloc/home_bloc.dart';
import 'package:saranstore/feature/home/presentation/bloc/home_event.dart';
import 'package:saranstore/feature/home/presentation/bloc/home_state.dart';
import 'package:saranstore/feature/home/presentation/pages/mobile/category_view.dart';
import 'package:saranstore/feature/home/presentation/pages/mobile/error_state_column.dart';
import 'package:saranstore/feature/home/presentation/pages/mobile/header_row.dart';
import 'package:saranstore/feature/home/presentation/pages/mobile/products_view.dart';

class MobileHomeView extends StatefulWidget {
  const MobileHomeView({super.key});

  @override
  State<MobileHomeView> createState() => _MobileHomeViewState();
}

class _MobileHomeViewState extends State<MobileHomeView> {
  final ScrollController productsScrollController = ScrollController();
  final ScrollController categoriesScrollController = ScrollController();
  final TextEditingController searchProductController = TextEditingController();
  final TextEditingController searchCategoryController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    context.read<HomeBloc>().add(
      FetchCategoriesEvent(isFromProductsList: false),
    );
  }

  @override
  void dispose() {
    super.dispose();
    productsScrollController.dispose();
    categoriesScrollController.dispose();
    searchProductController.dispose();
    searchCategoryController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppPalette.primaryColor,
        appBar: AppBar(
          backgroundColor: AppPalette.primaryColor,
          elevation: 0,
          title: HeaderRow(),
        ),
        body: BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is HomeLoaded && state.isAdded) {
              SsSnackbar().show(
                context: context,
                message: "Product added successfully :)",
              );
            }
          },
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return const Center(child: SsLoader());
              }

              if (state is HomeError) {
                return ErrorStateColumn(state: state);
              }

              if (state is HomeLoaded && state.selectedCategory == null) {
                return CategoryView(
                  state: state,
                  searchCategoryController: searchCategoryController,
                  categoriesScrollController: categoriesScrollController,
                  productsScrollController: productsScrollController,
                  searchProductController: searchProductController,
                );
              }

              if (state is HomeLoaded && state.selectedCategory != null) {
                return ProductsView(
                  productsScrollController: productsScrollController,
                  searchProductController: searchProductController,
                  state: state,
                  searchCategoryController: searchCategoryController,
                  categoriesScrollController: categoriesScrollController,
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
