
import 'package:expenses_tracking/features/expenses/data/local/local_data_source.dart';
import 'package:expenses_tracking/features/expenses/data/model/expenses.dart';
import 'package:expenses_tracking/features/expenses/domain/repository/list_repository.dart';

class ListRepositoryImpl implements ListRepository {
  final LocalDataSource localDataSource;

  ListRepositoryImpl({required this.localDataSource});

  @override
  Future<List<Expenses>> getExpenses(String status) async {
    return await localDataSource.getExpenses(status);
  }

}