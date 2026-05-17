import 'package:dio/dio.dart';

import 'package:saranstore/feature/home/data/model/product_model.dart';

class HomeRemoteDatasource {
  final Dio dio;

  HomeRemoteDatasource({required this.dio});

  Future<List<ProductModel>> getProducts() async {
    final response = await dio.get("products/category/mens-shoes");

    final List products = response.data['products'];

    return products.map((e) => ProductModel.fromJson(e)).toList();
  }
}


// https://dummyjson.com/products/category/mens-shoes
// https://dummyjson.com/products/category/mens-watches
// https://dummyjson.com/products/category/sports-accessories