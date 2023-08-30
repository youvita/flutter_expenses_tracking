part of 'report_list_bloc.dart';

abstract class ReportListEvent extends Equatable {
  const ReportListEvent();

  @override
  List<Object> get props => [];
}

class ExpensesTypeChanged extends ReportListEvent {
  const ExpensesTypeChanged(this.expensesType);

  final String expensesType;

  @override
  List<Object> get props => [expensesType];
}

class IssueDateChanged extends ReportListEvent {
  const IssueDateChanged(this.issueDate);

  final DateTime issueDate;

  @override
  List<Object> get props => [issueDate];
}

class CategoryChanged extends ReportListEvent {
  const CategoryChanged(this.image, this.category);

  final String image;
  final String category;

  @override
  List<Object> get props => [image, category];
}

class CurrencyChanged extends ReportListEvent {
  const CurrencyChanged(this.currency);

  final String currency;

  @override
  List<Object> get props => [currency];
}

class AmountChanged extends ReportListEvent {
  const AmountChanged(this.amount);

  final double amount;

  @override
  List<Object> get props => [amount];
}

class RemarkChanged extends ReportListEvent {
  const RemarkChanged(this.remark);

  final String remark;

  @override
  List<Object> get props => [remark];
}

class SaveEvent extends ReportListEvent {
  const SaveEvent();
}