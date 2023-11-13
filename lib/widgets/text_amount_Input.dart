import 'package:easy_localization/easy_localization.dart';
import 'package:expenses_tracking/constant/constant.dart';
import 'package:expenses_tracking/widgets/dropdown/list_drop_down.dart';
import 'package:expenses_tracking/widgets/dropdown/list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextAmountInputWidget extends StatefulWidget {
  final String placeholder;
  final String value;
  final String defaultCurrency;
  final EdgeInsets? padding;
  final double horSpace;
  final bool enable;
  final ValueChanged<String> onCurrencyChanged;
  final ValueChanged<String> onValueChanged;

  const TextAmountInputWidget({
    Key? key,
    this.enable = true,
    required this.placeholder,
    required this.value,
    this.defaultCurrency = '1',
    this.padding = const EdgeInsets.only(left: 10, top: 15, right: 20, bottom: 15),
    this.horSpace = 8,
    required this.onValueChanged,
    required this.onCurrencyChanged,
  }): super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomTextSelect();

}

class _CustomTextSelect extends State<TextAmountInputWidget> {
  String _selectedValue = '';
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.defaultCurrency;
    _controller.text = widget.value;
    _controller.addListener(_latestValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
              enable: widget.enable,
              listItems: const[
                ListItem<String>('USD', value: '1'),
                ListItem<String>('KHR', value: '2'),
              ],
              value: _selectedValue,
              onChange: (value) => setState(() {
              _selectedValue = value!;
              widget.onCurrencyChanged(value == '1' ? 'USD' : 'KHR');
              })
            )
          ),
          Flexible(
            flex: 2,
            child: TextField(
              autofocus: true,
              controller: _controller,
              enabled: widget.enable,
              key: const Key('createForm_amountInput_textField'),
              onChanged: (amount) => {
                widget.onValueChanged(amount)
              },
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                  hintText: widget.defaultCurrency == '1' ? '0.00' : '0',
                  border: InputBorder.none,
                  isCollapsed: true
              ),
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))],
              keyboardType: widget.defaultCurrency == '1' ? const TextInputType.numberWithOptions(decimal: true) : TextInputType.number,
              style: MyTextStyles.textStyleBold26,
            )
          )
        ],
      ),
    );
  }

  void _latestValue() {
  }

}
