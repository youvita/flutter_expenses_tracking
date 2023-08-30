
import 'package:expenses_tracking/features/expenses/data/local/local_data_source.dart';
import 'package:expenses_tracking/features/expenses/data/model/expenses.dart';
import 'package:expenses_tracking/features/expenses/domain/repository/create_repository.dart';

import '../../../../db/expenses_database.dart';

class CreateRepositoryImpl implements CreateRepository {
  // final _db = ExpensesDatabase();
  final LocalDataSource localDataSource;

  CreateRepositoryImpl({ required this.localDataSource});

  @override
  Future<void> save(Expenses expenses) async {
    // _db.init();
    // _db.insert(expenses);
    await localDataSource.save(expenses);
  }

}