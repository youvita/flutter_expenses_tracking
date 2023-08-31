
import 'package:expenses_tracking/features/expenses/data/model/expenses.dart';

import '../../../../core/db/expenses_database.dart';

abstract class LocalDataSource {
  Future<void> save(Expenses expenses);
}

class LocalDataSourceImpl extends LocalDataSource {
  final ExpensesDatabase db;

  LocalDataSourceImpl({ required this.db});

  @override
  Future<void> save(Expenses expenses) async {
    db.insert(expenses);
  }

}