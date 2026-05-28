import 'package:saranstore/feature/home/domain/entity/product_entity.dart';
import 'package:saranstore/feature/home/domain/repository/home_repository.dart';

class AddProductUsecase {
  final HomeRepository repository;

  AddProductUsecase({required this.repository});

  Future<ProductEntity> call(ProductEntity product)async{
    return await repository.addProduct(product);
  }
}