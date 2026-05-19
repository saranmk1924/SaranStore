import 'package:dio/dio.dart';

import 'package:saranstore/feature/home/data/model/product_model.dart';

class HomeRemoteDatasource {
  final Dio dio;

  HomeRemoteDatasource({required this.dio});

  Future<List<ProductModel>> getProducts() async {
    final response = await dio.get("products/category/sports-accessories");

    final List products = response.data['products'];

    return products.map((e) => ProductModel.fromJson(e)).toList();
  }
}

// https://dummyjson.com/products
// https://dummyjson.com/products/categories

// //////////FASHSION//////////////

// https://dummyjson.com/products/category/mens-shirts
// https://dummyjson.com/products/category/mens-shoes
// https://dummyjson.com/products/category/mens-watches

// https://dummyjson.com/products/category/womens-dresses
// https://dummyjson.com/products/category/womens-shoes
// https://dummyjson.com/products/category/womens-watches
// https://dummyjson.com/products/category/womens-bags
// https://dummyjson.com/products/category/womens-jewellery

// /////////ACCESSORIES//////////////
// ///https://dummyjson.com/products/category/sunglasses
// https://dummyjson.com/products/category/mobile-accessories
// https://dummyjson.com/products/category/sports-accessories

// /////////ELECTRONICS//////////////
// //https://dummyjson.com/products/category/smartphones
// //https://dummyjson.com/products/category/laptops
// //https://dummyjson.com/products/category/tablets

// //////////VEHICLES//////////////
// ///https://dummyjson.com/products/category/motorcycle
// https://dummyjson.com/products/category/vehicle

// //////////HOME&FURNITURE//////////////
// ///https://dummyjson.com/products/category/furniture
// https://dummyjson.com/products/category/home-decoration
// https://dummyjson.com/products/category/kitchen-accessories

// ///////////BEAUTY////////////////////
// ///https://dummyjson.com/products/category/beauty
// https://dummyjson.com/products/category/fragrances
// https://dummyjson.com/products/category/skin-care

// ///////////GROCERIES////////////////////
// ///https://dummyjson.com/products/category/groceries
 
// ///////////SEARCH API//////////////////// 
// ///https://dummyjson.com/products/search?q=shirt
// https://dummyjson.com/products/search?q=shoe
// https://dummyjson.com/products/search?q=watch

// //////////PAGINATION API////////////////////
// ///https://dummyjson.com/products?limit=10&skip=0
// https://dummyjson.com/products?limit=10&skip=10
// https://dummyjson.com/products?limit=10&skip=20

// /////////SINGLE PRODUCT API////////////////////
// ///https://dummyjson.com/products/1
// https://dummyjson.com/products/15

// /////////SORT EXAMPLE////////////////////
// ///https://dummyjson.com/products?sortBy=price&order=asc
// https://dummyjson.com/products?sortBy=price&order=desc

