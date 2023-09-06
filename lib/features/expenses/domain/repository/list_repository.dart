import 'package:expenses_tracking/features/expenses/data/model/expenses.dart';
abstract class ListRepository {
  Future<List<Expenses>> getExpenses();
}