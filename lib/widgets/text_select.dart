import 'package:expenses_tracking/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TextSelectWidget extends StatefulWidget {
  final String label;
  final String value;
  final String imagePath;
  final EdgeInsets? padding;
  final double horSpace;
  final bool enable;
  final ValueChanged<bool> onTap;

  const TextSelectWidget({
    Key? key,
    required this.label,
    required this.value,
    required this.imagePath,
    this.padding = const EdgeInsets.only(left: 20, top: 15, right: 14, bottom: 15),
    this.horSpace = 8,
    this.enable = true,
    required this.onTap
  }): super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomTextSelect();

}

class _CustomTextSelect extends State<TextSelectWidget> {
  bool isExpand = false;

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {
        if (widget.enable) {
          isExpand = !isExpand;
          widget.onTap(isExpand);
        }
      },
      child: Container(
        padding: widget.padding,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.label, style: MyTextStyles.textStyleMedium17),
            Row(
              children: [
                Text(widget.value, style: MyTextStyles.textStyleBold17),
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