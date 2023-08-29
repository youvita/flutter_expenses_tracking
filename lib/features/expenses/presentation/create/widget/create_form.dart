import 'package:expenses_tracking/features/expenses/presentation/create/bloc/create_expense_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateForm extends StatelessWidget {
  const CreateForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateExpenseBloc, CreateExpenseState>(
      listener: (context, state) {

      },
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _ExpenseTypeSelected(),
          _IssueDateSelected(),
          _CategoryInput(),
          _SaveButton()
        ],
      ),
    );
  }

}

class _ExpenseTypeSelected extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateExpenseBloc, CreateExpenseState>(
        builder: (context, state) {
          return ElevatedButton(onPressed: () {
            context.read<CreateExpenseBloc>().add(const ExpensesTypeChanged('1'));
          }, child: const Text('Expense'));
        }
    );
  }

}

class _IssueDateSelected extends StatelessWidget {
  DateTime dateTime = DateTime(2023, 08, 29);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateExpenseBloc, CreateExpenseState>(
        builder: (context, state) {
          return ElevatedButton(onPressed: () async {
            DateTime? newDateTime = await showDatePicker(
                context: context,
                initialDate: dateTime,
                firstDate: DateTime(2023),
                lastDate: DateTime(2100));

            if (newDateTime == null) return;

            // context.read<CreateExpenseBloc>().add(IssueDateChanged(newDateTime))
          }, child: const Text('Select Date'));
        }
    );
  }

}

class _CategoryInput extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateExpenseBloc, CreateExpenseState>(
        builder: (context, state) {
          return TextField(
            key: const Key('createForm_categoryInput_textField'),
            onChanged: (category) =>
                context.read<CreateExpenseBloc>().add(CategoryChanged(category)),
            decoration: const InputDecoration(
              labelText: 'category'
            ),
          );
        }
    );
  }

}

class _SaveButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateExpenseBloc, CreateExpenseState>(
      builder: (context, state) {
        return ElevatedButton(
          key: const Key('createForm_saveButton'),
          onPressed: () {
            context.read<CreateExpenseBloc>().add(const SaveEvent());
          },
          child: const Text('Save'),
        );
      },
    );
  }
}

