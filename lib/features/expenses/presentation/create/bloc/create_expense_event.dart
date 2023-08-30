part of 'create_expense_bloc.dart';

abstract class CreateExpenseEvent extends Equatable {
  const CreateExpenseEvent();

  @override
  List<Object> get props => [];
}

class ExpensesTypeChanged extends CreateExpenseEvent {
  const ExpensesTypeChanged(this.expensesType);

  final String expensesType;

  @override
  List<Object> get props => [expensesType];
}

class IssueDateChanged extends CreateExpenseEvent {
  const IssueDateChanged(this.issueDate);

  final DateTime issueDate;

  @override
  List<Object> get props => [issueDate];
}

class CategoryChanged extends CreateExpenseEvent {
  const CategoryChanged(this.image, this.category);

  final String image;
  final String category;

  @override
  List<Object> get props => [image, category];
}

class CurrencyChanged extends CreateExpenseEvent {
  const CurrencyChanged(this.currency);

  final String currency;

  @override
  List<Object> get props => [currency];
}

class AmountChanged extends CreateExpenseEvent {
  const AmountChanged(this.amount);

  final double amount;

  @override
  List<Object> get props => [amount];
}

class RemarkChanged extends CreateExpenseEvent {
  const RemarkChanged(this.remark);

  final String remark;

  @override
  List<Object> get props => [remark];
}

class SaveEvent extends CreateExpenseEvent {
  const SaveEvent();
}