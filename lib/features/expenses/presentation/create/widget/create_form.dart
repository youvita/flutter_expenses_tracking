import 'package:expenses_tracking/features/expenses/presentation/create/bloc/create_expense_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateForm extends StatelessWidget {
  const CreateForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateExpenseBloc, CreateExpenseState>(
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              _ExpenseTypeSelected(),
              _IssueDateSelected(),
              _CategoryInput(),
              _CurrencySelected(),
              _AmountInput(),
              _SaveButton()
            ],
          );
        }
    );
  }

}

class _ExpenseTypeSelected extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateExpenseBloc, CreateExpenseState>(
        builder: (context, state) {
          return Row(
            children: [
              ElevatedButton(onPressed: () {
                context.read<CreateExpenseBloc>().add(const ExpensesTypeChanged('1'));
              }, child: const Text('Expense')),
              ElevatedButton(onPressed: () {
                context.read<CreateExpenseBloc>().add(const ExpensesTypeChanged('2'));
              }, child: const Text('Income'))
            ],
          );
        }
    );
  }

}

class _IssueDateSelected extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateExpenseBloc, CreateExpenseState>(
        builder: (context, state) {
          return ElevatedButton(onPressed: () async {
            DateTime? selectedDateTime = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2023),
                lastDate: DateTime(2100)
            );

            if (selectedDateTime != null) {
                DateTime currentTime = DateTime.now();
                DateTime newDateTime = DateTime(selectedDateTime.year, selectedDateTime.month, selectedDateTime.day, currentTime.hour, currentTime.minute, currentTime.second);
                context.read<CreateExpenseBloc>().add(IssueDateChanged(newDateTime));
            }
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
                context.read<CreateExpenseBloc>().add(CategoryChanged('🤣',category)),
            decoration: const InputDecoration(
              labelText: 'category'
            ),
          );
        }
    );
  }

}

class _CurrencySelected extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateExpenseBloc, CreateExpenseState>(
        builder: (context, state) {
          return Row(
            children: [
              ElevatedButton(onPressed: () {
                context.read<CreateExpenseBloc>().add(const CurrencyChanged('USD'));
              }, child: const Text('USD')),
              ElevatedButton(onPressed: () {
                context.read<CreateExpenseBloc>().add(const CurrencyChanged('KHR'));
              }, child: const Text('KHR'))
            ],
          );
        }
    );
  }

}

class _AmountInput extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateExpenseBloc, CreateExpenseState>(
        builder: (context, state) {
          return TextField(
            key: const Key('createForm_amountInput_textField'),
            onChanged: (amount) =>
                context.read<CreateExpenseBloc>().add(AmountChanged(double.parse(amount))),
            decoration: const InputDecoration(
                labelText: 'amount'
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

