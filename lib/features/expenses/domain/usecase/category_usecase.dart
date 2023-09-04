
import 'package:expenses_tracking/features/expenses/data/model/categories.dart';
import 'package:expenses_tracking/features/expenses/domain/repository/create_repository.dart';

class CategoryUseCase {
  final CreateRepository repository;

  CategoryUseCase({
    required this.repository
  });

  Future<Categories> getCategories() async {
    return await repository.getCategories();
  }

}