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
