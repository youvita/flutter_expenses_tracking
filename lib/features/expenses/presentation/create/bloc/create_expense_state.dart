part of 'create_expense_bloc.dart';

abstract class CreateExpenseState extends Equatable {
  const CreateExpenseState();
}

class CreateExpenseInitial extends CreateExpenseState {
  @override
  List<Object> get props => [];
}
