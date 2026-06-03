import '../entity/product_entity.dart';
import '../repository/home_repository.dart';

class GetProductsUsecase {
  final HomeRepository repository;

  GetProductsUsecase({required this.repository});

  Future<List<ProductEntity>> call(String categorySlug) async {
    return await repository.getProducts(categorySlug);
  }
}