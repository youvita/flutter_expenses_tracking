

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
  }

  Future<void> _fetchExpenses(ListExpenseEvent event, Emitter<ListExpenseState> emit) async {
    final expenses = await _useCase.getExpenses();
    emit(
        state.copyWith(
            listExpenses: expenses
        )
    );
  }
}


