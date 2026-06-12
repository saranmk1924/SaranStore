import 'package:saranstore/core/enums/product_sort_type_enum.dart';
import 'package:saranstore/feature/home/domain/entity/category_entity.dart';

import '../../domain/entity/product_entity.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<ProductEntity> products;
  final List<CategoryEntity> categories;
  final CategoryEntity? selectedCategory;
  final bool isAdded;
  final String searchProductQuery;
  final String searchCategoryQuery;
  final ProductSortTypeEnum sortType;
  final bool clearProductSearch;

  HomeLoaded({
    required this.products,
    required this.isAdded,
    required this.categories,
    this.selectedCategory,
    required this.searchProductQuery,
    required this.searchCategoryQuery,
    required this.sortType,
    this.clearProductSearch=false,
  });
}

class HomeError extends HomeState {
  final String message;
  final bool isCategoriesView;
  final CategoryEntity? selectedCategory;
  HomeError(
    this.message, {
    required this.isCategoriesView,
    this.selectedCategory,
  });
}
