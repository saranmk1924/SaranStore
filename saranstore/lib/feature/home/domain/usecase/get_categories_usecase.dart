import 'package:saranstore/feature/home/domain/entity/category_entity.dart';
import 'package:saranstore/feature/home/domain/repository/home_repository.dart';

class GetCategoriesUsecase {
  final HomeRepository repository;
  GetCategoriesUsecase({required this.repository});

  Future<List<CategoryEntity>> call() async {
    return repository.getCategories();
  }
}
