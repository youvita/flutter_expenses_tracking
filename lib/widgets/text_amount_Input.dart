import 'package:expenses_tracking/constand/constand.dart';
import 'package:expenses_tracking/features/expenses/data/model/expenses.dart';
import 'package:expenses_tracking/widgets/dropdown/list_drop_down.dart';
import 'package:expenses_tracking/widgets/dropdown/list_item.dart';
import 'package:flutter/material.dart';

class TextAmountInputWidget extends StatefulWidget {
  final String placeholder;
  final String value;
  final EdgeInsets? padding;
  final double horSpace;
  final ValueChanged<Expenses> onValueChanged;

  const TextAmountInputWidget({
    Key? key,
    required this.placeholder,
    required this.value,
    this.padding = const EdgeInsets.only(left: 10, top: 15, right: 20, bottom: 15),
    this.horSpace = 8,
    required this.onValueChanged
  }): super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomTextSelect();

}

class _CustomTextSelect extends State<TextAmountInputWidget> {
  String _selectedValue = "1";
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: widget.padding,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
              child:
            DropDownList<String>(
              listItems: const [
                ListItem<String>('USD', value: '1'),
                ListItem<String>('KHR', value: '2'),
              ],
              value: _selectedValue,
              onChange: (value) => setState(() {
              _selectedValue = value!;
              })
            )
          ),
          Flexible(
            flex: 2,
            child: TextField(
              key: const Key('createForm_amountInput_textField'),
              onChanged: (amount) => {
                widget.onValueChanged(Expenses(currencyCode: _selectedValue == "1" ? "USD" : "KHR", amount: amount))
              },
              textAlign: TextAlign.right,
              decoration: const InputDecoration(
                  hintText: "0.00",
                  border: InputBorder.none,
                  isCollapsed: true
              ),
              keyboardType: TextInputType.number,
              style: MyTextStyles.textStyleBold17,
            )
          )
        ],
      ),
    );
  }

}
