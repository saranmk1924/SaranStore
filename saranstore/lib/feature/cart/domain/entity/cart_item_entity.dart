import 'package:saranstore/feature/home/domain/entity/product_entity.dart';

class CartItemEntity {
  final int quantity;
  final ProductEntity product;
  CartItemEntity({required this.product, required this.quantity});
}
