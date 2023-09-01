import 'package:expenses_tracking/config/date_util.dart';
import 'package:expenses_tracking/features/expenses/data/model/expenses.dart';
import 'package:expenses_tracking/features/expenses/presentation/create/bloc/create_expense_bloc.dart';
import 'package:expenses_tracking/features/expenses/presentation/create/widget/status_switch.dart';
import 'package:expenses_tracking/features/expenses/presentation/create/widget/text_remark_input.dart';
import 'package:expenses_tracking/widgets/divider_widget.dart';
import 'package:expenses_tracking/widgets/text_amount_Input.dart';
import 'package:expenses_tracking/widgets/text_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CreateForm extends StatelessWidget {
  const CreateForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              _StatusTypeWidget(),
              _IssueDateWidget(),
              const DividerWidget(),
              _CategoryWidget(),
              const DividerWidget(),
              _AmountInputWidget(),
              const DividerWidget(),
              _RemarkInputWidget(),
            ],
          ),
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
        padding: const EdgeInsets.only(left: 20, top: 22, right: 20, bottom: 22),
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
        value: "🤣$category",
        imagePath: "assets/images/ic_arrow_drop_down.svg",
        onTap: (String value) {
          setState(() {
            category = value;
          });
          context.read<CreateExpenseBloc>().add(CategoryChanged('🤣', category));
        });
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
        onValueChanged: (Expenses value) {
          setState(() {
            amount = value.amount!;
          });
          context.read<CreateExpenseBloc>().add(CurrencyChanged(value.currencyCode ?? "USD"));
          context.read<CreateExpenseBloc>().add(AmountChanged(double.parse(amount.isEmpty ? "0.0" : amount)));
        });
  }

}

class _RemarkInputWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RemarkInputState();
}

class _RemarkInputState extends State {
  String remark = "";
  @override
  Widget build(BuildContext context) {
    final isVisible = context.select((CreateExpenseBloc bloc) => bloc.state.amount);

    return TextRemarkInputWidget(
        isVisible: isVisible != 0.0,
        label: "Remark",
        placeholder: "Please Input",
        value: remark,
        onValueChanged: (String value) {
          setState(() {
            remark = value;
          });
          context.read<CreateExpenseBloc>().add(RemarkChanged(remark));
        }
      );
  }

}

class _SaveButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
        key: const Key('createForm_saveButton'),
        style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(50)
        ),
        onPressed: () {
          context.read<CreateExpenseBloc>().add(const SaveEvent());
        },
        child: const Text('Save'),
      )
    );
  }
}

