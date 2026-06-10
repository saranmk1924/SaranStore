import 'package:saranstore/feature/home/data/datasource/home_remote_datasource.dart';
import 'package:saranstore/feature/home/data/model/product_model.dart';
import 'package:saranstore/feature/home/domain/entity/category_entity.dart';

import '../../domain/entity/product_entity.dart';
import '../../domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDatasource remoteDatasource;

  HomeRepositoryImpl({required this.remoteDatasource});

  @override
  Future<List<ProductEntity>> getProducts(String categorySlug) async {
    return await remoteDatasource.getProducts(categorySlug);
  }

  @override
  Future<ProductEntity> addProduct(ProductEntity product) async {
    final model = ProductModel(
      id: product.id,
      title: product.title,
      thumbnail: product.thumbnail,
      price: product.price,
      rating: product.rating,
      description: product.description,
      category: product.category,
      warrantyInformation: product.warrantyInformation,
      shippingInformation: product.shippingInformation,
      availabilityStatus: product.availabilityStatus,
      reviews: product.reviews,
      returnPolicy: product.returnPolicy,
      images: product.images,
    );

    return await remoteDatasource.addProduct(model);
  }

  @override
  Future<List<CategoryEntity>> getCategories() async {
    return remoteDatasource.getCategories();
  }
}
