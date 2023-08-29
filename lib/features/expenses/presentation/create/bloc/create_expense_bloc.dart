import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../db/expenses_database.dart';

part 'create_expense_event.dart';
part 'create_expense_state.dart';

class CreateExpenseBloc extends Bloc<CreateExpenseEvent, CreateExpenseState> {

  final _db = ExpensesDatabase();

  CreateExpenseBloc() : super(CreateExpenseInitial()) {
    _db.init();
    on<CreateExpenseEvent>((event, emit) {
      on<ExpensesTypeChanged>(_onExpenseTypeChanged);
      on<IssueDateChanged>(_onIssueDateChanged);
      on<CategoryChanged>(_onCategoryChanged);
      on<CurrencyChanged>(_onCurrencyChanged);
      on<AmountChanged>(_onAmountChanged);
      on<SaveEvent>(_onSaved);
    });
  }

  void _onExpenseTypeChanged(
      ExpensesTypeChanged event,
      Emitter<CreateExpenseState> emit,
      ) {
    emit(
      state.copyWith(
        expenseType: event.expensesType
      )
    );
  }

  void _onIssueDateChanged(
      IssueDateChanged event,
      Emitter<CreateExpenseState> emit,
  ) {
    emit(
      state.copyWith(
        issueDate: event.issueDate
      )
    );
  }

  void _onCategoryChanged(
      CategoryChanged event,
      Emitter<CreateExpenseState> emit,
      ) {
    emit(
        state.copyWith(
            category: event.category
        )
    );
  }

  void _onCurrencyChanged(
      CurrencyChanged event,
      Emitter<CreateExpenseState> emit,
      ) {
    emit(
        state.copyWith(
            currency: event.currency
        )
    );
  }

  void _onAmountChanged(
      AmountChanged event,
      Emitter<CreateExpenseState> emit,
      ) {
    emit(
        state.copyWith(
            amount: event.amount
        )
    );
  }

  Future<void> _onSaved(
      SaveEvent event,
      Emitter<CreateExpenseState> emit,
      ) async {

    // row to insert
    Map<String, dynamic> row = {
      ExpensesDatabase.columnExpenseType: state.expenseType,
      ExpensesDatabase.columnIssueDate: state.issueDate?.toIso8601String(),
      ExpensesDatabase.columnCategory: state.category,
      ExpensesDatabase.columnCurrency: state.currency,
      ExpensesDatabase.columnAmount: state.amount,
    };
    _db.insert(row);
  }
}
