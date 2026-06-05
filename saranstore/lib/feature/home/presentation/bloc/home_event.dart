import 'package:saranstore/core/enums/product_sort_type_enum.dart';
import 'package:saranstore/feature/home/domain/entity/category_entity.dart';
import 'package:saranstore/feature/home/domain/entity/product_entity.dart';

abstract class HomeEvent {}

class FetchProductsEvent extends HomeEvent {
  final CategoryEntity selectedCategory;
  FetchProductsEvent({required this.selectedCategory});
}

class AddProductEvent extends HomeEvent {
  final ProductEntity product;
  final CategoryEntity selectedCategory;
  AddProductEvent({required this.product, required this.selectedCategory});
}

class FetchCategoriesEvent extends HomeEvent {
  final bool isFromProductsList;
  FetchCategoriesEvent({required this.isFromProductsList});
}

class SearchCategoryEvent extends HomeEvent {
  final String searchQuery;
  SearchCategoryEvent({required this.searchQuery});
}

class SearchProductEvent extends HomeEvent {
  final String searchQuery;
  SearchProductEvent({required this.searchQuery});
}

class SortProductsEvent extends HomeEvent {
  final ProductSortTypeEnum sortType;
  SortProductsEvent({required this.sortType});
}

class DeleteProductEvent extends HomeEvent {
  final int productId;
  DeleteProductEvent({required this.productId});
}
