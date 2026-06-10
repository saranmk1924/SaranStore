import 'package:saranstore/feature/home/data/model/review_model.dart';

import '../../domain/entity/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.id,
    required super.title,
    required super.thumbnail,
    required super.price,
    required super.rating,
    super.description,
    super.category,
    super.warrantyInformation,
    super.shippingInformation,
    super.availabilityStatus,
    super.reviews,
    super.returnPolicy,
    super.images,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title']??'',
      thumbnail: json['thumbnail'],
      price: (json['price'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      description: json['description']??'',
      category: json['category']??'',
      warrantyInformation: json['warrantyInformation']??'',
      shippingInformation: json['shippingInformation']??'',
      availabilityStatus: json['availabilityStatus']??'',
      reviews: (json['reviews'] as List<dynamic>? ?? []).map((review)=>ReviewModel.fromJson(review)).toList(),
      returnPolicy: json['returnPolicy']??'',
      images: List<String>.from( json['images']??[]),
    );
  }
}
