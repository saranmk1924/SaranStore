import 'package:saranstore/feature/home/domain/entity/category_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel({required super.name, required super.url, required super.slug});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json["name"],
      url: json["url"],
      slug: json["slug"],
    );
  }
}
