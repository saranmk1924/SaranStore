import 'package:saranstore/feature/home/domain/entity/category_entity.dart';
import 'package:saranstore/feature/home/domain/entity/product_entity.dart';

abstract class HomeEvent {}

class FetchProductsEvent extends HomeEvent {
  final CategoryEntity categorySlug;
  FetchProductsEvent({required this.categorySlug});
}

class AddProductEvent extends HomeEvent {
  final ProductEntity product;
  AddProductEvent({required this.product});
}

class FetchCategoriesEvent extends HomeEvent {
  final bool isFromProductsList;
  FetchCategoriesEvent({required this.isFromProductsList});
}
