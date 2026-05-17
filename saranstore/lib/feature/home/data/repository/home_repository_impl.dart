import 'package:saranstore/feature/home/data/datasource/home_remote_datasource.dart';

import '../../domain/entity/product_entity.dart';
import '../../domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDatasource remoteDatasource;

  HomeRepositoryImpl({required this.remoteDatasource});

  @override
  Future<List<ProductEntity>> getProducts() async {
    return await remoteDatasource.getProducts();
  }
}