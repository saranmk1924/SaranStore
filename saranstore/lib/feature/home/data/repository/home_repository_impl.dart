import 'package:saranstore/feature/home/data/datasource/home_remote_datasource.dart';
import 'package:saranstore/feature/home/data/model/product_model.dart';

import '../../domain/entity/product_entity.dart';
import '../../domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDatasource remoteDatasource;

  HomeRepositoryImpl({required this.remoteDatasource});

  @override
  Future<List<ProductEntity>> getProducts() async {
    return await remoteDatasource.getProducts();
  }

  @override
  Future<ProductEntity> addProduct(ProductEntity product) async {
    final model = ProductModel(
      id: product.id,
      title: product.title,
      thumbnail: product.thumbnail,
      price: product.price,
      rating: product.rating,
    );

    return await remoteDatasource.addProduct(model);
  }
}
