import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TextSelectWidget extends StatefulWidget {
  final String label;
  final String value;
  final String imagePath;
  final EdgeInsets? padding;
  final double horSpace;
  final ValueChanged<String> onTap;

  const TextSelectWidget({
    Key? key,
    required this.label,
    required this.value,
    required this.imagePath,
    this.padding = const EdgeInsets.only(left: 20, top: 15, right: 14, bottom: 15),
    this.horSpace = 8,
    required this.onTap
  }): super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomTextSelect();

}

class _CustomTextSelect extends State<TextSelectWidget> {

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () { widget.onTap(widget.value); },
      child: Container(
        padding: widget.padding,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.label),
            Row(
              children: [
                Text(widget.value),
                SizedBox(width: widget.horSpace),
                SvgPicture.asset(widget.imagePath)
              ],
            )
          ],
        ),
      )
    );
  }

}