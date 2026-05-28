import 'package:saranstore/feature/home/domain/entity/product_entity.dart';

abstract class HomeEvent {}

class FetchProductsEvent extends HomeEvent {}

class AddProductEvent extends HomeEvent {
  final ProductEntity product;
  AddProductEvent({required this.product});
}