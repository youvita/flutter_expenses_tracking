import 'package:expenses_tracking/config/date_util.dart';
import 'package:expenses_tracking/features/expenses/presentation/create/bloc/create_expense_bloc.dart';
import 'package:expenses_tracking/features/expenses/presentation/create/widget/status_switch.dart';
import 'package:expenses_tracking/widgets/TextAmountInputWidget.dart';
import 'package:expenses_tracking/widgets/TextSelectWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CreateForm extends StatelessWidget {
  const CreateForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _StatusTypeWidget(),
          _IssueDateWidget(),
          _CategoryWidget(),
          _CurrencySelected(),
          _AmountInputWidget(),
          _SaveButton()
        ]
    );
  }

}

class _StatusTypeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ExpenseTypeSelected();
}

class _ExpenseTypeSelected extends State {
  bool _enable = false;
  @override
  Widget build(BuildContext context) {

    return StatusSwitch(value: _enable, onChanged: (bool val) {
      setState(() {
        _enable = val;
      });

      if (_enable) {
        context.read<CreateExpenseBloc>().add(const ExpensesTypeChanged('1'));
      } else {
        context.read<CreateExpenseBloc>().add(const ExpensesTypeChanged('2'));
      }
    });
  }

}

class _IssueDateWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _IssueDateSelected();
}

class _IssueDateSelected extends State {
  DateTime newDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final issueDate = context.read<CreateExpenseBloc>();
    return TextSelectWidget(
        label: "Date",
        padding: const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 17),
        horSpace: 15,
        value: DateFormat(DateUtil.DAY_MONTH_YEAR).format(newDateTime),
        imagePath: "assets/images/ic_calendar.svg",
        onTap: (_) async {
            DateTime? selectedDateTime = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2023),
                lastDate: DateTime(2100));

                if (selectedDateTime != null) {
                  DateTime currentTime = DateTime.now();
                  setState(() {
                    newDateTime = DateTime(selectedDateTime.year, selectedDateTime.month, selectedDateTime.day, currentTime.hour, currentTime.minute, currentTime.second);
                  });
                  issueDate.add(IssueDateChanged(newDateTime));
                }
        }
    );
  }

}

class _CategoryWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CategoryInput();
}

class _CategoryInput extends State {
  String category = "Select";

  @override
  Widget build(BuildContext context) {
    return TextSelectWidget(
        label: "Category",
        value: category,
        imagePath: "assets/images/ic_arrow_drop_down.svg",
        onTap: (String value) {
          setState(() {
            category = "🤣$value";
          });
          context.read<CreateExpenseBloc>().add(CategoryChanged('🤣', category));
        });
    // return TextField(
    //   key: const Key('createForm_categoryInput_textField'),
    //   onChanged: (category) =>
    //       context.read<CreateExpenseBloc>().add(CategoryChanged('🤣',category)),
    //   decoration: const InputDecoration(
    //       labelText: 'category'
    //   ),
    // );
  }

}

class _CurrencySelected extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
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

}

class _AmountInputWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AmountInput();
}

class _AmountInput extends State {
  String amount = "";
  @override
  Widget build(BuildContext context) {
    return TextAmountInputWidget(
        placeholder: "Input",
        value: amount,
        onValueChanged: (String value) {
          setState(() {
            amount = value;
          });
          context.read<CreateExpenseBloc>().add(AmountChanged(double.parse(amount)));
        });
    // return TextField(
    //   key: const Key('createForm_amountInput_textField'),
    //   onChanged: (amount) =>
    //       context.read<CreateExpenseBloc>().add(AmountChanged(double.parse(amount))),
    //   decoration: const InputDecoration(
    //       labelText: 'amount'
    //   ),
    // );
  }

}

class _SaveButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: const Key('createForm_saveButton'),
      onPressed: () {
        context.read<CreateExpenseBloc>().add(const SaveEvent());
      },
      child: const Text('Save'),
    );
  }
}

