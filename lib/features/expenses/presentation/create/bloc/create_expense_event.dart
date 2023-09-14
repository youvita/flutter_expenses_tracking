part of 'create_expense_bloc.dart';

abstract class CreateExpenseEvent extends Equatable {
  const CreateExpenseEvent();

  @override
  List<Object> get props => [];
}

class ExpensesIDChanged extends CreateExpenseEvent {
  const ExpensesIDChanged(this.id);

  final int id;

  @override
  List<Object> get props => [id];
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

class CreateDateChanged extends CreateExpenseEvent {
  const CreateDateChanged(this.createDate);

  final DateTime createDate;

  @override
  List<Object> get props => [createDate];
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

class IsNewChanged extends CreateExpenseEvent {
  const IsNewChanged(this.isNew);

  final bool isNew;

  @override
  List<Object> get props => [isNew];
}

class IsUpdateChanged extends CreateExpenseEvent {
  const IsUpdateChanged(this.isUpdate);

  final bool isUpdate;

  @override
  List<Object> get props => [isUpdate];
}

class SaveEvent extends CreateExpenseEvent {
  const SaveEvent();
}

class UpdateEvent extends CreateExpenseEvent {
  const UpdateEvent();
}