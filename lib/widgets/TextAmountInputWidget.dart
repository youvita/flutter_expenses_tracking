import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TextAmountInputWidget extends StatefulWidget {
  final String placeholder;
  final String value;
  final EdgeInsets? padding;
  final double horSpace;
  final ValueChanged<String> onValueChanged;

  const TextAmountInputWidget({
    Key? key,
    required this.placeholder,
    required this.value,
    this.padding = const EdgeInsets.only(left: 20, top: 20, right: 14, bottom: 17),
    this.horSpace = 8,
    required this.onValueChanged
  }): super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomTextSelect();

}

class _CustomTextSelect extends State<TextAmountInputWidget> {

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: widget.padding,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () { widget.onValueChanged(widget.value); },
            child: Row(
              children: [
                const Text("USD"),
                SvgPicture.asset("assets/images/ic_arrow_drop_down.svg")
              ],
            ),
          ),
          SizedBox(
            width: 200,
            child: TextField(
              key: const Key('createForm_amountInput_textField'),
              onChanged: (amount) => {
                widget.onValueChanged(amount)
              },
              decoration: const InputDecoration(
                  labelText: 'amount'
              ),
            )
          )
        ],
      ),
    );
  }

}