import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TextSelectWidget extends StatefulWidget {
  final String value;
  final ValueChanged<String> onTap;
  final SvgPicture icon;

  const TextSelectWidget({Key? key, required this.value, required this.icon, required this.onTap}): super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomTextSelect();

}

class _CustomTextSelect extends State<TextSelectWidget> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () { widget.onTap(widget.value); },
      child: Container(
        padding: const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 17),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Date'),
            Row(
              children: [
                Text(widget.value),
                const SizedBox(width: 15),
                widget.icon
                // SvgPicture.asset('assets/images/ic_calendar.svg')
              ],
            )
          ],
        ),
      )
    );
  }

}