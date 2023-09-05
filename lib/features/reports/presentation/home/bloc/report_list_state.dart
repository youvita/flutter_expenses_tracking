part of 'report_list_bloc.dart';

class ReportListState extends Equatable {
  ReportListState({
    this.datePicker,
  });

  ReportListState copyWith({
    DateTime? datePicker,
  }) {
    return ReportListState(
      datePicker: datePicker ?? this.datePicker,
    );
  }

  final DateTime? datePicker;
  final double totalExpense = 0;
  late double totalIncome = 0;
  final double currentBalance = 0;

  @override
  List<Object?> get props => [datePicker, totalExpense, totalIncome, currentBalance];
}

class CreateExpenseInitial extends ReportListState {}
