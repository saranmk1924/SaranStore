import 'package:saranstore/feature/cart/domain/entity/cart_item_entity.dart';

abstract class CartState {}
 
class CartLoaded extends CartState {
  final List<CartItemEntity> products;
  CartLoaded({required this.products});
}
