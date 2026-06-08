import 'package:saranstore/feature/cart/domain/entity/cart_item_entity.dart';

abstract class CartEvent {}

class AddProductEvent extends CartEvent {
  final CartItemEntity product;
  AddProductEvent({required this.product});
}

class RemoveProductEvent extends CartEvent {
  final CartItemEntity product;
  RemoveProductEvent({required this.product});
}

class IncreaseProductQuantityEvent extends CartEvent {
  final int productId;
  IncreaseProductQuantityEvent({required this.productId});
}

class DecreaseProductQuantityEvent extends CartEvent {
  final int productId;
  DecreaseProductQuantityEvent({required this.productId});
}

class ClearCartEvent extends CartEvent {}
