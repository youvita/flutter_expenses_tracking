
import 'package:expenses_tracking/features/expenses/data/local/local_data_source.dart';
import 'package:expenses_tracking/features/expenses/data/model/categories.dart';
import 'package:expenses_tracking/features/expenses/data/model/expenses.dart';
import 'package:expenses_tracking/features/expenses/domain/repository/create_repository.dart';

class CreateRepositoryImpl implements CreateRepository {
  final LocalDataSource localDataSource;

  CreateRepositoryImpl({ required this.localDataSource});

  @override
  Future<void> save(Expenses expenses) async {
    await localDataSource.save(expenses);
  }

  @override
  Future<Categories> getCategories() async {
    return await localDataSource.readCategories();
  }

  @override
  Future<void> update(Expenses expenses) async {
    await localDataSource.update(expenses);
  }

}