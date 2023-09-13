

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/model/expenses.dart';
import '../../../domain/usecase/list_usecase.dart';

part 'list_expense_event.dart';
part 'list_expense_state.dart';

class ListExpenseBloc extends Bloc<ListExpenseEvent, ListExpenseState> {
  final ListUseCase _useCase;

  ListExpenseBloc({required ListUseCase useCase}) : _useCase = useCase, super(ListExpenseInitial()) {
    on<ListExpenseEvent>(_fetchExpenses);
    // on<StatusChanged>(_onStatusChanged);
  }

  Future<void> _fetchExpenses(ListExpenseEvent event, Emitter<ListExpenseState> emit) async {
    // print("Fetching.....");
    // print(event.status);
    final expenses = await _useCase.getExpenses(event.status ?? '');
    // print(expenses);
    emit(
        state.copyWith(
            listExpenses: expenses,
            status: event.status
        )
    );
  }

  // void _onStatusChanged(
  //     StatusChanged event,
  //     Emitter<ListExpenseState> emit,
  //     ) {
  //   print("status changed: ${event.status}");
  //   emit(
  //       state.copyWith(
  //           status: event.status
  //       )
  //   );
  // }
}


