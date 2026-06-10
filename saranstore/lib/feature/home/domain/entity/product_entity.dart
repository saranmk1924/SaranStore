import 'package:saranstore/feature/home/domain/entity/review_entity.dart';

class ProductEntity {
  final int id;
  final String title;
  final String thumbnail;
  final double price;
  final double rating;
  final String? description;
  final String? category;
  final String? warrantyInformation;
  final String? shippingInformation;
  final String? availabilityStatus;
  final List<ReviewEntity>? reviews;
  final String? returnPolicy;
  final List<String>? images;

  ProductEntity({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.price,
    required this.rating,
    this.description,
    this.category,
    this.warrantyInformation,
    this.shippingInformation,
    this.availabilityStatus,
    this.reviews,
    this.returnPolicy,
    this.images,
  });
}
