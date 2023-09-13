part of 'list_expense_bloc.dart';

class ListExpenseState extends Equatable {

  const ListExpenseState({
    this.listExpenses,
    this.status
  });

  final List<Expenses>? listExpenses;
  final String? status;

  ListExpenseState copyWith({
    List<Expenses>? listExpenses,
    String? status
  }) {
    return ListExpenseState(
        listExpenses: listExpenses ?? this.listExpenses,
        status: status ?? this.status
    );
  }

  @override
  List<Object?> get props => [listExpenses, status];
}

class ListExpenseInitial extends ListExpenseState {}
