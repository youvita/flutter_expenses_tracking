part of 'report_list_bloc.dart';

class ReportListState extends Equatable {
  const ReportListState({
    this.datePicker, this.totalIncome, this.totalExpense
  });

  ReportListState copyWith({
    DateTime? datePicker,
    double? totalExpense,
    double? totalIncome,
  }) {
    return ReportListState(
      datePicker: datePicker ?? this.datePicker,
      totalIncome: totalIncome ?? this.totalIncome,
      totalExpense: totalExpense ?? this.totalExpense,
    );
  }

  final DateTime? datePicker;
  final double? totalExpense;
  final double? totalIncome;

  @override
  List<Object?> get props => [datePicker, totalExpense, totalIncome];
}

class CreateExpenseInitial extends ReportListState {}
