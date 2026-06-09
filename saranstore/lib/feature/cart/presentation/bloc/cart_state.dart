import 'package:saranstore/feature/cart/domain/entity/cart_item_entity.dart';

abstract class CartState {}

class CartLoaded extends CartState {
  final List<CartItemEntity> products;
  CartLoaded({required this.products});

  double get totalPrice {
    return products.fold(
      0.0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );
  }

  int get quantity {
    return products.fold(0, (sum, item) => sum + item.quantity);
  }
}
