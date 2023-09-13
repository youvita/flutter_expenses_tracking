part of 'list_expense_bloc.dart';

abstract class ListExpenseEvent extends Equatable {
  const ListExpenseEvent(this.status);

  final String status;

  @override
  List<Object> get props => [status];
}

class ListExpenseLoad extends ListExpenseEvent {
  const ListExpenseLoad(super.status);
}

// class StatusChanged extends ListExpenseEvent {
//   const StatusChanged(this.status);
//
//   final String status;
//
//   @override
//   List<Object> get props => [status];
// }