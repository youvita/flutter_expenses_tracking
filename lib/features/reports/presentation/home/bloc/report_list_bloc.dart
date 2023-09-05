import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expenses_tracking/features/expenses/domain/usecase/create_usecase.dart';
import 'package:flutter/material.dart';

part 'report_list_event.dart';

part 'report_list_state.dart';

class ReportListBloc extends Bloc<ReportListEvent, ReportListState> {
  final CreateUseCase _useCase;

  ReportListBloc({required CreateUseCase useCase})
      : _useCase = useCase,
        super(CreateExpenseInitial()) {
    on<ReportListEvent>((event, emit) {
      on<OnYearDropChange>(_yearDropChange);
    });
  }

  void _yearDropChange(
      OnYearDropChange event,
    Emitter<ReportListState> emit,
  ) {
    state.totalIncome += 10.0;
    emit(state.copyWith(datePicker: event.datePicker));
  }

}
