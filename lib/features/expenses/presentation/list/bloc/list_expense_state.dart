part of 'list_expense_bloc.dart';

class ListExpenseState extends Equatable {

  const ListExpenseState({
    this.listExpenses
  });

  final List<Expenses>? listExpenses;

  ListExpenseState copyWith({
    List<Expenses>? listExpenses
  }) {
    return ListExpenseState(
        listExpenses: listExpenses ?? this.listExpenses
    );
  }

  @override
  List<Object?> get props => [listExpenses];
}

class ListExpenseInitial extends ListExpenseState {}
