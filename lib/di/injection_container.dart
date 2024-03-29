import 'package:expenses_tracking/features/expenses/data/local/local_data_source.dart';
import 'package:expenses_tracking/features/expenses/data/repository/create_repository_impl.dart';
import 'package:expenses_tracking/features/expenses/data/repository/list_repository_impl.dart';
import 'package:expenses_tracking/features/expenses/domain/repository/create_repository.dart';
import 'package:expenses_tracking/features/expenses/domain/repository/list_repository.dart';
import 'package:expenses_tracking/features/expenses/domain/usecase/category_usecase.dart';
import 'package:expenses_tracking/features/expenses/domain/usecase/create_usecase.dart';
import 'package:expenses_tracking/features/expenses/domain/usecase/list_usecase.dart';
import 'package:expenses_tracking/features/expenses/presentation/category/bloc/category_bloc.dart';
import 'package:expenses_tracking/features/expenses/presentation/create/bloc/create_expense_bloc.dart';
import 'package:expenses_tracking/features/expenses/presentation/list/bloc/list_expense_bloc.dart';
import 'package:expenses_tracking/features/reports/presentation/home/bloc/report_list_bloc.dart';
import 'package:get_it/get_it.dart';

import '../core/db/expenses_database.dart';

final sl = GetIt.instance;

Future<void> init() async {

  // Bloc
  sl.registerFactory(() => CreateExpenseBloc(useCase: sl()));
  sl.registerFactory(() => ReportListBloc(useCase: sl()));
  sl.registerFactory(() => CategoryBloc(useCase: sl()));
  sl.registerFactory(() => ListExpenseBloc(useCase: sl()));

  // Use Case
  sl.registerLazySingleton(() => CreateUseCase(repository: sl()));
  sl.registerLazySingleton(() => CategoryUseCase(repository: sl()));
  sl.registerLazySingleton(() => ListUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<CreateRepository>(() => CreateRepositoryImpl(localDataSource: sl()));
  sl.registerLazySingleton<ListRepository>(() => ListRepositoryImpl(localDataSource: sl()));

  // Local Source
  sl.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl(db: sl()));

  // External
  sl.registerLazySingleton(() {
    final db = ExpensesDatabase();
    db.init();
    return db;
  });

}
