import 'package:expenses_tracking/db/expenses_database.dart';
import 'package:expenses_tracking/features/expenses/data/local/local_data_source.dart';
import 'package:expenses_tracking/features/expenses/data/repository/create_repository_impl.dart';
import 'package:expenses_tracking/features/expenses/domain/repository/create_repository.dart';
import 'package:expenses_tracking/features/expenses/domain/usecase/create_usecase.dart';
import 'package:expenses_tracking/features/expenses/presentation/create/bloc/create_expense_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {

  // Bloc
  sl.registerFactory(() => CreateExpenseBloc(useCase: sl()));

  // Use Case
  sl.registerLazySingleton(() => CreateUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<CreateRepository>(() => CreateRepositoryImpl(localDataSource: sl()));

  // Local Source
  sl.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl(db: sl()));

  // External
  sl.registerLazySingleton(() {
    final db = ExpensesDatabase();
    db.init();
    return db;
  });

}