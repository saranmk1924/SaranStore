import 'package:saranstore/feature/home/domain/entity/category_entity.dart';

import '../entity/product_entity.dart';

abstract class HomeRepository {
  Future<List<ProductEntity>> getProducts(String categorySlug);
  Future<ProductEntity> addProduct(ProductEntity product);
  Future<List<CategoryEntity>> getCategories();
}