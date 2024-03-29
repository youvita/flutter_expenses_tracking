
import 'package:expenses_tracking/core/usecase/usecase.dart';
import 'package:expenses_tracking/features/expenses/data/model/expenses.dart';
import 'package:expenses_tracking/features/expenses/domain/repository/create_repository.dart';

class CreateUseCase implements UseCase<Expenses> {
  final CreateRepository repository;

  CreateUseCase({
    required this.repository
  });

  @override
  Future<void> save(Expenses params) async {
    return await repository.save(params);
  }

  @override
  Future<void> update(Expenses params) async {
    return await repository.update(params);
  }

}