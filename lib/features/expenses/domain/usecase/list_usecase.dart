
import 'package:expenses_tracking/features/expenses/data/model/expenses.dart';
import 'package:expenses_tracking/features/expenses/domain/repository/list_repository.dart';

class ListUseCase {
  final ListRepository repository;

  ListUseCase({
    required this.repository
  });

  Future<List<Expenses>> getExpenses(String status) async {
    return await repository.getExpenses(status);
  }

}