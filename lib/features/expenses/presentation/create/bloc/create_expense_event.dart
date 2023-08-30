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

  final String issueDate;

  @override
  List<Object> get props => [issueDate];
}

class CategoryChanged extends CreateExpenseEvent {
  const CategoryChanged(this.category);

  final String category;

  @override
  List<Object> get props => [category];
}

class CurrencyChanged extends CreateExpenseEvent {
  const CurrencyChanged(this.currency);

  final String currency;

  @override
  List<Object> get props => [currency];
}

class AmountChanged extends CreateExpenseEvent {
  const AmountChanged(this.amount);

  final String amount;

  @override
  List<Object> get props => [amount];
}

class SaveEvent extends CreateExpenseEvent {
  const SaveEvent();
}