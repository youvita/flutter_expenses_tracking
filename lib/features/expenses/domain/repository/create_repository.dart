import 'package:expenses_tracking/features/expenses/data/model/expenses.dart';

abstract class CreateRepository {
  Future<void> save(Expenses expenses);
}