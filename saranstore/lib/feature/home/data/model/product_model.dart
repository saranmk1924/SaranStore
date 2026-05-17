import '../../domain/entity/product_entity.dart';

class ProductModel extends ProductEntity {

  ProductModel({
    required super.id,
    required super.title,
    required super.thumbnail,
    required super.price,
    required super.rating,
  });

  factory ProductModel.fromJson(
    Map<String, dynamic> json,
  ) {

    return ProductModel(
      id: json['id'],

      title: json['title'],

      thumbnail: json['thumbnail'],

      price: (json['price'] as num).toDouble(),

      rating: (json['rating'] as num).toDouble(),
    );
  }
}