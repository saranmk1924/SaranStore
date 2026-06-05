import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saranstore/core/common_widget/ss_textformfield.dart';
import 'package:saranstore/core/constant/app_palette.dart';
import 'package:saranstore/core/enums/product_sort_type_enum.dart';
import 'package:saranstore/feature/home/domain/entity/product_entity.dart';
import 'package:saranstore/feature/home/presentation/bloc/home_bloc.dart';
import 'package:saranstore/feature/home/presentation/bloc/home_event.dart';
import 'package:saranstore/feature/home/presentation/bloc/home_state.dart';
import 'package:saranstore/feature/home/presentation/pages/mobile/add_product_dialog.dart';
import 'package:saranstore/feature/home/presentation/pages/mobile/no_result_found.dart';
import 'package:saranstore/feature/home/presentation/widgets/product_card.dart';

class ProductsView extends StatelessWidget {
  final ScrollController productsScrollController;
  final TextEditingController searchProductController;
  final TextEditingController searchCategoryController;
  final ScrollController categoriesScrollController;
  final HomeLoaded state;
  const ProductsView({
    super.key,
    required this.productsScrollController,
    required this.searchProductController,
    required this.state,
    required this.searchCategoryController,
    required this.categoriesScrollController,
  });

  @override
  Widget build(BuildContext context) {
    final List<ProductEntity> filteredProducts = state.products
        .where(
          (product) => product.title.toLowerCase().contains(
            state.searchProductQuery.toLowerCase(),
          ),
        )
        .toList();

    switch (state.sortType) {
      case ProductSortTypeEnum.priceHighToLow:
        filteredProducts.sort((a, b) => b.price.compareTo(a.price));
        break;
      case ProductSortTypeEnum.priceLowToHigh:
        filteredProducts.sort((a, b) => a.price.compareTo(b.price));
      case ProductSortTypeEnum.ratingHighToLow:
        filteredProducts.sort((a, b) => b.rating.compareTo(a.rating));
      default:
        filteredProducts;
    }
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 10, top: 15),
              child: Row(
                spacing: 5,
                children: [
                  Expanded(
                    child: SsTextformfield(
                      controller: searchProductController,
                      labelText: 'Search product',
                      onChanged: (value) {
                        context.read<HomeBloc>().add(
                          SearchProductEvent(searchQuery: value),
                        );
                      },
                    ),
                  ),

                  PopupMenuButton<ProductSortTypeEnum>(
                    tooltip: 'Sort',
                    icon: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor:
                              state.sortType == ProductSortTypeEnum.none
                              ? AppPalette.grey
                              : AppPalette.secondaryColor,
                          radius: 23,
                        ),
                        CircleAvatar(
                          backgroundColor: AppPalette.primaryColor,
                          radius: 21,
                          child: Icon(
                            Icons.sort,
                            color: state.sortType == ProductSortTypeEnum.none
                                ? AppPalette.grey
                                : AppPalette.secondaryColor,
                            size: 35,
                          ),
                        ),
                      ],
                    ),
                    // initialValue: ProductSortTypeEnum.all,
                    color: AppPalette.secondaryColor,
                    onSelected: (value) {
                      searchProductController.clear();
                      context.read<HomeBloc>().add(
                        SortProductsEvent(sortType: value),
                      );
                    },
                    itemBuilder: (_) {
                      return [
                        PopupMenuItem(
                          padding: EdgeInsets.zero,
                          value: ProductSortTypeEnum.none,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: state.sortType == ProductSortTypeEnum.none
                                  ? AppPalette.orange
                                  : AppPalette.transparent,
                            ),
                            child: Text(
                              "None",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          padding: EdgeInsets.zero,
                          value: ProductSortTypeEnum.priceLowToHigh,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  state.sortType ==
                                      ProductSortTypeEnum.priceLowToHigh
                                  ? AppPalette.orange
                                  : AppPalette.transparent,
                            ),
                            child: Text(
                              "Price low to high",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          padding: EdgeInsets.zero,
                          value: ProductSortTypeEnum.priceHighToLow,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  state.sortType ==
                                      ProductSortTypeEnum.priceHighToLow
                                  ? AppPalette.orange
                                  : AppPalette.transparent,
                            ),
                            child: Text(
                              "Price high to low",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          padding: EdgeInsets.zero,
                          value: ProductSortTypeEnum.ratingHighToLow,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  state.sortType ==
                                      ProductSortTypeEnum.ratingHighToLow
                                  ? AppPalette.orange
                                  : AppPalette.transparent,
                            ),
                            child: Text(
                              "Rating high to low",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ];
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Stack(
                children: [
                  Row(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          searchCategoryController.clear();
                          context.read<HomeBloc>().add(
                            FetchCategoriesEvent(isFromProductsList: true),
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
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Tooltip(
                      message:
                          'Swipe any product card from right to left to view the edit and delete options.',
                      child: Icon(Icons.info_outline, color: AppPalette.orange),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),

            Expanded(
              child: RawScrollbar(
                controller: productsScrollController,
                thumbVisibility: true,
                radius: const Radius.circular(50),
                thickness: 5,
                padding: EdgeInsets.only(right: 1),
                thumbColor: AppPalette.secondaryColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: filteredProducts.isNotEmpty
                      ? GridView.builder(
                          controller: productsScrollController,
                          primary: false,
                          itemCount: filteredProducts.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                childAspectRatio: 0.68,
                              ),
                          itemBuilder: (context, index) {
                            final product = filteredProducts[index];

                            return ProductCard(product: product);
                          },
                        )
                      : NoResultFound(),
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
                  searchProductController: searchProductController,
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
              child: Icon(Icons.add, fontWeight: FontWeight.w500, size: 35),
            ),
          ),
        ),
      ],
    );
  }
}
