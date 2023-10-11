import 'package:easy_localization/easy_localization.dart';
import 'package:expenses_tracking/constant/constant.dart';
import 'package:flutter/material.dart';

class TextInputWidget extends StatefulWidget {
  final String placeholder;
  final String label;
  final EdgeInsets? padding;
  final ValueChanged<String> onValueChanged;

  const TextInputWidget({
    Key? key,
    this.placeholder = 'Please Input',
    required this.label,
    this.padding = const EdgeInsets.only(left: 20, top: 15, right: 20, bottom: 15),
    required this.onValueChanged
  }): super(key: key);

  @override
  State<StatefulWidget> createState() => _TextInputState();

}

class _TextInputState extends State<TextInputWidget> {

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: widget.padding,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.label, style: MyTextStyles.textStyleMedium17),
          Flexible(
            flex: 2, child: TextField(
            key: const Key('createForm_textInput_textField'),
            onChanged: (value) => {
              widget.onValueChanged(value)
            },
            textAlign: TextAlign.right,
            decoration: InputDecoration(
                hintText: widget.placeholder,
                border: InputBorder.none,
                isCollapsed: true
            ),
            style: MyTextStyles.textStyleBold17,
          )
          )
        ],
      ),
    );
  }

}
