import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saranstore/core/common_widget/ss_textformfield.dart';
import 'package:saranstore/core/constant/app_palette.dart';
import 'package:saranstore/feature/home/domain/entity/category_entity.dart';
import 'package:saranstore/feature/home/presentation/bloc/home_bloc.dart';
import 'package:saranstore/feature/home/presentation/bloc/home_event.dart';
import 'package:saranstore/feature/home/presentation/bloc/home_state.dart';
import 'package:saranstore/feature/home/presentation/pages/mobile/no_result_found.dart';
import 'package:saranstore/feature/home/presentation/widgets/category_card.dart';

class CategoryView extends StatelessWidget {
  final HomeLoaded state;
  final TextEditingController searchCategoryController;
  final ScrollController categoriesScrollController;
  final ScrollController productsScrollController;
  final TextEditingController searchProductController;
  const CategoryView({
    super.key,
    required this.state,
    required this.searchCategoryController,
    required this.categoriesScrollController,
    required this.productsScrollController,
    required this.searchProductController,
  });

  @override
  Widget build(BuildContext context) {
    final List<CategoryEntity> filteredCategories = state.categories
        .where(
          (category) => category.name.toLowerCase().contains(
            state.searchCategoryQuery.toLowerCase(),
          ),
        )
        .toList();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
          child: SsTextformfield(
            controller: searchCategoryController,
            labelText: 'Search category',
            onChanged: (value) {
              context.read<HomeBloc>().add(
                SearchCategoryEvent(searchQuery: value),
              );
            },
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
            controller: categoriesScrollController,
            thumbVisibility: true,
            radius: const Radius.circular(50),
            thickness: 5,
            padding: EdgeInsets.only(right: 1),
            thumbColor: AppPalette.scrollThumbColor,
            child: filteredCategories.isNotEmpty
                ? GridView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 1,
                    ),
                    controller: categoriesScrollController,
                    primary: false,
                    itemCount: filteredCategories.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 16 / 9,
                        ),
                    itemBuilder: (context, index) {
                      final category = filteredCategories[index];

                      return GestureDetector(
                        onTap: () {
                          searchProductController.clear();
                          context.read<HomeBloc>().add(
                            FetchProductsEvent(selectedCategory: category),
                          );
                        },
                        child: CategoryCard(category: category),
                      );
                    },
                  )
                : NoResultFound(),
          ),
        ),
        const SizedBox(height: 6),
      ],
    );
  }
}
