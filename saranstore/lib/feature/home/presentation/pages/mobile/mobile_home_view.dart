import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saranstore/core/common_widget/ss_button.dart';
import 'package:saranstore/core/common_widget/ss_loader.dart';
import 'package:saranstore/core/common_widget/ss_snackbar.dart';
import 'package:saranstore/core/common_widget/ss_textformfield.dart';
import 'package:saranstore/core/constant/app_palette.dart';
import 'package:saranstore/feature/home/presentation/bloc/home_bloc.dart';
import 'package:saranstore/feature/home/presentation/bloc/home_event.dart';
import 'package:saranstore/feature/home/presentation/bloc/home_state.dart';
import 'package:saranstore/feature/home/presentation/pages/mobile/add_product_dialog.dart';
import 'package:saranstore/feature/home/presentation/widgets/category_card.dart';
import 'package:saranstore/feature/home/presentation/widgets/product_card.dart';

class MobileHomeView extends StatefulWidget {
  const MobileHomeView({super.key});

  @override
  State<MobileHomeView> createState() => _MobileHomeViewState();
}

class _MobileHomeViewState extends State<MobileHomeView> {
  final ScrollController _productsScrollController = ScrollController();
  final ScrollController _categoriesScrollController = ScrollController();
  final TextEditingController _searchProductController =
      TextEditingController();
  final TextEditingController _searchCategoryController =
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
    _productsScrollController.dispose();
    _categoriesScrollController.dispose();
    _searchProductController.dispose();
    _searchCategoryController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.primaryColor,
      appBar: AppBar(
        backgroundColor: AppPalette.primaryColor,
        elevation: 0,
        title: Stack(
          alignment: Alignment.center,
          children: [
            /// Left & Right Items
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipOval(
                  child: Image.asset(
                    'assets/pngs/app_logo.png',
                    width: 45,
                    height: 45,
                    fit: BoxFit.cover,
                  ),
                ),

                const Icon(Icons.shopping_cart_outlined, color: Colors.white),
              ],
            ),

            /// Center Title
            ShaderMask(
              shaderCallback: (bounds) {
                return const LinearGradient(
                  colors: [AppPalette.secondaryColor, AppPalette.orange],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds);
              },
              child: const Text(
                'SaranStore',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
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
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: AppPalette.red,
                        size: 70,
                      ),
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

            if (state is HomeLoaded && state.selectedCategory == null) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                      top: 15,
                    ),
                    child: SsTextformfield(
                      controller: _searchCategoryController,
                      labelText: 'Search category',
                    ),
                  ),
                  const SizedBox(height: 6),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      'To view the products, select a category',
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppPalette.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Expanded(
                    child: RawScrollbar(
                      controller: _categoriesScrollController,
                      thumbVisibility: true,
                      radius: const Radius.circular(50),
                      thickness: 5,
                      padding: EdgeInsets.only(right: 1),
                      thumbColor: AppPalette.secondaryColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: GridView.builder(
                          controller: _categoriesScrollController,
                          primary: false,
                          itemCount: state.categories.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                childAspectRatio: 16 / 9,
                              ),
                          itemBuilder: (context, index) {
                            final category = state.categories[index];

                            return GestureDetector(
                              onTap: () {
                                context.read<HomeBloc>().add(
                                  FetchProductsEvent(
                                    selectedCategory: category,
                                  ),
                                );
                              },
                              child: CategoryCard(category: category),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                ],
              );
            }

            if (state is HomeLoaded && state.selectedCategory != null) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                          top: 15,
                        ),
                        child: SsTextformfield(
                          controller: _searchProductController,
                          labelText: 'Search product',
                        ),
                      ),
                      const SizedBox(height: 6),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          spacing: 10,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                context.read<HomeBloc>().add(
                                  FetchCategoriesEvent(
                                    isFromProductsList: true,
                                  ),
                                );
                              },
                              child: CircleAvatar(
                                backgroundColor: AppPalette.secondaryColor,
                                child: Icon(
                                  Icons.arrow_back_sharp,
                                  color: AppPalette.primaryColor,
                                  size: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            Text(
                              state.selectedCategory?.name ?? '',
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppPalette.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),

                      Expanded(
                        child: RawScrollbar(
                          controller: _productsScrollController,
                          thumbVisibility: true,
                          radius: const Radius.circular(50),
                          thickness: 5,
                          padding: EdgeInsets.only(right: 1),
                          thumbColor: AppPalette.secondaryColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: GridView.builder(
                              controller: _productsScrollController,
                              primary: false,
                              itemCount: state.products.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 16,
                                    mainAxisSpacing: 16,
                                    childAspectRatio: 0.68,
                                  ),
                              itemBuilder: (context, index) {
                                final product = state.products[index];

                                return ProductCard(product: product);
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 20,

                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppPalette.orange.withValues(alpha: 0.2),
                            blurRadius: 15,
                            spreadRadius: 20,
                          ),
                        ],
                      ),
                      child: FloatingActionButton(
                        backgroundColor: AppPalette.secondaryColor,
                        foregroundColor: AppPalette.black,
                        elevation: 20,
                        onPressed: () {
                          AddProductDialog().addProduct(
                            context: context,
                            selectedCategory: state.selectedCategory!,
                          );
                          // ProductEntity product = ProductEntity(
                          //   id: 10,
                          //   title: "CM Vijay",
                          //   thumbnail: "https://pbs.twimg.com/profile_images/1837200576779563009/EcHkTM-M_400x400.jpg",
                          //   https://ritzmagazineimages.b-cdn.net/uploads/2020/05/ajith-kumar.jpg
                          //   price: 10.8,
                          //   rating: 5.0,
                          // );

                          // context.read<HomeBloc>().add(
                          //   AddProductEvent(product: product),
                          // );
                        },
                        child: Icon(
                          Icons.add,
                          fontWeight: FontWeight.w500,
                          size: 35,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
