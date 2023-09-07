part of 'list_expense_bloc.dart';

abstract class ListExpenseEvent extends Equatable {
  const ListExpenseEvent();

  @override
  List<Object> get props => [];
}

class ListExpenseLoad extends ListExpenseEvent {
  const ListExpenseLoad();
}