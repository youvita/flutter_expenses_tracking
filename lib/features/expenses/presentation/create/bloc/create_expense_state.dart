part of 'create_expense_bloc.dart';

class CreateExpenseState extends Equatable {
  const CreateExpenseState({
    this.expenseType,
    this.issueDate,
    this.category,
    this.currency,
    this.amount,
  });

  CreateExpenseState copyWith({
    String? expenseType,
    DateTime? issueDate,
    String? category,
    String? currency,
    Double? amount
  }) {
    return CreateExpenseState(
      expenseType: expenseType ?? this.expenseType,
      issueDate: issueDate ?? this.issueDate,
      category: category ?? this.category,
      currency: currency ?? this.currency,
      amount: amount ?? this.amount
    );
  }

  final String? expenseType;
  final DateTime? issueDate;
  final String? category;
  final String? currency;
  final Double? amount;

  @override
  List<Object?> get props => [expenseType, issueDate, category, currency, amount];
}

class CreateExpenseInitial extends CreateExpenseState {}
