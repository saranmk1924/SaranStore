import '../entity/product_entity.dart';

abstract class HomeRepository {
  Future<List<ProductEntity>> getProducts();
  Future<ProductEntity> addProduct(ProductEntity product);
}